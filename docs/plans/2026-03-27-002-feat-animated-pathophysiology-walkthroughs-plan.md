---
title: "feat: Add Animated Pathophysiology Walkthroughs"
type: feat
status: active
date: 2026-03-27
origin: docs/brainstorms/2026-03-27-animated-pathophysiology-walkthroughs-requirements.md
---

# feat: Add Animated Pathophysiology Walkthroughs

## Overview

Add an `AnimatedWalkthroughBlock` content type that renders multi-step animated diagrams of physiological cascades. Each walkthrough builds sequentially — step 3 shows everything from steps 1-2 plus new elements. Dual interaction modes: tap-to-advance (default) and auto-play. 8 walkthroughs covering all major SCI cascades. (see origin: `docs/brainstorms/2026-03-27-animated-pathophysiology-walkthroughs-requirements.md`)

## Problem Statement / Motivation

SCI pathophysiology involves temporal cascades that unfold sequentially. Static diagrams show everything simultaneously, making it hard to understand cause-and-effect ordering. The AD cascade has 7 sequential steps, spinal shock has 4 phases over weeks, and secondary injury unfolds over hours to days. Step-by-step animation matches how these phenomena actually work. (see origin)

## Proposed Solution

### Data Model (`topic_content_model.dart`)

```dart
enum VisualElementType { arrow, label, highlight, regionColor }

class WalkthroughVisualElement {
  final VisualElementType type;
  final double x1, y1;           // start position (0.0-1.0 relative)
  final double? x2, y2;          // end position (for arrows)
  final String? text;            // label text
  final Color color;
  const WalkthroughVisualElement({...});
}

class WalkthroughStep {
  final String title;            // e.g., "Step 3: Unopposed Sympathetic Response"
  final String description;     // 1-2 sentence explanation
  final List<WalkthroughVisualElement> elements;  // new elements revealed this step
  const WalkthroughStep({...});
}

class AnimatedWalkthroughBlock extends ContentBlock {
  final String title;
  final String? baseImagePath;   // optional Servier PNG as background
  final List<WalkthroughStep> steps;
  final Color? themeColor;
  AnimatedWalkthroughBlock({...});
}
```

### Renderer Widget (`topic_content_view.dart` + extracted widget)

Extract a `_AnimatedWalkthroughWidget` StatefulWidget:

- **State**: `_currentStep` (int), `_autoPlay` (bool), `AnimationController` for transitions
- **Layout**: Base image (if provided) in a `Stack`, with `AnimatedOpacity` overlays for each step's visual elements
- **Controls**: Step indicator dots, Previous/Next buttons, auto-play toggle
- **Rendering**: `CustomPainter` for arrows (curved `Path` with arrowhead), `Positioned` widgets for labels, `AnimatedContainer` for region highlights
- **Transitions**: 300ms fade-in for new elements when advancing steps

### 8 Walkthroughs (Content Data)

Each walkthrough authored as an `AnimatedWalkthroughBlock` in the appropriate module content file:

| # | Walkthrough | Module | Steps | Base Image |
|---|-------------|--------|-------|------------|
| 1 | AD Cascade | autonomic_dysreflexia | 7 | servier_adult_body_anterior.png |
| 2 | Spinal Shock Phases | pathophysiology | 5 | CustomPainter (timeline) |
| 3 | Secondary Injury Cascade | pathophysiology | 6 | CustomPainter (cord cross-section) |
| 4 | Micturition Reflex (UMN vs LMN) | neurogenic_bladder | 6 | servier_bladder.png |
| 5 | DVT Formation | cardiovascular | 5 | CustomPainter (vessel) |
| 6 | Orthostatic Hypotension | cardiovascular | 5 | servier_adult_body_anterior.png |
| 7 | HO Progression | msk_complications | 5 | servier_adult_body_anterior.png |
| 8 | Respiratory Failure Cascade | respiratory | 6 | servier_lung_airways.png |

## Technical Considerations

- **No external dependencies**: Flutter's `AnimationController`, `AnimatedOpacity`, `AnimatedPositioned`, and `CustomPainter` are sufficient
- **CustomPainter for arrows**: Draw curved arrows with `Path.quadraticBezierTo()` and triangular arrowheads. Arrow color matches step's theme color.
- **Performance**: Each walkthrough has 5-7 steps with ~3-5 visual elements per step. No performance concerns — total animated widgets per screen stays under 50.
- **Base images**: Some walkthroughs use Servier PNGs as backgrounds; others with no good existing image use `CustomPainter` to draw a schematic (spinal cord cross-section, vessel, timeline).

## Acceptance Criteria

- [ ] `AnimatedWalkthroughBlock` added to sealed `ContentBlock` class
- [ ] `WalkthroughStep` and `WalkthroughVisualElement` data models defined
- [ ] `_AnimatedWalkthroughWidget` renders multi-step animation with fade-in transitions
- [ ] Tap-to-advance mode: Previous/Next buttons, step indicator dots
- [ ] Auto-play mode: toggle button, 3-4 second advance interval, pause on tap
- [ ] `CustomPainter` draws directional arrows with arrowheads
- [ ] All 8 walkthroughs authored with clinically accurate step sequences
- [ ] Each walkthrough has 5-7 distinct steps with title + description
- [ ] Walkthroughs integrated inline in appropriate module content files
- [ ] `flutter analyze` passes with zero issues
- [ ] All existing 55 tests continue to pass

## Implementation Phases

### Phase 1: Data Model + Widget (Foundation)

**Files to modify:**
- `lib/data/models/topic_content_model.dart` — add 3 new classes + enum
- `lib/features/learning/topic_content_view.dart` — add switch case + extract widget

**Tasks:**
1. Add `VisualElementType` enum, `WalkthroughVisualElement`, `WalkthroughStep`, `AnimatedWalkthroughBlock` to model
2. Add `AnimatedWalkthroughBlock b => _buildAnimatedWalkthrough(b)` to switch
3. Build `_AnimatedWalkthroughWidget` StatefulWidget:
   - `AnimationController` with 300ms duration
   - `Stack` layout: base image + overlay layers per step
   - `CustomPainter` subclass for arrows (`_ArrowPainter`)
   - Step controls: dots, prev/next, auto-play toggle
4. Verify with a test walkthrough in `sci_fundamentals_content.dart`
5. Run `flutter analyze`

### Phase 2: Author 8 Walkthroughs

**Files to modify:** 6 module content files

**Tasks — can be parallelized across 2 agents:**

Agent 1 (walkthroughs 1-4):
1. AD Cascade in `autonomic_dysreflexia_content.dart`
2. Spinal Shock Phases in `pathophysiology_content.dart`
3. Secondary Injury Cascade in `pathophysiology_content.dart`
4. Micturition Reflex in `neurogenic_bladder_content.dart`

Agent 2 (walkthroughs 5-8):
5. DVT Formation in `cardiovascular_content.dart`
6. Orthostatic Hypotension in `cardiovascular_content.dart`
7. HO Progression in `msk_complications_content.dart`
8. Respiratory Failure Cascade in `respiratory_content.dart`

### Phase 3: Verification

1. `flutter analyze` — zero issues
2. `flutter test` — all 55+ tests pass
3. Visual review: each walkthrough has correct step count and logical progression

## Sources & References

### Origin

- **Origin document:** [docs/brainstorms/2026-03-27-animated-pathophysiology-walkthroughs-requirements.md](docs/brainstorms/2026-03-27-animated-pathophysiology-walkthroughs-requirements.md) — Key decisions: tap-to-advance default with auto-play toggle, 8 walkthroughs covering all major cascades, no external animation packages, use Servier PNGs as base layers where applicable.

### Internal References

- ContentBlock sealed class: `lib/data/models/topic_content_model.dart`
- Block rendering: `lib/features/learning/topic_content_view.dart`
- Existing animation usage: `lib/features/learning/home_screen.dart` (AnimationController + CurvedAnimation for stagger)
- Servier images: `assets/infographics/anatomy/servier_*.png`
- Flutter animation docs: AnimationController, AnimatedOpacity, CustomPainter
