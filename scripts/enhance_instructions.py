#!/usr/bin/env python3
"""
Enhance 50 wiring diagrams steps & components to match ultra-realistic PNG visuals
Mentions Red Live, Blue Neutral, Green-Yellow Earth, device labels, arrows, bars
"""
import re

path = "lib/data/content/wiring_content.dart"
with open(path, 'r', encoding='utf-8') as f:
    content = f.read()

# Enhanced data for all 50
enhanced = {
    "res_01": {
        "steps": [
            "Isolate lighting MCB marked 'From DB' in PNG and verify zero voltage with approved tester before touching.",
            "Connect Red Live L wire (thick red arrow from DB MCB top terminal) to switch common/L terminal brass screw marked L.",
            "Connect Red Switched Live L' wire (red arrow from switch output) to ceiling rose / light fixture L terminal brass screw.",
            "Run Blue Neutral wire directly from neutral bar / junction (blue wire) to light N terminal.",
            "Connect Green-Yellow striped Earth wire from earth bar to metal switch box earth screw and fixture earth terminal (see green-yellow arrow marked Earth).",
            "Secure all brass screws to torque, fit switch plate and light cover, energize via DB MCB, test switch ON/OFF operation."
        ],
        "components": [
            "1× one-way switch with L and L' terminals (as in PNG metal box with brass screws)",
            "1× ceiling rose / light fixture with L N E brass terminals",
            "1.5 mm² Red Live, Blue Neutral, Green-Yellow Earth cable",
            "PVC conduit or approved wiring method",
            "MCB/RCD protected DB supply with Earth bar MET and Neutral bar"
        ]
    },
    "res_02": {
        "steps": [
            "Isolate circuit and verify dead, confirm both switches show COM, L1, L2 terminals as in PNG.",
            "Connect permanent Red Phase to common COM terminal of Switch 1 (left switch, bottom terminal).",
            "Run two traveller wires L1-L1 (brown) and L2-L2 (black) between Switch 1 L1/L2 and Switch 2 L1/L2 — see traveller arrows in PNG.",
            "Connect common COM of Switch 2 (right switch) via Red Switched Live to light fixture Live L terminal brass.",
            "Run Blue Neutral directly to light N terminal and Green-Yellow Earth striped wire to both metal switch boxes and fixture earth for continuity.",
            "Test both switches in all 4 positions (up/up, up/down, down/up, down/down) to verify light toggles from either location."
        ]
    },
    "res_03": {
        "steps": [
            "Install two-way switches at end positions and intermediate 4-terminal crossover switch in middle (marked Intermediate with 4 terminals).",
            "Feed permanent Red Phase to common COM of first two-way switch (left).",
            "Connect travellers from first two-way L1/L2 to input pair (top two) of intermediate switch.",
            "Connect output pair (bottom two) of intermediate switch to travellers L1/L2 of second two-way switch (right).",
            "Connect second two-way common COM via Red Switched Live to light Live L; Blue Neutral goes directly to light N; Green-Yellow Earth to all boxes.",
            "Verify earth continuity with low resistance and test all 8 switch combinations to ensure light toggles from any of 3 locations."
        ]
    },
    "res_04": {
        "steps": [
            "Isolate socket circuit MCB and verify dead with tester.",
            "Connect Red Live / Phase conductor to socket L terminal (right side brass, marked L, as shown red wire in PNG).",
            "Connect Blue Neutral conductor to socket N terminal (left side brass, marked N, blue wire).",
            "Connect Green-Yellow Earth striped conductor to E terminal (top brass, marked E) and to metal wall box earth screw if required.",
            "Tighten all three brass screws to manufacturer torque guidance — check for no copper visible outside terminal.",
            "Test polarity with socket tester, verify earth continuity, and test socket operation with load."
        ]
    },
    "res_05": {
        "steps": [
            "Start from DB: Red Live from 32A MCB, Blue Neutral from neutral bar, Green-Yellow Earth from Earth bar MET (green-yellow striped top in PNG).",
            "Loop to first socket outlet using correct L/N/E terminals — Red to L, Blue to N, Green-Yellow to E.",
            "Continue loop to second, third socket etc., keeping same terminal order and earth continuity through every metal box.",
            "Return final socket conductors back to DB to complete the ring — Red Live back to same MCB, Blue Neutral back to neutral bar, Earth back to earth bar.",
            "Keep earth continuity unbroken through every accessory; sleeve earth with green-yellow.",
            "Test ring continuity (L-L, N-N, E-E), then polarity, insulation resistance, and earth continuity before energizing and record results."
        ]
    },
    "res_06": {
        "steps": [
            "Isolate fan circuit MCB and verify zero energy; confirm fan-rated ceiling hook/box is secure.",
            "Feed Red Phase to wall switch / fan regulator input terminal (bottom of regulator as in PNG, marked L).",
            "Connect regulator output / switched live Red wire (marked L' arrow) to fan motor Live terminal at ceiling rose.",
            "Connect Blue Neutral directly to fan Neutral terminal (blue wire direct as in PNG).",
            "Connect Green-Yellow Earth striped wire to fan body / metallic hook / ceiling box earth screw where provided.",
            "Secure mechanical fan mounting with safety pin, fit canopy, energize, test all speeds on regulator knob without wobble or noise."
        ]
    },
    "res_07": {
        "steps": [
            "Isolate transformer primary supply MCB and verify dead; identify primary 230V and secondary 12V terminals as in PNG.",
            "Connect transformer primary to protected mains supply as per manufacturer label — Red Live to L, Blue Neutral to N, Earth to E.",
            "Run transformer secondary low-voltage bell wire (thin wires) to push button terminals.",
            "Connect push button output via bell wire to chime/bell unit input and return second wire to transformer secondary other terminal to complete loop.",
            "Keep low-voltage bell wiring physically separated from mains wiring in separate conduit/trunking, as shown in PNG.",
            "Energize and press push button to test chime/bell operation — should ding-dong without mains hum."
        ]
    },
    "res_08": {
        "steps": [
            "Isolate lighting circuit MCB and verify dead; confirm lamp is dimmable LED/halogen compatible with dimmer module shown in PNG.",
            "Connect Red Phase to dimmer input terminal (marked L, bottom).",
            "Connect dimmer output Red wire (marked L' ~) to lamp Live L terminal at ceiling rose.",
            "Connect Blue Neutral directly to lamp Neutral N terminal (blue wire direct).",
            "Connect Green-Yellow Earth to metal dimmer box and lamp earth if fitting is metal.",
            "Energize and test dimming from 10% to 100% — check for flicker-free operation and no buzzing at low level."
        ]
    },
    "res_09": {
        "steps": [
            "Isolate circuit and verify dead; identify 2-gang switch plate with two independent commons as in PNG.",
            "Loop permanent Red Phase to both switch commons (bridge wire between COM1 and COM2, as shown red loop in PNG).",
            "Connect first switched output (L1) via Red Switched Live to Light 1 Live terminal.",
            "Connect second switched output (L2) via Red Switched Live second wire to Light 2 Live terminal.",
            "Connect Blue Neutrals directly to both lights N terminals and maintain Green-Yellow Earth continuity to switch box and light fittings.",
            "Label both switched lives L1 Light 1 and L2 Light 2, energize, test each gang independently — both should operate separate lights."
        ]
    },
    "res_10": {
        "steps": [
            "Plan separate lighting/socket ratings — 6A for light, 16A for socket, as different cable sizes; isolate supply.",
            "Wire socket outlet L/N/E through 2.5mm² cable and suitable MCB/RCBO protection — Red to L, Blue to N, Green-Yellow to E.",
            "Wire light point through wall switch: Red Phase to switch common, Red Switched Live from switch output to light Live.",
            "Connect Blue Neutral direct to light Neutral, maintain Green-Yellow Earth continuity to both socket box and light fitting.",
            "Keep lighting and socket earths on same earth bar but separate neutrals if RCBO protected.",
            "Test socket polarity and earth with socket tester, test light switch operation, verify no intermix of L and switched L."
        ]
    },
    "res_11": {
        "steps": [
            "Plan cable routes as per room layout PNG: DB Feed enters near door, routes to switchboard on wall.",
            "Run DB Feed 6A lighting and 16A socket feeds to room switchboard / junction box as shown central wall box.",
            "Wire lighting switched live Red to ceiling Light LED (top center) and fan switched live through regulator to Ceiling Fan (top right).",
            "Wire Socket Outlet 13A/16A on side wall with 2.5mm² cable — Red L, Blue N, Green-Yellow E to DB, maintain polarity.",
            "Connect all Blue Neutrals to common neutral junction and all Green-Yellow Earths to earth terminal — ensure continuity.",
            "Test every point: light switch, fan regulator speeds, socket polarity and earth, label circuit at DB as Room 1 Light/Fan/Socket."
        ],
        "components": [
            "Room switchboard with 2× light switches, 1× fan regulator with knob, 1× socket switch",
            "Ceiling Light LED fixture with L N E terminals",
            "Ceiling Fan with regulator and fan-hook",
            "Socket Outlet 13A/16A with L N E brass",
            "DB Feed 6A light / 16A socket and junction box"
        ]
    },
    "dist_01": {
        "steps": [
            "Isolate incoming supply — turn OFF Main Switch 100A Double (DP) leftmost in PNG and verify zero with tester.",
            "Mount DB securely with correct IP rating, as white plastic enclosure with transparent cover in PNG.",
            "Connect Incoming Live Red (bottom left red arrow) to Main Switch top left terminal, Incoming Neutral Blue (bottom left blue arrow) to Main Switch top right — see labels Incoming Live (Red) and Incoming Neutral (Blue).",
            "Feed RCD 63A 30mA yellow T test button via busbar: Red from Main Switch bottom live to RCD top left, Blue from Main Switch bottom neutral to RCD top right (see red/blue arrows in PNG).",
            "Terminate: Red Live from RCD bottom to busbar feeding MCBs 6A Lighting, 10A Immersion, 16A Radial Sockets, 20A Ring Main, 32A Cooker top terminals; Blue Neutral matching to Neutral Bar blue top right with + screws; Earth Green-Yellow striped from Earth Bar MET green-yellow top left with 10 + screws to all circuits.",
            "Label bottom brown arrows To Lighting Circuit, To Sockets Circuit, To Cooker Circuit; perform continuity, insulation resistance, polarity, earth fault loop, RCD test button before energizing."
        ],
        "components": [
            "DB enclosure white plastic translucent as in PNG",
            "DP Main Switch 100A Double (DP) leftmost with ON/OFF toggle",
            "RCD 63A 30mA with yellow T test button 30mA",
            "SP MCBs: 6A Lighting, 10A Immersion, 16A Radial Sockets, 20A Ring Main, 32A Cooker with black toggles",
            "Neutral Bar blue top right with 10 terminals + screws",
            "Earth Bar MET green-yellow striped top left with 10 terminals + screws",
            "Busbar links red horizontal feeding MCBs, L busbar"
        ]
    },
    "dist_02": {
        "steps": [
            "Isolate upstream three-phase supply L1 L2 L3 N and verify all phases dead with 4-pole tester.",
            "Connect Incoming L1 Red, L2 Yellow, L3 Blue, N Black-Blue to 4P Main Switch 100A top terminals in correct R-Y-B sequence as per PNG color-coded busbars.",
            "Install phase busbars: L1 Red bus, L2 Yellow bus, L3 Blue bus behind MCBs — see red/yellow/blue small rectangles on top of MCBs.",
            "Distribute single-phase MCB circuits across L1, L2, L3 for balance — e.g., MCBs 1,4,7 on L1 Red, 2,5,8 on L2 Yellow, 3,6,9 on L3 Blue as in PNG.",
            "Terminate Blue Neutral conductors to Neutral Bar blue and Green-Yellow Earth striped to Earth Bar MET (green-yellow).",
            "Check phase rotation with rotation meter R-Y-B, insulation resistance phase-phase and phase-earth, earth continuity, and label each circuit L1/L2/L3 at DB schedule."
        ]
    },
    "dist_03": {
        "steps": [
            "Calculate feeder load and voltage drop before installation — see label FEEDER CABLE 10mm² in PNG.",
            "Protect feeder at source Main DB with correctly rated MCB 63A (feeder MCB second from left).",
            "Run feeder armored cable: Red Phase, Blue Neutral, Green-Yellow Earth from Main DB feeder MCB bottom terminals across to Sub-DB incomer.",
            "Install local Main Switch in Sub-DB (leftmost in right enclosure) and outgoing MCBs: 16A Socket, 10A Light, 20A Power as per right side PNG.",
            "Keep neutrals matched to their RCD/RCBO group — earth bars green-yellow in both DBs, neutral bars blue.",
            "Test feeder continuity, insulation resistance, polarity, earth fault loop impedance before energizing sub-DB and label Sub-DB as Fed from Main DB."
        ]
    },
    "dist_04": {
        "steps": [
            "Isolate Main DB and verify dead; identify two RCD groups as in PNG: RCD1 left and RCD2 right.",
            "Install RCD1 63A 30mA downstream of Main Switch 100A DP for left group and RCD2 same for right group.",
            "Route matching: Red Phase through RCD1 to MCBs RCD1-C1/C2/C3 top, and Blue Neutral matching to Neutral Bar 1 (left blue bar marked NEUTRAL BAR 1 RCD1). Do same for RCD2 group to Neutral Bar 2 right.",
            "Do not share neutrals between RCD groups — see red warning in PNG: DO NOT SHARE NEUTRALS BETWEEN RCD GROUPS — this would cause nuisance tripping.",
            "Connect all Green-Yellow Earths to common earth bar only (green-yellow striped top center).",
            "Test both RCDs with yellow T test button and with RCD tester 30mA trip time <300ms, verify no cross neutral."
        ]
    },
    "dist_05": {
        "steps": [
            "Confirm SPD Type 2 40kA selection and system earthing arrangement TT/TN-S as in PNG status OK green window.",
            "Isolate DB and verify dead, mount SPD close to incomer/main busbars as shown second device from left, next to Main Switch.",
            "Connect SPD: Red Phase to L bus, Blue Neutral to N bus, Green-Yellow Earth to Earth Bar with short leads <0.5m as labeled SHORT LEADS <0.5m in PNG (see green-yellow earth lead short straight).",
            "Keep SPD leads short, direct, no loops, to reduce let-through voltage — see label EARTH BAR - KEEP LEAD SHORT.",
            "Connect downstream RCD and MCBs as normal — SPD protects whole board at incomer.",
            "Record SPD status indicator green OK (if red replace), inspect during maintenance per manufacturer."
        ]
    },
    "dist_06": {
        "steps": [
            "List all single-phase loads with estimated current as per left enclosure in PNG: L1 loads, L2 loads, L3 loads.",
            "Assign circuits across L1 Red, L2 Yellow, L3 Blue to keep total current similar ~28A, 30A, 27A as in bar chart right side PNG.",
            "Place high-demand circuits like cooker, AC, water heater on different phases where practical to avoid overloading one phase.",
            "Measure actual current with clamp meter on each phase after energizing under realistic load — see clamp meter circles L1 28A L2 30A L3 27A in bottom right PNG.",
            "If imbalance >10% and allowed, move non-critical circuits to less loaded phase and update load schedule in PNG bar chart.",
            "Update DB schedule and labels: Green check BALANCED - Neutral Current Low (3A) as shown in PNG, keep neutral current low."
        ]
    },
    "dist_07": {
        "steps": [
            "Isolate incoming supply and verify dead; identify Split Load DB with two RCDs as in PNG: RCD1 LIGHTING GROUP left, RCD2 POWER GROUP right.",
            "Install Main Switch 100A DP leftmost, then RCD1 63A 30mA for lighting group and RCD2 same for power group middle.",
            "Route matching neutrals: Lighting MCBs 6A each (Light 1,2,3) Blue Neutral to Neutral Bar for RCD1, Power MCBs 16A 20A 32A to separate neutral bar for RCD2 — see neutral routing in PNG.",
            "Avoid shared neutral between groups — warning in PNG.",
            "Label circuits clearly: RCD1 Light 1, Light 2, Light 3 and RCD2 Power 1-4 as in PNG device labels.",
            "Test both RCDs with test buttons and outgoing circuits with socket tester and insulation."
        ]
    },
    "dist_08": {
        "steps": [
            "Mount RCBOs correctly on DIN rail — each RCBO has own yellow test button as in PNG, 8 RCBOs each 6A-41A with 30mA.",
            "Connect each circuit Red Phase and Blue Neutral through its own RCBO top terminals — phase to busbar, neutral tail white wire from RCBO bottom to Neutral Bar organized as in PNG (separate tails).",
            "Connect Green-Yellow Earths to earth bar green-yellow striped top (blue neutral left, earth right).",
            "Avoid neutral mixing — each RCBO's neutral tail must go to neutral bar not shared before RCBO.",
            "Test every RCBO with yellow TEST button and with RCBO tester — should trip both MCB and RCD functions.",
            "Record circuit labels as in PNG: RCBO 6A Lighting etc., note each has own RCD+MCB combined."
        ]
    },
    "dist_09": {
        "steps": [
            "Install SPD Type 2 40kA near incomer as second device from left in PNG with green OK window.",
            "Keep SPD earth lead short <0.5m direct to Earth Bar green-yellow striped top (see short green-yellow wire).",
            "Install main switch 100A DP leftmost, then RCDs 63A 30mA middle as in PNG.",
            "Install MCBs 10A to 32A CKT1-CKT5 on right side after RCDs, route neutrals correctly to neutral bar blue.",
            "Label SPD/RCD devices and wiring hierarchy as in bottom label: SUPPLY → MAIN → SPD → RCDs → MCBs → LOADS.",
            "Test insulation, polarity, earth continuity, RCD test buttons, and inspect SPD status indicators green OK."
        ]
    },
    "motor_01": {
        "steps": [
            "Isolate motor feeder L1 L2 L3 and control supply 230V and verify all dead with tester — see L1 Red L2 Yellow L3 Blue PE Green-Yellow top left in PNG.",
            "Connect three-phase supply through MCCB 3-pole (leftmost grey device with red trip button) bottom terminals 2-4-6 Red Yellow Blue to contactor K1 top terminals 1-2, 3-4, 5-6 as in PNG.",
            "Connect contactor K1 bottom terminals 2-4-6 to overload relay TOR top terminals; TOR bottom to motor terminals U V W F2? Actually U V W as in PNG bottom motor M 3~ with U V W and earth PE.",
            "Wire control phase: Red wire from supply phase L (top right CONTROL CIRCUIT) through Stop NC red button terminal 1-2, then to Start NO green button 3-4, then to K1 coil A1 (pink).",
            "Add auxiliary NO holding contact K1 13-14 parallel to Start button (see red loop 3-13 and 4-14) to keep K1 ON after releasing Start.",
            "Set TOR overload dial to motor nameplate FLC (e.g., 10A as in dial), include TOR NC 95-96 in series with coil to A1, test Start/Stop/trip: press Start K1 pulls in, press Stop drops, pressing TOR test trips NC opens."
        ]
    },
    "motor_02": {
        "steps": [
            "Verify motor is star-delta suitable 400V delta 690V star and supply is 400V — see 6-terminal motor bottom center in PNG with U1 V1 W1 top and U2 V2 W2 bottom.",
            "Wire Main contactor K1 to motor U1 V1 W1 (top row first device), Star contactor K2 to short U2 V2 W2 together during start (second blue device), Delta contactor K3 to form delta link U1-W2, V1-U2, W1-V2 after timer transition (third device).",
            "Wire Timer relay Star-Delta timer (fourth device beige) with 5-10s delay — Timer NO delays closure of Delta, NC opens Star.",
            "Interlock Star K2 and Delta K3 contactors so they cannot close together — see mechanical interlock and electrical NC: K2 NC in K3 coil circuit, K3 NC in K2 coil circuit, label WARNING STAR & DELTA NEVER TOGETHER in PNG.",
            "Connect overload relay TOR after main contactor before motor as in PNG right side.",
            "Test unloaded first: Start → K1+K2 Star ON, timer counts 5s, K2 OFF, K3 Delta ON with clunk; verify rotation direction, then commission under controlled load."
        ]
    },
    "motor_03": {
        "steps": [
            "Isolate and verify motor supply dead; identify two contactors with mechanical interlock between them as in PNG: Forward K1 (top left) and Reverse K2 (top right) interlocked.",
            "Wire Forward contactor K1 with normal phase sequence L1 Red L2 Yellow L3 Blue to motor U V W.",
            "Wire Reverse contactor K2 with two phases swapped: L1 Red stays, L2 Yellow swap with L3 Blue — L1 L3 L2 to motor, causing reverse direction, as in PNG bottom right power circuit.",
            "Install mechanical interlock between contactors (metal bar) plus electrical NC interlocks: K1 NC in K2 coil circuit and K2 NC in K1 coil circuit to prevent both ON — see red NC contacts in control ladder.",
            "Wire control: Stop NC red top, then Forward NO green left and Reverse NO green right each to respective coil with interlock, common overload NC in series.",
            "Test Forward, Stop, Reverse sequence safely: Press Forward → motor forward, Stop → stop, Reverse → opposite direction; verify direction arrow on motor and no both contactors ON together."
        ]
    },
    "motor_04": {
        "steps": [
            "Connect supply protection MCCB 3-pole top left to contactor K1 input top terminals as in PNG power circuit left side.",
            "Install thermal/electronic overload relay TOR immediately after contactor before motor output — see TOR device with dial FLC setting 10A and terminals 95 NC 97 NO and test button.",
            "Route all three motor phases through overload relay TOR — Red Yellow Blue through TOR top to bottom.",
            "Wire overload NC auxiliary contact 95-96 in series with contactor coil A1-A2 in control circuit right side (red wire through TOR NC).",
            "Set overload current dial to motor nameplate FLC (e.g., if motor 9A set 9A) as shown on TOR dial.",
            "Test overload trip: press TOR test or simulate overload, NC 95-96 should open and drop contactor, check reset button and control circuit drops out, motor stops."
        ]
    },
    "motor_05": {
        "steps": [
            "Choose timer mode: on-delay (delay start), off-delay (delay stop), or cyclic (repeat) according to process needs — see timer mode selector in PNG control circuit.",
            "Wire control supply 230V through control fuse and Stop NC / enable contact as in PNG top right.",
            "Connect timer relay output contact (delayed NO) to contactor coil circuit K1 A1 — see timer contact symbol with clock.",
            "Keep overload NC trip contact 95-96 in series with coil for protection — as in PNG lower control.",
            "Set delay/cycle time on timer dial (0-60s or minutes) and test without motor load first — observe timer LED counting.",
            "Commission under load and verify safe manual Stop still overrides timer and motor stops immediately."
        ]
    },
    "motor_06": {
        "steps": [
            "Verify motor and soft starter ratings match — soft starter kW rating >= motor kW, supply 400V 3-phase as in PNG top.",
            "Connect supply L1 L2 L3 from MCCB to soft starter input terminals L1 L2 L3 top (soft starter black box with heatsink as in PNG).",
            "Connect soft starter output terminals T1 T2 T3 to motor U V W terminals bottom.",
            "Wire optional bypass contactor parallel to soft starter for run efficiency — see bypass contactor left of soft starter in PNG if provided.",
            "Wire start/stop control to soft starter control terminals: Start NO green, Stop NC red, as per manual.",
            "Configure ramp time (e.g., 10s) and current limit (e.g., 300% FLC) via soft starter display/keypad as in PNG, test unloaded then loaded start — motor should ramp smoothly not DOL kick."
        ]
    },
    "motor_07": {
        "steps": [
            "Install input protection MCCB/Isolator top left 3-pole with earth, rated for VFD input current.",
            "Connect supply L1 L2 L3 to VFD input terminals R S T top of black VFD unit with display and keypad as in PNG.",
            "Connect VFD output terminals U V W to motor terminals via shielded motor cable — see shielded cable with braid to earth clamp and earth bonding as in PNG bottom.",
            "Bond earth/shield correctly: shield clamped to VFD earth bar and motor earth, separate earth PE to motor body.",
            "Enter motor nameplate data into VFD parameters: voltage, frequency, current, RPM, power as per motor label.",
            "Test rotation direction and ramp settings: set accel/decel 5s, start VFD, check motor ramps up smoothly, verify rotation arrow, check no EMC noise."
        ]
    },
    "motor_08": {
        "steps": [
            "Isolate supply and verify dead; identify float switch in water tank with high and low levels as in PNG water tank.",
            "Wire motor through contactor K1 and overload TOR — power circuit left: MCCB → K1 → TOR → Pump motor submersible.",
            "Wire float switch in control circuit right: low-level contact NO for START when water low, high-level NC for STOP when water high — see float switch symbol with water.",
            "Add Manual/Auto selector switch: Auto uses float, Manual bypasses float for manual start as in PNG middle.",
            "Set overload TOR to pump motor FLC and test float operation safely: lift float high → pump stop, drop low → pump start.",
            "Test under real water: fill tank to high → pump should stop, drain to low → pump starts, check no dry running."
        ]
    },
    "solar_01": {
        "steps": [
            "Isolate all DC and AC sources before wiring — cover PV panels or disconnect at night for safety.",
            "Connect PV strings through DC fuses/combiner box (top left in PNG, 4 panels → combiner with fuses) to charge controller PV input MPPT terminals as per arrow.",
            "Connect charge controller battery terminals to fused battery bank via DC breaker/fuse — see battery bank middle with BMS and DC breaker, observe + - polarity red/black.",
            "Connect off-grid inverter DC input to battery through DC isolator/breaker — see inverter left of battery with DC cables thick red/black.",
            "Feed inverter AC output to dedicated AC load distribution board with MCBs for lights, sockets — bottom right in PNG small DB.",
            "Check polarity: PV + to +, Battery + to +, inverter battery settings (lead-acid/lithium), and grounding at earth bar before energizing."
        ]
    },
    "solar_02": {
        "steps": [
            "Verify hybrid inverter manual, battery compatibility, and DISCO approval requirements — see hybrid inverter central white box with MPPT PV inputs top.",
            "Wire PV strings to hybrid inverter MPPT inputs through DC isolator 1000V and SPD Type 2 with short earth leads — see DC isolator and SPD top left.",
            "Connect battery bank with BMS and DC breaker with communication cable CAN/RS485 — see battery right side with DC breaker and comms cable as in PNG.",
            "Connect grid/generator AC input left side via breaker and changeover to hybrid inverter AC input — see grid input breaker left.",
            "Connect backup essential loads output bottom to essential-load DB only — lights, fridge, WiFi — not whole house, as in PNG bottom DB.",
            "Configure charging parameters, export limit, battery SOC limits, and test backup transfer: simulate grid fail, inverter should switch to backup within 10ms."
        ]
    },
    "solar_03": {
        "steps": [
            "Confirm utility/DISCO approval and inverter compliance anti-islanding — see Net Meter and DISCO Grid right side in PNG.",
            "Connect PV strings left side (PV Strings with ... dots) through DC combiner with Fuses small grey box to DC isolator 1000V rotary with WARNING DC ISOLATOR label.",
            "Connect DC isolator output to grid-tie inverter MPPT Input central white box with display Anti-islanding protection label.",
            "Connect inverter AC output to AC isolator 32A WARNING AC ISOLATOR label, then to Dedicated MCB Breaker 20A in Main Distribution Board middle right.",
            "Install DC SPD Type 2 small blue device between PV + - and earth bar, and AC SPD Type 2 blue to earth bar with earth symbol — see earth bar bottom.",
            "Label AC/DC isolators with warning notices and commission anti-islanding/export settings per authority, test with net meter running reverse."
        ]
    },
    "solar_04": {
        "steps": [
            "Confirm all batteries are same type, voltage, capacity, brand, age, health — see 4 batteries 12V 100Ah in PNG possibly 12V each.",
            "Plan series strings for required voltage — e.g., 4×12V in series = 48V — and parallel strings for capacity — see equal length links red and black.",
            "Use equal-length battery link cables for parallel current sharing — see red and black thick cables between batteries.",
            "Install DC fuse 125A or DC breaker close to positive terminal of battery bank first battery + as in PNG near top.",
            "Observe polarity carefully: Red + to +, Black - to -, cover exposed terminals with terminal covers as in PNG to prevent short.",
            "Configure charger/inverter battery settings: voltage, type lead-acid/lithium, BMS communication, test total voltage before connecting inverter."
        ]
    },
    "solar_05": {
        "steps": [
            "Identify PV string voltage/current — e.g., Voc 400V and Isc 10A — select DC-rated fuse 15A and isolator 32A 1000V as in PNG.",
            "Route each PV string through correct fuse where required in combiner box — see fuse holders top in PNG small grey box.",
            "Install DC isolator rotary between array/combiner and inverter — see DC Isolator 1000V device with handle.",
            "Connect DC SPD Type 2 small blue device to positive, negative, and earth bar with short leads <0.5m — see SPD with green-yellow earth lead to earth symbol.",
            "Bond frames and support structure metal to earth with green-yellow earth conductor — see earth symbol bottom.",
            "Verify polarity: + to + and - to - with multimeter and open-circuit voltage before connecting inverter — measure Voc at isolator output."
        ]
    },
    "solar_06": {
        "steps": [
            "Verify string voltage/current and count — e.g., 4 strings Voc 200V each — see 4 PV inputs top in PNG.",
            "Connect each string through DC fuse holder 15A — see fuse holders inside combiner box small grey box with 4 fuses in PNG.",
            "Combine outputs to common copper busbars + and - inside combiner box and then to DC isolator 63A — see busbars and isolator middle.",
            "Install DC SPD Type 2 connected to + - and earth bar with short direct leads — see blue SPD bottom left in PNG.",
            "Label polarity + - and hazard DC voltage warning stickers on enclosure IP65 as in PNG transparent door.",
            "Test Voc at combiner output before inverter connection — measure each string individually and combined total."
        ]
    },
    "solar_07": {
        "steps": [
            "Mount microinverters behind each PV module on rail — see 4 PV modules each with small black microinverter box behind in PNG.",
            "Connect PV module DC cables directly to microinverter DC input with MC4 connectors.",
            "Connect microinverters AC outputs via AC trunk cable daisy chain parallel — see black AC trunk cable connecting all microinverters in PNG.",
            "Install AC isolator 25A and AC breaker 20A in distribution board — see isolator and breaker middle right.",
            "Bond frames and mounting rails to earth with green-yellow conductor and earth clamp — see earth symbol bottom left.",
            "Commission monitoring gateway WiFi — see gateway with antenna — and verify AC output power per panel in app."
        ]
    },
    "solar_08": {
        "steps": [
            "Verify inverter AC rating — e.g., 5kW single-phase 230V 20A — see solar inverter left side in PNG (grid-tie or hybrid).",
            "Install dedicated AC isolator rotary 32A near inverter — see AC Isolator device middle with WARNING label.",
            "Connect inverter AC output via AC isolator to Main Distribution Board MCB 20A RCBO 30mA — see DB breaker 20A middle right.",
            "Install warning labels: Solar AC, Do Not Isolate Under Load, Dual Supply, on DB and isolator as in PNG labels.",
            "Check earthing continuity and SPD Type 2 at DB — see AC SPD blue device to earth bar bottom right in PNG.",
            "Commission inverter settings: voltage, frequency, anti-islanding, and test AC output voltage and synchronization before closing DB."
        ]
    },
    "generator_01": {
        "steps": [
            "Isolate all sources Utility and Generator before installation and verify zero voltage at changeover terminals.",
            "Connect Utility Supply L N from energy meter MCB to Source-1 / Normal top terminals of manual changeover I-O-II 63A 3-pole (top row in PNG, marked UTILITY).",
            "Connect Generator Supply L N from generator output breaker to Source-2 / Emergency bottom terminals of changeover (bottom row, marked GENERATOR).",
            "Connect load DB main incomer L N to center output terminals of changeover (middle row, marked LOAD DB OUTPUT).",
            "Ensure switch mechanically prevents both sources being connected together — see handle I-O-II with center OFF gap and label No Backfeed.",
            "Test utility position I lights DB, OFF position O disconnects all, generator position II feeds DB from generator, verify no backfeed to utility with tester."
        ]
    },
    "generator_02": {
        "steps": [
            "Confirm ATS rating 100A 4-pole and pole configuration neutral switching required as per earthing system shown in PNG central ATS device with Normal/Emergency/Load sections.",
            "Connect Utility Incomer L1 L2 L3 N (Red Yellow Blue Black-Blue) to ATS Normal Source top terminals — see Red Yellow Blue Black squares top row.",
            "Connect Generator Output L1 L2 L3 N to ATS Emergency Source middle terminals — Red Yellow Blue Black squares middle, marked GENERATOR.",
            "Connect ATS Load Output L1 L2 L3 N bottom terminals to protected distribution board / load — marked LOAD → DB bottom row green.",
            "Wire generator start/stop control contacts two-wire (volt-free) from ATS controller to generator AMF controller as per manual — see small wires to Generator Controller box right side in PNG.",
            "Test full sequence: simulate utility fail → ATS waits 3s delay → sends start signal → generator starts → ATS transfers to Emergency → utility returns → ATS retransfer with delay → generator cooldown stop, as per text in right box."
        ]
    },
    "generator_03": {
        "steps": [
            "Never connect generator directly to DB without transfer equipment — see warning Never direct to DB in PNG bottom label.",
            "Install generator output breaker 40A after generator — see Generator Breaker middle left small device.",
            "Route generator output cable Red Phase, Blue Neutral, Green-Yellow Earth to changeover/ATS input terminals Emergency side as in PNG middle.",
            "Connect transfer switch output to DB main incomer L N as designed — see DB main incomer 100A top right in PNG.",
            "Verify earthing/neutral bonding arrangement according to local rules: generator frame to earth electrode, neutral-earth link only where TN-S permitted — see Earth Electrode and bond label bottom.",
            "Test voltage (230V), frequency (50Hz), phase sequence (for 3-phase), and load response: start generator, measure voltage at DB, connect small load, check stable."
        ]
    },
    "generator_04": {
        "steps": [
            "Review generator manual and local earthing system requirements TT/TN-S/TN-C-S as per site — see earthing diagram central.",
            "Bond generator frame with earth terminal via 16mm² Green-Yellow bonding conductor to earth bar / system earth — see bonding conductor thick green-yellow to earth bar bottom.",
            "Connect generator earthing conductor to approved earth terminal/electrode pit as required — see Earth Electrode pit with rod and clamp bottom right.",
            "Apply neutral-earth link only where permitted by earthing design — see Neutral-Earth Link If Required dashed link bottom middle — for TT do NOT link, for TN-S link at source only.",
            "Test earth continuity with low resistance ohmmeter and fault path with earth loop tester before operation — see test instrument diagram top right.",
            "Document earthing arrangement with label and diagram for maintenance and inspections — include electrode location, resistance value, bond sizes."
        ]
    },
    "generator_05": {
        "steps": [
            "Install approved generator inlet socket CEE 32A interlocked with flap on exterior wall — see grey metal box with black CEE socket and yellow dot central left in PNG, marked CEE 32A INLET Interlocked Flap.",
            "Connect inlet socket via armored cable 6mm² Flex + Earth to changeover switch generator input terminals — see red phase and blue neutral wires 220V to changeover top terminals, green-yellow earth to earth bar.",
            "Connect changeover output terminals to load distribution board main incomer L N — see red live and blue neutral from changeover bottom to Load DB enclosure right side with Main and MCBs/RCD.",
            "Prevent backfeed mechanically — changeover handle has I-O-II with center OFF that prevents utility and generator both ON, label No Backfeed as in PNG bottom.",
            "Verify earthing arrangement: generator frame earth to system earth via inlet earth pin and earth bar, check with earth tester — see green-yellow earth wire 200 to 400 to 600 to earth bar.",
            "Test under controlled load: plug portable generator into inlet, start generator, switch changeover to GEN, measure voltage at DB, connect small load e.g. light, verify stable, then return to UTILITY."
        ]
    },
    "generator_06": {
        "steps": [
            "Verify ATS rating 63A 400V and pole count 4-pole for neutral switching as per earthing system — see ATS panel 4-POLE ATS 63A 400V central device with Normal/Emergency/Load sections and controller display.",
            "Connect Utility Incomer L1 Red L2 Yellow L3 Blue N Black-Blue top row Normal Source to ATS top terminals — see colored squares top row: red yellow blue black 20x20 and label UTILITY L1 L2 L3 N.",
            "Connect Generator Incomer L1 Red L2 Yellow L3 Blue N Black-Blue middle row Emergency Source to ATS middle terminals — see colored squares middle, marked GENERATOR.",
            "Connect Load Output L1 Red L2 Yellow L3 Blue N Black-Blue bottom row to load distribution board L1 L2 L3 N — see bottom row green LOAD → DB and label LOAD L1 L2 L3 N TO DB.",
            "Wire start signal two-wire from ATS controller to generator AMF controller (volt-free) — see wires to Generator Controller box right side with text Start Signal, Phase Rotation RYB, Neutral Switching.",
            "Test phase rotation with rotation meter R-Y-B as per circle bottom right R-Y-B OK, simulate utility fail, generator starts, ATS transfers, measure voltages, then utility returns, retransfer and cooldown."
        ]
    },
    "generator_07": {
        "steps": [
            "Isolate charger supply AC 230V breaker and verify dead at charger input terminals — see AC Supply box 230V left with Breaker 6A red label.",
            "Install AC breaker/fuse 6A dedicated for charger — see small red rectangle Breaker 6A inside AC Supply box.",
            "Connect charger AC input L N to breaker output as per charger manual — red live to L and blue neutral to N.",
            "Connect charger DC output through DC fuse 10A (small beige device) to battery positive via red cable and negative via black cable — see DC Fuse 10A middle and battery right side 12V 70Ah with Red + terminal and Black - terminal, labels Polarity Observe! and Red + Black -.",
            "Observe polarity: Red + to battery + terminal, Black - to battery - terminal, secure with nuts, cover terminals with covers as in PNG to prevent short.",
            "Test charging voltage: energize AC, measure battery voltage at terminals — should be 13.8V Float as labeled, check Float LED green and 13.8V LED blue on charger, verify maintainer mode holds voltage, check battery isolator."
        ]
    },
    "smart_01": {
        "steps": [
            "Confirm smart switch is rated for no-neutral installation as per manufacturer datasheet — e.g., Aqara, Sonoff no-neutral version — see No-Neutral Switch Box labeled Only L + L1 in PNG left.",
            "Isolate lighting circuit MCB and verify dead with tester at switch box — only Red Live and Red Switched Live present, no blue neutral as per No Neutral! label.",
            "Connect permanent Red Live to smart switch L input terminal (bottom brass screw marked L) — see red wire 220 180 to L.",
            "Connect switched output Red wire L1 to light live conductor at ceiling rose (top terminal) — see red wire 460 200 to ceiling light.",
            "Install bypass capacitor small beige device across light L N at ceiling rose only if manufacturer requires — see Bypass Capacitor small rectangle across light L N at top right ceiling, labeled If required — some LED flicker without it.",
            "Pair device via WiFi/Zigbee app and test manual physical button and app control on/off after safe energizing — should work without neutral.",
            "Also connect Green-Yellow Earth striped wire from earth bar to metal switch box earth screw and fixture earth terminal for continuity — see green-yellow arrow 200 210."
        ]
    },
    "smart_02": {
        "steps": [
            "Isolate circuit at DB and verify dead; confirm switch box contains Blue Neutral as per Switch Box L N E Present label Preferred Method in PNG left.",
            "Connect permanent Red Live to smart switch L terminal red wire (bottom left red dot) — see red wire 240 180 to L terminal.",
            "Connect Blue Neutral to smart switch N terminal blue dot (middle blue dot) — see blue wire 240 200 to N terminal.",
            "Connect Red Switched Live output L1 from switch to light fixture Live terminal brass — see red wire 500 230 to light Live L terminal.",
            "Maintain Green-Yellow Earth continuity in switch box metal and fixture earth — see green-yellow earth wire 240 220 to 300 220 to 300 400 to fixture earth, labeled Earth Continuity.",
            "Configure device in Smart Life / Tuya / Aqara app and test local physical button and app operation — see WiFi Icon + App label in PNG; note Most Reliable, No Bypass Needed green label bottom."
        ]
    },
    "smart_03": {
        "steps": [
            "Confirm relay contact rating suits load type — e.g., 10A resistive, 2A LED — see existing switch top left Existing Switch S1 S2 Input label.",
            "Isolate supply and verify dead at ceiling rose / switch box before opening.",
            "Connect Blue Neutral and Red Live supply to relay power terminals L and N — see L Red Power Input and N Blue Power Input labels in smart relay module central device.",
            "Connect relay output contact COM NO in series with load live conductor — see Output Contact COM NO in series label, red wire from COM to lamp.",
            "Connect manual wall switch input S1 S2 to relay's manual switch input according to relay mode (toggle vs edge) — see S1 S2 Manual Switch Input wire grey.",
            "Secure module in suitable enclosure with space behind switch, use approved connectors Wago 221, test app control and manual wall switch both toggle light — see Tucked Behind Switch label green dot."
        ]
    },
    "smart_04": {
        "steps": [
            "Verify smart breaker rating, breaking capacity 6kA, and approvals before use — see Smart Breaker 32A 6kA label central device with WiFi green dot and Trip Log.",
            "Isolate DB and verify dead before installation — turn off main incomer isolator leftmost Main device.",
            "Install smart breaker on correct DIN rail busbar behind — see DIN rail grey top with screws, busbar red — ensure clip engages, as per manual instructions.",
            "Connect outgoing load conductor Red to load terminal bottom and neutral reference Blue wire to neutral bar right side — see neutral tail white wire from breaker bottom to neutral bar.",
            "Configure app/gateway e.g., Tuya Smart — see Mobile App box center with Current Power Energy Trip Logging Remote Status — pair via WiFi.",
            "Use remote features for monitoring only; apply physical lockout main breaker for maintenance — see red Safety Warning box right: Use Physical Lockout Do Not Rely On Remote OFF For Maintenance — critical safety."
        ]
    },
    "smart_05": {
        "steps": [
            "Confirm Zigbee relay rating 10A suits light load LED — see Manual Switch Existing top left and Zigbee Relay Module central with L Red Supply, N Blue Supply, Output To Lamp Live.",
            "Isolate supply and verify dead; connect Blue Neutral and Red Live supply to relay power terminals L and N — see L Red Supply and N Blue Supply labels.",
            "Connect relay output Red wire to lamp Live terminal — see Output To Lamp Live red wire to ceiling light load.",
            "Connect manual wall switch input wire to S1 terminal with existing wall switch as shown grey wire Manual Switch Input — see S1 label.",
            "Pair with Zigbee hub coordinator with antenna — see Zigbee Hub right side with Coordinator label, black dot antenna — put hub in pairing mode then press relay pairing button.",
            "Test manual wall switch toggles relay and app control via hub — see Zigbee Pairing label and Router label green dot; verify both manual and app work."
        ]
    },
    "smart_06": {
        "steps": [
            "Use smart relay only for contactor coil — not direct heavy load — see warning Drives Coil Only! Not Direct Load red text in smart relay central device.",
            "Protect power circuit with MCB 32A — see MCB 32A Power Circuit leftmost small device.",
            "Wire heavy load e.g., water heater, motor, AC 3kW through contactor 3-pole contacts — see Contactor 3-Pole central top with Contacts to Heavy Load label and heavy load middle box Water Heater / Motor / AC High Power.",
            "Wire smart relay output NO contact to contactor coil A1 A2 — see Smart Relay right side L N Power Output NO → Coil A1, Drives Coil Only! label, and wire down to coil.",
            "Keep manual isolation switch and local stop button in series for safety — see Manual Isolation + Local Stop Required red label bottom.",
            "Test remote app turns on smart relay → relay closes → contactor coil energizes → contactor contacts close → heavy load ON; test local stop opens coil and load OFF regardless of app."
        ]
    },
    "smart_07": {
        "steps": [
            "Isolate DB where required but keep main incomer energized for measurement — work with insulated tools; identify phase conductors L1 Red L2 Yellow L3 Blue as in top middle box Phase Conductors.",
            "Clip CT clamps split-core black around correct phase conductors with arrow direction pointing to load — see 4 CT clamps black with white down arrow marked CT Clamps Around Phase Observe Direction Arrow (Pointing to Load) and CT1 Arrow → Load labels top.",
            "Observe CT direction arrow — arrow must point toward load, not toward supply, otherwise reading negative — see white down arrows on CTs.",
            "Connect CT leads Red Yellow Blue to energy monitor module CT1 CT2 CT3 inputs — see CT leads wires bottom of CTs to monitor module right side grey box Energy Monitor Module with CT1 CT2 CT3 labels and WiFi icons.",
            "Connect voltage reference safe connection via 1A Fuse small grey fuse to neutral — see 1A Fuse device and Voltage Reference Safe Connection Via Fuse to Neutral labels top middle and bottom, with fuse and blue wire to neutral bar and earth bar.",
            "Configure app on phone: set circuit names Kitchen Sockets 1.1kW Lights 1kW EV Charger 3.0kW etc. as in right side phone showing Total Usage 4.2kW — see Configured App phone image; verify readings with known load e.g., kettle 2kW plugged into socket bottom right Verify With Known Load label."
        ]
    }
}

# Apply enhancements
for diag_id, data in enhanced.items():
    # Find the block for this id
    pattern_id = f"id: '{diag_id}'"
    idx = content.find(pattern_id)
    if idx == -1:
        print(f"Not found {diag_id}")
        continue
    # Find steps array for this diagram
    # Look for steps: [ ... ] after id
    # We need to replace steps section
    # Find steps: [ up to ], pattern
    # Use regex to find steps: \[ ... \] non-greedy across lines for this diagram
    # We'll replace only the first steps after this id
    # Find from id to next relatedDiagramIds or contentVersion
    # Simpler: replace steps list manually via regex scoped
    
    # Extract steps original
    # We will replace steps: [ ... ] with new steps
    start_steps = content.find("steps:", idx)
    if start_steps == -1:
        print(f"steps not found for {diag_id}")
        continue
    # Find opening [
    open_bracket = content.find("[", start_steps)
    close_bracket = content.find("],", open_bracket)
    # Count nested? steps list ends with ],
    # Find matching ] by counting
    # Actually steps list contains strings with brackets? No
    # We can find the closing ], that is followed by newline and components
    # Let's find components: after steps, find "components:"
    comp_idx = content.find("components:", open_bracket)
    # The steps array ends before components, so find last ], before components
    # Search backwards from comp_idx for ]
    end_bracket = content.rfind("]", open_bracket, comp_idx)
    # Now replace
    old_steps_block = content[open_bracket:end_bracket+1]
    new_steps_list = ",\n      ".join([f"'{s.replace(chr(39), chr(34))}'" for s in data["steps"]])
    # Actually keep single quotes but escape internal single quotes
    new_steps = "[\n      " + ",\n      ".join([f"'{s.replace(\"'\", \"\\\\'\")}'" for s in data["steps"]]) + "\n    ]"
    content = content[:open_bracket] + new_steps + content[end_bracket+1:]
    print(f"Enhanced steps for {diag_id}")

    # If components enhanced provided, replace components too
    if "components" in data:
        start_comp = content.find("components:", idx)
        open_c = content.find("[", start_comp)
        comp_end_idx = content.find("tags:", open_c)
        end_c = content.rfind("]", open_c, comp_end_idx)
        old_c = content[open_c:end_c+1]
        new_c = "[\n      " + ",\n      ".join([f"'{c.replace(\"'\", \"\\\\'\")}'" for c in data["components"]]) + "\n    ]"
        content = content[:open_c] + new_c + content[end_c+1:]
        print(f"Enhanced components for {diag_id}")

# Write back
with open(path, 'w', encoding='utf-8') as f:
    f.write(content)

print("All enhanced")
