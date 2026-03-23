---
date: 2026-03-23
topic: learning-resource-improvements
focus: Visual aids, interactive learning, how residents actually learn, ISNCSCI video demonstrations
---

# Ideation: SCI Training App — Learning Resource Improvements

## Codebase Context
- Flutter app with 14 SCI board-review modules, 154 quiz questions, 3 interactive tools
- Clinical Editorial design system (Space Grotesk + Source Serif 4 + JetBrains Mono)
- 519KB of Dart content across 14 module files, backed by 86K-word verified reference text
- Flashcard system exists but is NOT connected to data
- assets/audio/ and assets/images/ are EMPTY — no multimedia
- No spaced repetition, no progress tracking, no persistence layer
- No video demonstrations of clinical exam skills
- Quiz is random-draw only, not adaptive
- Reference text has [BOARD]/[COMPREHENSIVE] tags but app doesn't filter by them
- INSTRUCTIONS.md lists 6 target subspecialties (SCI, TBI, Stroke, EDX, P&O, Pediatric Rehab)

## Ranked Ideas

### 1. Interactive ISNCSCI Video Exam Technique Library
**Description:** Add a "Watch Technique" mode to the dermatome map and ISNCSCI tools. Short 30-90s video clips demonstrating proper MMT positioning, sensory point testing, BCR technique for each of the 10 key muscles and 28 sensory points.
**Rationale:** Motor skills cannot be learned from text. Residents fail the hands-on ISNCSCI exam because they've never seen proper technique. DermatomeMapWidget already has study + quiz modes — technique mode is architecturally natural.
**Downsides:** Requires recording/sourcing ~40 videos. Storage/streaming complexity.
**Confidence:** 85%
**Complexity:** Medium
**Status:** Unexplored

### 2. Spaced Repetition Engine with Persistent Progress
**Description:** Replace stateless flashcard/quiz with SM-2 scheduler backed by local storage. Track per-question performance with intervals. "X cards due today" on home screen. Missed questions resurface in 1 day; mastered in 30 days.
**Rationale:** Single most evidence-backed technique for board prep. Current quiz has zero memory. Ebbinghaus forgetting curve: 70% loss within 24h without review; SRS reduces to <10%.
**Downsides:** Requires local database dependency (Hive/SQLite). UX complexity.
**Confidence:** 95%
**Complexity:** Medium
**Status:** Unexplored

### 3. Virtual Patient Encounter Simulator
**Description:** 10-15 branching clinical scenarios with decision consequences. Cross-links modules. Wrong choices show clinical outcomes.
**Rationale:** Board exams test clinical reasoning, not recall. Simulation-based education shows superiority over didactics.
**Downsides:** Content creation labor-intensive. Branching logic adds UI complexity.
**Confidence:** 80%
**Complexity:** High
**Status:** Unexplored

### 4. Diagnostic-First Onboarding + Competency Dashboard
**Description:** 20-question diagnostic quiz on first launch → knowledge heat map. Home screen becomes living competency dashboard with decaying confidence meters.
**Rationale:** Residents don't know what they don't know. Assessment-first improves time-to-mastery 20-40%. Decaying dashboard makes forgetting visible.
**Downsides:** Requires persistence. First-launch friction.
**Confidence:** 75%
**Complexity:** Medium
**Status:** Unexplored

### 5. Board-Mode Cram Filter
**Description:** "Board Prep" toggle: show only [BOARD]-tagged content, filter quiz to board difficulty, collapse to pearls/mnemonics/scales. 86K words → ~30K board-only.
**Rationale:** 48-hours-before-boards resident needs ruthless prioritization. Tags and difficulty fields already exist.
**Downsides:** Content blocks need board/comprehensive tagging in Dart model.
**Confidence:** 90%
**Complexity:** Low
**Status:** Unexplored

### 6. Build Remaining Interactive Clinical Algorithm Widgets
**Description:** Build the 6 unimplemented CustomWidgetType tools: AD flowchart, bladder algorithm, bowel algorithm, spasticity ladder, pressure staging, functional outcomes chart.
**Rationale:** Bedside tools residents actually use. Bridges studying and treating. Reusable patterns transfer to TBI/Stroke apps.
**Downsides:** 6 widgets = significant engineering.
**Confidence:** 85%
**Complexity:** Medium-High
**Status:** Unexplored

### 7. Subspecialty App Factory (Shared Core Package)
**Description:** Extract pmr_training_core Flutter package. Each subspecialty app becomes thin data layer on shared engine.
**Rationale:** 6 target subspecialties. Currently each app is copy-paste. Shared package: one fix propagates everywhere, new app spinup days→hours.
**Downsides:** Refactoring effort. Package versioning.
**Confidence:** 70%
**Complexity:** High
**Status:** Unexplored

## Rejection Summary

| # | Idea | Reason Rejected |
|---|------|-----------------|
| 1 | Audio/Podcast Pipeline | Content problem, not code; NotebookLM handoff planned |
| 2 | Module-Scoped Quiz | Subsumed by SRS engine |
| 3 | Peer Comparison Benchmarking | Requires backend + critical mass; premature |
| 4 | OTA Content Updates | Architectural, not learning; premature |
| 5 | Full-Text Reference Search | Low learning impact |
| 6 | Timed Mock Board Exam | Quiz variant, subsumed by SRS + Board Mode |
| 7 | Active Recall Micro-Checks | Complex authoring; addressed by SRS flashcards |
| 8 | Program Director Dashboard | Requires backend, institutional sales; premature |
| 9 | Collaborative Study Notes | Requires backend + network effect; premature |
| 10 | Adaptive Quiz Engine | Subsumed by SRS |
| 11 | Deep-Link Reference Search | UX convenience, not pedagogical |

## Session Log
- 2026-03-23: Initial ideation — 24 candidates generated across 3 parallel agents (learner pain, inversion/assumption-breaking, leverage/compounding), 18 unique after dedupe, 7 survived adversarial filtering
