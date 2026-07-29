#!/usr/bin/env python3
"""Production QA audit for the bundled wiring concept library."""

from __future__ import annotations

from collections import Counter, defaultdict
from dataclasses import dataclass
from pathlib import Path
import hashlib
import re
import sys

from localization_audit import DartMapParser

ROOT = Path(__file__).resolve().parents[1]
WIRING_FILE = ROOT / 'lib/data/content/wiring_content.dart'


@dataclass
class Diagram:
    id: str
    title: str
    category: str
    description: str
    asset: str
    difficulty: str
    steps: list[str]
    components: list[str]
    safety: list[str]
    mistakes: list[str]
    testing: list[str]
    notes: list[str]
    standards: list[str]
    content_version: str
    line: int


def _matching_paren(source: str, open_index: int) -> int:
    depth = 0
    index = open_index
    while index < len(source):
        if source.startswith('//', index):
            end = source.find('\n', index)
            index = len(source) if end < 0 else end + 1
            continue
        if source.startswith('/*', index):
            end = source.find('*/', index + 2)
            index = len(source) if end < 0 else end + 2
            continue
        if source[index] in "'\"":
            parser = DartMapParser(source[index:])
            parser.string()
            index += parser.index
            continue
        if source[index] == '(':
            depth += 1
        elif source[index] == ')':
            depth -= 1
            if depth == 0:
                return index
        index += 1
    raise ValueError('Unclosed WiringDiagram constructor')


def _string(block: str, name: str, optional: bool = False) -> str:
    match = re.search(rf'\b{name}\s*:\s*', block)
    if not match:
        if optional:
            return ''
        raise ValueError(f'Missing {name}')
    remainder = block[match.end():].lstrip()
    if remainder.startswith('null'):
        return ''
    parser = DartMapParser(remainder)
    return parser.string()


def _strings(block: str, name: str) -> list[str]:
    match = re.search(rf'\b{name}\s*:\s*\[', block)
    if not match:
        return []
    index = match.end()
    depth = 1
    result = []
    while index < len(block) and depth:
        if block[index].isspace() or block[index] == ',':
            index += 1
            continue
        if block[index] in "'\"":
            parser = DartMapParser(block[index:])
            result.append(parser.string())
            index += parser.index
            continue
        if block[index] == '[':
            depth += 1
        elif block[index] == ']':
            depth -= 1
        index += 1
    return result


def load_diagrams() -> list[Diagram]:
    source = WIRING_FILE.read_text(encoding='utf-8')
    result = []
    for match in re.finditer(r'\bWiringDiagram\s*\(', source):
        open_index = source.index('(', match.start())
        end = _matching_paren(source, open_index)
        block = source[match.start():end + 1]
        result.append(Diagram(
            id=_string(block, 'id'),
            title=_string(block, 'title'),
            category=_string(block, 'category'),
            description=_string(block, 'description'),
            asset=_string(block, 'svgPath', optional=True),
            difficulty=_string(block, 'difficulty'),
            steps=_strings(block, 'steps'),
            components=_strings(block, 'components'),
            safety=_strings(block, 'safetyWarnings'),
            mistakes=_strings(block, 'commonMistakes'),
            testing=_strings(block, 'testingProcedure'),
            notes=_strings(block, 'professionalNotes'),
            standards=_strings(block, 'standardsReferences'),
            content_version=_string(block, 'contentVersion'),
            line=source.count('\n', 0, match.start()) + 1,
        ))
    return result


def _webp_size(path: Path) -> tuple[int, int]:
    data = path.read_bytes()
    if len(data) < 30 or data[:4] != b'RIFF' or data[8:12] != b'WEBP':
        raise ValueError('not a WebP RIFF file')
    chunk = data[12:16]
    if chunk == b'VP8X':
        width = 1 + int.from_bytes(data[24:27], 'little')
        height = 1 + int.from_bytes(data[27:30], 'little')
        return width, height
    if chunk == b'VP8 ':
        marker = data.find(b'\x9d\x01\x2a', 20)
        if marker < 0:
            raise ValueError('VP8 frame marker missing')
        width = int.from_bytes(data[marker + 3:marker + 5], 'little') & 0x3FFF
        height = int.from_bytes(data[marker + 5:marker + 7], 'little') & 0x3FFF
        return width, height
    if chunk == b'VP8L':
        if data[20] != 0x2F:
            raise ValueError('VP8L signature missing')
        bits = int.from_bytes(data[21:25], 'little')
        width = (bits & 0x3FFF) + 1
        height = ((bits >> 14) & 0x3FFF) + 1
        return width, height
    raise ValueError(f'unsupported WebP chunk {chunk!r}')


def audit(diagrams: list[Diagram]) -> list[str]:
    errors = []
    ids = Counter(item.id for item in diagrams)
    titles = Counter(item.title.casefold() for item in diagrams)
    if len(diagrams) != 20:
        errors.append(f'Expected 20 diagrams, found {len(diagrams)}')
    if any(count != 1 for count in ids.values()):
        errors.append('Duplicate diagram IDs found')
    if any(count != 1 for count in titles.values()):
        errors.append('Duplicate diagram titles found')

    expected = {
        'residential': 11,
        'distribution': 1,
        'motors': 3,
        'solar': 1,
        'smart': 4,
    }
    actual = Counter(item.category for item in diagrams)
    if dict(actual) != expected:
        errors.append(f'Category counts differ: {dict(actual)}')

    banned = (
        'Refer to ultra-realistic PNG',
        'as in PNG',
        'Thermal Overload Relay TOR with dial',
        'red arrow marked Live / L',
        'blue arrow to Neutral Bar',
        'green-yellow striped top left',
    )
    hashes = {}
    for item in diagrams:
        if not item.asset:
            errors.append(f'{item.id}: no diagram asset')
        else:
            asset = ROOT / item.asset
            if not asset.is_file():
                errors.append(f'{item.id}: missing asset {item.asset}')
            else:
                try:
                    dimensions = _webp_size(asset)
                    if dimensions != (1000, 545):
                        errors.append(f'{item.id}: unexpected dimensions {dimensions}')
                except Exception as error:
                    errors.append(f'{item.id}: unreadable asset: {error}')
                digest = hashlib.sha256(asset.read_bytes()).hexdigest()
                if digest in hashes:
                    errors.append(f'{item.id}: duplicate image of {hashes[digest]}')
                hashes[digest] = item.id
        if not 5 <= len(item.steps) <= 9:
            errors.append(f'{item.id}: expected 5-9 steps, found {len(item.steps)}')
        if len(item.components) < 3 or len(set(item.components)) != len(item.components):
            errors.append(f'{item.id}: component list is incomplete or duplicated')
        for label, values in [
            ('safety', item.safety),
            ('mistakes', item.mistakes),
            ('testing', item.testing),
            ('notes', item.notes),
            ('standards', item.standards),
        ]:
            if not values:
                errors.append(f'{item.id}: {label} list is empty')
        all_text = '\n'.join([
            item.title, item.description, *item.steps, *item.components,
            *item.safety, *item.mistakes, *item.testing, *item.notes,
        ])
        for phrase in banned:
            if phrase.lower() in all_text.lower():
                errors.append(f'{item.id}: contaminated generated phrase: {phrase}')
                break
        if item.content_version != '2.1.0-production-wiring-audit':
            errors.append(f'{item.id}: old content version {item.content_version}')

    return errors


def main() -> int:
    diagrams = load_diagrams()
    errors = audit(diagrams)
    categories = Counter(item.category for item in diagrams)
    print('Electrician Simulator App production wiring audit')
    print(f'  Diagrams: {len(diagrams)}')
    print(f'  Categories: {dict(categories)}')
    print(f'  Steps: {sum(len(item.steps) for item in diagrams)}')
    print(f'  Assets: {sum(bool(item.asset) for item in diagrams)}')
    if errors:
        print(f'  RESULT: FAIL ({len(errors)} issue(s))')
        for error in errors[:80]:
            print(f'   - {error}')
        if len(errors) > 80:
            print(f'   - ... and {len(errors) - 80} more')
        return 1
    print('  RESULT: PASS')
    return 0


if __name__ == '__main__':
    sys.exit(main())
