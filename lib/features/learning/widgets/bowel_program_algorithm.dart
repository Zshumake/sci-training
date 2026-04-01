import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

/// Interactive bowel program builder.
///
/// Guides the learner through building a bowel program for either UMN
/// (reflex) or LMN (areflexic) bowel, with an interactive timeline,
/// troubleshooting branches, and gastrocolic reflex timing pearls.
class BowelProgramAlgorithm extends StatefulWidget {
  const BowelProgramAlgorithm({super.key});

  @override
  State<BowelProgramAlgorithm> createState() => _BowelProgramAlgorithmState();
}

class _BowelProgramAlgorithmState extends State<BowelProgramAlgorithm> {
  // null = not yet selected
  _BowelType? _selectedType;
  int _currentStep = 0;
  bool _showTroubleshooting = false;
  String? _troubleshootingBranch;

  // UMN reflex bowel program steps
  static const List<_BowelStep> _umnSteps = [
    _BowelStep(
      title: 'Timing Selection',
      instruction:
          'Schedule the bowel program at the SAME TIME every day (or every other day). Perform 20-30 minutes AFTER a meal to capitalize on the gastrocolic reflex.',
      pearl:
          'Gastrocolic reflex: eating triggers mass colonic peristalsis via vagal and hormonal pathways. Strongest after BREAKFAST (highest cortisol, longest fasting). Most effective 20-30 minutes post-meal.',
      icon: Icons.schedule,
      timelineLabel: 'Meal',
      timelineMinutes: '0 min',
    ),
    _BowelStep(
      title: 'Dietary Optimization',
      instruction:
          'High-fibre diet (20-30g/day): fruits, vegetables, whole grains. Adequate fluid intake (2-3 L/day). Warm liquids before the program can enhance the gastrocolic reflex.',
      pearl:
          'Fibre adds bulk and softens stool. In UMN bowel, fibre is generally helpful. In LMN bowel, excessive fibre may worsen impaction due to absent propulsive reflexes.',
      icon: Icons.restaurant,
      timelineLabel: 'Wait',
      timelineMinutes: '20-30 min',
    ),
    _BowelStep(
      title: 'Transfer to Commode',
      instruction:
          'Transfer to padded commode or toilet (gravity-assisted positioning). Upright seated posture with feet supported. Avoid performing the bowel program in bed if possible.',
      pearl:
          'Gravity assists evacuation by 30-50%. Sitting upright straightens the anorectal angle (puborectalis relaxation). A footstool or raised feet can further optimise the angle.',
      icon: Icons.accessible,
      timelineLabel: 'Transfer',
      timelineMinutes: '30 min',
    ),
    _BowelStep(
      title: 'Suppository Insertion',
      instruction:
          'Insert a rectal suppository against the rectal wall (NOT into stool). Choice: bisacodyl (stimulant) or polyethylene glycol (PEG)-based. Wait 15-20 minutes for effect.',
      pearl:
          'Bisacodyl (Dulcolax): chemical stimulant — irritates rectal mucosa to trigger reflex peristalsis. Onset 15-30 min. PEG-based (Magic Bullet): faster onset (10-15 min), less mucosal irritation, CO2-releasing. Hydrogenated vegetable oil base absorbs faster than polyethylene glycol base.',
      icon: Icons.medication,
      timelineLabel: 'Suppository',
      timelineMinutes: '30-35 min',
      choices: [
        _StepChoice(
          label: 'Bisacodyl (Dulcolax)',
          detail:
              '10 mg rectal suppository. Chemical stimulant. Onset 15-30 min. Place against rectal wall. May cause cramping in incomplete injuries.',
        ),
        _StepChoice(
          label: 'PEG-based (Magic Bullet)',
          detail:
              'CO2-releasing suppository. Onset 10-15 min. Less mucosal irritation. Hydrogenated vegetable oil base for faster absorption. Preferred by many centres.',
        ),
      ],
    ),
    _BowelStep(
      title: 'Digital Stimulation',
      instruction:
          'After suppository wait time: insert lubricated gloved finger 1-2 cm into rectum. Perform gentle circular motion against the rectal wall for 15-20 seconds. Repeat every 5-10 minutes until evacuation is complete.',
      pearl:
          'Digital stimulation activates the rectocolic reflex via the intact sacral arc (S2-S4) in UMN bowel. It relaxes the internal anal sphincter and triggers peristalsis. CONTRAINDICATED in LMN bowel (no reflex arc to activate).',
      icon: Icons.touch_app,
      timelineLabel: 'Digital Stim',
      timelineMinutes: '45-50 min',
    ),
    _BowelStep(
      title: 'Completion Criteria',
      instruction:
          'The program is complete when: two consecutive digital stimulations produce no stool, OR mucus-only return. Total program time target: <60 minutes.',
      pearl:
          'If program takes >60 minutes regularly, reassess: timing, diet, suppository type, medications (opioids slow transit), or add oral agents (senna, docusate). Incomplete evacuation increases AD risk in injuries at T6 and above.',
      icon: Icons.check_circle_outline,
      timelineLabel: 'Complete',
      timelineMinutes: '50-60 min',
    ),
  ];

  // LMN areflexic bowel program steps
  static const List<_BowelStep> _lmnSteps = [
    _BowelStep(
      title: 'Manual Evacuation (Primary Method)',
      instruction:
          'In LMN bowel, the sacral reflex arc is disrupted. Digital stimulation does NOT work. Manual evacuation (digital removal of stool) is the primary bowel care method.',
      pearl:
          'LMN bowel has a FLACCID external anal sphincter (denervated). Stool accumulates and the patient cannot generate propulsive contractions. Risk of incontinence between evacuations due to patulous (open) sphincter.',
      icon: Icons.back_hand,
      timelineLabel: 'Manual Evac',
      timelineMinutes: '0 min',
    ),
    _BowelStep(
      title: 'Valsalva / Abdominal Massage',
      instruction:
          'Valsalva maneuver (bearing down) and clockwise abdominal massage can assist evacuation. These rely on increased abdominal pressure rather than reflex peristalsis.',
      pearl:
          'Abdominal massage: firm pressure in clockwise direction (ascending to transverse to descending colon) can mechanically move stool. More useful in LMN than UMN because UMN patients often have spastic abdominal muscles.',
      icon: Icons.self_improvement,
      timelineLabel: 'Assist',
      timelineMinutes: '10-15 min',
    ),
    _BowelStep(
      title: 'Dietary Modification',
      instruction:
          'Balanced fibre intake. CAUTION: excessive fibre in LMN bowel may worsen impaction because propulsive reflexes are absent. Adequate fluids (2-3 L/day). Stool should be firm-formed (not too soft, not too hard).',
      pearl:
          'Unlike UMN bowel where you want to soften stool, in LMN bowel you may want SLIGHTLY firmer stool to reduce incontinence between evacuations (the flaccid sphincter cannot hold liquid stool).',
      icon: Icons.restaurant,
      timelineLabel: 'Diet',
      timelineMinutes: 'Daily',
    ),
    _BowelStep(
      title: 'Stool Softeners & Oral Agents',
      instruction:
          'Docusate sodium (Colace) 100-200 mg BID for stool softening. Senna 1-2 tabs at bedtime for mild stimulation. Polyethylene glycol (MiraLAX) 17g daily for osmotic effect. Titrate to achieve formed but soft stool.',
      pearl:
          'Oral agents are adjuncts, not replacements for manual evacuation in LMN bowel. Schedule oral laxatives so their effect coincides with planned evacuation time (senna takes 6-12 hours; take at bedtime for morning program).',
      icon: Icons.medication_liquid,
      timelineLabel: 'Meds',
      timelineMinutes: 'Scheduled',
      choices: [
        _StepChoice(
          label: 'Docusate (Colace)',
          detail:
              '100-200 mg PO BID. Stool softener (surfactant). Onset 1-3 days. Safe for long-term use. Does NOT stimulate peristalsis.',
        ),
        _StepChoice(
          label: 'Senna (Senokot)',
          detail:
              '1-2 tablets PO at bedtime. Stimulant laxative. Onset 6-12 hours. Take at bedtime for morning bowel program.',
        ),
        _StepChoice(
          label: 'Polyethylene Glycol (MiraLAX)',
          detail:
              '17g (1 capful) in 8 oz liquid daily. Osmotic laxative. Onset 1-3 days. Non-habit forming.',
        ),
      ],
    ),
    _BowelStep(
      title: 'Continence Management',
      instruction:
          'Because the EAS is flaccid in LMN bowel, incontinence between evacuations is common. Strategies: scheduled frequent evacuations, dietary adjustment for firmer stool, constipating agents if needed, and protective garments.',
      pearl:
          'Some patients with LMN bowel may benefit from a colostomy for improved quality of life and independence, especially if manual evacuation is difficult due to hand function limitations (tetraplegia with LMN bowel is particularly challenging).',
      icon: Icons.shield_outlined,
      timelineLabel: 'Continence',
      timelineMinutes: 'Ongoing',
    ),
  ];

  // Troubleshooting data
  static const Map<String, _TroubleshootInfo> _troubleshooting = {
    'long_program': _TroubleshootInfo(
      title: 'Program Takes >60 Minutes',
      causes: [
        'Inadequate dietary fibre or fluid intake',
        'Suppository not placed against rectal wall (placed into stool mass)',
        'Opioid or anticholinergic medications slowing transit',
        'Inconsistent timing (not using gastrocolic reflex)',
        'Performing program in bed instead of on commode',
      ],
      solutions: [
        'Increase fibre to 20-30g/day and fluids to 2-3 L/day',
        'Switch suppository type (try PEG-based for faster onset)',
        'Review medications — taper opioids if possible',
        'Schedule consistently 20-30 min after meal',
        'Use commode with upright positioning',
        'Consider adding oral senna at bedtime (6-12 hr onset)',
        'Add mini-enema if suppository alone is insufficient',
      ],
    ),
    'no_results': _TroubleshootInfo(
      title: 'No Results After Complete Program',
      causes: [
        'Stool too high in colon (suppository only reaches rectum/sigmoid)',
        'Severe constipation or faecal loading',
        'Ileus (post-operative or post-injury)',
        'Opioid-induced constipation',
        'Inadequate digital stimulation technique',
      ],
      solutions: [
        'Obtain abdominal X-ray to assess stool burden',
        'Consider oral bowel prep (GoLYTELY) for severe loading',
        'Add scheduled oral laxatives: senna + docusate',
        'Rule out ileus (check bowel sounds, distension)',
        'Consider prokinetic agents (metoclopramide, prucalopride)',
        'If refractory: TAI (transanal irrigation) system',
        'Surgical consultation for colostomy if quality of life is poor',
      ],
    ),
  };

  List<_BowelStep> get _activeSteps =>
      _selectedType == _BowelType.umn ? _umnSteps : _lmnSteps;

  void _selectType(_BowelType type) {
    setState(() {
      _selectedType = type;
      _currentStep = 0;
      _showTroubleshooting = false;
      _troubleshootingBranch = null;
    });
  }

  void _nextStep() {
    if (_currentStep < _activeSteps.length - 1) {
      setState(() => _currentStep++);
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  void _reset() {
    setState(() {
      _selectedType = null;
      _currentStep = 0;
      _showTroubleshooting = false;
      _troubleshootingBranch = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surfaceLight,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (_selectedType == null) ...[
            _buildTypeSelector(),
          ] else ...[
            _buildHeader(),
            const SizedBox(height: 12),
            _buildTimeline(),
            const SizedBox(height: 16),
            _buildCurrentStepCard(),
            const SizedBox(height: 12),
            _buildStepNavigation(),
            const SizedBox(height: 16),
            _buildTroubleshootingSection(),
            if (_troubleshootingBranch != null) ...[
              const SizedBox(height: 12),
              _buildTroubleshootingDetail(_troubleshooting[_troubleshootingBranch!]!),
            ],
          ],
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppTheme.cardBackground,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppTheme.borderSubtle, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Neurogenic Bowel Program Builder',
                style: AppTheme.displayFont(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.primaryNavy),
              ),
              const SizedBox(height: 8),
              Text(
                'Select the type of neurogenic bowel to build a management program:',
                style: AppTheme.bodyFont(
                    fontSize: 14,
                    color: AppTheme.textSecondary,
                    height: 1.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _typeCard(
          type: _BowelType.umn,
          title: 'UMN Reflex Bowel',
          subtitle: 'Injury ABOVE the conus (above S2)',
          features: [
            'Intact sacral reflex arc (S2-S4)',
            'Spastic external anal sphincter (EAS)',
            'Reflex peristalsis preserved in distal colon',
            'Digital stimulation IS effective',
            'Suppositories activate local reflexes',
          ],
          color: AppTheme.bowelColor,
        ),
        const SizedBox(height: 12),
        _typeCard(
          type: _BowelType.lmn,
          title: 'LMN Areflexic Bowel',
          subtitle: 'Injury AT or BELOW the conus (S2-S4) or cauda equina',
          features: [
            'Disrupted sacral reflex arc',
            'Flaccid external anal sphincter',
            'No reflex peristalsis in distal colon',
            'Digital stimulation does NOT work',
            'Manual evacuation is primary method',
          ],
          color: AppTheme.primaryNavy,
        ),
      ],
    );
  }

  Widget _typeCard({
    required _BowelType type,
    required String title,
    required String subtitle,
    required List<String> features,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () => _selectType(type),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: color, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child:
                      Icon(Icons.arrow_forward_rounded, size: 18, color: color),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: AppTheme.displayFont(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: color)),
                      Text(subtitle,
                          style: AppTheme.bodyFont(
                              fontSize: 12, color: AppTheme.textSecondary)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ...features.map((f) => Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022 ',
                          style: AppTheme.bodyFont(fontSize: 12, color: color)),
                      Expanded(
                          child: Text(f,
                              style: AppTheme.bodyFont(
                                  fontSize: 12, height: 1.3))),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final isUMN = _selectedType == _BowelType.umn;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isUMN
            ? AppTheme.bowelColor.withValues(alpha: 0.08)
            : AppTheme.primaryNavy.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border(
          left: BorderSide(
              color: isUMN ? AppTheme.bowelColor : AppTheme.primaryNavy,
              width: 3),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isUMN ? 'UMN Reflex Bowel Program' : 'LMN Areflexic Bowel Program',
                  style: AppTheme.displayFont(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: isUMN ? AppTheme.bowelColor : AppTheme.primaryNavy),
                ),
                Text(
                  'Step ${_currentStep + 1} of ${_activeSteps.length}',
                  style: AppTheme.monoFont(
                      fontSize: 11, color: AppTheme.textSecondary),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: _reset,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: AppTheme.borderSubtle),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.refresh_rounded,
                      size: 14, color: AppTheme.textSecondary),
                  const SizedBox(width: 4),
                  Text('Reset',
                      style: AppTheme.monoFont(
                          fontSize: 10, color: AppTheme.textSecondary)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    final steps = _activeSteps;
    final themeColor = _selectedType == _BowelType.umn
        ? AppTheme.bowelColor
        : AppTheme.primaryNavy;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppTheme.borderSubtle, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.timeline, size: 16, color: AppTheme.textSecondary),
              const SizedBox(width: 6),
              Text('Program Timeline',
                  style: AppTheme.monoFont(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textSecondary,
                      letterSpacing: 1.0)),
            ],
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: steps.asMap().entries.map((entry) {
                final i = entry.key;
                final step = entry.value;
                final isActive = i == _currentStep;
                final isPast = i < _currentStep;

                return Row(
                  children: [
                    GestureDetector(
                      onTap: () => setState(() => _currentStep = i),
                      child: Column(
                        children: [
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: isActive
                                  ? themeColor
                                  : isPast
                                      ? themeColor.withValues(alpha: 0.3)
                                      : AppTheme.surfaceMuted,
                              borderRadius: BorderRadius.circular(14),
                              border: isActive
                                  ? Border.all(
                                      color: themeColor.withValues(alpha: 0.4),
                                      width: 2)
                                  : null,
                            ),
                            child: Icon(
                              step.icon,
                              size: 14,
                              color: isActive || isPast
                                  ? Colors.white
                                  : AppTheme.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(step.timelineLabel,
                              style: AppTheme.monoFont(
                                  fontSize: 8,
                                  fontWeight: isActive
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  color: isActive
                                      ? themeColor
                                      : AppTheme.textSecondary)),
                          Text(step.timelineMinutes,
                              style: AppTheme.monoFont(
                                  fontSize: 7,
                                  color: AppTheme.textSecondary)),
                        ],
                      ),
                    ),
                    if (i < steps.length - 1)
                      Container(
                        width: 24,
                        height: 2,
                        margin: const EdgeInsets.only(bottom: 16),
                        color: isPast
                            ? themeColor.withValues(alpha: 0.3)
                            : AppTheme.borderSubtle,
                      ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentStepCard() {
    final step = _activeSteps[_currentStep];
    final themeColor = _selectedType == _BowelType.umn
        ? AppTheme.bowelColor
        : AppTheme.primaryNavy;

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppTheme.borderSubtle, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title bar
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: themeColor,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(5)),
            ),
            child: Row(
              children: [
                Icon(step.icon, color: Colors.white, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(step.title,
                      style: AppTheme.displayFont(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'STEP ${_currentStep + 1}',
                    style: AppTheme.monoFont(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(step.instruction,
                    style: AppTheme.bodyFont(
                        fontSize: 13,
                        color: AppTheme.textPrimary,
                        height: 1.5)),
                const SizedBox(height: 12),

                // Pearl callout
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.pearlBackground,
                    borderRadius: BorderRadius.circular(4),
                    border: const Border(
                      left:
                          BorderSide(color: AppTheme.pearlBorder, width: 3),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.lightbulb_outline,
                          size: 16, color: AppTheme.pearlBorder),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Clinical Pearl',
                                style: AppTheme.monoFont(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.pearlBorder,
                                    letterSpacing: 0.8)),
                            const SizedBox(height: 4),
                            Text(step.pearl,
                                style: AppTheme.bodyFont(
                                    fontSize: 12,
                                    color: AppTheme.textPrimary,
                                    height: 1.4)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Choices (if any)
                if (step.choices != null && step.choices!.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Text('Options:',
                      style: AppTheme.displayFont(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary)),
                  const SizedBox(height: 6),
                  ...step.choices!.map((c) => _buildChoiceCard(c, themeColor)),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChoiceCard(_StepChoice choice, Color color) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(4),
        border: Border(left: BorderSide(color: color, width: 2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(choice.label,
              style: AppTheme.displayFont(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: color)),
          const SizedBox(height: 4),
          Text(choice.detail,
              style: AppTheme.bodyFont(
                  fontSize: 11,
                  color: AppTheme.textPrimary,
                  height: 1.4)),
        ],
      ),
    );
  }

  Widget _buildStepNavigation() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: _currentStep > 0 ? _prevStep : null,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: _currentStep > 0
                    ? AppTheme.surfaceMuted
                    : AppTheme.surfaceLight,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                    color: _currentStep > 0
                        ? AppTheme.borderSubtle
                        : AppTheme.inkLight),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.chevron_left,
                      size: 18,
                      color: _currentStep > 0
                          ? AppTheme.textPrimary
                          : AppTheme.borderSubtle),
                  Text('Previous',
                      style: AppTheme.displayFont(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: _currentStep > 0
                              ? AppTheme.textPrimary
                              : AppTheme.borderSubtle)),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap:
                _currentStep < _activeSteps.length - 1 ? _nextStep : null,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: _currentStep < _activeSteps.length - 1
                    ? (_selectedType == _BowelType.umn
                        ? AppTheme.bowelColor
                        : AppTheme.primaryNavy)
                    : AppTheme.surfaceLight,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Next',
                      style: AppTheme.displayFont(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: _currentStep < _activeSteps.length - 1
                              ? Colors.white
                              : AppTheme.borderSubtle)),
                  Icon(Icons.chevron_right,
                      size: 18,
                      color: _currentStep < _activeSteps.length - 1
                          ? Colors.white
                          : AppTheme.borderSubtle),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTroubleshootingSection() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppTheme.borderSubtle, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () =>
                setState(() => _showTroubleshooting = !_showTroubleshooting),
            child: Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: AppTheme.warningAmber.withValues(alpha: 0.08),
                borderRadius: _showTroubleshooting
                    ? const BorderRadius.vertical(top: Radius.circular(5))
                    : BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  const Icon(Icons.build_circle_outlined,
                      size: 18, color: AppTheme.warningAmber),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text('Troubleshooting',
                        style: AppTheme.displayFont(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.warningAmber)),
                  ),
                  Icon(
                    _showTroubleshooting
                        ? Icons.expand_less
                        : Icons.expand_more,
                    color: AppTheme.warningAmber,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          if (_showTroubleshooting)
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What problem are you encountering?',
                    style: AppTheme.bodyFont(
                        fontSize: 13,
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  _troubleshootOption(
                    'long_program',
                    'Program takes >60 minutes',
                    Icons.timer_off_outlined,
                  ),
                  const SizedBox(height: 6),
                  _troubleshootOption(
                    'no_results',
                    'No results after complete program',
                    Icons.block,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _troubleshootOption(String key, String label, IconData icon) {
    final isSelected = _troubleshootingBranch == key;
    return GestureDetector(
      onTap: () => setState(
          () => _troubleshootingBranch = isSelected ? null : key),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.warningAmber.withValues(alpha: 0.1)
              : AppTheme.surfaceLight,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
              color: isSelected
                  ? AppTheme.warningAmber
                  : AppTheme.borderSubtle),
        ),
        child: Row(
          children: [
            Icon(icon,
                size: 18,
                color: isSelected
                    ? AppTheme.warningAmber
                    : AppTheme.textSecondary),
            const SizedBox(width: 8),
            Expanded(
                child: Text(label,
                    style: AppTheme.displayFont(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? AppTheme.warningAmber
                            : AppTheme.textPrimary))),
            if (isSelected)
              const Icon(Icons.check_circle,
                  size: 16, color: AppTheme.warningAmber),
          ],
        ),
      ),
    );
  }

  Widget _buildTroubleshootingDetail(_TroubleshootInfo info) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppTheme.warningAmber, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: const BoxDecoration(
              color: AppTheme.warningAmber,
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(5)),
            ),
            child: Text(info.title,
                style: AppTheme.displayFont(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Possible Causes:',
                    style: AppTheme.displayFont(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.dangerRed)),
                const SizedBox(height: 6),
                ...info.causes.map((c) => Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('\u2022 ',
                              style: AppTheme.bodyFont(
                                  fontSize: 12,
                                  color: AppTheme.dangerRed)),
                          Expanded(
                              child: Text(c,
                                  style: AppTheme.bodyFont(
                                      fontSize: 12, height: 1.3))),
                        ],
                      ),
                    )),
                const Divider(height: 20, color: AppTheme.inkLight),
                Text('Solutions:',
                    style: AppTheme.displayFont(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.successGreen)),
                const SizedBox(height: 6),
                ...info.solutions.map((s) => Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('\u2022 ',
                              style: AppTheme.bodyFont(
                                  fontSize: 12,
                                  color: AppTheme.successGreen)),
                          Expanded(
                              child: Text(s,
                                  style: AppTheme.bodyFont(
                                      fontSize: 12, height: 1.3))),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum _BowelType { umn, lmn }

class _BowelStep {
  final String title;
  final String instruction;
  final String pearl;
  final IconData icon;
  final String timelineLabel;
  final String timelineMinutes;
  final List<_StepChoice>? choices;

  const _BowelStep({
    required this.title,
    required this.instruction,
    required this.pearl,
    required this.icon,
    required this.timelineLabel,
    required this.timelineMinutes,
    this.choices,
  });
}

class _StepChoice {
  final String label;
  final String detail;

  const _StepChoice({required this.label, required this.detail});
}

class _TroubleshootInfo {
  final String title;
  final List<String> causes;
  final List<String> solutions;

  const _TroubleshootInfo({
    required this.title,
    required this.causes,
    required this.solutions,
  });
}
