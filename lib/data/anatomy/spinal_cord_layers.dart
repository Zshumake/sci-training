import 'package:flutter/material.dart';
import '../models/anatomy_layer_model.dart';

/// Interactive layered diagram of the spinal cord cross-section.
///
/// Six layers from deepest (central canal/gray matter) to outermost
/// (SCI syndrome overlay), each with annotations and board pearls.
final AnatomyDiagram spinalCordLayersDiagram = AnatomyDiagram(
  id: 'spinal-cord-cross-section',
  title: 'Spinal Cord Cross-Section',
  description:
      'Interactive layered view of the spinal cord in cross-section. '
      'Peel away layers to reveal tracts, gray matter, and clinical '
      'syndrome zones. Tap annotation dots for clinical details.',
  layers: const [
    // ── Layer 1 (deepest): Central Canal & Gray Matter ──
    AnatomyLayer(
      name: 'Central Canal & Gray Matter',
      description:
          'H-shaped gray matter containing neuronal cell bodies. Anterior '
          'horns house lower motor neurons (alpha and gamma). Posterior '
          'horns receive sensory afferents. The intermediolateral (IML) '
          'column at T1-L2 contains preganglionic sympathetic neurons. '
          'Clarke nucleus (T1-L2) relays proprioceptive input to the '
          'cerebellum via the dorsal spinocerebellar tract.',
      color: Color(0xFF6B7280),
      order: 5,
      annotations: [
        LayerAnnotation(
          label: 'Anterior Horn',
          detail:
              'Contains alpha motor neurons (LMN). Damage causes flaccid '
              'paralysis, atrophy, fasciculations, and areflexia at the '
              'level of injury. Key for distinguishing UMN vs LMN patterns.',
          x: 0.38,
          y: 0.58,
        ),
        LayerAnnotation(
          label: 'Posterior Horn',
          detail:
              'Receives pain, temperature, and crude touch afferents. '
              'Substantia gelatinosa (lamina II) modulates pain input — '
              'basis of the gate control theory.',
          x: 0.62,
          y: 0.38,
        ),
        LayerAnnotation(
          label: 'IML Column (T1-L2)',
          detail:
              'Intermediolateral cell column contains preganglionic '
              'sympathetic neurons. Loss above T6 causes autonomic '
              'dysreflexia risk. Loss of all sympathetic outflow (above T1) '
              'causes neurogenic shock.',
          x: 0.68,
          y: 0.50,
        ),
        LayerAnnotation(
          label: "Clarke's Nucleus",
          detail:
              "Clarke's column (C8-L2) relays proprioceptive information "
              'to the cerebellum via the dorsal spinocerebellar tract. '
              'Important for coordination and ataxia assessment.',
          x: 0.55,
          y: 0.42,
        ),
      ],
    ),

    // ── Layer 2: Dorsal Columns ──
    AnatomyLayer(
      name: 'Dorsal Columns',
      description:
          'Posterior white matter carrying proprioception, vibration, and '
          'fine touch/two-point discrimination. Fasciculus gracilis (medial) '
          'carries lower extremity/sacral input; fasciculus cuneatus '
          '(lateral, above T6) carries upper extremity/cervical input. '
          'Fibers ascend ipsilaterally and cross at the medullary decussation.',
      color: Color(0xFF3B82F6),
      order: 4,
      annotations: [
        LayerAnnotation(
          label: 'Fasciculus Gracilis',
          detail:
              'Medial dorsal column. Carries proprioception, vibration, and '
              'fine touch from the lower extremities and sacral segments. '
              'Present at all spinal cord levels.',
          x: 0.48,
          y: 0.28,
        ),
        LayerAnnotation(
          label: 'Fasciculus Cuneatus',
          detail:
              'Lateral dorsal column, present only above T6. Carries '
              'proprioception, vibration, and fine touch from the upper '
              'extremities. Board Pearl: loss = posterior cord syndrome.',
          x: 0.58,
          y: 0.25,
        ),
      ],
    ),

    // ── Layer 3: Lateral Corticospinal Tract ──
    AnatomyLayer(
      name: 'Lateral Corticospinal Tract',
      description:
          'Main voluntary motor pathway (~90% of corticospinal fibers). '
          'Crosses at the medullary pyramids (pyramidal decussation). '
          'Somatotopic organization: arms medial, legs lateral. '
          'Damage causes UMN signs: spasticity, hyperreflexia, Babinski, '
          'clonus below the level of injury.',
      color: Color(0xFFEF4444),
      order: 3,
      annotations: [
        LayerAnnotation(
          label: 'Somatotopy',
          detail:
              'Arms are represented medially, legs laterally within the '
              'lateral CST. This explains why central cord syndrome '
              'preferentially affects the upper extremities — the medial '
              '(arm) fibers are damaged first by centrifugal expansion.',
          x: 0.25,
          y: 0.50,
        ),
        LayerAnnotation(
          label: 'Pyramidal Decussation',
          detail:
              'Fibers cross at the cervicomedullary junction. Lesions '
              'above this produce contralateral weakness; lesions below '
              'produce ipsilateral weakness. Board-favorite anatomy point.',
          x: 0.22,
          y: 0.38,
        ),
      ],
    ),

    // ── Layer 4: Spinothalamic Tract ──
    AnatomyLayer(
      name: 'Spinothalamic Tract',
      description:
          'Carries pain and temperature sensation. Fibers enter the cord, '
          'ascend 1-2 levels in the tract of Lissauer, then cross in the '
          'anterior white commissure to ascend contralaterally. '
          'Somatotopy: sacral fibers lateral, cervical fibers medial (lamination). '
          'This is why syringomyelia causes a cape-like sensory loss.',
      color: Color(0xFF22C55E),
      order: 2,
      annotations: [
        LayerAnnotation(
          label: 'Anterior White Commissure',
          detail:
              'Site of spinothalamic tract decussation. Fibers cross 1-2 '
              'levels above their entry point. Syringomyelia expanding '
              'from the central canal disrupts crossing fibers here, '
              'causing bilateral suspended sensory loss (cape distribution).',
          x: 0.45,
          y: 0.62,
        ),
        LayerAnnotation(
          label: 'Somatotopy (Sacral Lateral)',
          detail:
              'Sacral fibers are most lateral (outermost), cervical most '
              'medial. External compression (e.g., tumor) affects sacral '
              'fibers first — "sacral sparing" in incomplete injuries '
              'indicates some preservation of the outermost fibers.',
          x: 0.20,
          y: 0.55,
        ),
      ],
    ),

    // ── Layer 5: Anterior Corticospinal Tract ──
    AnatomyLayer(
      name: 'Anterior Corticospinal Tract',
      description:
          'Uncrossed motor fibers representing <10% of the total '
          'corticospinal tract. These fibers descend ipsilaterally in '
          'the anterior funiculus and cross at the segmental level. '
          'Primarily innervates axial (trunk) musculature. Less clinically '
          'significant but may contribute to recovery in incomplete SCI.',
      color: Color(0xFFF59E0B),
      order: 1,
      annotations: [
        LayerAnnotation(
          label: 'Uncrossed Fibers',
          detail:
              'Unlike the lateral CST, anterior CST fibers do not cross '
              'at the pyramids. They descend ipsilaterally and cross at '
              'the segmental level. May provide a substrate for motor '
              'recovery in incomplete injuries.',
          x: 0.42,
          y: 0.70,
        ),
      ],
    ),

    // ── Layer 6 (outermost): SCI Syndrome Overlay ──
    AnatomyLayer(
      name: 'SCI Syndrome Overlay',
      description:
          'Toggle this layer to see the zones affected in each SCI '
          'syndrome: Central Cord (central gray + medial white matter), '
          'Brown-Sequard (ipsilateral hemisection), Anterior Cord '
          '(anterior 2/3 — motor + spinothalamic, spares dorsal columns), '
          'Posterior Cord (dorsal columns only — rare).',
      color: Color(0xFF8B5CF6),
      order: 0,
      annotations: [
        LayerAnnotation(
          label: 'Central Cord Zone',
          detail:
              'Most common incomplete SCI syndrome. Hyperextension injury '
              'in elderly with stenosis. Arms > legs weakness (medial CST '
              'fibers affected). Preserved sacral sensation. Best prognosis '
              'for ambulation among incomplete syndromes.',
          x: 0.50,
          y: 0.48,
        ),
        LayerAnnotation(
          label: 'Brown-Sequard Zone',
          detail:
              'Hemisection: ipsilateral motor loss (CST) + ipsilateral '
              'proprioception/vibration loss (dorsal columns) + '
              'contralateral pain/temperature loss (STT crosses). '
              'Best overall prognosis of all SCI syndromes.',
          x: 0.30,
          y: 0.45,
        ),
        LayerAnnotation(
          label: 'Anterior Cord Zone',
          detail:
              'Anterior 2/3 of cord affected: loss of motor (CST), pain, '
              'and temperature (STT). Dorsal columns preserved — intact '
              'proprioception and vibration. Worst prognosis among '
              'incomplete syndromes. Often from ASA occlusion.',
          x: 0.40,
          y: 0.60,
        ),
        LayerAnnotation(
          label: 'Posterior Cord Zone',
          detail:
              'Rarest syndrome. Isolated dorsal column damage: loss of '
              'proprioception, vibration, fine touch. Motor, pain, and '
              'temperature preserved. Causes sensory ataxia. '
              'Associated with B12 deficiency, tabes dorsalis.',
          x: 0.52,
          y: 0.30,
        ),
      ],
    ),
  ],
  boardPearls: const [
    // Visible when Gray Matter + Lateral CST are shown
    BoardPearl(
      requiredVisibleLayers: [5, 3],
      title: 'UMN vs LMN Signs',
      content:
          'At the level of injury: LMN signs (flaccid, areflexia, atrophy) '
          'from anterior horn damage. Below the level: UMN signs (spastic, '
          'hyperreflexia, Babinski) from lateral CST disruption. This '
          'distinction is critical for AIS classification and prognosis.',
    ),
    // Visible when Gray Matter + Spinothalamic are shown
    BoardPearl(
      requiredVisibleLayers: [5, 2],
      title: 'Syringomyelia Pattern',
      content:
          'Central canal expansion (syrinx) first disrupts crossing '
          'spinothalamic fibers at the anterior white commissure, causing '
          'bilateral loss of pain/temperature in a cape-like distribution '
          'while preserving dorsal column function. This "dissociated '
          'sensory loss" is a classic board question.',
    ),
    // Visible when Dorsal Columns + Spinothalamic are shown
    BoardPearl(
      requiredVisibleLayers: [4, 2],
      title: 'Brown-Sequard Dissociation',
      content:
          'Because dorsal columns ascend ipsilaterally (cross in medulla) '
          'while spinothalamic fibers cross at the spinal level, a '
          'hemisection produces ipsilateral dorsal column loss with '
          'contralateral pain/temperature loss — the hallmark '
          'dissociation of Brown-Sequard syndrome.',
    ),
    // Visible when all main tracts + SCI Overlay are shown
    BoardPearl(
      requiredVisibleLayers: [0, 3, 2, 4],
      title: 'Syndrome Prognosis Ranking',
      content:
          'Brown-Sequard has the best prognosis (>90% ambulatory), followed '
          'by central cord syndrome (good leg recovery, variable hands). '
          'Anterior cord syndrome has the worst prognosis among incomplete '
          'injuries (<10-20% motor recovery). Posterior cord is rare but '
          'preserves motor function.',
    ),
    // Visible when Gray Matter + Syndrome Overlay
    BoardPearl(
      requiredVisibleLayers: [5, 0],
      title: 'Central Cord & Somatotopy',
      content:
          'Central cord syndrome preferentially affects upper extremities '
          'because arm motor fibers are medial in the lateral CST. '
          'The expanding central lesion damages these medial fibers first. '
          'Sacral fibers (most lateral) are spared — hence "sacral sparing" '
          'and preserved lower extremity function.',
    ),
  ],
);
