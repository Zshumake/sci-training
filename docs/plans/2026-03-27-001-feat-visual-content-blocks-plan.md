---
title: "feat: Add Visual Content Blocks to Break Up Text Walls"
type: feat
status: active
date: 2026-03-27
origin: docs/brainstorms/2026-03-27-visual-content-blocks-requirements.md
---

# feat: Add Visual Content Blocks to Break Up Text Walls

## Overview

Add three new `ContentBlock` subclasses — `AnnotatedImageBlock`, `FlowchartBlock`, and `ComparisonDiagramBlock` — to the sealed `ContentBlock` hierarchy, then intersperse them throughout all 14 SCI modules to transform the reading experience from text-heavy scrolling to an atlas-style layout with visual breaks every 2-3 text sections.

## Problem Statement / Motivation

13 of 14 modules deliver knowledge through sequential `TextBlock`, `BulletCardBlock`, and `TableBlock` content with no visual interactivity. The ASIA module proves that interactive elements dramatically improve engagement (5 custom widgets), but every other module reads like a clinical textbook. Residents learn anatomy and clinical pathways spatially through diagrams, not by reading paragraph descriptions of nerve pathways. (see origin: `docs/brainstorms/2026-03-27-visual-content-blocks-requirements.md`)

## Proposed Solution

### Phase 1: Define Three New Block Types

Add to `lib/data/models/topic_content_model.dart`:

**1. AnnotatedImageBlock**

```dart
class AnnotationPoint {
  final double x;          // 0.0-1.0 relative to image width
  final double y;          // 0.0-1.0 relative to image height
  final String label;
  final String description;
  final Color? color;
  const AnnotationPoint({...});
}

class AnnotatedImageBlock extends ContentBlock {
  final String assetPath;
  final String caption;
  final List<AnnotationPoint> annotations;
  final String? description;
  AnnotatedImageBlock({...});
}
```

**2. FlowchartBlock**

```dart
class FlowchartNode {
  final String id;
  final String text;
  final FlowchartNodeType type;  // decision, action, outcome, start
  final Color? color;
  const FlowchartNode({...});
}

enum FlowchartNodeType { start, decision, action, outcome }

class FlowchartEdge {
  final String fromId;
  final String toId;
  final String? label;       // "Yes" / "No" / condition text
  const FlowchartEdge({...});
}

class FlowchartBlock extends ContentBlock {
  final String title;
  final List<FlowchartNode> nodes;
  final List<FlowchartEdge> edges;
  final String? description;
  FlowchartBlock({...});
}
```

**3. ComparisonDiagramBlock**

```dart
class ComparisonSide {
  final String title;
  final String? imagePath;
  final List<String> features;
  final Color themeColor;
  const ComparisonSide({...});
}

class ComparisonDiagramBlock extends ContentBlock {
  final String title;
  final ComparisonSide left;
  final ComparisonSide right;
  final String? description;
  ComparisonDiagramBlock({...});
}
```

### Phase 2: Build Three Renderers

Add to `lib/features/learning/topic_content_view.dart`:

**AnnotatedImageBlock renderer** (`_buildAnnotatedImage`):
- Display the Servier PNG with `Image.asset()` inside a `Container` with `cardBackground` + `borderSubtle` border
- Overlay `AnnotationPoint` markers as colored dots positioned with `Stack` + `Positioned` using fractional coordinates
- On tap: expand a label card below the dot showing `label` and `description`
- Caption below image in `AppTheme.bodyFont(fontSize: 12, fontStyle: italic)`

**FlowchartBlock renderer** (`_buildFlowchart`):
- Render nodes vertically as a decision tree using `Column` with connecting lines
- Decision nodes: diamond-shaped or rounded rectangle with `?` icon, two outgoing paths (Yes/No)
- Action nodes: rounded rectangle in `accentTeal`
- Outcome nodes: rounded rectangle in `successGreen` or `dangerRed`
- User taps decision nodes to choose a path; non-chosen branches collapse
- Title above in `AppTheme.displayFont()`

**ComparisonDiagramBlock renderer** (`_buildComparisonDiagram`):
- Two side-by-side columns in a `Row`
- Each side: optional image at top, title in `displayFont`, feature bullets below
- Left side has left-colored accent border, right side has right-colored accent border
- Responsive: stack vertically on narrow screens
- Swipe/toggle between sides on mobile with `PageView` or `TabBar`

### Phase 3: Content Authoring — All 14 Modules

Go through each module's content file and add visual blocks. Target: **2+ visuals per tab**.

**Module-by-module visual mapping:**

| Module | Annotated Images | Flowcharts | Comparisons |
|--------|-----------------|------------|-------------|
| SCI Fundamentals | Vertebral anatomy, vascular supply, body anterior/posterior/lateral | — | Cervical vs thoracic vs lumbar anatomy |
| ASIA/ISNCSCI | Dermatome body map, key sensory points | AIS classification algorithm | Complete vs incomplete, UMN vs LMN |
| Pathophysiology | Spinal cord cross-section, vascular watershed | — | Primary vs secondary injury, spinal vs neurogenic shock |
| Neurogenic Bladder | Bladder innervation (servier_bladder.png), urinary male/female | Bladder management algorithm | UMN vs LMN bladder, storage vs voiding |
| Neurogenic Bowel | Digestive system, colon, colon cross-section | Bowel program algorithm | UMN reflex vs LMN areflexic bowel |
| Autonomic Dysreflexia | Body anterior (trigger zones), cardiac innervation | AD management algorithm | AD vs preeclampsia |
| Respiratory | Lung airways, bronchus, gas exchange | Respiratory weaning algorithm | Diaphragm vs intercostal vs accessory muscles |
| Cardiovascular | Cardiomyocyte, brain arteries | DVT prophylaxis algorithm | Neurogenic vs hemorrhagic shock |
| Spasticity | Body map (spasticity pattern) | Spasticity management ladder | Beneficial vs harmful spasticity |
| Pain Syndromes | Spinal cord cross-section (pain pathways) | Pain treatment algorithm | At-level vs below-level neuropathic pain |
| Pressure Injuries | Skin layers, skin dermis, burn stages | Pressure injury prevention | Stage I-IV visual comparison |
| Sexuality & Fertility | Urinary male/female (reproductive) | — | Reflexogenic vs psychogenic erections |
| MSK Complications | Body maps (HO sites, fracture sites) | — | HO vs DVT, osteoporotic fracture vs DVT |
| Rehab Continuum | Body anterior (functional levels) | — | Tetraplegia vs paraplegia outcomes |

**Servier image mapping** (existing assets):
- `servier_bladder.png` → Neurogenic Bladder module
- `servier_urinary_male.png`, `servier_urinary_female.png` → Bladder + Sexuality
- `servier_digestive_system.png`, `servier_colon.png` → Neurogenic Bowel
- `servier_lung_airways.png`, `servier_bronchus.png` → Respiratory
- `servier_cardiomyocyte.png` → Cardiovascular
- `servier_skin_layers.png`, `servier_skin_dermis.png`, `servier_burn_stages.png` → Pressure Injuries
- `servier_adult_body_anterior/lateral/posterior.png` → Multiple modules (dermatomes, HO sites, spasticity)
- `servier_brain_*.png` → Fundamentals, Pathophysiology
- `servier_kidney*.png`, `servier_nephron.png` → Bladder complications

## Acceptance Criteria

- [ ] Three new `ContentBlock` subclasses added to sealed class (`topic_content_model.dart`)
- [ ] Three builder methods added to switch expression (`topic_content_view.dart`)
- [ ] AnnotatedImageBlock: displays image with tappable annotation dots + expandable labels
- [ ] FlowchartBlock: renders step-through decision tree with tappable nodes
- [ ] ComparisonDiagramBlock: side-by-side visual comparison with toggle/swipe on mobile
- [ ] All 14 module content files updated with interspersed visual blocks
- [ ] Each module tab has at least 2 visual blocks
- [ ] No more than 3 consecutive text/bullet/table blocks without a visual break
- [ ] All images use existing Servier PNGs from `assets/infographics/anatomy/`
- [ ] 7 clinical algorithm flowcharts implemented (AD, bladder, bowel, spasticity, respiratory, DVT, pressure injury)
- [ ] `flutter analyze` passes with zero issues
- [ ] All 55 existing tests continue to pass

## Implementation Phases

### Phase 1: Block Types + Renderers (Foundation)

**Tasks:**
1. Add `AnnotationPoint`, `AnnotatedImageBlock`, `FlowchartNode`, `FlowchartEdge`, `FlowchartBlock`, `ComparisonSide`, `ComparisonDiagramBlock` to `topic_content_model.dart`
2. Add three cases to the `_buildBlock` switch in `topic_content_view.dart`
3. Implement `_buildAnnotatedImage()` renderer
4. Implement `_buildFlowchart()` renderer
5. Implement `_buildComparisonDiagram()` renderer
6. Verify: `flutter analyze` clean, test with one sample block per type in `sci_fundamentals_content.dart`

**Estimated scope:** 3 new classes, 3 helper classes/enums, 3 builder methods, ~400 lines

### Phase 2: Clinical Algorithm Flowcharts (7 Algorithms)

**Tasks:**
1. Author AD management flowchart data (nodes + edges)
2. Author bladder management algorithm
3. Author bowel program algorithm
4. Author spasticity management ladder
5. Author respiratory weaning algorithm
6. Author DVT prophylaxis algorithm
7. Author pressure injury prevention/staging algorithm

**Estimated scope:** 7 `FlowchartBlock` data structures, each with 8-15 nodes and 10-20 edges

### Phase 3: Content Integration — Modules 1-7

**Tasks:**
1. SCI Fundamentals: add 4 annotated images (vertebral, vascular, body maps) + 1 comparison
2. ASIA/ISNCSCI: add 2 annotated images + 1 flowchart (AIS algorithm) + 2 comparisons
3. Pathophysiology: add 2 annotated images + 2 comparisons
4. Neurogenic Bladder: add 2 annotated images + 1 flowchart + 2 comparisons
5. Neurogenic Bowel: add 2 annotated images + 1 flowchart + 1 comparison
6. Autonomic Dysreflexia: add 2 annotated images + 1 flowchart + 1 comparison
7. Respiratory: add 2 annotated images + 1 flowchart + 1 comparison

### Phase 4: Content Integration — Modules 8-14

**Tasks:**
1. Cardiovascular: add 2 annotated images + 1 flowchart + 1 comparison
2. Spasticity: add 1 annotated image + 1 flowchart + 1 comparison
3. Pain Syndromes: add 1 annotated image + 1 flowchart + 1 comparison
4. Pressure Injuries: add 3 annotated images + 1 flowchart + 1 comparison
5. Sexuality & Fertility: add 2 annotated images + 1 comparison
6. MSK Complications: add 2 annotated images + 2 comparisons
7. Rehab Continuum: add 1 annotated image + 1 comparison

### Phase 5: Verification

**Tasks:**
1. `flutter analyze` — zero issues
2. `flutter test` — all 55 tests pass
3. Content audit: verify every tab has 2+ visual blocks
4. Content audit: verify no 3+ consecutive text blocks without visual break

## Sources & References

### Origin

- **Origin document:** [docs/brainstorms/2026-03-27-visual-content-blocks-requirements.md](docs/brainstorms/2026-03-27-visual-content-blocks-requirements.md) — Key decisions: intersperse visuals with text (don't replace), three block types (annotated images, flowcharts, comparisons), all 14 modules, open-source images only.

### Internal References

- ContentBlock sealed class: `lib/data/models/topic_content_model.dart:1-131`
- Block rendering switch: `lib/features/learning/topic_content_view.dart:48-60`
- Theme constants: `lib/core/theme/app_theme.dart`
- Servier images: `assets/infographics/anatomy/servier_*.png` (31 files)
- Infographic model: `lib/data/models/sci_infographic_model.dart`
