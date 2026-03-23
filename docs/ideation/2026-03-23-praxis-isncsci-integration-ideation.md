---
date: 2026-03-23
topic: praxis-isncsci-integration
focus: How to incorporate the Praxis ISNCSCI open-source ecosystem into the SCI Training app
---

# Ideation: Praxis ISNCSCI Integration

## Available Assets

### Open Source (Apache 2.0)
1. **praxis-isncsci/algorithm** — TypeScript ISNCSCI scoring engine (npm: `isncsci` v2.0.6)
2. **praxis-isncsci/ui** — Web components for exam interface (body diagram, worksheet)
3. **praxis-isncsci/ionic-app** — Mobile app reference architecture (Vue + Capacitor)
4. **Python port** — Previously created Python implementation with ExamBuilder, Validator, GUIHelper

### Already in Our App
- `ISNCSCIScoringTool` widget — manual score entry + auto-classification
- `DermatomeMapWidget` — body map with study + quiz modes
- `AISPracticeWidget` — 14 clinical scenarios for AIS grading practice
- 154 quiz questions (many on ISNCSCI classification)
- Comprehensive ASIA/ISNCSCI module content (5 tabs)

## Ranked Integration Ideas

### 1. Port Praxis Algorithm to Dart — Replace Our Homegrown Calculator
**Description:** Port the TypeScript `isncsci` npm package to a native Dart implementation. Replace the current `ISNCSCIScoringTool`'s AIS classification logic (which is simplified) with the production-grade Praxis algorithm that handles all edge cases: asterisk values (*, **), NT handling, non-key muscle consideration, complex AIS B vs C determination.
**Rationale:** Our current ISNCSCI calculator uses simplified logic. The Praxis algorithm is the same one used by clinicians worldwide on isncscialgorithm.com — validated against 2,106 ISNCSCI cases from the Rick Hansen SCI Registry. Using the real algorithm means our training tool produces the same results as the clinical gold standard.
**Downsides:** Algorithm porting effort (~1-2 days for a clean Dart port). Must maintain parity with upstream updates.
**Confidence:** 95%
**Complexity:** Medium
**Status:** Unexplored

### 2. Interactive ISNCSCI Worksheet with Visual Body Diagram
**Description:** Adapt the Praxis `ui` web components' body diagram SVGs and exam interface patterns into native Flutter widgets. Create a visual ISNCSCI worksheet that looks like the actual paper worksheet (Figure 22-2 from DeLisa) — body outline with labeled sensory points, motor muscles listed on sides, score entry cells, auto-computed results below. Residents interact with it exactly as they would the real form.
**Rationale:** The current ISNCSCIScoringTool uses a tabbed interface (Sensory tab / Motor tab / Results tab) which is functional but doesn't match the actual ISNCSCI worksheet layout. Residents need to practice with the real format. The Praxis UI repo has SVG body diagram assets and design tokens that could be adapted.
**Downsides:** Complex Flutter UI to replicate the worksheet layout. May need CustomPainter for the body diagram overlay.
**Confidence:** 80%
**Complexity:** High
**Status:** Unexplored

### 3. Guided ISNCSCI Classification Walkthrough (Training Mode)
**Description:** Build a step-by-step guided classification trainer that walks residents through the ISNCSCI classification algorithm one step at a time. Present exam findings → ask the resident to determine sensory level → reveal correct answer → ask for motor level → reveal → ask for NLI → ask for AIS grade → explain. Uses the Praxis algorithm as the answer engine but wraps it in pedagogical scaffolding.
**Rationale:** Neither the Praxis tools NOR our current app teaches HOW to classify — they just CALCULATE the answer. The gap is training mode. The AIS Practice Widget has 14 cases but only asks for the AIS grade — it doesn't walk through each step. This would be the first tool that teaches the classification algorithm step-by-step.
**Downsides:** Significant UX design work. Need 20+ training cases with varied complexity.
**Confidence:** 90%
**Complexity:** Medium-High
**Status:** Unexplored

### 4. ISNCSCI Case Library with Praxis-Validated Answers
**Description:** Build a library of 30-50 ISNCSCI classification cases (exam worksheets with all scores filled in) that residents must classify. Use the Praxis algorithm to generate the gold-standard correct answer for each case. Cases range from straightforward (complete C5 AIS A) to complex (asymmetric incomplete with non-key muscle function, asterisk values, NT levels). The ASIA ISNCSCI Classification Workbook (26 practice cases) could serve as content inspiration.
**Rationale:** The current AIS Practice Widget has 14 cases with pre-written scenarios. But real ISNCSCI classification requires looking at an actual worksheet full of numbers and working through the algorithm. This is much closer to what residents face on boards and in clinical practice.
**Downsides:** Case creation is labor-intensive. Need to ensure edge cases are clinically realistic.
**Confidence:** 85%
**Complexity:** Medium
**Status:** Unexplored

### 5. WebView Embed of isncscialgorithm.com as Quick Reference
**Description:** Embed the official isncscialgorithm.com calculator in a Flutter WebView as a quick-reference tool accessible from the ASIA module. This gives residents instant access to the validated calculator without leaving the app.
**Rationale:** Fastest integration path. Zero algorithm porting needed. Residents get the exact same tool used clinically.
**Downsides:** Requires internet. Doesn't integrate with app data/progress. No training mode.
**Confidence:** 70%
**Complexity:** Low
**Status:** Unexplored

### 6. Dart Package: `isncsci_dart` — Reusable Across All Apps
**Description:** Port the Praxis algorithm to Dart and publish as a standalone Dart package (`isncsci_dart`) that any Flutter app can use. This becomes infrastructure for the SCI Training app AND for any future clinical tools you build. Include the ExamBuilder pattern from the Python port, validation utilities, and a clean API.
**Rationale:** Maximum leverage. A Dart ISNCSCI package doesn't exist on pub.dev — you'd be the first. Every PM&R Flutter app (yours and others') could use it. Apache 2.0 license allows this.
**Downsides:** Package maintenance responsibility. Need comprehensive test suite.
**Confidence:** 75%
**Complexity:** Medium-High
**Status:** Unexplored

### 7. Combine Praxis Algorithm + Video Technique Library
**Description:** Merge Ideas #1 and #3 with the Video Exam Library brainstorm. The guided walkthrough shows a case, but ALSO includes video demonstrations at each step. "Now test the C6 dermatome" → shows 15-second video of proper technique → "What score would you give?" → resident enters score → algorithm validates. This creates a complete ISNCSCI exam SIMULATION.
**Rationale:** This is the 10x idea. No tool anywhere combines (a) validated ISNCSCI algorithm + (b) exam technique videos + (c) guided classification training in a single experience. This would be category-defining for SCI education.
**Downsides:** Highest complexity. Requires video content AND algorithm AND training UX.
**Confidence:** 65%
**Complexity:** Very High
**Status:** Unexplored

## Recommended Implementation Order

**Phase 1 (1 week): Port Praxis algorithm to Dart**
- Port the TypeScript `isncsci` package to Dart
- Replace current ISNCSCIScoringTool classification logic with Praxis algorithm
- Add comprehensive test suite matching Praxis test cases
- Publish as internal package (optionally pub.dev later)

**Phase 2 (2 weeks): Build Guided Classification Trainer**
- 30 training cases (use ASIA Workbook as template, Praxis algorithm as answer engine)
- Step-by-step walkthrough UI (sensory → motor → NLI → AIS)
- Detailed explanations at each step
- Progress tracking (which cases completed, score)

**Phase 3 (1 month): Visual ISNCSCI Worksheet**
- Native Flutter worksheet matching the official ASIA form layout
- Visual body diagram with tappable sensory points
- Motor score entry alongside the diagram
- Real-time Praxis algorithm classification as scores are entered

**Phase 4 (2 months): Full ISNCSCI Exam Simulator**
- Combine worksheet + guided trainer + video technique library
- Simulated patient encounter: "You're examining a patient with suspected SCI"
- Step through the full exam with video guidance at each point
- Auto-classification using validated Praxis algorithm
- Score and track performance

## Session Log
- 2026-03-23: Initial ideation — 7 ideas generated, research found Praxis ISNCSCI ecosystem (6 repos, Apache 2.0), plus user's existing Python port of the algorithm
