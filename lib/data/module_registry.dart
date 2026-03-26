import 'models/topic_content_model.dart';
import 'module_contents/sci_fundamentals_content.dart';
import 'module_contents/classification_asia_content.dart';
import 'module_contents/pathophysiology_content.dart';
import 'module_contents/neurogenic_bladder_content.dart';
import 'module_contents/neurogenic_bowel_content.dart';
import 'module_contents/autonomic_dysreflexia_content.dart';
import 'module_contents/respiratory_content.dart';
import 'module_contents/cardiovascular_content.dart';
import 'module_contents/spasticity_content.dart';
import 'module_contents/pain_syndromes_content.dart';
import 'module_contents/pressure_injuries_content.dart';
import 'module_contents/sexuality_fertility_content.dart';
import 'module_contents/msk_complications_content.dart';
import 'module_contents/rehab_continuum_content.dart';

final Map<String, TopicData Function()> moduleContentRegistry = {
  'sci-fundamentals': () => sciFundamentalsContent,
  'classification-asia': () => classificationAsiaContent,
  'pathophysiology': () => pathophysiologyContent,
  'neurogenic-bladder': () => neurogenicBladderContent,
  'neurogenic-bowel': () => neurogenicBowelContent,
  'autonomic-dysreflexia': () => autonomicDysreflexiaContent,
  'respiratory': () => respiratoryContent,
  'cardiovascular': () => cardiovascularContent,
  'spasticity': () => spasticityContent,
  'pain-syndromes': () => painSyndromesContent,
  'pressure-injuries': () => pressureInjuriesContent,
  'sexuality-fertility': () => sexualityFertilityContent,
  'msk-complications': () => mskComplicationsContent,
  'rehab-continuum': () => rehabContinuumContent,
};
