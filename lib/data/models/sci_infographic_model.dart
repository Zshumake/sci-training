import 'package:flutter/material.dart';
import 'infographic_model.dart';

/// SCI-specific infographic data — 22 items across anatomy, flowchart,
/// and summary categories.
class SCIInfographicData {
  static const List<Infographic> all = [
    // ══════════════════════════════════════════════
    // ANATOMY (10)
    // ══════════════════════════════════════════════
    Infographic(
      id: 'spinal-cord-cross-section',
      title: 'Spinal Cord Cross-Section',
      description:
          'Labeled tracts: corticospinal, spinothalamic, dorsal columns, '
          'gray matter with anterior/posterior horns',
      assetPath: 'assets/infographics/anatomy/spinal_cord_cross_section.svg',
      category: InfographicCategory.anatomy,
      moduleId: 'pathophysiology',
      icon: Icons.circle_outlined,
    ),
    Infographic(
      id: 'vertebral-anatomy',
      title: 'Vertebral Anatomy',
      description:
          'Vertebral body, pedicles, lamina, spinous process, transverse '
          'process, and spinal canal',
      assetPath: 'assets/infographics/anatomy/vertebral_anatomy.svg',
      category: InfographicCategory.anatomy,
      moduleId: 'sci-fundamentals',
      icon: Icons.view_in_ar_rounded,
    ),
    Infographic(
      id: 'vascular-supply',
      title: 'Spinal Cord Vascular Supply',
      description:
          'Anterior spinal artery, paired posterior spinal arteries, '
          'artery of Adamkiewicz (T9-T12)',
      assetPath: 'assets/infographics/anatomy/vascular_supply.svg',
      category: InfographicCategory.anatomy,
      moduleId: 'pathophysiology',
      icon: Icons.bloodtype_rounded,
    ),
    Infographic(
      id: 'bladder-innervation',
      title: 'Bladder Innervation',
      description:
          'S2-S4 parasympathetic (pelvic nerve), T11-L2 sympathetic '
          '(hypogastric nerve), pudendal nerve',
      assetPath: 'assets/infographics/anatomy/bladder_innervation.svg',
      category: InfographicCategory.anatomy,
      moduleId: 'neurogenic-bladder',
      icon: Icons.water_drop_rounded,
    ),
    Infographic(
      id: 'bowel-innervation',
      title: 'Bowel Innervation',
      description:
          'Enteric nervous system, vagus nerve (proximal), pelvic nerve '
          '(S2-S4 distal), internal/external sphincters',
      assetPath: 'assets/infographics/anatomy/bowel_innervation.svg',
      category: InfographicCategory.anatomy,
      moduleId: 'neurogenic-bowel',
      icon: Icons.swap_vert_circle_rounded,
    ),
    Infographic(
      id: 'autonomic-pathways',
      title: 'Autonomic Pathways',
      description:
          'Intermediolateral (IML) column, sympathetic chain, pre- and '
          'post-ganglionic fibers, target organs',
      assetPath: 'assets/infographics/anatomy/autonomic_pathways.svg',
      category: InfographicCategory.anatomy,
      moduleId: 'autonomic-dysreflexia',
      icon: Icons.account_tree_rounded,
    ),
    Infographic(
      id: 'respiratory-innervation',
      title: 'Respiratory Innervation',
      description:
          'C3-C5 diaphragm (phrenic nerve), T1-T11 intercostals, '
          'T6-T12 abdominals, accessory muscles',
      assetPath: 'assets/infographics/anatomy/respiratory_innervation.svg',
      category: InfographicCategory.anatomy,
      moduleId: 'respiratory',
      icon: Icons.air_rounded,
    ),
    Infographic(
      id: 'cardiac-innervation',
      title: 'Cardiac Innervation',
      description:
          'T1-T4 cardioacceleratory sympathetic fibers, vagal '
          'parasympathetic tone, bradycardia in high cervical SCI',
      assetPath: 'assets/infographics/anatomy/cardiac_innervation.svg',
      category: InfographicCategory.anatomy,
      moduleId: 'cardiovascular',
      icon: Icons.favorite_rounded,
    ),
    Infographic(
      id: 'erection-ejaculation-pathways',
      title: 'Erection & Ejaculation Pathways',
      description:
          'Point (S2-S4 parasympathetic) and Shoot (T11-L2 sympathetic) '
          'mnemonic with neural anatomy',
      assetPath:
          'assets/infographics/anatomy/erection_ejaculation_pathways.svg',
      category: InfographicCategory.anatomy,
      moduleId: 'sexuality-fertility',
      icon: Icons.male_rounded,
    ),
    Infographic(
      id: 'skin-layers-pressure',
      title: 'Skin Layers & Pressure Injury',
      description:
          'Epidermis, dermis, subcutaneous fat, fascia, muscle, bone — '
          'staged pressure injury depth',
      assetPath: 'assets/infographics/anatomy/skin_layers_pressure.svg',
      category: InfographicCategory.anatomy,
      moduleId: 'pressure-injuries',
      icon: Icons.layers_rounded,
    ),

    // ══════════════════════════════════════════════
    // FLOWCHARTS / ALGORITHMS (7)
    // ══════════════════════════════════════════════
    Infographic(
      id: 'ad-management-algorithm',
      title: 'AD Management Algorithm',
      description:
          'Sit up, loosen clothing, check BP, identify/remove noxious '
          'stimulus, pharmacologic management if BP > 150',
      assetPath:
          'assets/infographics/flowcharts/ad_management_algorithm.svg',
      category: InfographicCategory.flowchart,
      moduleId: 'autonomic-dysreflexia',
      icon: Icons.account_tree_rounded,
    ),
    Infographic(
      id: 'bladder-management-algorithm',
      title: 'Bladder Management Algorithm',
      description:
          'Decision tree: UMN vs LMN bladder, CIC vs indwelling vs '
          'suprapubic, anticholinergic selection',
      assetPath:
          'assets/infographics/flowcharts/bladder_management_algorithm.svg',
      category: InfographicCategory.flowchart,
      moduleId: 'neurogenic-bladder',
      icon: Icons.account_tree_rounded,
    ),
    Infographic(
      id: 'bowel-program-algorithm',
      title: 'Bowel Program Algorithm',
      description:
          'UMN vs LMN bowel, digital stimulation vs manual evacuation, '
          'medication escalation ladder',
      assetPath:
          'assets/infographics/flowcharts/bowel_program_algorithm.svg',
      category: InfographicCategory.flowchart,
      moduleId: 'neurogenic-bowel',
      icon: Icons.account_tree_rounded,
    ),
    Infographic(
      id: 'spasticity-management-ladder',
      title: 'Spasticity Management Ladder',
      description:
          'Stretching/positioning, oral medications (baclofen, tizanidine), '
          'botulinum toxin, ITB pump, surgical options',
      assetPath:
          'assets/infographics/flowcharts/spasticity_management_ladder.svg',
      category: InfographicCategory.flowchart,
      moduleId: 'spasticity',
      icon: Icons.stairs_rounded,
    ),
    Infographic(
      id: 'respiratory-weaning-algorithm',
      title: 'Respiratory Weaning Algorithm',
      description:
          'Ventilator weaning progression for cervical SCI: '
          'SIMV, PS, trach collar trials, phrenic pacing criteria',
      assetPath:
          'assets/infographics/flowcharts/respiratory_weaning_algorithm.svg',
      category: InfographicCategory.flowchart,
      moduleId: 'respiratory',
      icon: Icons.account_tree_rounded,
    ),
    Infographic(
      id: 'dvt-prophylaxis-algorithm',
      title: 'DVT Prophylaxis Algorithm',
      description:
          'Acute SCI DVT prevention: LMWH timing, IPC use, '
          'IVC filter indications, duration of prophylaxis',
      assetPath:
          'assets/infographics/flowcharts/dvt_prophylaxis_algorithm.svg',
      category: InfographicCategory.flowchart,
      moduleId: 'cardiovascular',
      icon: Icons.account_tree_rounded,
    ),
    Infographic(
      id: 'pressure-injury-prevention',
      title: 'Pressure Injury Prevention',
      description:
          'Risk assessment (Braden), turning schedule, nutrition optimization, '
          'seating/wheelchair prescription, surgical intervention',
      assetPath:
          'assets/infographics/flowcharts/pressure_injury_prevention.svg',
      category: InfographicCategory.flowchart,
      moduleId: 'pressure-injuries',
      icon: Icons.account_tree_rounded,
    ),

    // ══════════════════════════════════════════════
    // VISUAL SUMMARIES (5)
    // ══════════════════════════════════════════════
    Infographic(
      id: 'asia-ais-summary',
      title: 'ASIA/AIS Classification Summary',
      description:
          'AIS A-E grades, motor/sensory level determination, '
          'ZPP definition, sacral sparing criteria',
      assetPath: 'assets/infographics/summaries/asia_ais_summary.svg',
      category: InfographicCategory.summary,
      moduleId: 'classification-asia',
      icon: Icons.assignment_rounded,
    ),
    Infographic(
      id: 'functional-outcomes-summary',
      title: 'Functional Outcomes by Level',
      description:
          'Expected independence for C4-L1 complete SCI: '
          'mobility, self-care, respiratory, and equipment needs',
      assetPath:
          'assets/infographics/summaries/functional_outcomes_summary.svg',
      category: InfographicCategory.summary,
      moduleId: 'rehab-continuum',
      icon: Icons.accessibility_new_rounded,
    ),
    Infographic(
      id: 'medication-summary',
      title: 'SCI Medications Cheat Sheet',
      description:
          'Key medications by system: bladder, bowel, spasticity, pain, '
          'AD, DVT, orthostatic hypotension',
      assetPath: 'assets/infographics/summaries/medication_summary.svg',
      category: InfographicCategory.summary,
      moduleId: 'pain-syndromes',
      icon: Icons.medication_rounded,
    ),
    Infographic(
      id: 'sci-syndromes-summary',
      title: 'SCI Syndromes Comparison',
      description:
          'Central cord, Brown-Sequard, anterior cord, posterior cord, '
          'cauda equina, conus medullaris',
      assetPath: 'assets/infographics/summaries/sci_syndromes_summary.svg',
      category: InfographicCategory.summary,
      moduleId: 'pathophysiology',
      icon: Icons.compare_arrows_rounded,
    ),
    Infographic(
      id: 'key-autonomic-levels',
      title: 'Key Autonomic Levels',
      description:
          'Critical sympathetic outflow levels: T1-T4 cardiac, T6 splanchnic, '
          'T10-L2 bladder/bowel/sexual, S2-S4 parasympathetic',
      assetPath: 'assets/infographics/summaries/key_autonomic_levels.svg',
      category: InfographicCategory.summary,
      moduleId: 'autonomic-dysreflexia',
      icon: Icons.linear_scale_rounded,
    ),
  ];

  static List<Infographic> getByCategory(InfographicCategory category) =>
      all.where((i) => i.category == category).toList();

  static List<Infographic> getByModule(String moduleId) =>
      all.where((i) => i.moduleId == moduleId).toList();
}
