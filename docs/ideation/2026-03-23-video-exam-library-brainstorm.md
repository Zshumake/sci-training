---
date: 2026-03-23
topic: video-exam-technique-library
parent: 2026-03-23-learning-resource-improvements-ideation.md
idea: "#1 Interactive ISNCSCI Video Exam Technique Library"
---

# Brainstorm: Interactive ISNCSCI Video Exam Technique Library

## The Problem
Residents can recite "C5 = elbow flexors = biceps" but have never seen proper MMT technique for grading it. The ISNCSCI exam is a **motor skill** that cannot be learned from text alone. The app teaches WHAT to test but not HOW to test it.

## Existing Resources
- **ASIA InSTeP** (International Standards Training e-Learning Program): 5-module online course covering sensory exam, motor exam, anorectal exam. This is the gold standard but requires separate login, is not mobile-optimized, and isn't integrated into study flow.
- **AAPM&R KnowledgeNow**: Has written descriptions but limited video content.
- **YouTube**: Scattered videos of variable quality, no standardized format.

## Design Vision

### Three Integration Points

**1. Dermatome Map → "Technique" Mode**
The `DermatomeMapWidget` already has `DermatomeMapMode.study` and `DermatomeMapMode.quiz`. Add `DermatomeMapMode.technique`:
- Tap any dermatome zone → plays a 15-30s video showing:
  - Patient positioning
  - Exact anatomical landmark to test
  - Light touch technique (cotton tip applicator stroke <1cm)
  - Pin prick technique (safety pin sharp/dull)
  - How to grade 0/1/2

**2. Motor Exam → Video MMT Guide**
Add a new widget `MotorExamVideoGuide` accessible from the ASIA module:
- List of 10 key muscles with thumbnail
- Tap any muscle → plays 30-60s video showing:
  - Patient positioning (supine, per ISNCSCI standard)
  - Stabilization points
  - Direction of resistance application
  - What grade 3 vs 4 vs 5 looks like
  - Common errors

**3. Special Tests → Video Clips**
- Bulbocavernosus reflex (BCR) testing technique
- Deep anal pressure (DAP) testing
- Voluntary anal contraction (VAC) instruction
- Delayed plantar response elicitation

### Video Content Plan (40 videos total)

| Category | Count | Duration Each | Total |
|----------|-------|---------------|-------|
| Sensory exam technique (LT + PP general) | 2 | 60s | 2 min |
| Key sensory landmarks (high-yield 10) | 10 | 15-20s | 3 min |
| Motor exam — 10 key muscles | 10 | 45-60s | 8 min |
| Motor grading demonstration (0-5 scale) | 1 | 90s | 1.5 min |
| Anorectal exam (BCR, DAP, VAC) | 3 | 30-45s | 2 min |
| Special tests (delayed plantar, etc.) | 4 | 20-30s | 1.5 min |
| **Total** | **~30** | | **~18 min** |

### Video Production Options

**Option A: Record Original Videos (Best)**
- Use standardized model/volunteer
- Film in clinical setting with proper positioning
- Owner (PM&R physician) can record during clinical teaching
- Highest quality, fully owned content
- Estimated effort: 1-2 afternoons with a camera

**Option B: Curated External Links (Fastest)**
- Link to ASIA InSTeP videos or vetted YouTube content
- Use `url_launcher` (already in pubspec) to open external URLs
- Lower integration quality but zero production effort
- Risk: external links may break or change

**Option C: AI-Generated Technique Animations (Innovative)**
- Use 3D human model with overlay annotations
- No real patient needed
- Consistent, repeatable, stylized to match app aesthetic
- Tools: Blender + Flutter Rive/Lottie animations
- Higher technical complexity but unique differentiator

### Recommended Approach: Option A + B Hybrid
1. **Phase 1**: Link to best existing videos (ASIA InSTeP, vetted YouTube) via url_launcher — ship in 1 week
2. **Phase 2**: Record original videos for the 10 key muscles (highest-demand content) — ship in 1 month
3. **Phase 3**: Record remaining sensory/special test videos — ship in 2 months

### Technical Implementation

**New files to create:**
- `lib/data/models/video_model.dart` — VideoClip model (id, title, description, myotome/dermatome, assetPath or url, duration, thumbnailPath)
- `lib/data/video_data.dart` — Static list of all video clips with URLs/asset paths
- `lib/features/learning/widgets/video_player_view.dart` — Video player widget (use `video_player` or `chewie` package)
- `lib/features/learning/widgets/motor_exam_guide.dart` — List view of 10 muscles with video launch

**Files to modify:**
- `pubspec.yaml` — add `video_player` or `chewie` dependency
- `lib/data/models/topic_content_model.dart` — add `VideoBlock` content block type
- `lib/features/learning/topic_content_view.dart` — add `_buildVideoBlock` renderer
- `lib/features/learning/widgets/dermatome_map_widget.dart` — add `technique` mode
- `lib/data/module_contents/classification_asia_content.dart` — add VideoBlock entries

**New dependency:** `video_player: ^2.9.1` or `chewie: ^1.8.5` (wraps video_player with controls)

### Content Block Design

```dart
class VideoBlock extends ContentBlock {
  final String title;
  final String description;
  final String videoUrl; // YouTube URL or asset path
  final String? thumbnailAsset;
  final Duration duration;
  final String category; // 'sensory', 'motor', 'special'

  VideoBlock({
    required this.title,
    required this.description,
    required this.videoUrl,
    this.thumbnailAsset,
    required this.duration,
    this.category = 'motor',
  });
}
```

### Key Sensory Landmarks Video List (Priority 10)
1. C5 — Lateral antecubital fossa
2. C6 — Thumb dorsal surface
3. C7 — Middle finger dorsal surface
4. T4 — Nipple line
5. T10 — Umbilicus
6. L4 — Medial malleolus
7. L5 — Dorsum of foot (3rd MTP)
8. S1 — Lateral heel
9. S4-5 — Perianal area
10. General technique — LT (cotton tip) and PP (safety pin)

### 10 Key Muscle MMT Videos (Priority)
1. C5 — Biceps (elbow flexion): patient position, stabilize shoulder, resist at distal forearm
2. C6 — ECR (wrist extension): forearm pronated on table, resist dorsum of hand
3. C7 — Triceps (elbow extension): arm abducted 90°, resist at distal forearm
4. C8 — FDP (finger flexion of middle finger): stabilize PIP, resist at DIP
5. T1 — ADM (small finger abduction): hand flat, resist lateral border of 5th digit
6. L2 — Iliopsoas (hip flexion): hip at 90° in supine, resist at distal thigh
7. L3 — Quadriceps (knee extension): sitting or supine, resist at distal tibia
8. L4 — Tibialis anterior (ankle dorsiflexion): resist at dorsum of foot
9. L5 — EHL (great toe extension): resist at dorsum of great toe distal phalanx
10. S1 — Gastrocnemius (ankle plantarflexion): resist at plantar surface of foot

### Success Metrics
- Residents can demonstrate proper MMT technique for all 10 key muscles
- Dermatome map quiz scores improve after technique mode usage
- Time to complete ISNCSCI worksheet decreases
- User engagement: technique mode becomes top-3 most-used feature

## Next Steps
1. Decide on video production approach (original vs linked vs hybrid)
2. Add `video_player` dependency and `VideoBlock` content type
3. Build video list UI in motor exam guide
4. Integrate "technique" mode into dermatome map
5. Source/record first batch of 10 MMT videos
