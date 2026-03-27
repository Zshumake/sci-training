---
date: 2026-03-27
topic: animated-pathophysiology-walkthroughs
---

# Animated Pathophysiology Walkthroughs

## Problem Frame

SCI pathophysiology involves temporal cascades — sequences of physiological events that unfold over time. Static diagrams flatten these into incomprehensible spaghetti (multiple arrows, labels, and pathways all visible simultaneously). Residents struggle to understand AD pathophysiology, spinal shock phases, and secondary injury cascades because the medium (static text + diagrams) fundamentally mismatches the content (sequential, temporal processes). Step-by-step animation matches how these phenomena actually unfold.

## Requirements

- R1. **AnimatedWalkthroughBlock**: A new `ContentBlock` subclass that renders a multi-step animated walkthrough. Each step reveals new visual elements (arrows, labels, color changes, highlights) on a base anatomy image. Steps build on each other — step 3 shows everything from steps 1 and 2 plus new elements.

- R2. **Dual interaction modes**: Default tap-to-advance (user taps "Next Step" / "Previous Step" to control pace). Auto-play toggle that advances every 3-4 seconds with pause/rewind. Both modes available for all walkthroughs.

- R3. **Step indicator**: Progress dots or numbered steps showing current position (e.g., "Step 3 of 7"). Each step has a short title and a 1-2 sentence explanation text below the animation.

- R4. **8 animated walkthroughs** covering all major SCI cascades:
  1. **Autonomic Dysreflexia cascade** — noxious stimulus → afferent signal → unchecked sympathetic → vasoconstriction below → baroreceptor → parasympathetic above → headache/flushing/bradycardia
  2. **Spinal shock 4-phase progression** (Ditunno model) — areflexia → denervation supersensitivity → hyperreflexia → spasticity
  3. **Secondary injury cascade** — vascular ischemia → excitotoxicity → free radicals → inflammatory response → apoptosis → cavitation
  4. **Micturition reflex** — UMN pathway (PMC → pelvic nerve → detrusor contraction + EUS relaxation) vs LMN pathway (loss of coordination → DSD)
  5. **DVT formation** (Virchow's triad) — stasis → endothelial injury → hypercoagulability → thrombus → embolization
  6. **Orthostatic hypotension mechanism** — upright position → venous pooling → decreased preload → decreased CO → intact baroreceptors → interrupted sympathetic response → hypotension
  7. **Heterotopic ossification progression** — inflammation → mesenchymal cell migration → cartilage formation → calcification → mature bone
  8. **Respiratory failure cascade in acute cervical SCI** — loss of intercostals → paradoxical breathing → mucus retention → atelectasis → pneumonia → respiratory failure

- R5. **Visual elements per step**: Each step can add arrows (directional, with labels), highlights (color change on a region), text labels (appear at coordinates), and opacity changes (dim previous elements to focus on new). Built with Flutter's native animation framework — no external dependencies.

- R6. **Integration**: Walkthroughs are embedded inline in module content as `AnimatedWalkthroughBlock` instances, placed at the appropriate location in each module's tab content.

## Success Criteria

- All 8 walkthroughs render smoothly with step-by-step progression
- Both tap-to-advance and auto-play modes work
- Each walkthrough has 5-8 clearly distinct steps
- Walkthroughs use existing Servier anatomy PNGs as base layers where applicable
- `flutter analyze` passes with zero issues

## Scope Boundaries

- **In scope**: 8 animated walkthroughs, dual interaction modes, inline content integration
- **Out of scope**: 3D animations, custom illustration creation, video recording, sound effects
- **Not building**: External dependency on animation packages — use Flutter's built-in `AnimationController` + `AnimatedOpacity` + `AnimatedPositioned`

## Key Decisions

- **Tap-to-advance as default**: Studying mode should be manual pace. Auto-play is a convenience toggle for review.
- **Build on existing Servier PNGs**: Use anatomy images as base layers with programmatic overlays (arrows, labels, highlights), not custom illustrations.
- **8 walkthroughs**: Cover all major cascades that are inherently temporal and commonly tested.
- **No external animation packages**: Flutter's native animation system is sufficient for opacity, position, and color transitions.

## Outstanding Questions

### Deferred to Planning

- [Affects R1][Technical] What data model should `AnimatedWalkthroughBlock` use? Options: list of `WalkthroughStep` objects each containing a list of `VisualElement`s (arrows, labels, highlights) with coordinates and animation properties.
- [Affects R5][Technical] How should arrows be drawn? Options: `CustomPainter` with `Path` objects, or pre-positioned arrow images. CustomPainter is more flexible.
- [Affects R4][Needs research] Which Servier images work as base layers for each walkthrough, or should some use schematic diagrams built with `CustomPainter`?

## Next Steps

→ `/ce:plan` for structured implementation planning
