🔬 Day 8 – CMOS Fundamentals, Fabrication, SPICE & SKY130 Standard Cell Design

🧭 Overview

Day 8 focused on understanding CMOS technology from the device and fabrication level through physical layout and electrical simulation.

The practical work followed this flow:

CMOS Fundamentals ↓ CMOS Inverter ↓ CMOS Fabrication ↓ SKY130 PDK ↓ Magic VLSI ↓ Standard Cell Layout ↓ SPICE Extraction ↓ ngspice Simulation ↓ Transient Analysis

📝 SPICE Deck
A SPICE deck is a text-based description of an electrical circuit used by a SPICE simulator. For the CMOS inverter, the circuit contains PMOS, NMOS, input A, output Y, VPWR, VGND, and load capacitance.

         VPWR
           |
          PMOS
           |
           +------ Y
           |
          NMOS
           |
          VGND

             A
             |
      Gates of PMOS/NMOS
🔌 CMOS Inverter
The CMOS inverter uses complementary PMOS and NMOS devices controlled by the same input.

A = 0 → PMOS ON, NMOS OFF → Y ≈ VPWR A = 1 → PMOS OFF, NMOS ON → Y ≈ VGND

Y = ~A

⚡ CMOS Switching Behavior
A practical CMOS inverter has finite rise time, fall time, and propagation delay because device resistance, gate capacitance, diffusion capacitance, interconnect capacitance, and load capacitance affect the transition.

🏭 16-Mask CMOS Fabrication Process
The fabrication discussion covered wafer preparation, well formation, isolation, active-region formation, gate formation, source/drain implantation, contacts, metal formation, passivation, and final processing.

Silicon ↓ Wells ↓ Active Regions ↓ Gate ↓ Source / Drain ↓ Contacts ↓ Metal Interconnects ↓ Completed CMOS Circuit

🧱 Well Formation and CMOS Structure
The CMOS structure uses appropriate well regions for the complementary devices.

Important concepts include:

N-well

P-well

Substrate

Dopant implantation

Active regions

🧪 Masking and Photolithography
Photolithography and masking define physical regions such as wells, active areas, polysilicon, implant regions, contacts, and metal layers.

Mask ↓ Pattern Transfer ↓ Etching / Implantation / Deposition ↓ Physical Structure

SKY130 PDK
The SKY130 PDK provides technology-specific information needed for physical design and simulation, including technology layers, design rules, device information, standard-cell libraries, LEF information, Liberty libraries, SPICE models, and technology files.

🎨 Introduction to Magic VLSI
Magic VLSI is used for physical layout creation, layer inspection, design-rule checking, circuit extraction, and technology-specific layout work.

📐 Custom SKY130 CMOS Inverter Layout
A custom SKY130A CMOS inverter was implemented with PMOS and NMOS devices, input A, output Y, VPWR, VGND, contacts, and interconnect structures.

The layout was inspected using Magic and used as the source for subsequent SPICE extraction.

🔍 SPICE Extraction from Layout
After creating the physical layout, the circuit was extracted into a SPICE representation.

The extracted description contains information about:

🔌 MOS transistors

📏 Device dimensions

🔗 Device connectivity

⚡ Parasitic capacitances

🔋 Power connections

⏚ Ground connections

The extraction relationship is:

Physical Layout ↓ Magic ↓ SPICE Extraction ↓ Extracted Circuit ↓ Electrical Simulation

⚙️ ngspice Transient Simulation
The extracted inverter was simulated using ngspice with the supply and transient stimulus used during the practical exercise.

VPWR = 3.3 V VGND = 0 V Input = pulse source Analysis = transient Simulation time = 20 ns

📈 Transient Waveform
The input A and output Y waveforms demonstrate the expected inverter relationship:

A = LOW → Y = HIGH A = HIGH → Y = LOW

The zoomed view makes the switching interval easier to inspect.

✅ From Physical Layout to Electrical Verification
CMOS Transistor Design ↓ Physical Layout ↓ Magic VLSI ↓ DRC / Physical Verification ↓ SPICE Extraction ↓ Extracted Netlist + Parasitics ↓ ngspice ↓ Transient Analysis ↓ Electrical Verification

📦 Standard-Cell Perspective
The custom inverter can be considered a basic standard-cell building block with a defined physical and logical interface.

Important characteristics include:

Cell dimensions

Power connection

Ground connection

Input pins

Output pins

Technology-compliant geometry

Routing compatibility

Timing information

Electrical characterization

🎯 Key Learning Outcomes
CMOS

CMOS inverter operation

PMOS/NMOS complementary behavior

CMOS switching

Noise margins

Rise and fall behavior

Propagation delay

Fabrication

16-mask CMOS process

Well formation

Active-region formation

Gate formation

Source/drain implantation

Contacts

Metal interconnects

Photolithography and masking

SKY130

SKY130 PDK

Technology layers

Design-rule information

Standard-cell libraries

Technology-specific simulation data

Magic VLSI

Physical layout

Layer inspection

DRC

SPICE extraction

Standard-cell layout

SPICE / ngspice

SPICE deck structure

Device connectivity

Input stimulus

Load capacitance

Transient simulation

Waveform interpretation

Parasitic effects

🏁 Day 8 Summary
The exercise established the connection between CMOS device fundamentals, fabrication, physical layout, SPICE extraction, and electrical simulation.

Device Level ↓ Circuit Level ↓ Fabrication Level ↓ Layout Level ↓ SPICE Level ↓ Simulation Level

The custom SKY130 CMOS inverter was implemented using Magic, extracted into SPICE, and simulated using ngspice.
