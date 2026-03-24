import '../models/anatomy_3d_model.dart';

/// 3D Sketchfab models for SCI anatomy education.
class SCIAnatomy3DData {
  static const List<Anatomy3DModel> all = [
    // ── Vertebral Column ──
    Anatomy3DModel(
      id: 'vertebral-column',
      title: 'Vertebral Column',
      description:
          'Full human spinal column with cervical (C1-C7), thoracic (T1-T12), '
          'lumbar (L1-L5), sacral, and coccygeal regions. Essential for '
          'understanding SCI level localization and stability classification.',
      sketchfabId: 'bcd9eee09ce044ef98a69c315aa792e2',
      attribution: '3D (scratchi) — CC Attribution',
      moduleId: 'sci-fundamentals',
      relevantTopics: [
        'Spinal column regions',
        'Vertebral body anatomy',
        'SCI level localization',
        'Spinal stability',
      ],
    ),

    // ── Spinal Cord ──
    Anatomy3DModel(
      id: 'spinal-cord',
      title: 'Spinal Cord Anatomy',
      description:
          'Detailed spinal cord model showing cord segments, nerve roots, '
          'and cauda equina. Useful for understanding the difference between '
          'skeletal level and neurological level of injury.',
      sketchfabId: 'd4af33ccf03b4fec8754180bcb480516',
      attribution: 'University of Dundee, CAHID — CC BY-SA 2.1 JP',
      moduleId: 'pathophysiology',
      relevantTopics: [
        'Cord segments vs vertebral levels',
        'Conus medullaris',
        'Cauda equina',
        'Upper vs lower motor neuron',
      ],
    ),

    // ── Cervical Vertebra ──
    Anatomy3DModel(
      id: 'cervical-vertebra',
      title: 'Cervical Vertebra (C3/C4)',
      description:
          'Detailed single cervical vertebra showing vertebral body, pedicles, '
          'lamina, spinous process, transverse foramen, and spinal canal. '
          'Critical for understanding cervical SCI mechanics.',
      sketchfabId: '29b6bb536df84df08fa0ad444c3b01d1',
      attribution: 'Eric Bauer, Elon University — CC Attribution',
      moduleId: 'sci-fundamentals',
      relevantTopics: [
        'Vertebral body fracture',
        'Spinal canal dimensions',
        'Central cord syndrome',
        'Cervical stenosis',
      ],
    ),

    // ── Autonomic Nervous System ──
    Anatomy3DModel(
      id: 'autonomic-nervous-system',
      title: 'Autonomic Nervous System',
      description:
          'Schematic of the sympathetic (T1-L2) and parasympathetic divisions. '
          'Shows the sympathetic chain, splanchnic nerves, and autonomic '
          'outflow critical for understanding autonomic dysreflexia.',
      sketchfabId: '4372a945f4264b8ebb8f52d0cb9af76b',
      attribution: 'John A Burns School of Medicine — Sketchfab',
      moduleId: 'autonomic-dysreflexia',
      relevantTopics: [
        'Sympathetic chain (T1-L2)',
        'Parasympathetic outflow',
        'Autonomic dysreflexia',
        'Splanchnic nerve innervation',
      ],
    ),
  ];

  /// Get all 3D models for a specific module.
  static List<Anatomy3DModel> getByModule(String moduleId) =>
      all.where((m) => m.moduleId == moduleId).toList();

  /// Get all 3D models relevant to a given topic keyword (case-insensitive).
  static List<Anatomy3DModel> searchByTopic(String keyword) {
    final lc = keyword.toLowerCase();
    return all
        .where(
            (m) => m.relevantTopics.any((t) => t.toLowerCase().contains(lc)))
        .toList();
  }
}
