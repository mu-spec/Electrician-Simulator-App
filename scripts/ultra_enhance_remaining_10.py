#!/usr/bin/env python3
"""
Ultra-enhance remaining 10 SVGs to highly professional realistic vector
Same style as dist_01.png AI reference: gradients, shadows, striped earth, detailed devices
Generator 05-07 + Smart 01-07
"""
import os

OUT_DIR = "assets/diagrams"

def header(w,h,title):
    return f'''<svg xmlns="http://www.w3.org/2000/svg" width="{w}" height="{h}" viewBox="0 0 {w} {h}">
  <defs>
    <linearGradient id="encG" x1="0" y1="0" x2="0" y2="1"><stop offset="0%" stop-color="#FFFFFF"/><stop offset="100%" stop-color="#F8FAFC"/></linearGradient>
    <linearGradient id="devG" x1="0" y1="0" x2="0" y2="1"><stop offset="0%" stop-color="#FFFFFF"/><stop offset="100%" stop-color="#F1F5F9"/></linearGradient>
    <linearGradient id="railG" x1="0" y1="0" x2="0" y2="1"><stop offset="0%" stop-color="#E2E8F0"/><stop offset="100%" stop-color="#94A3B8"/></linearGradient>
    <linearGradient id="metalG" x1="0" y1="0" x2="1" y2="1"><stop offset="0%" stop-color="#F8FAFC"/><stop offset="100%" stop-color="#CBD5E1"/></linearGradient>
    <pattern id="earthP" width="14" height="14" patternTransform="rotate(45)" patternUnits="userSpaceOnUse"><rect width="7" height="14" fill="#22C55E"/><rect x="7" width="7" height="14" fill="#EAB308"/></pattern>
    <pattern id="grid" width="22" height="22" patternUnits="userSpaceOnUse"><rect width="22" height="22" fill="none" stroke="#F1F5F9" stroke-width="1"/></pattern>
    <filter id="sh" x="-20%" y="-20%" width="140%" height="140%"><feDropShadow dx="0" dy="6" stdDeviation="8" flood-color="#0F172A" flood-opacity="0.08"/></filter>
    <filter id="dsh" x="-15%" y="-15%" width="130%" height="130%"><feDropShadow dx="0" dy="3" stdDeviation="4" flood-color="#0F172A" flood-opacity="0.1"/></filter>
  </defs>
  <rect width="{w}" height="{h}" fill="#FFFFFF"/>
  <rect width="{w}" height="{h}" fill="url(#grid)" opacity="0.6"/>
  <text x="{w/2}" y="42" text-anchor="middle" font-family="Inter,Arial,sans-serif" font-size="26" font-weight="800" fill="#0F172A">{title}</text>
'''

def footer(): return "</svg>"
def enc(x,y,w,h): return f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="14" fill="url(#encG)" stroke="#CBD5E1" stroke-width="2" filter="url(#sh)"/><rect x="{x}" y="{y}" width="{w}" height="{h}" rx="14" fill="none" stroke="#F1F5F9" stroke-width="1" opacity="0.8"/>'
def rail(x,y,w): return f'<rect x="{x}" y="{y}" width="{w}" height="28" rx="4" fill="url(#railG)" stroke="#64748B" stroke-width="1.2"/><circle cx="{x+18}" cy="{y+14}" r="6" fill="#CBD5E1" stroke="#64748B"/><circle cx="{x+w-18}" cy="{y+14}" r="6" fill="#CBD5E1" stroke="#64748B"/>'
def wire(d,c,wi=4,dash=""): return f'<path d="{d}" stroke="{c}" stroke-width="{wi}" fill="none" stroke-linecap="round" stroke-linejoin="round"{" stroke-dasharray=\""+dash+"\"" if dash else ""}/>'
def label(x,y,t,co="#0F172A",sz=12,w=700): return f'<text x="{x}" y="{y}" font-family="Arial" font-size="{sz}" font-weight="{w}" fill="{co}">{t}</text>'

def ensure(): os.makedirs(OUT_DIR, exist_ok=True)

def gen_05():
    w,h=1000,660
    s=header(w,h,"PORTABLE GENERATOR CHANGEOVER WIRING DIAGRAM")
    s+=enc(40,70,920,550)
    s+=label(200,100,"EXTERIOR WALL WITH INLET","#475569",12,600)
    s+=label(650,100,"DISTRIBUTION BOARD ROOM","#2563EB",12,600)
    # Inlet socket realistic
    s+='<g filter="url(#dsh)"><rect x="80" y="130" width="140" height="110" rx="12" fill="url(#metalG)" stroke="#64748B" stroke-width="1.8"/><rect x="100" y="150" width="100" height="70" rx="8" fill="#1E293B"/><circle cx="150" cy="185" r="22" fill="#334155" stroke="#94A3B8" stroke-width="2"/><circle cx="150" cy="185" r="6" fill="#FACC15"/><text x="150" y="235" text-anchor="middle" font-size="9" font-weight="700" fill="#0F172A">CEE 32A INLET</text><text x="150" y="247" text-anchor="middle" font-size="8" fill="#475569">Interlocked Flap</text></g>'
    s+='<g filter="url(#dsh)"><rect x="340" y="150" width="100" height="130" rx="8" fill="url(#devG)" stroke="#64748B" stroke-width="1.8"/><text x="390" y="175" text-anchor="middle" font-size="10" font-weight="700">Changeover</text><text x="390" y="188" text-anchor="middle" font-size="9" font-weight="700">I-O-II 63A</text><rect x="355" y="200" width="70" height="30" rx="6" fill="#0F172A"/><rect x="365" y="205" width="50" height="20" rx="4" fill="#334155"/><text x="390" y="250" text-anchor="middle" font-size="8">UTILITY OFF GEN</text><text x="390" y="260" text-anchor="middle" font-size="7" fill="#DC2626">No Backfeed</text></g>'
    s+='<g filter="url(#dsh)"><rect x="600" y="140" width="280" height="180" rx="10" fill="url(#encG)" stroke="#CBD5E1" stroke-width="1.8"/><text x="740" y="165" text-anchor="middle" font-size="11" font-weight="700">Load DB</text>'+rail(620,180,240)+'<rect x="630" y="220" width="60" height="80" rx="6" fill="white" stroke="#475569"/><text x="660" y="250" text-anchor="middle" font-size="8" font-weight="700">Main</text><rect x="710" y="220" width="50" height="80" rx="6" fill="white" stroke="#64748B"/><text x="735" y="250" text-anchor="middle" font-size="8">MCBs</text><rect x="780" y="220" width="50" height="80" rx="6" fill="#BFDBFE" stroke="#2563EB"/><text x="805" y="250" text-anchor="middle" font-size="8">RCD</text></g>'
    # Wires
    s+=wire("M 220 185 L 340 185","#DC2626",5)
    s+=wire("M 220 205 L 330 205 L 330 220 L 340 220","#2563EB",4)
    s+=wire("M 200 220 L 200 400 L 600 400","#16A34A",3,"8 4")
    s+=wire("M 440 280 L 600 280","#DC2626",5)
    s+=wire("M 440 300 L 600 300","#2563EB",4)
    s+=label(250,380,"Generator Cable 6mm² Flex + Earth","#DC2626",10,600)
    s+=label(80,500,"✓ Interlocked Inlet Prevents Live Pins ✓ IP44","#16A34A",11,700)
    s+=label(80,525,"⚠ Test under controlled load, check earthing arrangement","#DC2626",10,600)
    s+=footer()
    return s

def gen_06():
    w,h=1050,700
    s=header(w,h,"THREE PHASE GENERATOR ATS WIRING DIAGRAM")
    s+=enc(40,70,920,600)
    s+=label(500,100,"ATS PANEL WITH CONTROLLER DISPLAY","#0F172A",13,700)
    # ATS device
    s+='<g filter="url(#dsh)"><rect x="350" y="130" width="260" height="300" rx="12" fill="url(#devG)" stroke="#475569" stroke-width="2"/><text x="480" y="155" text-anchor="middle" font-size="12" font-weight="800">4-POLE ATS 63A 400V</text><rect x="370" y="170" width="220" height="30" rx="6" fill="#1E293B"/><text x="480" y="188" text-anchor="middle" font-size="9" fill="white">UTILITY L1 L2 L3 N (Normal)</text><rect x="380" y="210" width="20" height="20" rx="4" fill="#DC2626"/><rect x="410" y="210" width="20" height="20" rx="4" fill="#EAB308"/><rect x="440" y="210" width="20" height="20" rx="4" fill="#2563EB"/><rect x="470" y="210" width="20" height="20" rx="4" fill="#94A3B8"/><rect x="370" y="250" width="220" height="30" rx="6" fill="#7F1D1D"/><text x="480" y="268" text-anchor="middle" font-size="9" fill="white">GENERATOR L1 L2 L3 N (Emergency)</text><rect x="380" y="290" width="20" height="20" rx="4" fill="#DC2626"/><rect x="410" y="290" width="20" height="20" rx="4" fill="#EAB308"/><rect x="440" y="290" width="20" height="20" rx="4" fill="#2563EB"/><rect x="470" y="290" width="20" height="20" rx="4" fill="#94A3B8"/><rect x="370" y="340" width="220" height="30" rx="6" fill="#16A34A"/><text x="480" y="358" text-anchor="middle" font-size="9" fill="white">LOAD L1 L2 L3 N → DB</text></g>'
    s+='<g filter="url(#dsh)"><rect x="80" y="130" width="200" height="100" rx="10" fill="white" stroke="#CBD5E1" stroke-width="1.5"/><text x="180" y="155" text-anchor="middle" font-size="10" font-weight="700">Utility Incomer</text><text x="180" y="170" text-anchor="middle" font-size="9">L1 L2 L3 N from Meter</text><text x="180" y="185" text-anchor="middle" font-size="8">Red Yellow Blue N</text></g>'
    s+='<g filter="url(#dsh)"><rect x="80" y="280" width="200" height="100" rx="10" fill="#FEF3C7" stroke="#D97706" stroke-width="1.5"/><text x="180" y="305" text-anchor="middle" font-size="10" font-weight="700">Generator Incomer</text><text x="180" y="320" text-anchor="middle" font-size="9">L1 L2 L3 N 10kVA</text></g>'
    s+='<g filter="url(#dsh)"><rect x="700" y="200" width="220" height="200" rx="10" fill="white" stroke="#CBD5E1" stroke-width="1.5"/><text x="810" y="225" text-anchor="middle" font-size="10" font-weight="700">Generator Controller</text><text x="720" y="245" font-size="9">• Utility Fail Delay 3s</text><text x="720" y="262" font-size="9">• Start Signal 2-wire</text><text x="720" y="279" font-size="9">• Phase Rotation RYB</text><text x="720" y="296" font-size="9">• Neutral Switching</text><text x="720" y="313" font-size="9">• Transfer / Cooldown</text><circle cx="810" cy="350" r="20" fill="white" stroke="#64748B"/><text x="810" y="355" text-anchor="middle" font-size="8" font-weight="700">R-Y-B OK</text></g>'
    s+=wire("M 280 180 L 350 180","#DC2626",4)
    s+=wire("M 280 300 L 350 300","#DC2626",4)
    s+=wire("M 610 355 L 700 355","#DC2626",3)
    s+=footer()
    return s

def gen_07():
    w,h=1000,660
    s=header(w,h,"GENERATOR BATTERY CHARGER CIRCUIT DIAGRAM")
    s+=enc(40,70,920,550)
    s+='<g filter="url(#dsh)"><rect x="80" y="150" width="120" height="80" rx="8" fill="white" stroke="#64748B"/><text x="140" y="175" text-anchor="middle" font-size="9" font-weight="700">AC Supply</text><text x="140" y="188" text-anchor="middle" font-size="8">230V</text><rect x="90" y="195" width="100" height="20" rx="4" fill="#FECACA" stroke="#DC2626"/><text x="140" y="208" text-anchor="middle" font-size="8">Breaker 6A</text></g>'
    s+='<g filter="url(#dsh)"><rect x="280" y="130" width="180" height="140" rx="12" fill="url(#devG)" stroke="#D97706" stroke-width="1.8"/><text x="370" y="155" text-anchor="middle" font-size="11" font-weight="800">Smart Battery Charger</text><rect x="300" y="165" width="60" height="15" rx="7" fill="#22C55E"/><text x="330" y="176" text-anchor="middle" font-size="8" fill="white">Float</text><rect x="380" y="165" width="60" height="15" rx="7" fill="#3B82F6"/><text x="410" y="176" text-anchor="middle" font-size="8" fill="white">13.8V</text><text x="370" y="200" text-anchor="middle" font-size="9">Maintainer Mode</text><text x="370" y="215" text-anchor="middle" font-size="8">LED Indicators</text><text x="370" y="235" text-anchor="middle" font-size="8">AC→DC Isolated</text></g>'
    s+='<g filter="url(#dsh)"><rect x="550" y="180" width="140" height="20" rx="4" fill="#FEF3C7" stroke="#D97706"/><text x="620" y="193" text-anchor="middle" font-size="9" font-weight="700">DC Fuse 10A</text></g>'
    s+='<g filter="url(#dsh)"><rect x="750" y="130" width="160" height="160" rx="12" fill="url(#devG)" stroke="#0F172A" stroke-width="2"/><text x="830" y="155" text-anchor="middle" font-size="10" font-weight="800">Generator Starting Battery</text><text x="830" y="170" text-anchor="middle" font-size="9">12V 70Ah</text><rect x="780" y="180" width="30" height="20" rx="4" fill="#DC2626"/><text x="795" y="193" text-anchor="middle" font-size="8" fill="white">+</text><rect x="870" y="180" width="30" height="20" rx="4" fill="#0F172A"/><text x="885" y="193" text-anchor="middle" font-size="8" fill="white">-</text><text x="830" y="230" text-anchor="middle" font-size="9">Red + Black -</text><text x="830" y="245" text-anchor="middle" font-size="8">Polarity Observe!</text><text x="830" y="265" text-anchor="middle" font-size="9" font-weight="700">13.8V Float</text></g>'
    s+=wire("M 200 190 L 280 190","#DC2626",4)
    s+=wire("M 460 200 L 550 190","#DC2626",3)
    s+=wire("M 690 190 L 750 190","#DC2626",4)
    s+=wire("M 690 210 L 750 210","#0F172A",4)
    s+=label(400,350,"Isolated AC→DC prevents feedback","#16A34A",11,600)
    s+=footer()
    return s

def smart_01():
    w,h=1000,660
    s=header(w,h,"SMART SWITCH WITHOUT NEUTRAL WIRING DIAGRAM")
    s+=enc(40,70,920,550)
    s+='<g filter="url(#dsh)"><rect x="80" y="140" width="140" height="80" rx="8" fill="white" stroke="#64748B"/><text x="150" y="165" text-anchor="middle" font-size="9" font-weight="700">Switch Box</text><text x="150" y="178" text-anchor="middle" font-size="8">No Neutral!</text><text x="150" y="190" text-anchor="middle" font-size="8" fill="#DC2626">Only L + L1</text></g>'
    s+='<g filter="url(#dsh)"><rect x="300" y="130" width="160" height="130" rx="12" fill="url(#devG)" stroke="#8B5CF6" stroke-width="2"/><text x="380" y="155" text-anchor="middle" font-size="10" font-weight="800">No-Neutral Smart Switch</text><text x="380" y="172" text-anchor="middle" font-size="9">L Input Red Live</text><text x="380" y="185" text-anchor="middle" font-size="9">L1 Output Switched Live</text><circle cx="320" cy="200" r="5" fill="#DC2626"/><circle cx="440" cy="200" r="5" fill="#F87171"/><text x="380" y="220" text-anchor="middle" font-size="8">WiFi Zigbee</text><text x="380" y="235" text-anchor="middle" font-size="8">Needs Bypass? Check</text></g>'
    s+='<g filter="url(#dsh)"><circle cx="700" cy="200" r="60" fill="white" stroke="#64748B" stroke-width="1.8"/><text x="700" y="195" text-anchor="middle" font-size="11" font-weight="700">Ceiling Light</text><text x="700" y="210" text-anchor="middle" font-size="8">LED Load</text><rect x="660" y="230" width="80" height="30" rx="6" fill="#FEF3C7" stroke="#D97706"/><text x="700" y="248" text-anchor="middle" font-size="8" font-weight="700">Bypass Capacitor</text><text x="700" y="258" text-anchor="middle" font-size="7">If required</text></g>'
    s+=wire("M 220 180 L 300 180","#DC2626",4)
    s+=wire("M 460 200 L 640 200","#F87171",4)
    s+=wire("M 700 260 L 700 400 L 200 400 L 200 210 L 320 210","#16A34A",3,"6 3")
    s+=wire("M 640 230 L 640 350 L 400 350","#2563EB",3)
    s+=label(500,350,"Blue Neutral Direct To Light","#2563EB",10,600)
    s+=label(80,500,"⚠ Confirm switch rated for no-neutral + bypass at load","#D97706",11,600)
    s+=footer()
    return s

def smart_02():
    w,h=1000,660
    s=header(w,h,"SMART SWITCH WITH NEUTRAL (PREFERRED) WIRING DIAGRAM")
    s+=enc(40,70,920,550)
    s+='<g filter="url(#dsh)"><rect x="80" y="140" width="160" height="100" rx="8" fill="white" stroke="#64748B"/><text x="160" y="165" text-anchor="middle" font-size="10" font-weight="700">Switch Box</text><text x="160" y="180" text-anchor="middle" font-size="9">L N E Present</text><text x="160" y="193" text-anchor="middle" font-size="8" fill="#16A34A">Preferred Method</text></g>'
    s+='<g filter="url(#dsh)"><rect x="320" y="130" width="180" height="150" rx="12" fill="url(#devG)" stroke="#8B5CF6" stroke-width="2"/><text x="410" y="155" text-anchor="middle" font-size="11" font-weight="800">Smart Switch With Neutral</text><circle cx="340" cy="180" r="6" fill="#DC2626" stroke="#7F1D1D"/><text x="360" y="183" font-size="9">L Red Permanent Live</text><circle cx="340" cy="205" r="6" fill="#2563EB" stroke="#1E40AF"/><text x="360" y="208" font-size="9">N Blue Neutral</text><circle cx="340" cy="230" r="6" fill="#F87171"/><text x="360" y="233" font-size="9">L1 Switched Live to Light</text><text x="410" y="260" text-anchor="middle" font-size="8">WiFi Icon + App</text></g>'
    s+='<g filter="url(#dsh)"><circle cx="750" cy="200" r="65" fill="white" stroke="#64748B" stroke-width="1.8"/><text x="750" y="195" text-anchor="middle" font-size="11" font-weight="700">Light Fixture</text><text x="750" y="210" text-anchor="middle" font-size="9">L N E</text><circle cx="720" cy="230" r="4" fill="#F87171"/><circle cx="750" cy="230" r="4" fill="#2563EB"/><circle cx="780" cy="230" r="4" fill="#16A34A"/></g>'
    s+=wire("M 240 180 L 320 180","#DC2626",4)
    s+=wire("M 240 200 L 320 205","#2563EB",4)
    s+=wire("M 240 220 L 300 220 L 300 400 L 750 400","#16A34A",3,"6 3")
    s+=wire("M 500 230 L 685 230","#F87171",4)
    s+=wire("M 360 205 L 400 300 L 685 230","#2563EB",2)
    s+=label(500,300,"Earth Continuity To Box & Fixture","#16A34A",10,600)
    s+=label(500,420,"✓ Most Reliable, No Bypass Needed","#16A34A",11,700)
    s+=footer()
    return s

def smart_03():
    w,h=1000,680
    s=header(w,h,"SMART RELAY MODULE WIRING DIAGRAM")
    s+=enc(40,70,920,580)
    s+='<g filter="url(#dsh)"><rect x="80" y="140" width="160" height="80" rx="8" fill="white" stroke="#64748B"/><text x="160" y="165" text-anchor="middle" font-size="10" font-weight="700">Existing Switch</text><text x="160" y="180" text-anchor="middle" font-size="9">S1 S2 Input</text></g>'
    s+='<g filter="url(#dsh)"><rect x="320" y="130" width="200" height="140" rx="12" fill="url(#devG)" stroke="#0F766E" stroke-width="2"/><text x="420" y="155" text-anchor="middle" font-size="11" font-weight="800">Smart Relay Module</text><text x="340" y="180" font-size="9">L Red Power Input</text><text x="340" y="195" font-size="9">N Blue Power Input</text><text x="340" y="210" font-size="9">COM NO Output Contact</text><text x="340" y="225" font-size="9">S1 S2 Manual Switch Input</text><circle cx="490" cy="240" r="8" fill="#22C55E"/><text x="420" y="260" text-anchor="middle" font-size="8">Tucked Behind Switch</text></g>'
    s+='<g filter="url(#dsh)"><circle cx="700" cy="200" r="60" fill="white" stroke="#64748B"/><text x="700" y="195" text-anchor="middle" font-size="11" font-weight="700">Lamp Load</text><text x="700" y="210" text-anchor="middle" font-size="9">Live via Relay</text></g>'
    s+='<g filter="url(#dsh)"><rect x="80" y="350" width="840" height="80" rx="10" fill="#FFFBEB" stroke="#FDE68A"/><text x="90" y="375" font-size="10" font-weight="700">Wiring:</text><text x="90" y="395" font-size="10">• Permanent L N to relay power • Relay COM NO in series with load live • S1 S2 to existing wall switch • Use approved connectors Wago, enclosure with space</text></g>'
    s+=wire("M 240 170 L 320 170","#64748B",3)
    s+=wire("M 160 220 L 160 400 L 420 400 L 420 260","#2563EB",3)
    s+=wire("M 520 210 L 640 200","#DC2626",4)
    s+=footer()
    return s

def smart_04():
    w,h=1050,700
    s=header(w,h,"SMART BREAKER CONCEPT WIRING DIAGRAM")
    s+=enc(40,70,970,600)
    s+=rail(70,130,910)
    s+='<g filter="url(#dsh)"><rect x="80" y="170" width="70" height="90" rx="6" fill="white" stroke="#475569"/><text x="115" y="195" text-anchor="middle" font-size="8" font-weight="700">Main</text></g>'
    s+='<g filter="url(#dsh)"><rect x="170" y="170" width="100" height="120" rx="8" fill="url(#devG)" stroke="#8B5CF6" stroke-width="2"/><text x="220" y="195" text-anchor="middle" font-size="9" font-weight="800">Smart Breaker</text><circle cx="190" cy="210" r="6" fill="#22C55E"/><text x="210" y="213" font-size="8">WiFi</text><rect x="180" y="225" width="80" height="20" rx="4" fill="#0F172A"/><text x="220" y="238" text-anchor="middle" font-size="8" fill="#22C55E">32A 6kA</text><text x="220" y="255" text-anchor="middle" font-size="8">Trip Log</text></g>'
    s+='<g filter="url(#dsh)"><rect x="320" y="190" width="200" height="80" rx="8" fill="white" stroke="#CBD5E1"/><text x="420" y="210" text-anchor="middle" font-size="10" font-weight="700">Mobile App</text><text x="420" y="225" text-anchor="middle" font-size="8">Current Power Energy</text><text x="420" y="240" text-anchor="middle" font-size="8">Trip Logging Remote Status</text></g>'
    s+='<g filter="url(#dsh)"><rect x="600" y="190" width="200" height="80" rx="8" fill="#FEE2E2" stroke="#FECACA"/><text x="700" y="210" text-anchor="middle" font-size="10" font-weight="700" fill="#7F1D1D">Safety Warning</text><text x="700" y="225" text-anchor="middle" font-size="8">Use Physical Lockout</text><text x="700" y="240" text-anchor="middle" font-size="8">Do Not Rely On Remote OFF</text><text x="700" y="255" text-anchor="middle" font-size="8">For Maintenance</text></g>'
    s+=wire("M 150 260 L 170 220","#DC2626",4)
    s+=wire("M 270 230 L 320 220","#22C55E",2)
    s+=wire("M 220 290 L 220 330 L 400 330","#2563EB",3)
    s+=footer()
    return s

def smart_05():
    w,h=1000,700
    s=header(w,h,"ZIGBEE SMART RELAY LIGHTING WIRING DIAGRAM")
    s+=enc(40,70,920,600)
    s+='<g filter="url(#dsh)"><rect x="80" y="140" width="120" height="80" rx="8" fill="white" stroke="#64748B"/><text x="140" y="165" text-anchor="middle" font-size="9" font-weight="700">Manual Switch</text><text x="140" y="180" text-anchor="middle" font-size="8">Existing</text></g>'
    s+='<g filter="url(#dsh)"><rect x="280" y="130" width="180" height="150" rx="12" fill="url(#devG)" stroke="#0F766E" stroke-width="2"/><text x="370" y="155" text-anchor="middle" font-size="11" font-weight="800">Zigbee Relay Module</text><text x="300" y="175" font-size="9">L Red Supply</text><text x="300" y="190" font-size="9">N Blue Supply</text><text x="300" y="205" font-size="9">Output To Lamp Live</text><text x="300" y="220" font-size="9">S1 Manual Switch Input</text><circle cx="430" cy="250" r="10" fill="#6366F1"/><text x="370" y="270" text-anchor="middle" font-size="8">Zigbee Pairing</text></g>'
    s+='<g filter="url(#dsh)"><circle cx="650" cy="200" r="55" fill="white" stroke="#64748B"/><text x="650" y="195" text-anchor="middle" font-size="11" font-weight="700">Light Load</text></g>'
    s+='<g filter="url(#dsh)"><rect x="780" y="130" width="140" height="100" rx="12" fill="white" stroke="#6366F1" stroke-width="1.8"/><text x="850" y="155" text-anchor="middle" font-size="10" font-weight="700">Zigbee Hub</text><text x="850" y="172" text-anchor="middle" font-size="8">Coordinator</text><circle cx="850" cy="195" r="12" fill="#6366F1"/><text x="850" y="220" text-anchor="middle" font-size="8">Router</text></g>'
    s+=wire("M 200 170 L 280 170","#64748B",3)
    s+=wire("M 460 200 L 595 200","#DC2626",4)
    s+=wire("M 460 180 L 460 120 L 780 120 L 780 140","#22C55E",2)
    s+=footer()
    return s

def smart_06():
    w,h=1050,700
    s=header(w,h,"SMART CONTACTOR FOR HEAVY LOAD WIRING DIAGRAM")
    s+=enc(40,70,970,600)
    s+='<g filter="url(#dsh)"><rect x="80" y="150" width="100" height="60" rx="6" fill="white" stroke="#64748B"/><text x="130" y="175" text-anchor="middle" font-size="9" font-weight="700">MCB 32A</text><text x="130" y="188" text-anchor="middle" font-size="8">Power Circuit</text></g>'
    s+='<g filter="url(#dsh)"><rect x="220" y="130" width="140" height="100" rx="8" fill="white" stroke="#64748B" stroke-width="1.8"/><text x="290" y="155" text-anchor="middle" font-size="10" font-weight="700">Contactor 3-Pole</text><text x="290" y="170" text-anchor="middle" font-size="9">Contacts to Heavy Load</text><text x="290" y="185" text-anchor="middle" font-size="9">A1 A2 Coil</text><circle cx="250" cy="205" r="4" fill="#0F172A"/><circle cx="330" cy="205" r="4" fill="#0F172A"/></g>'
    s+='<g filter="url(#dsh)"><rect x="420" y="140" width="140" height="100" rx="8" fill="white" stroke="#B45309" stroke-width="1.8"/><text x="490" y="165" text-anchor="middle" font-size="10" font-weight="700">Heavy Load</text><text x="490" y="180" text-anchor="middle" font-size="9">Water Heater / Motor / AC</text><text x="490" y="195" text-anchor="middle" font-size="8">High Power</text></g>'
    s+='<g filter="url(#dsh)"><rect x="650" y="130" width="180" height="120" rx="12" fill="url(#devG)" stroke="#8B5CF6" stroke-width="2"/><text x="740" y="155" text-anchor="middle" font-size="11" font-weight="800">Smart Relay</text><text x="670" y="175" font-size="9">L N Power</text><text x="670" y="190" font-size="9">Output NO → Coil A1</text><text x="670" y="205" font-size="9">Drives Coil Only!</text><text x="670" y="220" font-size="9" fill="#DC2626">Not Direct Load</text></g>'
    s+=wire("M 180 180 L 220 180","#DC2626",4)
    s+=wire("M 360 180 L 420 180","#DC2626",4)
    s+=wire("M 740 220 L 740 300 L 290 300 L 290 230","#8B5CF6",3)
    s+=label(650,300,"Manual Isolation + Local Stop Required","#DC2626",10,700)
    s+=footer()
    return s

def smart_07():
    w,h=1050,700
    s=header(w,h,"ENERGY MONITOR CT WIRING DIAGRAM")
    s+=enc(40,70,970,600)
    s+=rail(70,130,910)
    s+='<g filter="url(#dsh)"><rect x="80" y="170" width="80" height="60" rx="6" fill="white" stroke="#475569"/><text x="120" y="195" text-anchor="middle" font-size="8" font-weight="700">Main</text></g>'
    s+='<g filter="url(#dsh)"><rect x="200" y="170" width="500" height="80" rx="8" fill="#F8FAFC" stroke="#CBD5E1"/><text x="450" y="190" text-anchor="middle" font-size="10" font-weight="700">Phase Conductors L1 L2 L3</text><rect x="250" y="200" width="60" height="40" rx="20" fill="none" stroke="#DC2626" stroke-width="4"/><text x="280" y="195" text-anchor="middle" font-size="8">CT1 Arrow → Load</text><rect x="350" y="200" width="60" height="40" rx="20" fill="none" stroke="#EAB308" stroke-width="4"/><text x="380" y="195" text-anchor="middle" font-size="8">CT2</text><rect x="450" y="200" width="60" height="40" rx="20" fill="none" stroke="#2563EB" stroke-width="4"/><text x="480" y="195" text-anchor="middle" font-size="8">CT3</text></g>'
    s+='<g filter="url(#dsh)"><rect x="750" y="140" width="200" height="160" rx="12" fill="url(#devG)" stroke="#06B6D4" stroke-width="2"/><text x="850" y="165" text-anchor="middle" font-size="11" font-weight="800">Energy Monitor Module</text><text x="770" y="185" font-size="9">CT Inputs 1 2 3</text><text x="770" y="200" font-size="9">Voltage Reference via Fuse</text><text x="770" y="215" font-size="9">Safe Connection to N</text><text x="770" y="230" font-size="9">WiFi Communication</text><text x="770" y="245" font-size="9">App: Circuit Names + Power</text><circle cx="850" cy="275" r="12" fill="#06B6D4"/><text x="850" y="280" text-anchor="middle" font-size="8" fill="white">WiFi</text></g>'
    s+=wire("M 280 240 L 750 210","#DC2626",2)
    s+=wire("M 380 240 L 750 230","#EAB308",2)
    s+=wire("M 480 240 L 750 250","#2563EB",2)
    s+=label(100,330,"Observe CT direction arrow to load, verify with known load e.g. kettle 2kW","#16A34A",11,600)
    s+=footer()
    return s

def main():
    ensure()
    gens = {
        "generator_05.svg": gen_05,
        "generator_06.svg": gen_06,
        "generator_07.svg": gen_07,
        "smart_01.svg": smart_01,
        "smart_02.svg": smart_02,
        "smart_03.svg": smart_03,
        "smart_04.svg": smart_04,
        "smart_05.svg": smart_05,
        "smart_06.svg": smart_06,
        "smart_07.svg": smart_07,
    }
    for fname, fn in gens.items():
        path = os.path.join(OUT_DIR, fname)
        with open(path, 'w', encoding='utf-8') as f:
            f.write(fn())
        print(f"Ultra-enhanced {path} -> {os.path.getsize(path)} bytes")

if __name__ == "__main__":
    main()
