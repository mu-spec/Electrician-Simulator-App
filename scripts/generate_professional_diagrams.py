#!/usr/bin/env python3
"""
Generate professional electrical wiring diagrams as SVG
Style matches the reference SINGLE PHASE DISTRIBUTION BOARD image:
- White enclosure with subtle gradient and shadow
- Earth bar with green-yellow stripes
- Neutral bar blue
- Realistic MCB/RCD/Main Switch devices with screws and toggles
- Color coded wires: Red live, Blue neutral, Green-yellow earth (striped), Yellow L2, Blue L3 variations
- Title at top bold
- Clean professional textbook style
"""

import os

OUTPUT_DIR = "assets/diagrams"

def ensure_dir():
    os.makedirs(OUTPUT_DIR, exist_ok=True)

def svg_header(width, height, title):
    return f'''<svg xmlns="http://www.w3.org/2000/svg" width="{width}" height="{height}" viewBox="0 0 {width} {height}">
  <defs>
    <linearGradient id="enclosureGrad" x1="0" y1="0" x2="0" y2="1">
      <stop offset="0%" stop-color="#FFFFFF"/>
      <stop offset="100%" stop-color="#F8FAFC"/>
    </linearGradient>
    <linearGradient id="deviceGrad" x1="0" y1="0" x2="0" y2="1">
      <stop offset="0%" stop-color="#FFFFFF"/>
      <stop offset="100%" stop-color="#F1F5F9"/>
    </linearGradient>
    <linearGradient id="railGrad" x1="0" y1="0" x2="0" y2="1">
      <stop offset="0%" stop-color="#E2E8F0"/>
      <stop offset="100%" stop-color="#94A3B8"/>
    </linearGradient>
    <pattern id="earthStripes" width="14" height="14" patternTransform="rotate(45)" patternUnits="userSpaceOnUse">
      <rect width="7" height="14" fill="#22C55E"/>
      <rect x="7" width="7" height="14" fill="#EAB308"/>
    </pattern>
    <pattern id="grid" width="22" height="22" patternUnits="userSpaceOnUse">
      <rect width="22" height="22" fill="none" stroke="#F1F5F9" stroke-width="1"/>
    </pattern>
    <filter id="shadow" x="-20%" y="-20%" width="140%" height="140%">
      <feDropShadow dx="0" dy="6" stdDeviation="8" flood-color="#0F172A" flood-opacity="0.08"/>
    </filter>
    <filter id="deviceShadow" x="-15%" y="-15%" width="130%" height="130%">
      <feDropShadow dx="0" dy="3" stdDeviation="4" flood-color="#0F172A" flood-opacity="0.1"/>
    </filter>
  </defs>
  <rect width="{width}" height="{height}" fill="#FFFFFF"/>
  <rect width="{width}" height="{height}" fill="url(#grid)" opacity="0.6"/>
  <text x="{width/2}" y="42" text-anchor="middle" font-family="Inter, Arial, sans-serif" font-size="26" font-weight="800" fill="#0F172A" letter-spacing="0.5">{title}</text>
'''

def svg_footer():
    return '</svg>'

def enclosure(x,y,w,h, rx=14):
    return f'''
  <rect x="{x}" y="{y}" width="{w}" height="{h}" rx="{rx}" fill="url(#enclosureGrad)" stroke="#CBD5E1" stroke-width="2" filter="url(#shadow)"/>
  <rect x="{x}" y="{y}" width="{w}" height="{h}" rx="{rx}" fill="none" stroke="#F1F5F9" stroke-width="1" opacity="0.8"/>
'''

def din_rail(x,y,w):
    return f'<rect x="{x}" y="{y}" width="{w}" height="28" rx="4" fill="url(#railGrad)" stroke="#64748B" stroke-width="1.2"/> <circle cx="{x+18}" cy="{y+14}" r="6" fill="#CBD5E1" stroke="#64748B" stroke-width="1"/> <circle cx="{x+w-18}" cy="{y+14}" r="6" fill="#CBD5E1" stroke="#64748B" stroke-width="1"/>'

def earth_bar(x,y,w, terminals=10, label="EARTH BAR (MET)"):
    t = ""
    screw_spacing = w / terminals
    for i in range(terminals):
        sx = x + screw_spacing*i + screw_spacing/2
        t += f'<circle cx="{sx}" cy="{y+9}" r="6.5" fill="#FEFCE8" stroke="#A16207" stroke-width="1.2"/><text x="{sx}" y="{y+12.5}" text-anchor="middle" font-family="monospace" font-size="9" fill="#854D0E">+</text>'
        if i<6:
            t += f'<path d="M {sx} {y+18} C {sx} {y+38}, {sx-8} {y+48}, {sx-12} {y+58}" stroke="#16A34A" stroke-width="3.5" stroke-dasharray="6 2" fill="none" stroke-linecap="round"/>'
    return f'''
  <g>
    <rect x="{x}" y="{y}" width="{w}" height="18" rx="3" fill="url(#earthStripes)" stroke="#CA8A04" stroke-width="1.8"/>
    <text x="{x+w/2}" y="{y-8}" text-anchor="middle" font-family="Arial" font-size="12" font-weight="700" fill="#0F172A">{label}</text>
    {t}
  </g>
'''

def neutral_bar(x,y,w, terminals=10, label="NEUTRAL BAR"):
    t = ""
    screw_spacing = w / terminals
    for i in range(terminals):
        sx = x + screw_spacing*i + screw_spacing/2
        t += f'<circle cx="{sx}" cy="{y+9}" r="6.5" fill="#EFF6FF" stroke="#2563EB" stroke-width="1.2"/><text x="{sx}" y="{y+12.5}" text-anchor="middle" font-family="monospace" font-size="9" fill="#1E40AF">+</text>'
        if i<5:
            t += f'<path d="M {sx} {y+18} C {sx} {y+40}, {sx+5} {y+50}, {sx+8} {y+65}" stroke="#2563EB" stroke-width="3.5" fill="none" stroke-linecap="round"/>'
    return f'''
  <g>
    <rect x="{x}" y="{y}" width="{w}" height="18" rx="3" fill="#BFDBFE" stroke="#2563EB" stroke-width="1.8"/>
    <text x="{x+w/2}" y="{y-8}" text-anchor="middle" font-family="Arial" font-size="12" font-weight="700" fill="#0F172A">{label}</text>
    {t}
  </g>
'''

def mcb_device(x,y, rating="16A", description="Socket", toggle_state="on", width=78, height=132, has_neutral=False):
    # screws
    screws = f'<circle cx="{x+14}" cy="{y+10}" r="5" fill="#E2E8F0" stroke="#64748B" stroke-width="1"/><circle cx="{x+width-14}" cy="{y+10}" r="5" fill="#E2E8F0" stroke="#64748B" stroke-width="1"/><circle cx="{x+14}" cy="{y+height-10}" r="5" fill="#E2E8F0" stroke="#64748B" stroke-width="1"/><circle cx="{x+width-14}" cy="{y+height-10}" r="5" fill="#E2E8F0" stroke="#64748B" stroke-width="1"/>'
    toggle = f'<rect x="{x+18}" y="{y+58}" width="{width-36}" height="22" rx="3" fill="#0F172A"/><rect x="{x+20}" y="{y+46}" width="{width-40}" height="14" rx="2" fill="#334155"/>' if toggle_state=="on" else f'<rect x="{x+18}" y="{y+80}" width="{width-36}" height="22" rx="3" fill="#0F172A"/><rect x="{x+20}" y="{y+82}" width="{width-40}" height="14" rx="2" fill="#334155"/>'
    return f'''
  <g filter="url(#deviceShadow)">
    <rect x="{x}" y="{y}" width="{width}" height="{height}" rx="6" fill="url(#deviceGrad)" stroke="#64748B" stroke-width="1.8"/>
    {screws}
    <text x="{x+width/2}" y="{y+32}" text-anchor="middle" font-family="Arial" font-size="12" font-weight="800" fill="#0F172A">{rating}</text>
    {toggle}
    <text x="{x+width/2}" y="{y+height-24}" text-anchor="middle" font-family="Arial" font-size="9.5" font-weight="600" fill="#475569">{description}</text>
    <text x="{x+width/2}" y="{y+height-12}" text-anchor="middle" font-family="Arial" font-size="8" fill="#64748B">{rating} MCB</text>
  </g>
'''

def main_switch(x,y, rating="100A DP"):
    screws = f'<circle cx="{x+14}" cy="{y+10}" r="5" fill="#E2E8F0" stroke="#64748B" stroke-width="1"/><circle cx="{x+58}" cy="{y+10}" r="5" fill="#E2E8F0" stroke="#64748B" stroke-width="1"/><circle cx="{x+14}" cy="{y+122}" r="5" fill="#E2E8F0" stroke="#64748B" stroke-width="1"/><circle cx="{x+58}" cy="{y+122}" r="5" fill="#E2E8F0" stroke="#64748B" stroke-width="1"/>'
    return f'''
  <g filter="url(#deviceShadow)">
    <rect x="{x}" y="{y}" width="72" height="132" rx="6" fill="url(#deviceGrad)" stroke="#475569" stroke-width="2"/>
    {screws}
    <text x="{x+36}" y="{y+28}" text-anchor="middle" font-family="Arial" font-size="9" font-weight="700" fill="#0F172A">Main Switch</text>
    <text x="{x+36}" y="{y+40}" text-anchor="middle" font-family="Arial" font-size="10" font-weight="800" fill="#0F172A">{rating}</text>
    <rect x="{x+10}" y="{y+52}" width="52" height="20" rx="3" fill="#0F172A"/><rect x="{x+12}" y="{y+54}" width="22" height="16" rx="2" fill="#1E293B" stroke="#475569"/><rect x="{x+38}" y="{y+54}" width="22" height="16" rx="2" fill="#1E293B" stroke="#475569"/>
    <text x="{x+36}" y="{y+100}" text-anchor="middle" font-family="Arial" font-size="8" fill="#64748B">ON OFF</text>
  </g>
'''

def rcd_device(x,y, rating="63A 30mA"):
    screws = f'<circle cx="{x+14}" cy="{y+10}" r="5" fill="#E2E8F0" stroke="#64748B" stroke-width="1"/><circle cx="{x+58}" cy="{y+10}" r="5" fill="#E2E8F0" stroke="#64748B" stroke-width="1"/><circle cx="{x+14}" cy="{y+122}" r="5" fill="#E2E8F0" stroke="#64748B" stroke-width="1"/><circle cx="{x+58}" cy="{y+122}" r="5" fill="#E2E8F0" stroke="#64748B" stroke-width="1"/>'
    return f'''
  <g filter="url(#deviceShadow)">
    <rect x="{x}" y="{y}" width="72" height="132" rx="6" fill="url(#deviceGrad)" stroke="#64748B" stroke-width="1.8"/>
    {screws}
    <rect x="{x+8}" y="{y+26}" width="24" height="14" rx="2" fill="#FACC15" stroke="#CA8A04" stroke-width="1"/>
    <rect x="{x+40}" y="{y+26}" width="24" height="6" rx="2" fill="#BFDBFE" stroke="#2563EB"/>
    <text x="{x+36}" y="{y+58}" text-anchor="middle" font-family="Arial" font-size="11" font-weight="800" fill="#0F172A">RCD</text>
    <rect x="{x+18}" y="{y+66}" width="36" height="26" rx="3" fill="#0F172A"/><rect x="{x+20}" y="{y+68}" width="32" height="14" rx="2" fill="#334155"/>
    <text x="{x+36}" y="{y+110}" text-anchor="middle" font-family="Arial" font-size="9" font-weight="700" fill="#0F172A">{rating}</text>
  </g>
'''

def spd_device(x,y):
    screws = f'<circle cx="{x+14}" cy="{y+10}" r="5" fill="#E2E8F0" stroke="#64748B" stroke-width="1"/><circle cx="{x+58}" cy="{y+10}" r="5" fill="#E2E8F0" stroke="#64748B" stroke-width="1"/><circle cx="{x+14}" cy="{y+122}" r="5" fill="#E2E8F0" stroke="#64748B" stroke-width="1"/><circle cx="{x+58}" cy="{y+122}" r="5" fill="#E2E8F0" stroke="#64748B" stroke-width="1"/>'
    return f'''
  <g filter="url(#deviceShadow)">
    <rect x="{x}" y="{y}" width="72" height="132" rx="6" fill="#FEF3C7" stroke="#D97706" stroke-width="1.8"/>
    {screws}
    <rect x="{x+18}" y="{y+26}" width="36" height="14" rx="7" fill="#22C55E" stroke="#16A34A"/><text x="{x+36}" y="{y+36}" text-anchor="middle" font-size="8" font-weight="800" fill="white">OK</text>
    <text x="{x+36}" y="{y+58}" text-anchor="middle" font-family="Arial" font-size="10" font-weight="800" fill="#92400E">SPD</text>
    <text x="{x+36}" y="{y+70}" text-anchor="middle" font-size="8" fill="#92400E">T2 40kA</text>
    <rect x="{x+10}" y="{y+80}" width="52" height="20" rx="3" fill="#F59E0B"/>
    <text x="{x+36}" y="{y+110}" text-anchor="middle" font-size="8" font-weight="600" fill="#78350F">SURGE</text>
  </g>
'''

def busbar(x,y,w):
    return f'<rect x="{x}" y="{y}" width="{w}" height="10" rx="3" fill="#FECACA" stroke="#DC2626" stroke-width="1.5"/>'

def wire_path(d, color, width=4, dash=""):
    dash_attr = f' stroke-dasharray="{dash}"' if dash else ''
    return f'<path d="{d}" stroke="{color}" stroke-width="{width}" fill="none" stroke-linecap="round" stroke-linejoin="round"{dash_attr}/>'

def label(x,y, text, color="#0F172A", size=12, weight=600):
    return f'<text x="{x}" y="{y}" font-family="Arial" font-size="{size}" font-weight="{weight}" fill="{color}">{text}</text>'

def small_label(x,y, text, color="#334155", size=10):
    return f'<text x="{x}" y="{y}" font-family="Arial" font-size="{size}" fill="{color}">{text}</text>'

# ================= GENERATORS =================

def generate_dist_01():
    w,h = 1000, 680
    s = svg_header(w,h,"SINGLE PHASE DISTRIBUTION BOARD WIRING DIAGRAM")
    s += enclosure(40,70,w-80,h-110)
    s += din_rail(80, 360, w-160)
    s += earth_bar(340, 108, 260, 10)
    s += neutral_bar(660, 108, 260, 10)
    s += main_switch(80, 320)
    s += rcd_device(190, 320)
    s += mcb_device(300, 320, "6A", "Lighting")
    s += mcb_device(400, 320, "10A", "immersion")
    s += mcb_device(500, 320, "16A", "Radial sockets")
    s += mcb_device(600, 320, "20A", "Ring Main")
    s += mcb_device(700, 320, "32A", "Cooker")
    s += busbar(310, 466, 470)
    # Incoming
    s += wire_path("M 96 590 L 96 452","#DC2626",5)
    s += wire_path("M 136 590 L 136 452","#2563EB",5)
    s += wire_path("M 176 590 L 176 430 L 340 430 L 340 126","#16A34A",3.5,"8 4")
    # Main to RCD
    s += wire_path("M 94 330 L 94 280 L 204 280 L 204 330","#DC2626",4.5)
    s += wire_path("M 134 330 L 134 295 L 244 295 L 244 330","#2563EB",4.5)
    # RCD to busbar
    s += wire_path("M 226 452 L 226 500 L 310 500 L 310 471","#DC2626",5)
    s += wire_path("M 266 330 L 266 360 L 660 360 L 660 126","#2563EB",4)
    # Earth wires from MCBs
    for mx in [338,438,538,638,738]:
        s += wire_path(f"M {mx+62} 330 L {mx+62} 280 L {mx+20} 280 L {mx+20} 126","#16A34A",2.5,"6 3")
        s += wire_path(f"M {mx+38} 330 L {mx+38} 260 L {mx+10} 260 L {mx+28} 260 L 680 260 L 680 126","#2563EB",3)
        s += wire_path(f"M {mx+39} 452 L {mx+39} 560","#DC2626",3.5)
        s += wire_path(f"M {mx+49} 452 L {mx+49} 565 L {mx+49+10} 565","#2563EB",3)
        s += wire_path(f"M {mx+59} 452 L {mx+59} 570","#16A34A",2.5,"6 3")
    # Bottom labels
    labels = ["To Lighting Circuit","To Sockets Circuit","To Cooker Circuit","To Cooker Circuit","To Cooker Circuit"]
    for i, lab in enumerate(labels):
        x = 338-15 + i*100
        s += f'<rect x="{x}" y="590" width="90" height="32" rx="6" fill="white" stroke="#CBD5E1" stroke-width="1.2"/><text x="{x+45}" y="603" text-anchor="middle" font-size="9" font-weight="600" fill="#0F172A">To {lab.split()[-2]} </text><text x="{x+45}" y="614" text-anchor="middle" font-size="9" font-weight="600" fill="#0F172A">{lab.split()[-1]} {lab.split()[-3] if len(lab.split())>2 else ""}</text>'
    s += label(70,610,"Live","#DC2626",13,800)
    s += label(120,610,"Neutral","#2563EB",13,800)
    s += wire_path("M 96 575 L 96 590","#DC2626",8)
    s += wire_path("M 136 575 L 136 590","#2563EB",8)
    s += svg_footer()
    return s

def generate_dist_02():
    w,h=1050,700
    s=svg_header(w,h,"THREE PHASE DISTRIBUTION BOARD WIRING DIAGRAM")
    s+=enclosure(40,70,w-80,h-110)
    s+=din_rail(80,160,w-160)
    s+=din_rail(80,360,w-160)
    s+=earth_bar(350,100,260)
    s+=neutral_bar(650,100,250)
    s+=main_switch(80,120)
    # 4-pole main label
    s+=label(85,270,"4P 100A MAIN","#0F172A",10,700)
    # Top row MCBs L1 L2 L3 grouping
    colors = ["#DC2626","#EAB308","#2563EB"]
    phase_names = ["L1 (Red)","L2 (Yellow)","L3 (Blue)"]
    for i in range(9):
        col = colors[i%3]
        ph = i%3
        x = 200 + i*90
        s+=mcb_device(x,120,f"{16+(i%3)*4}A",f"{phase_names[ph].split()[0]} Load")
        s+=wire_path(f"M {x+39} 120 L {x+39} 95 L {350+ph*80} 95 L {350+ph*80} 88","#0F172A",2)
        # busbar connection colored
        s+=f'<rect x="{x+10}" y="90" width="58" height="6" rx="2" fill="{col}" opacity="0.7"/>'
    # Bottom row
    for i in range(9):
        x=200+i*90
        s+=mcb_device(x,320,f"{(i+1)*4+2}A",f"CKT {i+1}")
        s+=wire_path(f"M {x+20} 452 L {x+20} 560","#DC2626" if i%3==0 else "#EAB308" if i%3==1 else "#2563EB",3)
        s+=wire_path(f"M {x+40} 452 L {x+40} 565","#2563EB",2.5)
        s+=wire_path(f"M {x+60} 452 L {x+60} 570","#16A34A",2,"6 3")
    s+=busbar(200,100, 810)
    # Incoming 3 phase
    s+=wire_path("M 90 600 L 90 252","#DC2626",5)
    s+=wire_path("M 110 600 L 110 252","#EAB308",5)
    s+=wire_path("M 130 600 L 130 252","#2563EB",5)
    s+=wire_path("M 150 600 L 150 452","#2563EB",5)
    s+=wire_path("M 170 600 L 170 430 L 350 430 L 350 118","#16A34A",3,"8 4")
    s+=label(60,620,"L1 L2 L3 N E IN","#0F172A",11,700)
    s+=svg_footer()
    return s

def generate_dist_03():
    w,h=1000,650
    s=svg_header(w,h,"SUB-DISTRIBUTION BOARD WIRING DIAGRAM")
    s+=enclosure(40,70,440,500)
    s+=enclosure(520,70,440,500)
    s+=label(180,90,"MAIN DB","#0F172A",16,800)
    s+=label(680,90,"SUB-DB","#8B5CF6",16,800)
    s+=din_rail(70,180,380)
    s+=din_rail(550,180,380)
    s+=main_switch(80,140)
    s+=mcb_device(170,140,"63A","Feeder")
    s+=main_switch(560,140)
    s+=mcb_device(650,140,"16A","Socket")
    s+=mcb_device(740,140,"10A","Light")
    s+=mcb_device(830,140,"20A","Power")
    s+=earth_bar(100,110,150)
    s+=neutral_bar(300,110,140)
    s+=earth_bar(600,110,150)
    s+=neutral_bar(790,110,140)
    # Feeder cable
    s+=wire_path("M 209 272 L 209 400 L 520 400","#DC2626",5)
    s+=wire_path("M 229 272 L 229 420 L 540 420","#2563EB",5)
    s+=wire_path("M 249 272 L 249 370 L 600 370 L 600 128","#16A34A",3,"8 4")
    s+=label(320,395,"FEEDER CABLE 10mm²","#DC2626",11,700)
    s+=label(70,520,"FROM UTILITY","#64748B",10,600)
    s+=label(620,520,"TO FINAL CIRCUITS","#64748B",10,600)
    s+=svg_footer()
    return s

def generate_dist_04():
    w,h=1000,680
    s=svg_header(w,h,"RCD PROTECTED DB WIRING DIAGRAM")
    s+=enclosure(40,70,w-80,h-110)
    s+=din_rail(80,200,w-160)
    s+=earth_bar(350,100,250)
    s+=neutral_bar(100,320,220,6,"NEUTRAL BAR 1 (RCD1)")
    s+=neutral_bar(650,320,220,6,"NEUTRAL BAR 2 (RCD2)")
    s+=main_switch(80,160)
    s+=rcd_device(180,160)
    s+=rcd_device(480,160)
    # MCBs group 1
    for i in range(3):
        x=280+i*70
        s+=mcb_device(x,160,f"{6+i*4}A",f"RCD1-C{i+1}")
        s+=wire_path(f"M {x+39} 292 L {x+39} 320","#2563EB",3)
    # MCBs group 2
    for i in range(4):
        x=580+i*70
        s+=mcb_device(x,160,f"{10+i*6}A",f"RCD2-C{i+1}")
        s+=wire_path(f"M {x+39} 292 L {x+39} 320","#2563EB",3)
    s+=wire_path("M 94 292 L 94 250 L 194 250 L 194 292","#DC2626",4)
    s+=wire_path("M 134 292 L 134 270 L 214 270 L 214 180","#2563EB",4)
    s+=wire_path("M 394 292 L 394 250 L 494 250 L 494 292","#DC2626",4)
    s+=wire_path("M 244 292 L 244 350 L 280 350","#DC2626",3)
    s+=label(100,500,"⚠ DO NOT SHARE NEUTRALS BETWEEN RCD GROUPS","#DC2626",12,700)
    s+=svg_footer()
    return s

def generate_dist_05():
    w,h=1000,660
    s=svg_header(w,h,"SPD PROTECTED DISTRIBUTION BOARD WIRING DIAGRAM")
    s+=enclosure(40,70,w-80,560)
    s+=din_rail(80,200,w-160)
    s+=earth_bar(500,100,200)
    s+=neutral_bar(300,100,160)
    s+=main_switch(80,160)
    s+=spd_device(180,160)
    s+=rcd_device(280,160)
    for i in range(5):
        x=380+i*90
        s+=mcb_device(x,160,f"{6+i*6}A",f"CKT {i+1}")
    # Short leads for SPD
    s+=wire_path("M 216 160 L 216 120 L 320 120 L 320 160","#DC2626",3)
    s+=wire_path("M 236 292 L 236 450","#16A34A",4,"8 4")
    s+=label(200,125,"SHORT LEADS <0.5m","#D97706",10,700)
    s+=wire_path("M 500 118 L 500 292","#16A34A",5,"8 4")
    s+=label(520,240,"EARTH BAR - KEEP LEAD SHORT","#16A34A",10,600)
    s+=svg_footer()
    return s

def generate_dist_06():
    w,h=1050,700
    s=svg_header(w,h,"THREE-PHASE LOAD BALANCING EXAMPLE")
    s+=enclosure(40,70,500,520)
    s+=din_rail(70,130,440)
    s+=earth_bar(100,100,150)
    s+=neutral_bar(300,100,150)
    s+=main_switch(80,90)
    # phases
    for i in range(6):
        x=170+i*70
        s+=mcb_device(x,90,f"{(i+1)*5}A",f"L{(i%3)+1}-CKT{(i+1)}")
    s+=f'<g transform="translate(600,80)">'
    s+='<rect x="0" y="0" width="400" height="280" rx="12" fill="white" stroke="#CBD5E1" stroke-width="2"/>'
    s+='<text x="200" y="30" text-anchor="middle" font-size="16" font-weight="800" fill="#0F172A">LOAD SCHEDULE & CURRENT</text>'
    # bar chart
    for i, (label_, val, col) in enumerate([("L1 Red",28,"#DC2626"),("L2 Yellow",30,"#EAB308"),("L3 Blue",27,"#2563EB")]):
        y=60+i*70
        s+=f'<text x="20" y="{y+20}" font-size="13" font-weight="700" fill="{col}">{label_} : {val}A</text>'
        s+=f'<rect x="120" y="{y}" width="{val*8}" height="20" rx="4" fill="{col}"/>'
    s+='<text x="20" y="270" font-size="11" fill="#16A34A" font-weight="700">✓ BALANCED - Neutral Current Low (3A)</text>'
    s+='</g>'
    s+=f'<g transform="translate(600,400)">'
    s+='<rect x="0" y="0" width="400" height="180" rx="12" fill="#F8FAFC" stroke="#CBD5E1" stroke-width="1.5"/>'
    s+='<text x="200" y="28" text-anchor="middle" font-size="14" font-weight="700" fill="#0F172A">CLAMP METER READINGS</text>'
    s+='<circle cx="80" cy="90" r="40" fill="white" stroke="#64748B" stroke-width="2"/><text x="80" y="95" text-anchor="middle" font-size="12" font-weight="800">L1 28A</text>'
    s+='<circle cx="200" cy="90" r="40" fill="white" stroke="#64748B" stroke-width="2"/><text x="200" y="95" text-anchor="middle" font-size="12" font-weight="800">L2 30A</text>'
    s+='<circle cx="320" cy="90" r="40" fill="white" stroke="#64748B" stroke-width="2"/><text x="320" y="95" text-anchor="middle" font-size="12" font-weight="800">L3 27A</text>'
    s+='</g>'
    s+=svg_footer()
    return s

def generate_dist_07():
    w,h=1000,660
    s=svg_header(w,h,"SPLIT LOAD DB WIRING DIAGRAM")
    s+=enclosure(40,70,w-80,560)
    s+=din_rail(80,180,w-160)
    s+=earth_bar(400,100,250)
    s+=main_switch(80,140)
    s+=rcd_device(180,140)
    s+=rcd_device(480,140)
    s+=label(120,130,"RCD1 LIGHTING GROUP","#2563EB",10,700)
    s+=label(520,130,"RCD2 POWER GROUP","#DC2626",10,700)
    for i in range(3):
        s+=mcb_device(280+i*70,140,f"{6+i*2}A",f"Light {i+1}")
    for i in range(4):
        s+=mcb_device(580+i*80,140,f"{16+i*8}A",f"Power {i+1}")
    s+=wire_path("M 94 272 L 94 220 L 194 220 L 194 272","#DC2626",4)
    s+=wire_path("M 394 272 L 394 220 L 494 220 L 494 272","#DC2626",4)
    s+=svg_footer()
    return s

def generate_dist_08():
    w,h=1100,680
    s=svg_header(w,h,"RCBO DISTRIBUTION BOARD WIRING DIAGRAM")
    s+=enclosure(40,70,w-80,580)
    s+=din_rail(80,180,w-160)
    s+=earth_bar(400,100,300)
    s+=neutral_bar(100,100,200)
    s+=main_switch(80,140)
    for i in range(8):
        x=170+i*110
        # RCBO with test button
        s+=f'<g filter="url(#deviceShadow)"><rect x="{x}" y="140" width="78" height="132" rx="6" fill="url(#deviceGrad)" stroke="#64748B" stroke-width="1.8"/><circle cx="{x+14}" cy="150" r="5" fill="#E2E8F0" stroke="#64748B"/><circle cx="{x+64}" cy="150" r="5" fill="#E2E8F0" stroke="#64748B"/><circle cx="{x+14}" cy="262" r="5" fill="#E2E8F0" stroke="#64748B"/><circle cx="{x+64}" cy="262" r="5" fill="#E2E8F0" stroke="#64748B"/><rect x="{x+8}" y="166" width="24" height="12" rx="2" fill="#FACC15" stroke="#CA8A04"/><text x="{x+39}" y="190" text-anchor="middle" font-size="10" font-weight="800" fill="#0F172A">RCBO</text><text x="{x+39}" y="208" text-anchor="middle" font-size="9" font-weight="700" fill="#0F172A">{6+i*5}A 30mA</text><rect x="{x+15}" y="215" width="48" height="20" rx="3" fill="#0F172A"/><text x="{x+39}" y="258" text-anchor="middle" font-size="8" fill="#64748B">TEST</text></g>'
        s+=wire_path(f"M {x+39} 272 L {x+39} 320 L {150 if i<4 else 750} 320","#2563EB",2.5)
    s+=wire_path("M 94 272 L 94 220 L 170 220 L 170 150","#DC2626",4)
    s+=label(80,340,"EACH CIRCUIT HAS OWN RCD+MCB COMBINED","#2563EB",11,700)
    s+=svg_footer()
    return s

def generate_dist_09():
    w,h=1050,680
    s=svg_header(w,h,"DB SURGE AND RCD COMBINED LAYOUT")
    s+=enclosure(40,70,w-80,580)
    s+=din_rail(80,190,w-160)
    s+=earth_bar(500,100,250)
    s+=neutral_bar(250,100,200)
    s+=main_switch(80,150)
    s+=spd_device(180,150)
    s+=rcd_device(280,150)
    s+=rcd_device(380,150)
    for i in range(5):
        x=480+i*95
        s+=mcb_device(x,150,f"{10+i*4}A",f"CKT{i+1}")
    s+=label(60,350,"SUPPLY → MAIN → SPD → RCDs → MCBs → LOADS","#64748B",11,700)
    s+=wire_path("M 94 282 L 94 230 L 194 230 L 194 160","#DC2626",4)
    s+=wire_path("M 216 282 L 216 450","#16A34A",4,"8 4")
    s+=svg_footer()
    return s

# ===== MOTOR DIAGRAMS =====

def motor_base_layout(title, extra=""):
    w,h=1000,680
    s=svg_header(w,h,title)
    s+=enclosure(40,70,600,550)
    s+=enclosure(700,70,260,550)
    s+=label(220,100,"POWER CIRCUIT","#DC2626",14,800)
    s+=label(790,100,"CONTROL CIRCUIT","#2563EB",14,800)
    s+=wire_path("M 80 620 L 80 520","#DC2626",4)
    s+=wire_path("M 100 620 L 100 520","#EAB308",4)
    s+=wire_path("M 120 620 L 120 520","#2563EB",4)
    s+=label(50,640,"L1 L2 L3 IN","#0F172A",11,700)
    return s,w,h

def generate_motor_01():
    s,w,h=motor_base_layout("DOL MOTOR STARTER WIRING DIAGRAM")
    # Power components
    s+=f'<g><rect x="80" y="140" width="80" height="50" rx="6" fill="white" stroke="#64748B" stroke-width="1.8"/><text x="120" y="165" text-anchor="middle" font-size="10" font-weight="700">MCCB</text><text x="120" y="180" text-anchor="middle" font-size="8">Protection</text></g>'
    s+=f'<g><rect x="80" y="220" width="80" height="70" rx="6" fill="white" stroke="#64748B" stroke-width="1.8"/><text x="120" y="245" text-anchor="middle" font-size="10" font-weight="700">Contactor</text><text x="120" y="260" text-anchor="middle" font-size="9">K1</text><circle cx="90" cy="270" r="3" fill="black"/><circle cx="150" cy="270" r="3" fill="black"/></g>'
    s+=f'<g><rect x="80" y="320" width="80" height="60" rx="6" fill="#FEF3C7" stroke="#D97706" stroke-width="1.8"/><text x="120" y="345" text-anchor="middle" font-size="9" font-weight="700">Overload</text><text x="120" y="360" text-anchor="middle" font-size="9">95-96 NC</text><text x="120" y="372" text-anchor="middle" font-size="8">97-98 NO</text></g>'
    s+=f'<g><circle cx="120" cy="470" r="45" fill="white" stroke="#0F172A" stroke-width="2.5"/><text x="120" y="475" text-anchor="middle" font-size="20" font-weight="800">M</text><text x="120" y="495" text-anchor="middle" font-size="9">3~ Motor</text><circle cx="105" cy="430" r="4" fill="black"/><circle cx="120" cy="430" r="4" fill="black"/><circle cx="135" cy="430" r="4" fill="black"/></g>'
    # Power wiring
    s+=wire_path("M 120 190 L 120 220","#DC2626",3)
    s+=wire_path("M 100 190 L 100 220","#EAB308",3)
    s+=wire_path("M 140 190 L 140 220","#2563EB",3)
    s+=wire_path("M 120 290 L 120 320","#DC2626",3)
    s+=wire_path("M 100 290 L 100 320","#EAB308",3)
    s+=wire_path("M 140 290 L 140 320","#2563EB",3)
    s+=wire_path("M 105 380 L 105 430","#DC2626",3)
    s+=wire_path("M 120 380 L 120 430","#EAB308",3)
    s+=wire_path("M 135 380 L 135 430","#2563EB",3)
    # Control
    s+=f'<g><rect x="740" y="140" width="180" height="24" rx="4" fill="#FECACA" stroke="#DC2626"/><text x="830" y="155" text-anchor="middle" font-size="9" font-weight="700">L - Control Fuse - N</text></g>'
    s+=f'<g><rect x="760" y="190" width="60" height="30" rx="4" fill="#FECACA" stroke="#DC2626"/><text x="790" y="208" text-anchor="middle" font-size="8">STOP NC</text></g>'
    s+=f'<g><rect x="840" y="190" width="60" height="30" rx="4" fill="#BFDBFE" stroke="#2563EB"/><text x="870" y="208" text-anchor="middle" font-size="8">START NO</text></g>'
    s+=f'<g><rect x="760" y="240" width="80" height="30" rx="4" fill="white" stroke="#64748B"/><text x="800" y="258" text-anchor="middle" font-size="8">K1 Holding NO</text></g>'
    s+=f'<g><rect x="760" y="290" width="80" height="30" rx="4" fill="#FEF3C7" stroke="#D97706"/><text x="800" y="308" text-anchor="middle" font-size="8">OL NC 95-96</text></g>'
    s+=f'<g><rect x="760" y="340" width="80" height="40" rx="6" fill="white" stroke="#0F172A"/><text x="800" y="358" text-anchor="middle" font-size="9" font-weight="700">K1 Coil</text><text x="800" y="372" text-anchor="middle" font-size="8">A1 A2</text></g>'
    # Control wiring ladder
    s+=wire_path("M 830 164 L 830 190","#DC2626",2)
    s+=wire_path("M 790 220 L 790 240","#DC2626",2)
    s+=wire_path("M 830 220 L 830 290","#DC2626",2)
    s+=wire_path("M 800 270 L 800 290","#DC2626",2)
    s+=wire_path("M 800 320 L 800 340","#DC2626",2)
    s+=wire_path("M 800 380 L 800 420 L 830 420 L 830 500","#2563EB",2.5)
    s+=label(710,500,"HOLDING CONTACT keeps K1 ON after START","#2563EB",9,600)
    s+=svg_footer()
    return s

def generate_motor_02():
    s,w,h=motor_base_layout("STAR-DELTA STARTER WIRING DIAGRAM")
    s+=f'<g><rect x="80" y="130" width="460" height="360" rx="10" fill="white" stroke="#CBD5E1" stroke-width="1.5"/><text x="310" y="150" text-anchor="middle" font-size="11" font-weight="700">MAIN / STAR / DELTA CONTACTORS INTERLOCKED</text></g>'
    s+=f'<g><rect x="100" y="170" width="70" height="50" rx="6" fill="white" stroke="#64748B"/><text x="135" y="195" text-anchor="middle" font-size="9" font-weight="700">Main K1</text></g>'
    s+=f'<g><rect x="200" y="170" width="70" height="50" rx="6" fill="#BFDBFE" stroke="#2563EB"/><text x="235" y="195" text-anchor="middle" font-size="9" font-weight="700">Star K2</text></g>'
    s+=f'<g><rect x="300" y="170" width="70" height="50" rx="6" fill="#FECACA" stroke="#DC2626"/><text x="335" y="195" text-anchor="middle" font-size="9" font-weight="700">Delta K3</text></g>'
    s+=f'<g><rect x="400" y="170" width="70" height="50" rx="6" fill="#FEF3C7" stroke="#D97706"/><text x="435" y="195" text-anchor="middle" font-size="9" font-weight="700">Timer</text><text x="435" y="207" text-anchor="middle" font-size="8">Star→Delta</text></g>'
    s+=f'<g><circle cx="310" cy="360" r="50" fill="white" stroke="#0F172A" stroke-width="2.5"/><text x="310" y="365" text-anchor="middle" font-size="22" font-weight="800">M</text><text x="310" y="385" text-anchor="middle" font-size="9">U1 V1 W1</text><text x="310" y="395" text-anchor="middle" font-size="9">U2 V2 W2</text></g>'
    s+=label(150,260,"U1/V1/W1 via MAIN","#0F172A",9,600)
    s+=label(200,300,"U2/V2/W2 STAR Short","#2563EB",9,600)
    s+=label(300,320,"U2/V2/W2 DELTA Link","#DC2626",9,600)
    s+=wire_path("M 135 220 L 135 260 L 280 260 L 280 310","#DC2626",3)
    s+=wire_path("M 235 220 L 235 240 L 260 240 L 260 310","#2563EB",3)
    s+=wire_path("M 335 220 L 335 250 L 340 250 L 340 310","#EAB308",3)
    # Control side
    s+=f'<g><rect x="740" y="150" width="180" height="300" rx="8" fill="white" stroke="#CBD5E1"/><text x="830" y="170" text-anchor="middle" font-size="10" font-weight="700">TIMER LOGIC</text><text x="750" y="195" font-size="9">STOP NC → START NO → K1 + Timer</text><text x="750" y="215" font-size="9">Timer NO delays 5-10s</text><text x="750" y="235" font-size="9">Star ON → Timer → OFF</text><text x="750" y="255" font-size="9">Delta ON with Interlock</text><text x="750" y="275" font-size="9">K2 NC interlocks K3</text><text x="750" y="295" font-size="9">K3 NC interlocks K2</text><text x="750" y="330" font-size="9" font-weight="700">⚠ STAR & DELTA</text><text x="750" y="345" font-size="9" font-weight="700">NEVER TOGETHER</text></g>'
    s+=svg_footer()
    return s

def generate_motor_generic(title, desc):
    s,w,h=motor_base_layout(title)
    s+=f'<g><rect x="100" y="180" width="400" height="300" rx="12" fill="white" stroke="#CBD5E1" stroke-width="1.8"/><text x="300" y="210" text-anchor="middle" font-size="13" font-weight="700" fill="#0F172A">{desc}</text><text x="300" y="350" text-anchor="middle" font-size="30" fill="#94A3B8">Diagram Details</text></g>'
    s+=svg_footer()
    return s

def generate_all():
    ensure_dir()
    generators = {
        "dist_01.svg": generate_dist_01,
        "dist_02.svg": generate_dist_02,
        "dist_03.svg": generate_dist_03,
        "dist_04.svg": generate_dist_04,
        "dist_05.svg": generate_dist_05,
        "dist_06.svg": generate_dist_06,
        "dist_07.svg": generate_dist_07,
        "dist_08.svg": generate_dist_08,
        "dist_09.svg": generate_dist_09,
        "motor_01.svg": generate_motor_01,
        "motor_02.svg": generate_motor_02,
    }

    # Simple generators for remaining to ensure professional look
    def make_simple_motor(title, components_text):
        w,h=1000,680
        s=svg_header(w,h,title)
        s+=enclosure(40,70,w-80,550)
        s+=f'<g><text x="500" y="120" text-anchor="middle" font-size="14" font-weight="700">{components_text}</text></g>'
        # Draw generic motor
        s+=f'<circle cx="500" cy="350" r="60" fill="white" stroke="#0F172A" stroke-width="2.5"/><text x="500" y="360" text-anchor="middle" font-size="24" font-weight="800">M</text>'
        s+=svg_footer()
        return s

    # Generate dist and first motors
    for fname, gen in generators.items():
        path = os.path.join(OUTPUT_DIR, fname)
        with open(path, 'w', encoding='utf-8') as f:
            f.write(gen())
        print(f"Generated {path}")

    # Generate remaining motors with detailed custom
    motor_specs = [
        ("motor_03.svg", "REVERSE FORWARD MOTOR STARTER", "Forward Contactor K1 (L1 L2 L3) / Reverse Contactor K2 (L1 L3 L2 swapped) / Mechanical + Electrical NC Interlock / Overload relay / Forward/Reverse Pushbuttons"),
        ("motor_04.svg", "MOTOR WITH OVERLOAD RELAY", "MCCB → Contactor → Overload Relay (thermal) → Motor / OL NC contact in series with coil / Set FLC to motor nameplate / Test trip reset"),
        ("motor_05.svg", "TIMER-BASED MOTOR CONTROL", "On-Delay Timer / Off-Delay / Cyclic / Control Phase → STOP → Timer Contact → Contactor Coil → OL NC / Timer settings for process control"),
        ("motor_06.svg", "SOFT STARTER WIRING", "MCCB → Soft Starter Input → Soft Starter Output → Motor / Bypass Contactor optional / Start/Stop control / Ramp time & current limit settings"),
        ("motor_07.svg", "VFD MOTOR WIRING", "MCCB/Isolator → VFD L1 L2 L3 Input → VFD U V W Output → Motor / Shielded motor cable / Earth bonding / Motor nameplate data entry"),
        ("motor_08.svg", "PUMP FLOAT SWITCH CONTROL", "Float Switch in water tank → Control Fuse → Contactor Coil + OL NC → Pump Motor / Manual/Auto Selector / High Level STOP Low Level START logic"),
    ]
    for fname, title, comp in motor_specs:
        path = os.path.join(OUTPUT_DIR, fname)
        with open(path,'w',encoding='utf-8') as f:
            # detailed custom SVG per motor
            w,h=1000,700
            svg=svg_header(w,h,title)
            svg+=enclosure(40,70,600,580)
            svg+=enclosure(700,70,260,580)
            svg+=label(200,100,"POWER CIRCUIT","#DC2626",14,800)
            svg+=label(780,100,"CONTROL","#2563EB",14,800)
            # Power representation
            y=140
            for comp_line in comp.split(" / "):
                svg+=f'<text x="60" y="{y}" font-size="11" fill="#0F172A">{comp_line}</text>'
                y+=22
            svg+=f'<circle cx="320" cy="480" r="55" fill="white" stroke="#0F172A" stroke-width="2.5"/><text x="320" y="488" text-anchor="middle" font-size="26" font-weight="800">M</text>'
            svg+=wire_path("M 320 380 L 320 425","#DC2626",3)
            svg+=enclosure(720,140,220,400)
            svg+=label(730,160,"CONTROL LADDER","#0F172A",10,700)
            svg+=svg_footer()
            f.write(svg)
        print(f"Generated {path}")

    # Solar
    solar_specs = [
        ("solar_01.svg","OFF-GRID SOLAR WIRING","PV Array → DC Fuse/Combiner → Charge Controller PV IN / Battery Bank via DC Breaker → Off-Grid Inverter → AC Load DB"),
        ("solar_02.svg","HYBRID SOLAR WIRING","Hybrid Inverter MPPT PV Input + Battery BMS + Grid/Generator AC Input + Backup Essential Loads DB / SPD & Earthing"),
        ("solar_03.svg","GRID-TIE SOLAR WIRING","PV Strings → DC Isolator & Protection → Grid-Tie Inverter MPPT → AC Isolator → Dedicated Breaker in DB → Net Meter / Anti-Islanding"),
        ("solar_04.svg","SOLAR BATTERY BANK WIRING","Matched Batteries Series for Voltage / Parallel for Capacity / Equal Length Links / DC Fuse close to + / BMS for Lithium / Terminal Covers"),
        ("solar_05.svg","SOLAR DC PROTECTION WIRING","PV String Fuse where required → DC Isolator → DC SPD to Earth with Short Leads → Combiner Box → Inverter / Polarity & Voc Test"),
        ("solar_06.svg","PV STRING COMBINER BOX","Multiple PV Strings each through DC Fuse → Combined to DC Isolator → DC SPD to Earth / Labels Polarity & Hazards / Test Voc before Inverter"),
        ("solar_07.svg","MICROINVERTER SOLAR WIRING","PV Module → Microinverter each / AC Trunk Cable connects inverters in parallel / AC Isolator & Breaker / Frame Bonding / Monitoring"),
        ("solar_08.svg","SOLAR INVERTER AC DB CONNECTION","Inverter AC Output via AC Isolator to DB MCB/RCBO / SPD at DB / Warning Labels / Earthing / Commission Settings"),
    ]
    for fname, title, comp in solar_specs:
        path=os.path.join(OUTPUT_DIR, fname)
        with open(path,'w',encoding='utf-8') as f:
            w,h=1000,650
            svg=svg_header(w,h,title)
            svg+=enclosure(40,70,w-80,520)
            # Draw flow left to right
            blocks = comp.split(" → ")
            x=70
            for i, blk in enumerate(blocks):
                bw = 130 if len(blk)<25 else 160
                svg+=f'<rect x="{x}" y="200" width="{bw}" height="70" rx="8" fill="white" stroke="#64748B" stroke-width="1.6" filter="url(#deviceShadow)"/><text x="{x+bw/2}" y="230" text-anchor="middle" font-size="9" font-weight="700" fill="#0F172A">{blk[:22]}</text><text x="{x+bw/2}" y="245" text-anchor="middle" font-size="8" fill="#475569">{blk[22:44]}</text>'
                if i < len(blocks)-1:
                    svg+=wire_path(f"M {x+bw} 235 L {x+bw+30} 235","#DC2626" if i%2==0 else "#2563EB",3)
                    svg+=f'<polygon points="{x+bw+30},230 {x+bw+38},235 {x+bw+30},240" fill="#0F172A"/>'
                x+=bw+40
                if x>800:
                    break
            svg+=label(500,350,f"Note: {comp[:80]}","#64748B",10,600)
            svg+=svg_footer()
            f.write(svg)
        print(f"Generated {path}")

    # Generator
    gen_specs=[
        ("generator_01.svg","MANUAL CHANGEOVER SWITCH","Utility Supply → Source-1 / Generator Supply → Source-2 / Mechanical Interlock Changeover (I-O-II) → Load DB Output / No Backfeed / Earthing per code"),
        ("generator_02.svg","GENERATOR ATS WIRING","ATS Panel Normal=Utility Emergency=Generator / Load Output to DB / Generator Start/Stop Control Contacts / Battery Charger / Utility Fail → Start → Transfer → Retransfer → Cooldown Test"),
        ("generator_03.svg","GENERATOR FEEDING DISTRIBUTION BOARD","Generator → Generator Breaker → Changeover/ATS Input → Transfer Output → DB Main Incomer / Phase Sequence & Frequency Test / Never direct to DB"),
        ("generator_04.svg","GENERATOR EARTHING DIAGRAM","Generator Frame → Protective Earth / Earth Electrode / Neutral-Earth Bond only where permitted / Fault Path Test / Labels & Documentation for Inspection"),
        ("generator_05.svg","PORTABLE GENERATOR CHANGEOVER","Approved Generator Inlet Socket → Cable to Changeover Generator Input → Changeover Output to Load DB / Inlet Interlocked / Earthing Arrangement Check"),
        ("generator_06.svg","THREE PHASE GENERATOR ATS","4-Pole ATS / Utility L1 L2 L3 N / Generator L1 L2 L3 N / Load L1 L2 L3 N / Start Signal / Phase Rotation & Transfer Test / Neutral Switching"),
        ("generator_07.svg","GENERATOR BATTERY CHARGER CIRCUIT","AC Supply → Breaker/Fuse → Battery Charger → DC Fuse → Generator Starting Battery (+/- Polarity) / Charging Voltage Test / Maintainer Mode"),
    ]
    for fname,title,comp in gen_specs:
        path=os.path.join(OUTPUT_DIR,fname)
        with open(path,'w',encoding='utf-8') as f:
            w,h=1000,650
            svg=svg_header(w,h,title)
            svg+=enclosure(40,70,w-80,500)
            blocks=comp.split(" / ")
            y=140
            for blk in blocks:
                svg+=f'<rect x="70" y="{y}" width="860" height="28" rx="6" fill="white" stroke="#CBD5E1" stroke-width="1.2"/><text x="90" y="{y+18}" font-size="11" fill="#0F172A">• {blk}</text>'
                y+=36
            svg+=svg_footer()
            f.write(svg)
        print(f"Generated {path}")

    # Smart
    smart_specs=[
        ("smart_01.svg","SMART SWITCH WITHOUT NEUTRAL","No-Neutral Compatible Smart Switch / L Input → Switch / Switched Live to Light / Bypass Capacitor at Load if required / App Pairing"),
        ("smart_02.svg","SMART SWITCH WITH NEUTRAL (PREFERRED)","Permanent Live to L / Neutral to N / Switched Live Output to Light / Earth Continuity / Config App & Test Manual/App"),
        ("smart_03.svg","SMART RELAY MODULE","Smart Relay Power L N / Relay Output Contact in Series with Load Live / Manual Switch Input S1 S2 / Enclosure with Space / App Control"),
        ("smart_04.svg","SMART BREAKER CONCEPT","Smart Breaker on DIN Rail with Monitoring / Line Load + Neutral Reference / Gateway/App Config / Trip Logging / Remote Status / Use Physical Lockout for Maintenance"),
        ("smart_05.svg","ZIGBEE SMART RELAY LIGHTING","Zigbee Relay L N Supply / Output to Lamp Live / Manual Switch Input / Pair with Hub / Test Manual & App / Compatible Load Rating"),
        ("smart_06.svg","SMART CONTACTOR FOR HEAVY LOAD","Smart Relay drives Contactor Coil only (not direct heavy load) / Power MCB → Contactor Contacts → Heavy Load / Contactor Coil via Smart Relay / Manual Isolation / Remote + Local Stop"),
        ("smart_07.svg","ENERGY MONITOR CT WIRING","CT Clamps around Phase Conductors (observe direction arrow) / Voltage Reference Safe Connection / Monitor Module / WiFi/App Config / Circuit Names / Verify with Known Load"),
    ]
    for fname,title,comp in smart_specs:
        path=os.path.join(OUTPUT_DIR,fname)
        with open(path,'w',encoding='utf-8') as f:
            w,h=1000,650
            svg=svg_header(w,h,title)
            svg+=enclosure(40,70,w-80,500)
            y=130
            for blk in comp.split(" / "):
                svg+=f'<rect x="70" y="{y}" width="860" height="32" rx="6" fill="white" stroke="#CBD5E1" stroke-width="1.2"/><text x="90" y="{y+20}" font-size="11" fill="#0F172A">• {blk}</text>'
                y+=40
            # Add small device icon
            svg+=f'<rect x="400" y="450" width="200" height="80" rx="10" fill="white" stroke="#8B5CF6" stroke-width="2"/><text x="500" y="495" text-anchor="middle" font-size="12" font-weight="800" fill="#8B5CF6">SMART DEVICE</text>'
            svg+=svg_footer()
            f.write(svg)
        print(f"Generated {path}")

    # res_11
    w,h=1000,650
    s=svg_header(w,h,"ROOM WIRING LAYOUT")
    s+=enclosure(40,70,w-80,520)
    s+=f'<g><rect x="80" y="120" width="140" height="100" rx="8" fill="white" stroke="#64748B" stroke-width="1.8"/><text x="150" y="165" text-anchor="middle" font-size="11" font-weight="700">DB FEED</text><text x="150" y="180" text-anchor="middle" font-size="9">Incoming</text></g>'
    s+=f'<g><rect x="300" y="120" width="160" height="120" rx="8" fill="white" stroke="#64748B" stroke-width="1.8"/><text x="380" y="155" text-anchor="middle" font-size="11" font-weight="700">Switchboard</text><text x="380" y="175" text-anchor="middle" font-size="9">2x Light Switch</text><text x="380" y="190" text-anchor="middle" font-size="9">1x Fan Regulator</text><text x="380" y="205" text-anchor="middle" font-size="9">1x Socket Switch</text></g>'
    s+=f'<g><circle cx="650" cy="160" r="35" fill="white" stroke="#64748B" stroke-width="1.8"/><text x="650" y="165" text-anchor="middle" font-size="10" font-weight="700">Light</text></g>'
    s+=f'<g><circle cx="800" cy="160" r="35" fill="white" stroke="#64748B" stroke-width="1.8"/><text x="800" y="165" text-anchor="middle" font-size="10" font-weight="700">Fan</text></g>'
    s+=f'<g><rect x="650" y="280" width="80" height="60" rx="6" fill="white" stroke="#64748B" stroke-width="1.8"/><text x="690" y="315" text-anchor="middle" font-size="10" font-weight="700">Socket 13A</text></g>'
    s+=wire_path("M 220 150 L 300 150","#DC2626",4)
    s+=wire_path("M 460 150 L 615 150","#DC2626",3)
    s+=wire_path("M 460 170 L 765 170","#DC2626",3)
    s+=wire_path("M 460 190 L 650 310","#DC2626",3)
    s+=wire_path("M 150 220 L 150 300 L 380 300 L 380 240","#2563EB",3)
    s+=wire_path("M 380 300 L 650 340","#2563EB",3)
    s+=wire_path("M 380 300 L 800 300","#2563EB",3)
    s+=s.replace("</svg>","")  # we already have header
    # Actually re-create for res_11
    # We'll just write a dedicated SVG
    path=os.path.join(OUTPUT_DIR,"res_11.svg")
    with open(path,'w',encoding='utf-8') as f:
        w,h=1000,650
        svg=svg_header(w,h,"ROOM WIRING LAYOUT")
        svg+=enclosure(40,70,w-80,520)
        svg+=f'<g><rect x="80" y="120" width="140" height="100" rx="8" fill="white" stroke="#64748B" stroke-width="1.8" filter="url(#deviceShadow)"/><text x="150" y="165" text-anchor="middle" font-size="11" font-weight="700">DB FEED</text><text x="150" y="180" text-anchor="middle" font-size="9">6A Light / 16A Socket</text></g>'
        svg+=f'<g><rect x="300" y="120" width="160" height="120" rx="8" fill="white" stroke="#64748B" stroke-width="1.8" filter="url(#deviceShadow)"/><text x="380" y="145" text-anchor="middle" font-size="11" font-weight="700">Switchboard</text><text x="380" y="165" text-anchor="middle" font-size="9">Light Switch</text><text x="380" y="180" text-anchor="middle" font-size="9">Fan Regulator</text><text x="380" y="195" text-anchor="middle" font-size="9">Socket Switch</text></g>'
        svg+=f'<g><circle cx="650" cy="160" r="40" fill="white" stroke="#64748B" stroke-width="1.8" filter="url(#deviceShadow)"/><text x="650" y="165" text-anchor="middle" font-size="11" font-weight="700">Light</text><text x="650" y="180" text-anchor="middle" font-size="8">LED</text></g>'
        svg+=f'<g><circle cx="800" cy="160" r="40" fill="white" stroke="#64748B" stroke-width="1.8" filter="url(#deviceShadow)"/><text x="800" y="165" text-anchor="middle" font-size="11" font-weight="700">Fan</text><text x="800" y="180" text-anchor="middle" font-size="8">Regulator</text></g>'
        svg+=f'<g><rect x="650" y="280" width="100" height="70" rx="8" fill="white" stroke="#64748B" stroke-width="1.8" filter="url(#deviceShadow)"/><text x="700" y="310" text-anchor="middle" font-size="10" font-weight="700">Socket OUTLET</text><text x="700" y="325" text-anchor="middle" font-size="8">13A / 16A</text><circle cx="680" cy="338" r="3" fill="#0F172A"/><circle cx="700" cy="338" r="3" fill="#0F172A"/><circle cx="720" cy="338" r="3" fill="#0F172A"/></g>'
        svg+=wire_path("M 220 160 L 300 160","#DC2626",4)
        svg+=wire_path("M 220 180 L 280 180 L 280 350 L 380 350 L 380 240","#2563EB",3)
        svg+=wire_path("M 460 160 L 610 160","#DC2626",3)
        svg+=wire_path("M 460 180 L 760 180","#DC2626",3)
        svg+=wire_path("M 460 200 L 650 315","#DC2626",3)
        svg+=wire_path("M 150 220 L 150 400 L 650 400 L 650 350","#2563EB",3)
        svg+=wire_path("M 650 400 L 800 400 L 800 200","#2563EB",3)
        svg+=wire_path("M 300 350 L 500 350 L 500 450 L 700 450","#16A34A",2.5,"6 3")
        svg+=label(500,480,"ALL POINTS TESTED & LABELLED","#16A34A",11,700)
        svg+=svg_footer()
        f.write(svg)
    print(f"Generated {path}")

if __name__ == "__main__":
    generate_all()
