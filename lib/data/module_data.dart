import 'models/module_model.dart';

class ModuleData {
  static final List<ModuleModel> standardModules = [
    ModuleModel(
      id: 'sci-fundamentals',
      title: 'SCI Fundamentals',
      description:
          'Epidemiology, spinal cord anatomy, vascular supply, and definitions.',
      highlights: ['Epidemiology', 'Anatomy', 'Vascular supply'],
    ),
    ModuleModel(
      id: 'classification-asia',
      title: 'ASIA/ISNCSCI Classification',
      description:
          'ASIA Impairment Scale, dermatomes, myotomes, NLI, ZPP, and SCI syndromes.',
      highlights: ['AIS', 'Dermatomes', 'SCI syndromes'],
    ),
    ModuleModel(
      id: 'pathophysiology',
      title: 'SCI Pathophysiology',
      description:
          'Primary vs secondary injury, spinal shock, neurogenic shock, and recovery mechanisms.',
      highlights: ['Spinal shock', 'Neurogenic shock', 'Secondary injury'],
    ),
    ModuleModel(
      id: 'neurogenic-bladder',
      title: 'Neurogenic Bladder',
      description:
          'UMN vs LMN bladder, urodynamics, CIC, management algorithms, and complications.',
      highlights: ['UMN vs LMN', 'CIC', 'Urodynamics'],
    ),
    ModuleModel(
      id: 'neurogenic-bowel',
      title: 'Neurogenic Bowel',
      description:
          'UMN vs LMN bowel, bowel programs, digital stimulation, and pharmacotherapy.',
      highlights: ['UMN vs LMN', 'Bowel program', 'Digital stim'],
    ),
    ModuleModel(
      id: 'autonomic-dysreflexia',
      title: 'Autonomic Dysreflexia',
      description:
          'Pathophysiology, triggers, acute management, and prevention strategies.',
      highlights: ['T6 and above', 'Triggers', 'Management'],
    ),
    ModuleModel(
      id: 'respiratory',
      title: 'Respiratory Management',
      description:
          'Level-dependent respiratory function, ventilator weaning, secretion management.',
      highlights: ['Diaphragm C3-5', 'FVC', 'Ventilator weaning'],
    ),
    ModuleModel(
      id: 'cardiovascular',
      title: 'Cardiovascular Complications',
      description:
          'Orthostatic hypotension, DVT/PE, bradycardia, and temperature dysregulation.',
      highlights: ['Orthostasis', 'DVT/PE', 'Bradycardia'],
    ),
    ModuleModel(
      id: 'spasticity',
      title: 'Spasticity in SCI',
      description:
          'UMN spasticity assessment, management ladder, baclofen, ITB pump, botulinum toxin.',
      highlights: ['MAS', 'Baclofen', 'ITB pump'],
    ),
    ModuleModel(
      id: 'pain-syndromes',
      title: 'Pain Syndromes in SCI',
      description:
          'ISCIP classification, neuropathic vs nociceptive, at-level vs below-level pain.',
      highlights: ['ISCIP', 'Neuropathic', 'Central pain'],
    ),
    ModuleModel(
      id: 'pressure-injuries',
      title: 'Pressure Injuries',
      description:
          'NPUAP staging, risk factors, common locations by position, prevention and management.',
      highlights: ['NPUAP staging', 'Risk factors', 'Flap surgery'],
    ),
    ModuleModel(
      id: 'sexuality-fertility',
      title: 'Sexuality & Fertility',
      description:
          'Level-dependent sexual function, erectile dysfunction, ejaculation, fertility options.',
      highlights: ['Reflexogenic', 'Psychogenic', 'EEJ/PVS'],
    ),
    ModuleModel(
      id: 'msk-complications',
      title: 'MSK Complications',
      description:
          'Heterotopic ossification, osteoporosis, fractures, shoulder pain, overuse injuries.',
      highlights: ['HO', 'Osteoporosis', 'Shoulder pain'],
    ),
    ModuleModel(
      id: 'rehab-continuum',
      title: 'SCI Rehabilitation Continuum',
      description:
          'Acute care through community reintegration, functional outcomes by level, FIM.',
      highlights: ['Functional goals', 'Equipment', 'Community'],
    ),
  ];
}
