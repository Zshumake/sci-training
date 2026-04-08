import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/responsive_layout.dart';

/// Interactive step-by-step AD emergency management simulator.
///
/// Presents a clinical scenario (T4 complete SCI, BP 210/110, headache,
/// diaphoresis above lesion) and guides the learner through the correct
/// management sequence with feedback, drug dosing, and a BP response
/// animation.
class ADManagementFlowchart extends StatefulWidget {
  const ADManagementFlowchart({super.key});

  @override
  State<ADManagementFlowchart> createState() => _ADManagementFlowchartState();
}

class _ADManagementFlowchartState extends State<ADManagementFlowchart>
    with SingleTickerProviderStateMixin {
  int _currentStep = -1; // -1 = scenario presentation
  int _wrongAttempts = 0;
  bool _showDrugPanel = false;

  late AnimationController _bpController;
  late Animation<double> _bpAnimation;

  // Simulated systolic BP at each step completion
  static const List<double> _bpValues = [
    210, // initial
    200, // sit up
    195, // loosen clothing
    190, // check BP (confirmed)
    160, // check bladder (catheterise)
    140, // check bowel (disimpact)
    130, // check skin
    118, // pharmacologic treatment
  ];

  static const List<_ADStep> _steps = [
    _ADStep(
      index: 0,
      title: 'Sit Patient Upright',
      urgency: _Urgency.emergent,
      instruction:
          'Immediately sit the patient upright with legs dangling. This uses orthostatic pooling to lower BP by approximately 10-20 mmHg.',
      lookFor:
          'Monitor for symptomatic hypotension if patient has baseline low BP. Support trunk if needed for stability.',
      rationale:
          'Gravity-mediated venous pooling in the lower extremities reduces preload and lowers BP. This is the fastest non-pharmacologic intervention.',
    ),
    _ADStep(
      index: 1,
      title: 'Loosen Tight Clothing & Equipment',
      urgency: _Urgency.emergent,
      instruction:
          'Remove abdominal binders, TED hose, tight clothing, leg bag straps, and any constrictive devices below the level of injury.',
      lookFor:
          'Check for kinked catheter tubing, tight shoes, restrictive orthotics, or wrinkled sheets under the patient.',
      rationale:
          'Any constrictive stimulus below the lesion can trigger or worsen the sympathetic response. Removing these eliminates potential noxious stimuli.',
    ),
    _ADStep(
      index: 2,
      title: 'Check Blood Pressure',
      urgency: _Urgency.emergent,
      instruction:
          'Obtain BP immediately and recheck every 2-5 minutes. SBP rise of 20-40 mmHg above baseline is significant in SCI (baseline often 90-110 mmHg).',
      lookFor:
          'SBP elevation >=20-40 mmHg above patient\'s baseline (SCI baseline is often 90-110 mmHg) meets diagnostic criteria. SBP >180 mmHg is a hypertensive emergency with risk of stroke, seizure, and death.',
      rationale:
          'Objective BP measurement confirms the diagnosis of AD and guides the urgency of pharmacologic intervention.',
    ),
    _ADStep(
      index: 3,
      title: 'Check Bladder (Most Common Cause: 75-85%)',
      urgency: _Urgency.emergent,
      instruction:
          'If catheterised: check for kinks, blockage, full bag. Irrigate or replace catheter using lidocaine jelly. If not catheterised: perform straight catheterisation with lidocaine jelly.',
      lookFor:
          'Distended bladder on palpation. Catheter draining? Bag full? Tubing kinked or clamped? UTI signs?',
      rationale:
          'Bladder distension is the #1 cause of AD. Draining even 500 mL can resolve the episode. Use lidocaine jelly to prevent further noxious afferent input.',
    ),
    _ADStep(
      index: 4,
      title: 'Check Bowel (Second Most Common Cause)',
      urgency: _Urgency.monitoring,
      instruction:
          'With BP still elevated after bladder check: apply lidocaine jelly to rectum, wait 2 minutes, then perform gentle digital exam. Remove any impacted stool.',
      lookFor:
          'Faecal impaction, rectal distension. If digital stimulation triggers worsening symptoms, STOP and treat pharmacologically first.',
      rationale:
          'Rectal distension/impaction is the second most common trigger. Lidocaine anesthetises the rectum to prevent worsening the sympathetic response during exam.',
    ),
    _ADStep(
      index: 5,
      title: 'Check Skin & Other Causes',
      urgency: _Urgency.monitoring,
      instruction:
          'Inspect for pressure injuries, ingrown toenails, burns, tight orthotics, DVT, fractures, or any noxious stimulus below the injury level.',
      lookFor:
          'Skin breakdown, swelling (DVT/fracture), temperature changes, insect bites, abdominal distension (acute abdomen).',
      rationale:
          'After bladder and bowel, skin and musculoskeletal causes account for most remaining triggers. A systematic head-to-toe survey below the lesion is essential.',
    ),
    _ADStep(
      index: 6,
      title: 'Pharmacologic Treatment',
      urgency: _Urgency.emergent,
      instruction:
          'If BP remains elevated (SBP elevation >=20-40 mmHg above patient\'s baseline; SCI baseline is often 90-110 mmHg) after removing identifiable causes, initiate rapid-acting antihypertensive therapy while continuing to search for the trigger.',
      lookFor:
          'Response to medication within 5-10 minutes. Recheck BP every 2-5 minutes. Watch for rebound hypotension after stimulus removal.',
      rationale:
          'Pharmacologic treatment buys time while the noxious stimulus is identified. Use short-acting agents to avoid rebound hypotension once the stimulus is removed.',
    ),
  ];

  // Correct step order (0-indexed). User must pick steps in this order.
  static const List<int> _correctOrder = [0, 1, 2, 3, 4, 5, 6];

  @override
  void initState() {
    super.initState();
    _bpController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _bpAnimation = Tween<double>(begin: 210, end: 210).animate(
      CurvedAnimation(parent: _bpController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _bpController.dispose();
    super.dispose();
  }

  void _advanceStep(int tappedIndex) {
    final nextCorrect = _currentStep + 1;
    if (nextCorrect >= _steps.length) return;

    if (tappedIndex == _correctOrder[nextCorrect]) {
      // Correct pick
      setState(() {
        _currentStep = nextCorrect;
        _wrongAttempts = 0;
        if (_currentStep == 6) _showDrugPanel = true;
      });
      _animateBP(nextCorrect);
    } else {
      // Wrong pick
      setState(() => _wrongAttempts++);
      _showFeedbackSnackbar(nextCorrect);
    }
  }

  void _animateBP(int stepIndex) {
    final from = _bpValues[stepIndex];
    final to = _bpValues[stepIndex + 1];
    _bpAnimation = Tween<double>(begin: from, end: to).animate(
      CurvedAnimation(parent: _bpController, curve: Curves.easeInOut),
    );
    _bpController.reset();
    _bpController.forward();
  }

  void _showFeedbackSnackbar(int correctIndex) {
    final correct = _steps[_correctOrder[correctIndex]];
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppTheme.dangerRed,
        duration: const Duration(seconds: 3),
        content: Text(
          'Not yet. The next priority is: ${correct.title}',
          style: AppTheme.bodyFont(fontSize: 13, color: Colors.white),
        ),
      ),
    );
  }

  void _reset() {
    setState(() {
      _currentStep = -1;
      _wrongAttempts = 0;
      _showDrugPanel = false;
    });
    _bpAnimation = Tween<double>(begin: 210, end: 210).animate(
      CurvedAnimation(parent: _bpController, curve: Curves.easeInOut),
    );
    _bpController.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surfaceLight,
      body: ResponsiveBody(
        maxWidth: ResponsiveBreakpoints.maxToolWidth,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildT6PearlCard(),
            const SizedBox(height: 12),
            _buildScenarioCard(),
            const SizedBox(height: 16),
            _buildBPMonitor(),
            const SizedBox(height: 16),
            _buildStepList(),
            if (_showDrugPanel) ...[
              const SizedBox(height: 16),
              _buildDrugDosingPanel(),
            ],
            if (_currentStep >= _steps.length - 1) ...[
              const SizedBox(height: 16),
              _buildCompletionCard(),
            ],
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildT6PearlCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.accentTeal.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
        border: const Border(
          left: BorderSide(color: AppTheme.accentTeal, width: 3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.lightbulb_outline,
              color: AppTheme.accentTeal, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: AppTheme.bodyFont(
                    fontSize: 12,
                    color: AppTheme.textPrimary,
                    height: 1.4),
                children: [
                  TextSpan(
                    text: 'PEARL — T6 threshold rule: ',
                    style: AppTheme.monoFont(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.accentTeal,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const TextSpan(
                    text:
                        'AD occurs in injuries at or ABOVE T6 (loss of supraspinal modulation of splanchnic sympathetic outflow). Rare with injuries below T8.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScenarioCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.dangerRed.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
        border: const Border(
          left: BorderSide(color: AppTheme.dangerRed, width: 3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.warning_amber_rounded,
                  color: AppTheme.dangerRed, size: 20),
              const SizedBox(width: 8),
              Text(
                'CLINICAL SCENARIO',
                style: AppTheme.monoFont(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.dangerRed,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'A 28-year-old male with T4 AIS-A (complete) SCI presents with:',
            style: AppTheme.bodyFont(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary),
          ),
          const SizedBox(height: 8),
          _bulletText('BP 210/110 mmHg (baseline 100/65)'),
          _bulletText('Pounding headache'),
          _bulletText('Profuse diaphoresis and flushing above T4'),
          _bulletText('Pale, cool skin below T4 with piloerection'),
          _bulletText('Bradycardia (HR 52)'),
          _bulletText('Nasal congestion'),
          const SizedBox(height: 10),
          Text(
            _currentStep == -1
                ? 'Tap the correct first step below to begin management.'
                : 'Select the next management step in the correct order.',
            style: AppTheme.bodyFont(
              fontSize: 13,
              fontStyle: FontStyle.italic,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bulletText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('\u2022 ',
              style: AppTheme.bodyFont(
                  fontSize: 14, color: AppTheme.dangerRed)),
          Expanded(
            child: Text(text,
                style:
                    AppTheme.bodyFont(fontSize: 13, color: AppTheme.textPrimary)),
          ),
        ],
      ),
    );
  }

  Widget _buildBPMonitor() {
    return AnimatedBuilder(
      animation: _bpAnimation,
      builder: (context, child) {
        final bp = _bpAnimation.value;
        Color bpColor;
        String bpLabel;
        if (bp >= 180) {
          bpColor = AppTheme.dangerRed;
          bpLabel = 'HYPERTENSIVE EMERGENCY';
        } else if (bp >= 140) {
          // Baseline 100/65 → 140 is ≥40 mmHg above baseline → treat
          bpColor = AppTheme.warningAmber;
          bpLabel = 'ELEVATED (>=20-40 ABOVE BASELINE) — TREAT';
        } else if (bp >= 130) {
          bpColor = AppTheme.warningAmber;
          bpLabel = 'IMPROVING';
        } else {
          bpColor = AppTheme.successGreen;
          bpLabel = 'RESOLVING';
        }

        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppTheme.cardBackground,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: bpColor, width: 1.5),
          ),
          child: Row(
            children: [
              Icon(Icons.monitor_heart_rounded, color: bpColor, size: 28),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Systolic BP',
                    style: AppTheme.monoFont(
                        fontSize: 10,
                        color: AppTheme.textSecondary,
                        letterSpacing: 0.8),
                  ),
                  Text(
                    '${bp.round()} mmHg',
                    style: AppTheme.monoFont(
                        fontSize: 24, fontWeight: FontWeight.w700, color: bpColor),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: bpColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  bpLabel,
                  style: AppTheme.monoFont(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: bpColor,
                      letterSpacing: 0.5),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStepList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MANAGEMENT STEPS',
          style: AppTheme.monoFont(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: AppTheme.textSecondary,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        ..._steps.map((step) => _buildStepTile(step)),
      ],
    );
  }

  Widget _buildStepTile(_ADStep step) {
    final isCompleted = step.index <= _currentStep;
    final isNext = step.index == _currentStep + 1;
    final isLocked = step.index > _currentStep + 1;

    Color urgencyColor;
    switch (step.urgency) {
      case _Urgency.emergent:
        urgencyColor = AppTheme.dangerRed;
      case _Urgency.monitoring:
        urgencyColor = AppTheme.warningAmber;
      case _Urgency.resolved:
        urgencyColor = AppTheme.successGreen;
    }

    return GestureDetector(
      onTap: isLocked || isCompleted ? null : () => _advanceStep(step.index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isCompleted
              ? AppTheme.successGreen.withValues(alpha: 0.06)
              : isNext
                  ? AppTheme.cardBackground
                  : AppTheme.surfaceMuted.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(6),
          border: Border(
            left: BorderSide(
              color: isCompleted
                  ? AppTheme.successGreen
                  : isNext
                      ? urgencyColor
                      : AppTheme.borderSubtle,
              width: 3,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (isCompleted)
                  const Icon(Icons.check_circle_rounded,
                      color: AppTheme.successGreen, size: 18)
                else if (isNext)
                  Icon(Icons.radio_button_unchecked,
                      color: urgencyColor, size: 18)
                else
                  const Icon(Icons.lock_outline,
                      color: AppTheme.borderSubtle, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    step.title,
                    style: AppTheme.displayFont(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isLocked
                          ? AppTheme.textSecondary
                          : AppTheme.textPrimary,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: urgencyColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    step.urgency.label,
                    style: AppTheme.monoFont(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        color: urgencyColor,
                        letterSpacing: 0.5),
                  ),
                ),
              ],
            ),
            if (isCompleted) ...[
              const SizedBox(height: 8),
              _detailRow(Icons.medical_services_outlined, 'Action',
                  step.instruction),
              const SizedBox(height: 6),
              _detailRow(Icons.search, 'Look for', step.lookFor),
              const SizedBox(height: 6),
              _expandableRationale(step.rationale),
            ],
          ],
        ),
      ),
    );
  }

  Widget _detailRow(IconData icon, String label, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 14, color: AppTheme.accentTeal),
        const SizedBox(width: 6),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$label: ',
                  style: AppTheme.displayFont(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary),
                ),
                TextSpan(
                  text: text,
                  style: AppTheme.bodyFont(
                      fontSize: 12,
                      color: AppTheme.textPrimary,
                      height: 1.4),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _expandableRationale(String text) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      childrenPadding: const EdgeInsets.only(bottom: 4),
      dense: true,
      title: Text(
        'Why this step?',
        style: AppTheme.displayFont(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppTheme.accentTeal),
      ),
      iconColor: AppTheme.accentTeal,
      collapsedIconColor: AppTheme.accentTeal,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppTheme.accentTeal.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(text,
              style: AppTheme.bodyFont(
                  fontSize: 12,
                  color: AppTheme.textPrimary,
                  height: 1.4)),
        ),
      ],
    );
  }

  Widget _buildDrugDosingPanel() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppTheme.borderSubtle, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: const BoxDecoration(
              color: AppTheme.primaryNavy,
              borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
            ),
            child: Row(
              children: [
                const Icon(Icons.medication_rounded,
                    color: Colors.white, size: 18),
                const SizedBox(width: 8),
                Text(
                  'Pharmacologic Options',
                  style: AppTheme.displayFont(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                _drugCard(
                  'Nitropaste (2% nitroglycerin ointment)',
                  'Apply 1/2 to 2 inches above the level of injury',
                  'Onset 1-3 min. FIRST LINE — easy to remove if BP drops. Wipe off once stimulus removed.',
                  AppTheme.dangerRed,
                  '1st LINE',
                ),
                const SizedBox(height: 8),
                _drugCard(
                  'Nifedipine (immediate release)',
                  '10 mg — bite and swallow (do NOT give sublingual)',
                  'Onset 5-15 min. Avoid sublingual — risk of precipitous hypotension. Use if nitropaste unavailable.',
                  AppTheme.warningAmber,
                  '2nd LINE',
                ),
                const SizedBox(height: 8),
                _drugCard(
                  'Clonidine',
                  '0.1 to 0.4 mg PO',
                  'Onset 30-60 min. Longer acting. Useful for recurrent episodes. Caution: rebound hypertension if stopped abruptly.',
                  AppTheme.accentTeal,
                  'ADJUNCT',
                ),
                const SizedBox(height: 8),
                _drugCard(
                  'Hydralazine',
                  '10-20 mg IV for refractory cases',
                  'For hypertensive emergency with end-organ damage. IV access required. ICU setting.',
                  AppTheme.primaryNavy,
                  'REFRACTORY',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _drugCard(
      String name, String dose, String notes, Color color, String tag) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(6),
        border: Border(left: BorderSide(color: color, width: 3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(tag,
                    style: AppTheme.monoFont(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(name,
                    style: AppTheme.displayFont(
                        fontSize: 12, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.surfaceLight,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(dose,
                style: AppTheme.monoFont(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: color)),
          ),
          const SizedBox(height: 6),
          Text(notes,
              style: AppTheme.bodyFont(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                  height: 1.4)),
        ],
      ),
    );
  }

  Widget _buildCompletionCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.successGreen.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
        border: const Border(
          left: BorderSide(color: AppTheme.successGreen, width: 3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.check_circle_rounded,
                  color: AppTheme.successGreen, size: 20),
              const SizedBox(width: 8),
              Text(
                'AD EPISODE MANAGED',
                style: AppTheme.monoFont(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.successGreen,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'You have successfully managed this AD episode. Key takeaways:',
            style: AppTheme.bodyFont(
                fontSize: 13, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          _bulletSummary('Sit up immediately to use gravity'),
          _bulletSummary('Bladder is the #1 cause (75-85%)'),
          _bulletSummary('Bowel is the #2 cause'),
          _bulletSummary('Use lidocaine jelly before catheterisation or rectal exam'),
          _bulletSummary('Nitropaste is first-line — easy to titrate/remove'),
          _bulletSummary('Monitor BP every 2-5 minutes throughout'),
          const SizedBox(height: 12),
          Center(
            child: ElevatedButton.icon(
              onPressed: _reset,
              icon: const Icon(Icons.refresh_rounded, size: 16),
              label: const Text('Restart Simulation'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bulletSummary(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('\u2022 ',
              style: AppTheme.bodyFont(
                  fontSize: 13, color: AppTheme.successGreen)),
          Expanded(
            child: Text(text,
                style: AppTheme.bodyFont(fontSize: 12, height: 1.4)),
          ),
        ],
      ),
    );
  }
}

enum _Urgency {
  emergent('EMERGENT'),
  monitoring('MONITORING'),
  resolved('RESOLVED');

  final String label;
  const _Urgency(this.label);
}

class _ADStep {
  final int index;
  final String title;
  final _Urgency urgency;
  final String instruction;
  final String lookFor;
  final String rationale;

  const _ADStep({
    required this.index,
    required this.title,
    required this.urgency,
    required this.instruction,
    required this.lookFor,
    required this.rationale,
  });
}
