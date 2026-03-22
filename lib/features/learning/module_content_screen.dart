import 'package:flutter/material.dart';
import '../../data/models/module_model.dart';
import '../../data/module_contents/sci_fundamentals_content.dart';
import '../../data/module_contents/classification_asia_content.dart';
import '../../data/module_contents/pathophysiology_content.dart';
import '../../data/module_contents/neurogenic_bladder_content.dart';
import '../../data/module_contents/neurogenic_bowel_content.dart';
import '../../data/module_contents/autonomic_dysreflexia_content.dart';
import '../../data/module_contents/respiratory_content.dart';
import '../../data/module_contents/cardiovascular_content.dart';
import '../../data/module_contents/spasticity_content.dart';
import '../../data/module_contents/pain_syndromes_content.dart';
import '../../data/module_contents/pressure_injuries_content.dart';
import '../../data/module_contents/sexuality_fertility_content.dart';
import '../../data/module_contents/msk_complications_content.dart';
import '../../data/module_contents/rehab_continuum_content.dart';
import 'topic_content_view.dart';
import '../../data/models/topic_content_model.dart';

class ModuleContentScreen extends StatelessWidget {
  final ModuleModel module;

  const ModuleContentScreen({super.key, required this.module});

  TopicData? _getTopicData() {
    switch (module.id) {
      case 'sci-fundamentals':
        return sciFundamentalsContent;
      case 'classification-asia':
        return classificationAsiaContent;
      case 'pathophysiology':
        return pathophysiologyContent;
      case 'neurogenic-bladder':
        return neurogenicBladderContent;
      case 'neurogenic-bowel':
        return neurogenicBowelContent;
      case 'autonomic-dysreflexia':
        return autonomicDysreflexiaContent;
      case 'respiratory':
        return respiratoryContent;
      case 'cardiovascular':
        return cardiovascularContent;
      case 'spasticity':
        return spasticityContent;
      case 'pain-syndromes':
        return painSyndromesContent;
      case 'pressure-injuries':
        return pressureInjuriesContent;
      case 'sexuality-fertility':
        return sexualityFertilityContent;
      case 'msk-complications':
        return mskComplicationsContent;
      case 'rehab-continuum':
        return rehabContinuumContent;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final topicData = _getTopicData();

    return Scaffold(
      appBar: AppBar(
        title: Text(module.title),
      ),
      body: topicData != null
          ? TopicContentView(topicData: topicData)
          : _buildComingSoon(),
    );
  }

  Widget _buildComingSoon() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.construction_rounded,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              module.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Content coming soon!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              module.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
