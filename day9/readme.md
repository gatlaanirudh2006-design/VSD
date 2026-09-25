# ⏱️ Day 9 — SKY130 Module 4: Timing Analysis, CTS & Post-CTS STA

> ### 🎯 Focus
> **Timing-aware ASIC physical design:** standard-cell timing models, setup/hold,
> clock-tree synthesis, clock distribution, placement, skew, STA, WNS and TNS.

---

## 🧭 1. Overview

Day 9 focuses on the timing-aware stage of the **SKY130 ASIC physical-design flow**.
The work connects standard-cell timing models with sequential timing, physical
clock distribution and post-CTS static timing analysis.

### 🔗 Core idea

```text
📚 Timing Models
      ↓
📐 Setup / Hold
      ↓
🌳 Clock Tree Synthesis
      ↓
📍 Physical Implementation
      ↓
⏱️ Post-CTS Timing
      ↓
📊 STA
      ↓
⚠️ WNS / TNS / Violations
This module provides a foundation for understanding timing closure in a
complete ASIC design flow.
