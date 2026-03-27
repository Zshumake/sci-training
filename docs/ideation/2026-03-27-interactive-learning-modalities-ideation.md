---
date: 2026-03-27
topic: interactive-learning-modalities
focus: non-reading interactive learning avenues beyond quizzes — videos, animations, drag-and-drop, clinical simulations
---

# Ideation: Interactive Non-Reading Learning Modalities

## Codebase Context

Flutter app with 14 SCI learning modules. Recently added 45 visual content blocks (AnnotatedImageBlock, FlowchartBlock, ComparisonDiagramBlock). 5 interactive ISNCSCI tools built. 31 Servier Medical Art PNGs. 154 quiz questions. Audio infrastructure scaffolded but empty (just_audio + PodcastModel + notebooklm-handoff/). No video player. 86K words of verified reference text. The app currently delivers 95% of content through reading — the user wants to make it feel nothing like a textbook.

## Ranked Ideas

### 1. Animated Pathophysiology Walkthroughs
**Description:** Step-by-step animated diagrams that walk through dynamic physiological cascades — AD, spinal shock, micturition reflex. User taps "Next Step" to reveal arrows, color changes, and labels sequentially on Servier anatomy PNGs. Built with Flutter's native animation framework.
**Rationale:** Physiological cascades are inherently temporal. Static diagrams flatten them. No new dependencies needed.
**Downsides:** Content authoring is labor-intensive per animation.
**Confidence:** 85%
**Complexity:** Medium
**Status:** Explored

### 2. Clinical Video Atlas (Curated External Links)
**Description:** VideoLinkBlock with curated links to open-access clinical videos — spasticity grading, AD signs, gait patterns. Opens via url_launcher.
**Rationale:** PM&R is physical. url_launcher already exists. Lowest effort.
**Downsides:** External dependency on video availability.
**Confidence:** 90%
**Complexity:** Low
**Status:** Unexplored

### 3. "Hot Seat" Clinical Decision Simulator
**Description:** Time-pressured branching scenarios with consequences. Built on existing FlowchartBlock data.
**Rationale:** 9 flowchart algorithms already encode decision trees. Turns static flowcharts into simulations.
**Downsides:** Heavy content authoring for consequence modeling.
**Confidence:** 75%
**Complexity:** High
**Status:** Unexplored

### 4. Audio Rounds via NotebookLM
**Description:** Populate empty podcast infrastructure with AI-generated case discussions.
**Rationale:** Infrastructure is literally built and empty. Fills hands-free gap.
**Downsides:** Passive consumption, not interactive.
**Confidence:** 95%
**Complexity:** Low
**Status:** Unexplored

### 5. Drag-and-Drop Functional Level Mapper
**Description:** Drag functional milestones onto correct spinal levels on body silhouette.
**Rationale:** Most tested PM&R board topic. Spatial memory > reading tables.
**Downsides:** Mobile drag UX can be fiddly.
**Confidence:** 80%
**Complexity:** Medium
**Status:** Unexplored

### 6. "Tap the Level" Gesture-Based Neuro Drill
**Description:** Body diagram + clinical finding description → tap the correct level.
**Rationale:** Extends existing DermatomeMapWidget. Spatial learning.
**Downsides:** Limited to localization testing.
**Confidence:** 85%
**Complexity:** Low-Medium
**Status:** Unexplored

### 7. Daily Clinical Vignette ("Morning Report")
**Description:** Daily case with clinical prioritization exercise. Streak mechanic.
**Rationale:** Duolingo engagement model + morning report format.
**Downsides:** Streak mechanics can feel gimmicky.
**Confidence:** 70%
**Complexity:** Medium
**Status:** Unexplored

## Rejection Summary

| # | Idea | Reason Rejected |
|---|------|-----------------|
| 1 | Spaced Repetition Flashcards | Covered in previous ideation |
| 2 | Pressure Injury Photo Staging | Content sourcing problem |
| 3 | Timed ISNCSCI Sprints | Too incremental |
| 4 | Teach-Back Verbal Recording | Weak signal without AI grading |
| 5 | Physical Exam Walkthroughs | Subsumed by animated walkthroughs + video atlas |
| 6 | Cross-Module Connections Map | Complexity without clear board-prep value |
| 7 | Peer Comparison Analytics | Premature; requires backend |

## Session Log
- 2026-03-27: Initial ideation — 24 candidates generated across 3 agents, 7 survived. User selected "Animated Pathophysiology Walkthroughs" for brainstorming.
