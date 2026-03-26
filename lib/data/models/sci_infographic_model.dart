import 'package:flutter/material.dart';
import 'infographic_model.dart';

/// SCI-specific infographic data — real open-source medical illustrations.
/// All Servier images are CC BY 4.0. See assets/infographics/LICENSES.md.
class SCIInfographicData {
  static const List<Infographic> all = [
    // ══════════════════════════════════════════════
    // ANATOMY — Servier Medical Art (CC BY 4.0)
    // ══════════════════════════════════════════════

    // -- Brain & Neuroanatomy --
    Infographic(
      id: 'brain-lateral',
      title: 'Brain — Lateral View',
      description: 'Cerebral hemispheres, frontal/parietal/temporal/occipital lobes',
      assetPath: 'assets/infographics/anatomy/servier_brain_lateral.png',
      category: InfographicCategory.anatomy,
      moduleId: 'sci-fundamentals',
      icon: Icons.psychology_rounded,
    ),
    Infographic(
      id: 'brain-sagittal',
      title: 'Brain — Sagittal Section',
      description: 'Midsagittal view showing corpus callosum, brainstem, cerebellum',
      assetPath: 'assets/infographics/anatomy/servier_brain_sagittal.png',
      category: InfographicCategory.anatomy,
      moduleId: 'sci-fundamentals',
      icon: Icons.psychology_rounded,
    ),
    Infographic(
      id: 'brain-detailed',
      title: 'Brain — Detailed Anatomy',
      description: 'Detailed cerebral anatomy with labeled structures',
      assetPath: 'assets/infographics/anatomy/servier_brain_detailed.png',
      category: InfographicCategory.anatomy,
      moduleId: 'sci-fundamentals',
      icon: Icons.psychology_rounded,
    ),
    Infographic(
      id: 'brain-brainstem',
      title: 'Brain & Brainstem',
      description: 'Brainstem connection to spinal cord, midbrain, pons, medulla',
      assetPath: 'assets/infographics/anatomy/servier_brain_brainstem.png',
      category: InfographicCategory.anatomy,
      moduleId: 'pathophysiology',
      icon: Icons.psychology_rounded,
    ),
    Infographic(
      id: 'brain-arteries',
      title: 'Cerebral Arterial Supply',
      description: 'Circle of Willis, anterior/middle/posterior cerebral arteries',
      assetPath: 'assets/infographics/anatomy/servier_brain_arteries.png',
      category: InfographicCategory.anatomy,
      moduleId: 'pathophysiology',
      icon: Icons.bloodtype_rounded,
    ),

    // -- Urinary System --
    Infographic(
      id: 'bladder-anatomy',
      title: 'Urinary Bladder',
      description: 'Bladder wall, detrusor muscle, trigone, internal/external sphincters',
      assetPath: 'assets/infographics/anatomy/servier_bladder.png',
      category: InfographicCategory.anatomy,
      moduleId: 'neurogenic-bladder',
      icon: Icons.water_drop_rounded,
    ),
    Infographic(
      id: 'urinary-male',
      title: 'Male Urinary System',
      description: 'Complete male urinary tract: kidneys, ureters, bladder, urethra',
      assetPath: 'assets/infographics/anatomy/servier_urinary_male.png',
      category: InfographicCategory.anatomy,
      moduleId: 'neurogenic-bladder',
      icon: Icons.male_rounded,
    ),
    Infographic(
      id: 'urinary-female',
      title: 'Female Urinary System',
      description: 'Complete female urinary tract anatomy',
      assetPath: 'assets/infographics/anatomy/servier_urinary_female.png',
      category: InfographicCategory.anatomy,
      moduleId: 'neurogenic-bladder',
      icon: Icons.female_rounded,
    ),
    Infographic(
      id: 'kidney-anatomy',
      title: 'Kidney Anatomy',
      description: 'Renal cortex, medulla, pelvis, and calyceal system',
      assetPath: 'assets/infographics/anatomy/servier_kidney_detailed.png',
      category: InfographicCategory.anatomy,
      moduleId: 'neurogenic-bladder',
      icon: Icons.water_drop_rounded,
    ),
    Infographic(
      id: 'nephron-anatomy',
      title: 'Nephron',
      description: 'Glomerulus, proximal/distal tubules, loop of Henle, collecting duct',
      assetPath: 'assets/infographics/anatomy/servier_nephron.png',
      category: InfographicCategory.anatomy,
      moduleId: 'neurogenic-bladder',
      icon: Icons.water_drop_rounded,
    ),

    // -- GI System --
    Infographic(
      id: 'digestive-system',
      title: 'Digestive System',
      description: 'Complete GI tract from esophagus to rectum',
      assetPath: 'assets/infographics/anatomy/servier_digestive_system.png',
      category: InfographicCategory.anatomy,
      moduleId: 'neurogenic-bowel',
      icon: Icons.swap_vert_circle_rounded,
    ),
    Infographic(
      id: 'colon-anatomy',
      title: 'Colon Anatomy',
      description: 'Ascending, transverse, descending, sigmoid colon and rectum',
      assetPath: 'assets/infographics/anatomy/servier_colon.png',
      category: InfographicCategory.anatomy,
      moduleId: 'neurogenic-bowel',
      icon: Icons.swap_vert_circle_rounded,
    ),
    Infographic(
      id: 'colon-cross-section',
      title: 'Colon — Cross-Section',
      description: 'Wall layers: mucosa, submucosa, muscularis, serosa',
      assetPath: 'assets/infographics/anatomy/servier_colon_cross_section.png',
      category: InfographicCategory.anatomy,
      moduleId: 'neurogenic-bowel',
      icon: Icons.swap_vert_circle_rounded,
    ),

    // -- Respiratory --
    Infographic(
      id: 'lung-airways',
      title: 'Intrapulmonary Airways',
      description: 'Bronchial tree, bronchioles, alveolar ducts',
      assetPath: 'assets/infographics/anatomy/servier_lung_airways.png',
      category: InfographicCategory.anatomy,
      moduleId: 'respiratory',
      icon: Icons.air_rounded,
    ),
    Infographic(
      id: 'gas-exchange-pulmonary',
      title: 'Pulmonary Gas Exchange',
      description: 'Alveolar-capillary interface, O2/CO2 exchange',
      assetPath: 'assets/infographics/anatomy/servier_gas_exchange_pulmonary.png',
      category: InfographicCategory.anatomy,
      moduleId: 'respiratory',
      icon: Icons.air_rounded,
    ),

    // -- Cardiovascular --
    Infographic(
      id: 'cardiomyocyte',
      title: 'Cardiomyocyte',
      description: 'Cardiac muscle cell structure and contractile elements',
      assetPath: 'assets/infographics/anatomy/servier_cardiomyocyte.png',
      category: InfographicCategory.anatomy,
      moduleId: 'cardiovascular',
      icon: Icons.favorite_rounded,
    ),

    // -- Skin / Pressure Injuries --
    Infographic(
      id: 'skin-layers',
      title: 'Skin Layers',
      description: 'Epidermis, dermis, subcutaneous tissue, and appendages',
      assetPath: 'assets/infographics/anatomy/servier_skin_layers.png',
      category: InfographicCategory.anatomy,
      moduleId: 'pressure-injuries',
      icon: Icons.layers_rounded,
    ),
    Infographic(
      id: 'integumentary-system',
      title: 'Integumentary System',
      description: 'Complete integumentary system overview',
      assetPath: 'assets/infographics/anatomy/servier_integumentary.png',
      category: InfographicCategory.anatomy,
      moduleId: 'pressure-injuries',
      icon: Icons.layers_rounded,
    ),

    // -- Body Maps (for dermatome overlay reference) --
    Infographic(
      id: 'body-anterior',
      title: 'Human Body — Anterior',
      description: 'Full body anterior view for dermatome reference',
      assetPath: 'assets/infographics/anatomy/servier_adult_body_anterior.png',
      category: InfographicCategory.anatomy,
      moduleId: 'classification-asia',
      icon: Icons.accessibility_new_rounded,
    ),
    Infographic(
      id: 'body-posterior',
      title: 'Human Body — Posterior',
      description: 'Full body posterior view for dermatome reference',
      assetPath: 'assets/infographics/anatomy/servier_adult_body_posterior.png',
      category: InfographicCategory.anatomy,
      moduleId: 'classification-asia',
      icon: Icons.accessibility_new_rounded,
    ),
  ];

  static List<Infographic> getByCategory(InfographicCategory category) =>
      all.where((i) => i.category == category).toList();

  static List<Infographic> getByModule(String moduleId) =>
      all.where((i) => i.moduleId == moduleId).toList();
}
