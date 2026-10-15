🚀 VSDIAT | ASIC / VLSI Core Training
📘 Module 5: Routing and Physical Verification
🎯 Focus: Maze Routing, Design Rule Check (DRC), Power Distribution Network (PDN), Global Routing, Detailed Routing, and TritonRoute.

📌 Module Overview
Module 5 covers the routing-focused stages of the RTL-to-GDSII physical-design flow. It explains how placed cells are connected through metal interconnects and how the physical layout is checked against manufacturing rules.
🎯 Learning Objectives
By the end of this module, you should be able to:
- 🧩 Explain maze routing and Lee's algorithm.
- 🔍 Describe the purpose of Design Rule Checking (DRC).
- ⚡ Explain the role of a Power Distribution Network (PDN).
- 🔗 Describe how power straps connect to standard-cell power rails.
- 🌐 Distinguish global routing from detailed routing.
- 🛠️ Summarize TritonRoute and its key features.
- 🔌 Explain guide connectivity and routing across metal layers.
- 📂 Identify common post-route files and reports.
- 🏭 Relate these concepts to the complete RTL-to-GDSII flow.
🧭 1. SKY130_D5_SK1 — Routing Fundamentals and DRC
This section introduces routing algorithms and physical-layout verification.
🔹 SKY_L1 — Introduction to Maze Routing: Lee's Algorithm
Maze routing models the search for a connection as a path-finding problem on a grid.
📌 Topics
- Source and destination points
- Grid-based route exploration
- Expanding possible paths
- Finding a connected route
- Obstacles and routing constraints
Lee's algorithm systematically explores a routing grid to find a connected path between two points.
💡 Why it matters: Routing converts logical connectivity into physical metal interconnects. Maze-routing concepts help explain how automated tools search for wire paths.
🔹 SKY_L2 — Lee's Algorithm: Conclusion
This lesson connects the algorithmic concept to practical routing.
Important concepts
- Path exploration and connectivity
- Routing grids
- Obstacles and constraints
- Route generation
- The relationship between algorithms and physical implementation
These ideas provide a foundation for understanding global and detailed routing tools.
🔹 SKY_L3 — Design Rule Check (DRC)
Design Rule Check (DRC) verifies that physical layout geometry follows the manufacturing rules defined by the technology.
🔍 Common checks
- Minimum metal width
- Minimum spacing
- Layer-specific rules
- Via-related restrictions
- Metal geometry constraints
- Manufacturing-related layout requirements
💡 Why DRC matters: A layout can be logically correct and still violate manufacturing constraints. DRC checks the physical geometry against technology rules and is an important physical-verification step before fabrication.
⚡ 2. SKY130_D5_SK2 — Power Distribution Network and Routing
This section introduces power delivery and the transition from power planning to signal routing.
🔹 SKY_L1 — Build the Power Distribution Network
The Power Distribution Network (PDN) distributes power and ground across the chip.
📌 Key concepts
- VDD and VSS networks
- Power straps and rings
- Standard-cell power connections
- Supply-voltage distribution
- Physical power delivery
Every standard cell requires power and ground connections. The PDN provides the physical infrastructure needed to distribute these supplies throughout the design.
🔹 SKY_L2 — From Power Straps to Standard-Cell Rails
Higher-level power structures must connect to the power rails used by standard cells.
⚡ Power distribution hierarchy
Power Sources
     |
     v
Power Distribution Network
     |
     v
Power Straps / Rings
     |
     v
Standard-Cell VDD/VSS Rails
     |
     v
Individual Standard Cells
📌 Important concepts
- Power straps
- Standard-cell VDD/VSS rails
- Power connectivity
- Physical power distribution
- Interaction between the PDN and standard-cell placement
🔹 SKY_L3 — Global Routing, Detailed Routing, and TritonRoute
Routing is generally divided into two main stages.
🌐 Global Routing
Global routing estimates routing paths and allocates routing resources.
It considers:
- Connectivity
- Routing regions
- Routing capacity
- Congestion
- Approximate wire paths
🛠️ Detailed Routing
Detailed routing turns global-routing guidance into actual wire and via geometries while meeting detailed routing constraints.
It considers:
- Exact wire locations
- Metal layers
- Via placement
- Design rules
- Connectivity
- Routing constraints
⚙️ TritonRoute
TritonRoute is used for detailed routing in the RTL-to-GDSII physical-design flow. It connects placed cells according to the design netlist and produces the routed physical representation of the design.
🚦 3. SKY130_D5_SK3 — TritonRoute Features
This section examines how TritonRoute uses routing guidance and preserves electrical connectivity.
🔹 SKY_L1 — Honors Pre-Processed Route Guides
TritonRoute uses routing-guide information generated earlier in the flow.
Key concepts
- Route guides
- Pre-processed routing information
- Routing constraints
- Guide-based detailed routing
Route guides help the detailed router determine where connections should be routed.
🔹 SKY_L2 — Inter-Guide Connectivity and Intra-/Inter-Layer Routing
🔗 Inter-guide connectivity
The router must preserve connectivity across different routing-guide regions so that each completed net remains electrically connected.
➖ Intra-layer routing
Routing within the same metal layer must satisfy:
- Connectivity requirements
- Geometrical constraints
- Design rules
🔀 Inter-layer routing
Connections between different metal layers require vias.
Metal Layer A
     |
     v
    Via
     |
     v
Metal Layer B
Vias allow a connection to transition between metal layers and support routes that span multiple layers.
🔹 SKY_L3 — TritonRoute Method to Handle Connectivity
This lesson focuses on how TritonRoute maintains electrical connectivity while converting routing guidance into physical routes.
📌 Important concepts
- Net connectivity
- Guide connectivity
- Routing topology
- Layer transitions
- Via insertion
- Connectivity verification
The final physical routes must represent the intended logical connections in the netlist.
🔹 SKY_L4 — Routing Topology and Post-Route File List
This lesson examines routing topology and the data available after routing.
📂 Topics
- Routing topology
- Detailed route generation
- Post-route physical data
- Routed DEF
- Routing reports
- Physical-verification data
Post-route files represent the routed design and provide supporting information for verification and further analysis.
🔄 4. Routing Flow at a Glance
Placed Design
     |
     v
Power Distribution Network
     |
     v
Global Routing
     |
     v
Route Guides
     |
     v
Detailed Routing (TritonRoute)
     |
     v
DRC / Physical Verification
     |
     v
Post-Route Design
📚 5. Important Concepts Summary
Topic	Key idea
🗺️ Maze routing	Path-finding through a constrained grid
🧮 Lee's algorithm	Systematic exploration of a routing grid
🌐 Global routing	Approximate paths and resource allocation
🛠️ Detailed routing	Creation of physical wires and vias
⚡ PDN	Distribution of VDD and VSS
🔍 DRC	Verification against manufacturing rules
🧭 Route guides	Guidance for detailed routing
⚙️ TritonRoute	Detailed-routing tool
🔗 Connectivity	Preserving intended electrical connections
🧵 Routing topology	Structure of physical routes
📄 Post-route data	Routed DEF and supporting reports


🏭 6. Position in the RTL-to-GDSII Flow
RTL
 |
 v
Synthesis
 |
 v
Floorplanning
 |
 v
Power Planning
 |
 v
Placement
 |
 v
Clock Tree Synthesis
 |
 v
Global Routing
 |
 v
Detailed Routing
 |
 v
DRC / Physical Verification
 |
 v
GDSII
Earlier modules establish the design, timing, standard-cell, and physical-design foundations needed for these stages.
✅ 7. Module Completion Checklist
- [ ] 📘 SKY130_D5_SK1 — Routing and DRC
- [ ] 🗺️ Maze routing and Lee's algorithm
- [ ] 🔍 DRC purpose and common rule categories
- [ ] ⚡ SKY130_D5_SK2 — PDN and routing
- [ ] 🔗 Power straps and standard-cell power rails
- [ ] 🌐 Global routing
- [ ] 🛠️ Detailed routing
- [ ] ⚙️ TritonRoute and its features
- [ ] 📘 SKY130_D5_SK3 — TritonRoute topics
- [ ] 🧭 Route guides and inter-guide connectivity
- [ ] ➖ Intra-layer routing
- [ ] 🔀 Inter-layer routing and vias
- [ ] 🔗 Connectivity handling
- [ ] 🧵 Routing topology
- [ ] 📂 Post-route files and reports
🧠 8. Skills Covered
- 🏗️ Physical design: PDN, DRC, and physical verification
- 🧮 Routing algorithms: Maze routing and Lee's algorithm
- 🌐 Routing stages: Global and detailed routing
- ⚙️ Tools: TritonRoute and the RTL-to-GDSII routing flow
- 🔌 ASIC concepts: Power delivery, routing constraints, vias, connectivity, and post-route data
🏁 Conclusion
Module 5 brings together power distribution, routing algorithms, TritonRoute, and DRC to explain the routing-focused stages of VSDIAT physical-design training. These concepts show how a placed and clocked design is converted into a physically routed implementation that can proceed through physical verification.
📌 Module 5 Summary
Area	Main focus
Maze routing	Grid-based path finding
Lee's algorithm	Systematic route exploration
DRC	Manufacturing-rule verification
PDN	VDD/VSS power distribution
Global routing	Approximate routing paths
Detailed routing	Exact wires and vias
Route guides	Routing guidance
TritonRoute	Detailed routing
Connectivity	Electrical connection handling
Routing topology	Physical route structure
Post-route data	Routed DEF and reports
RTL-to-GDSII	Physical-design flow


🎓 Training: VSDIAT — ASIC / VLSI Core Training
📘 Module: 5 — Routing and Physical Verification with TritonRoute
