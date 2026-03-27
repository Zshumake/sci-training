---
date: 2026-03-27
topic: visual-content-blocks
---

# Visual Content Blocks: Break Up Text Walls with Interspersed Diagrams

## Problem Frame

PM&R residents using the SCI Training app encounter 14 modules of dense clinical text. Despite rich board-review content (86K+ words, 154 quiz questions, 5 interactive ISNCSCI tools), 13 of 14 modules deliver knowledge through scrollable text blocks, tables, and bullet cards. This creates a textbook-like reading experience that fails to leverage how residents actually learn — spatially, visually, and through pattern recognition. The ASIA module proves the concept: its 5 interactive tools make it the most engaging module. The rest need similar visual treatment.

## Requirements

- R1. **AnnotatedImageBlock**: A new content block type that displays an open-source anatomy image (Servier PNG) with color-coded labeled callouts. Tapping a callout region reveals its clinical significance in a brief overlay. Used for anatomy, innervation pathways, cross-sections, and organ diagrams.

- R2. **FlowchartBlock**: A new content block type that renders a clinical algorithm as a step-through decision tree. The user taps through decision nodes by answering clinical questions at each branch point. Each path leads to a management outcome. Used for AD management, bladder management, respiratory weaning, spasticity ladder, DVT prophylaxis, bowel program, and pressure injury staging.

- R3. **ComparisonDiagramBlock**: A new content block type that presents two clinical states side-by-side with visual diagrams. Users can toggle or swipe between states (e.g., UMN vs LMN bladder, complete vs incomplete injury). Each side shows its own annotated image with key differences highlighted.

- R4. **Content integration**: Intersperse visual blocks throughout all 14 modules, targeting at least 2 visuals per tab (so a 4-tab module has ~8 visual breakpoints). Visuals should be placed every 2-3 text sections to break up the reading flow.

- R5. **Visual-text relationship**: Visuals are interspersed with text, not replacements. Text blocks provide context before and after each visual. The reading flow should feel like a medical atlas — diagram illustrates what was just read, followed by clinical implications.

## Success Criteria

- Every module has at least 2 visual content blocks per tab
- No more than 3 consecutive text/bullet/table blocks without a visual break
- Visual blocks use real open-source medical illustrations (Servier, OpenStax), not AI-generated art
- Flowchart blocks cover all 7 "Coming Soon" clinical algorithms (AD, bladder, bowel, spasticity, respiratory, DVT, pressure injury)
- The app compiles with zero analysis issues after all blocks are added

## Scope Boundaries

- **In scope**: Three new block types, content authoring for all 14 modules, Servier image integration
- **Out of scope**: Video content, audio, spaced repetition, progress tracking, backend/persistence
- **Not building**: New standalone screens or tools — these are inline content blocks within existing module views

## Key Decisions

- **Intersperse, don't replace**: Visuals break up text but don't eliminate it. Text provides clinical context that diagrams alone can't convey.
- **Three block types**: AnnotatedImage for anatomy, Flowchart for algorithms, ComparisonDiagram for differentials. This covers the three main visual learning patterns in medical education.
- **All 14 modules**: Apply visual treatment across the entire app, not just high-priority modules. Consistency matters for the learning experience.
- **Open-source images only**: Use Servier Medical Art (CC BY 4.0) and other properly licensed assets. No AI-generated anatomy art.

## Outstanding Questions

### Deferred to Planning

- [Affects R1][Technical] How should AnnotatedImageBlock callouts be positioned — hardcoded coordinates per image, or a flexible overlay system?
- [Affects R2][Needs research] Should FlowchartBlock use a custom widget tree or render from a declarative data structure (JSON-like node/edge model)?
- [Affects R4][Needs research] Which specific text passages in each module should be replaced or accompanied by visuals? (Requires module-by-module content audit)

## Next Steps

→ `/ce:plan` for structured implementation planning
