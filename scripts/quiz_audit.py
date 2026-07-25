#!/usr/bin/env python3
"""Production QA checks for the bundled VoltMaster quiz bank."""

from __future__ import annotations

from collections import Counter, defaultdict
from dataclasses import dataclass
from pathlib import Path
import csv
import re
import sys

from localization_audit import DartMapParser

ROOT = Path(__file__).resolve().parents[1]
QUIZ_FILE = ROOT / 'lib/data/content/quiz_content.dart'


@dataclass
class Question:
    id: str
    question: str
    options: list[str]
    correct_index: int
    explanation: str
    category: str
    difficulty: str
    image_asset: str | None
    related_article_id: str | None
    line: int

    @property
    def answer(self) -> str:
        return self.options[self.correct_index]


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
    raise ValueError('Unclosed QuizQuestion constructor')


def _string_field(block: str, name: str) -> str:
    match = re.search(rf'\b{name}\s*:\s*', block)
    if not match:
        raise ValueError(f'Missing {name}')
    parser = DartMapParser(block[match.end():])
    return parser.string()


def _int_field(block: str, name: str) -> int:
    match = re.search(rf'\b{name}\s*:\s*(-?\d+)', block)
    if not match:
        raise ValueError(f'Missing {name}')
    return int(match.group(1))


def _nullable_string_field(block: str, name: str) -> str | None:
    match = re.search(rf'\b{name}\s*:\s*', block)
    if not match:
        return None
    remainder = block[match.end():].lstrip()
    if remainder.startswith('null'):
        return None
    parser = DartMapParser(remainder)
    return parser.string()


def _string_list_field(block: str, name: str) -> list[str]:
    match = re.search(rf'\b{name}\s*:\s*\[', block)
    if not match:
        raise ValueError(f'Missing {name}')
    index = match.end()
    depth = 1
    result: list[str] = []
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


def load_questions() -> list[Question]:
    source = QUIZ_FILE.read_text(encoding='utf-8')
    result: list[Question] = []
    for match in re.finditer(r'\bQuizQuestion\s*\(', source):
        open_index = source.index('(', match.start())
        end = _matching_paren(source, open_index)
        block = source[match.start():end + 1]
        result.append(
            Question(
                id=_string_field(block, 'id'),
                question=_string_field(block, 'question'),
                options=_string_list_field(block, 'options'),
                correct_index=_int_field(block, 'correctIndex'),
                explanation=_string_field(block, 'explanation'),
                category=_string_field(block, 'category'),
                difficulty=_string_field(block, 'difficulty'),
                image_asset=_nullable_string_field(block, 'imageAsset'),
                related_article_id=_nullable_string_field(block, 'relatedArticleId'),
                line=source.count('\n', 0, match.start()) + 1,
            )
        )
    return result


def audit(questions: list[Question]) -> list[str]:
    errors: list[str] = []
    ids = Counter(question.id for question in questions)
    duplicate_ids = [key for key, count in ids.items() if count != 1]
    if duplicate_ids:
        errors.append(f'Duplicate IDs: {duplicate_ids}')

    normalized_questions = Counter(
        re.sub(r'\W+', ' ', question.question.lower()).strip()
        for question in questions
    )
    duplicates = [key for key, count in normalized_questions.items() if count > 1]
    if duplicates:
        errors.append(f'Duplicate question text: {len(duplicates)}')

    option_sets = Counter(tuple(sorted(question.options)) for question in questions)
    repeated_option_sets = [key for key, count in option_sets.items() if count > 1]
    if repeated_option_sets:
        errors.append(f'Repeated four-option sets: {len(repeated_option_sets)}')

    banned_demo_phrases = {
        'basic electrical field question',
        'which practice is most correct for',
        'guess from cable color only',
        'bypass protection to finish faster',
        'ignore documentation and testing',
        'all planets',
    }
    theory_source = (ROOT / 'lib/data/content/theory_content.dart').read_text(encoding='utf-8')
    theory_ids = set(re.findall(r"\bid\s*:\s*['\"]([^'\"]+)['\"]", theory_source))

    for question in questions:
        if len(question.options) != 4:
            errors.append(f'{question.id}: expected 4 options, found {len(question.options)}')
            continue
        if not 0 <= question.correct_index < len(question.options):
            errors.append(f'{question.id}: correctIndex is out of range')
        if len(set(question.options)) != len(question.options):
            errors.append(f'{question.id}: duplicate options')
        if not question.question.strip().endswith('?'):
            errors.append(f'{question.id}: question should end with ?')
        if len(question.explanation.strip()) < 15:
            errors.append(f'{question.id}: explanation is too short')
        combined = ' '.join([question.question, *question.options, question.explanation]).lower()
        if any(phrase in combined for phrase in banned_demo_phrases):
            errors.append(f'{question.id}: demo/generic wording remains')
        if question.image_asset is not None and not (ROOT / question.image_asset).is_file():
            errors.append(f'{question.id}: missing image asset {question.image_asset}')
        if question.related_article_id is not None and question.related_article_id not in theory_ids:
            errors.append(f'{question.id}: unknown related article {question.related_article_id}')
        if question.answer.lower() not in question.explanation.lower():
            # This is an informational heuristic rather than a hard error for
            # numerical or explanatory answers.
            pass

    categories = defaultdict(list)
    for question in questions:
        categories[question.category].append(question)

    expected_categories = {
        'basics', 'safety', 'circuits', 'calculations',
        'motors', 'solar', 'standards', 'master',
    }
    if set(categories) != expected_categories:
        errors.append(f'Unexpected category set: {sorted(categories)}')
    for category, items in categories.items():
        if len(items) != 25:
            errors.append(f'{category}: expected 25 questions, found {len(items)}')
        items.sort(key=lambda question: int(question.id[1:]))
        counts = Counter(question.correct_index for question in items)
        if set(counts) != {0, 1, 2, 3} or max(counts.values()) - min(counts.values()) > 1:
            errors.append(f'{category}: answer positions are unbalanced: {dict(counts)}')
        if any(
            items[index].correct_index == items[index - 1].correct_index
            for index in range(1, len(items))
        ):
            errors.append(f'{category}: adjacent questions repeat the same answer position')

    global_counts = Counter(question.correct_index for question in questions)
    if global_counts != Counter({0: 50, 1: 50, 2: 50, 3: 50}):
        errors.append(f'Global answer positions must be 50 each: {dict(global_counts)}')
    return errors


def write_csv(questions: list[Question], path: Path):
    with path.open('w', newline='', encoding='utf-8-sig') as handle:
        writer = csv.writer(handle)
        writer.writerow([
            'id', 'category', 'difficulty', 'question',
            'option_a', 'option_b', 'option_c', 'option_d',
            'correct_letter', 'correct_answer', 'explanation', 'source_line',
        ])
        for item in questions:
            writer.writerow([
                item.id, item.category, item.difficulty, item.question,
                *item.options,
                'ABCD'[item.correct_index], item.answer,
                item.explanation, item.line,
            ])


def main() -> int:
    questions = load_questions()
    errors = audit(questions)
    categories = Counter(question.category for question in questions)
    answer_positions = Counter('ABCD'[question.correct_index] for question in questions)
    print('VoltMaster production quiz audit')
    print(f'  Questions: {len(questions)}')
    print(f'  Categories: {dict(sorted(categories.items()))}')
    print(f'  Correct-answer positions: {dict(answer_positions)}')
    if errors:
        print(f'  RESULT: FAIL ({len(errors)} issue(s))')
        for error in errors:
            print(f'   - {error}')
        return 1
    print('  RESULT: PASS')
    return 0


if __name__ == '__main__':
    sys.exit(main())
