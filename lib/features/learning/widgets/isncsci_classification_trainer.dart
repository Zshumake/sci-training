import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/isncsci/isncsci_algorithm.dart';
import '../../../core/isncsci/isncsci_exam_model.dart';
import '../../../core/isncsci/isncsci_result_model.dart';
import '../../../core/isncsci/isncsci_constants.dart';
import '../../../data/isncsci_training_cases.dart';

// ============================================================================
// Case Selection Screen
// ============================================================================

class ISNCSCIClassificationTrainer extends StatefulWidget {
  const ISNCSCIClassificationTrainer({super.key});

  @override
  State<ISNCSCIClassificationTrainer> createState() =>
      _ISNCSCIClassificationTrainerState();
}

class _ISNCSCIClassificationTrainerState
    extends State<ISNCSCIClassificationTrainer> {
  final Set<String> _completedCaseIds = {};

  @override
  Widget build(BuildContext context) {
    final cases = ISNCSCITrainingCases.allCases;
    final grouped = <String, List<ISNCSCITrainingCase>>{
      'basic': cases.where((c) => c.difficulty == 'basic').toList(),
      'intermediate':
          cases.where((c) => c.difficulty == 'intermediate').toList(),
      'advanced': cases.where((c) => c.difficulty == 'advanced').toList(),
    };

    return Scaffold(
      backgroundColor: AppTheme.surfaceLight,
      appBar: AppBar(title: const Text('Classification Trainer')),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          _buildIntroCard(),
          const SizedBox(height: 16),
          _buildProgressSummary(cases),
          const SizedBox(height: 20),
          for (final entry in grouped.entries) ...[
            _buildDifficultyHeader(entry.key, entry.value.length),
            const SizedBox(height: 8),
            ...entry.value.map((c) => _buildCaseTile(c)),
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }

  Widget _buildIntroCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppTheme.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Guided ISNCSCI Classification',
            style: AppTheme.displayFont(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Practice classifying spinal cord injuries step-by-step. '
            'Each case walks you through determining sensory levels, motor '
            'levels, NLI, completeness, and AIS grade with immediate feedback.',
            style: AppTheme.bodyFont(
              fontSize: 14,
              color: AppTheme.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSummary(List<ISNCSCITrainingCase> cases) {
    final completed = _completedCaseIds.length;
    final total = cases.length;
    final progress = total > 0 ? completed / total : 0.0;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.accentTeal.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: AppTheme.accentTeal.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 44,
            height: 44,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 4,
              backgroundColor: AppTheme.borderSubtle,
              valueColor: const AlwaysStoppedAnimation(AppTheme.accentTeal),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$completed of $total cases completed',
                  style: AppTheme.displayFont(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.accentTeal,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  completed == 0
                      ? 'Start with the basic cases below'
                      : completed == total
                          ? 'All cases completed!'
                          : 'Keep going -- try the next difficulty level',
                  style: AppTheme.bodyFont(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDifficultyHeader(String difficulty, int count) {
    final labels = {
      'basic': 'Basic',
      'intermediate': 'Intermediate',
      'advanced': 'Advanced',
    };
    final colors = {
      'basic': AppTheme.successGreen,
      'intermediate': AppTheme.warningAmber,
      'advanced': AppTheme.dangerRed,
    };
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: colors[difficulty]!.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            labels[difficulty]!.toUpperCase(),
            style: AppTheme.displayFont(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: colors[difficulty]!,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '$count cases',
          style: AppTheme.bodyFont(
            fontSize: 12,
            color: AppTheme.textSecondary,
          ),
        ),
        const Spacer(),
      ],
    );
  }

  Widget _buildCaseTile(ISNCSCITrainingCase trainingCase) {
    final isCompleted = _completedCaseIds.contains(trainingCase.id);
    final difficultyColor = {
          'basic': AppTheme.successGreen,
          'intermediate': AppTheme.warningAmber,
          'advanced': AppTheme.dangerRed,
        }[trainingCase.difficulty] ??
        AppTheme.textSecondary;

    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push<bool>(
          context,
          MaterialPageRoute(
            builder: (_) =>
                _CaseWalkthroughScreen(trainingCase: trainingCase),
          ),
        );
        if (result == true) {
          setState(() => _completedCaseIds.add(trainingCase.id));
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isCompleted
              ? AppTheme.successGreen.withValues(alpha: 0.06)
              : AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isCompleted
                ? AppTheme.successGreen.withValues(alpha: 0.3)
                : AppTheme.borderSubtle,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isCompleted
                  ? Icons.check_circle_rounded
                  : Icons.circle_outlined,
              color: isCompleted ? AppTheme.successGreen : AppTheme.borderSubtle,
              size: 22,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trainingCase.title,
                    style: AppTheme.displayFont(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    trainingCase.clinicalScenario,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.bodyFont(
                      fontSize: 12,
                      color: AppTheme.textSecondary,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 6,
              height: 36,
              decoration: BoxDecoration(
                color: difficultyColor.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// Case Walkthrough Screen
// ============================================================================

class _CaseWalkthroughScreen extends StatefulWidget {
  final ISNCSCITrainingCase trainingCase;
  const _CaseWalkthroughScreen({required this.trainingCase});

  @override
  State<_CaseWalkthroughScreen> createState() =>
      _CaseWalkthroughScreenState();
}

class _CaseWalkthroughScreenState extends State<_CaseWalkthroughScreen> {
  int _currentStep = 0;
  late final ISNCSCIResult _result;

  // User answers
  String? _userSensoryRight;
  String? _userSensoryLeft;
  String? _userMotorRight;
  String? _userMotorLeft;
  String? _userNLI;
  bool? _userSacralSparing;
  String? _userAIS;

  // Step checked state
  final Map<int, bool> _stepChecked = {};
  final Map<int, bool> _stepCorrect = {};

  static const _stepTitles = [
    'Review Exam Data',
    'Sensory Levels',
    'Motor Levels',
    'Neurological Level of Injury',
    'Completeness (Sacral Sparing)',
    'AIS Grade',
    'Results Summary',
  ];

  @override
  void initState() {
    super.initState();
    _result = calculateISNCSCI(widget.trainingCase.exam);
  }

  /// All possible correct values for a field (comma-separated by algorithm).
  List<String> _parseOptions(String value) {
    return value.split(',').map((s) => s.trim()).toList();
  }

  bool _isCorrectAnswer(String? userAnswer, String correctValues) {
    if (userAnswer == null) return false;
    final options = _parseOptions(correctValues);
    return options.contains(userAnswer.trim());
  }

  // Level list for dropdowns (C1 through S4_5)
  List<String> get _levelDropdownItems => sensoryLevels;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surfaceLight,
      appBar: AppBar(
        title: Text(
          widget.trainingCase.title,
          style: const TextStyle(fontSize: 15),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context, _currentStep == 6),
        ),
      ),
      body: Column(
        children: [
          _buildStepIndicator(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: _buildStepContent(),
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // Step indicator
  // --------------------------------------------------------------------------

  Widget _buildStepIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: AppTheme.cardBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Step ${_currentStep + 1} of 7',
                style: AppTheme.displayFont(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.accentTeal,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _stepTitles[_currentStep],
                  style: AppTheme.displayFont(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(7, (i) {
              final isActive = i == _currentStep;
              final isDone = i < _currentStep || _stepChecked[i] == true;
              return Expanded(
                child: Container(
                  height: 4,
                  margin: EdgeInsets.only(right: i < 6 ? 3 : 0),
                  decoration: BoxDecoration(
                    color: isDone
                        ? AppTheme.accentTeal
                        : isActive
                            ? AppTheme.accentTeal.withValues(alpha: 0.4)
                            : AppTheme.borderSubtle,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // Step content
  // --------------------------------------------------------------------------

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildStep0ReviewExam();
      case 1:
        return _buildStep1SensoryLevels();
      case 2:
        return _buildStep2MotorLevels();
      case 3:
        return _buildStep3NLI();
      case 4:
        return _buildStep4Completeness();
      case 5:
        return _buildStep5AIS();
      case 6:
        return _buildStep6Summary();
      default:
        return const SizedBox.shrink();
    }
  }

  // --- Step 0: Review Exam Data ---

  Widget _buildStep0ReviewExam() {
    final exam = widget.trainingCase.exam;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('Clinical Scenario'),
        _cardContainer(
          child: Text(
            widget.trainingCase.clinicalScenario,
            style: AppTheme.bodyFont(fontSize: 14, height: 1.6),
          ),
        ),
        const SizedBox(height: 16),
        _sectionHeader('Sensory Examination -- Light Touch'),
        _buildSensoryTable(
          exam.right.lightTouch,
          exam.left.lightTouch,
          'LT',
        ),
        const SizedBox(height: 12),
        _sectionHeader('Sensory Examination -- Pin Prick'),
        _buildSensoryTable(
          exam.right.pinPrick,
          exam.left.pinPrick,
          'PP',
        ),
        const SizedBox(height: 12),
        _sectionHeader('Motor Examination'),
        _buildMotorTable(exam.right.motor, exam.left.motor),
        const SizedBox(height: 12),
        _sectionHeader('Sacral Exam'),
        _buildSacralExamCard(exam),
        if (exam.right.lowestNonKeyMuscleWithMotorFunction != null ||
            exam.left.lowestNonKeyMuscleWithMotorFunction != null) ...[
          const SizedBox(height: 12),
          _sectionHeader('Non-Key Muscle Function'),
          _buildNonKeyMuscleCard(exam),
        ],
        const SizedBox(height: 16),
        _infoBox(
          'Review all exam data carefully before proceeding. Pay attention to '
          'asymmetries, S4-5 values, and the pattern of preserved function.',
        ),
      ],
    );
  }

  Widget _buildSensoryTable(Sensory right, Sensory left, String label) {
    return _cardContainer(
      child: Column(
        children: [
          Row(
            children: [
              _tableHeaderCell('Level', flex: 2),
              _tableHeaderCell('Right $label'),
              _tableHeaderCell('Left $label'),
            ],
          ),
          const Divider(height: 1, color: AppTheme.borderSubtle),
          for (int i = 0; i < sensoryExamLevels.length; i++)
            _sensoryRow(
              sensoryExamLevels[i],
              right[sensoryExamLevels[i]],
              left[sensoryExamLevels[i]],
              isEven: i.isEven,
            ),
        ],
      ),
    );
  }

  Widget _sensoryRow(String level, String rVal, String lVal,
      {bool isEven = false}) {
    return Container(
      color: isEven ? AppTheme.surfaceMuted.withValues(alpha: 0.4) : null,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(level,
                style: AppTheme.monoFont(fontSize: 12, fontWeight: FontWeight.w600)),
          ),
          Expanded(child: _scoreCell(rVal)),
          Expanded(child: _scoreCell(lVal)),
        ],
      ),
    );
  }

  Widget _buildMotorTable(Motor right, Motor left) {
    return _cardContainer(
      child: Column(
        children: [
          Row(
            children: [
              _tableHeaderCell('Level', flex: 2),
              _tableHeaderCell('Muscle', flex: 3),
              _tableHeaderCell('Right'),
              _tableHeaderCell('Left'),
            ],
          ),
          const Divider(height: 1, color: AppTheme.borderSubtle),
          for (int i = 0; i < motorLevels.length; i++)
            _motorRow(
              motorLevels[i],
              motorLevelToMuscle[motorLevels[i]] ?? '',
              right[motorLevels[i]],
              left[motorLevels[i]],
              isEven: i.isEven,
            ),
        ],
      ),
    );
  }

  Widget _motorRow(String level, String muscle, String rVal, String lVal,
      {bool isEven = false}) {
    return Container(
      color: isEven ? AppTheme.surfaceMuted.withValues(alpha: 0.4) : null,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(level,
                style: AppTheme.monoFont(fontSize: 12, fontWeight: FontWeight.w600)),
          ),
          Expanded(
            flex: 3,
            child: Text(
              muscle.split('(').first.trim(),
              style: AppTheme.bodyFont(fontSize: 11, color: AppTheme.textSecondary),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(child: _scoreCell(rVal)),
          Expanded(child: _scoreCell(lVal)),
        ],
      ),
    );
  }

  Widget _scoreCell(String value) {
    final isNormal =
        value == '2' || value == '5' || value == '2**' || value == '5**';
    final isAbsent = value == '0';
    final isNT = value.startsWith('NT');
    Color textColor;
    if (isNormal) {
      textColor = AppTheme.successGreen;
    } else if (isAbsent) {
      textColor = AppTheme.dangerRed;
    } else if (isNT) {
      textColor = AppTheme.warningAmber;
    } else {
      textColor = AppTheme.textPrimary;
    }
    return Text(
      value,
      textAlign: TextAlign.center,
      style: AppTheme.monoFont(fontSize: 12, color: textColor),
    );
  }

  Widget _buildSacralExamCard(Exam exam) {
    return _cardContainer(
      child: Row(
        children: [
          Expanded(
            child: _sacralItem(
                'DAP', exam.deepAnalPressure.label),
          ),
          Container(width: 1, height: 40, color: AppTheme.borderSubtle),
          Expanded(
            child: _sacralItem(
                'VAC', exam.voluntaryAnalContraction.label),
          ),
        ],
      ),
    );
  }

  Widget _sacralItem(String label, String value) {
    final isYes = value == 'Yes';
    final isNo = value == 'No';
    return Column(
      children: [
        Text(label,
            style: AppTheme.displayFont(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppTheme.textSecondary)),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: isYes
                ? AppTheme.successGreen.withValues(alpha: 0.1)
                : isNo
                    ? AppTheme.dangerRed.withValues(alpha: 0.1)
                    : AppTheme.warningAmber.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            value,
            style: AppTheme.monoFont(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: isYes
                  ? AppTheme.successGreen
                  : isNo
                      ? AppTheme.dangerRed
                      : AppTheme.warningAmber,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNonKeyMuscleCard(Exam exam) {
    return _cardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (exam.right.lowestNonKeyMuscleWithMotorFunction != null)
            Text(
              'Right: non-key muscle function present at '
              '${exam.right.lowestNonKeyMuscleWithMotorFunction}',
              style: AppTheme.bodyFont(fontSize: 13),
            ),
          if (exam.left.lowestNonKeyMuscleWithMotorFunction != null)
            Text(
              'Left: non-key muscle function present at '
              '${exam.left.lowestNonKeyMuscleWithMotorFunction}',
              style: AppTheme.bodyFont(fontSize: 13),
            ),
        ],
      ),
    );
  }

  // --- Step 1: Sensory Levels ---

  Widget _buildStep1SensoryLevels() {
    final correctR = _result.classification.neurologicalLevels.sensoryRight;
    final correctL = _result.classification.neurologicalLevels.sensoryLeft;
    final checked = _stepChecked[1] == true;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('Determine the Sensory Levels'),
        _infoBox(
          'The sensory level is the most caudal segment with NORMAL (2/2) '
          'sensation for BOTH light touch AND pin prick, with all rostral '
          'dermatomes also normal. Determine separately for each side.',
        ),
        const SizedBox(height: 16),
        _buildLevelDropdown(
          label: 'Right Sensory Level',
          value: _userSensoryRight,
          onChanged: checked ? null : (v) => setState(() => _userSensoryRight = v),
        ),
        const SizedBox(height: 12),
        _buildLevelDropdown(
          label: 'Left Sensory Level',
          value: _userSensoryLeft,
          onChanged: checked ? null : (v) => setState(() => _userSensoryLeft = v),
        ),
        if (checked) ...[
          const SizedBox(height: 16),
          _buildFeedback(
            isCorrect: _isCorrectAnswer(_userSensoryRight, correctR) &&
                _isCorrectAnswer(_userSensoryLeft, correctL),
            correctAnswer: 'Right: $correctR, Left: $correctL',
            explanation:
                'The sensory level is determined by finding the most caudal '
                'segment where BOTH light touch AND pin prick are 2 (normal), '
                'with all segments above also normal. Check each side independently.',
          ),
        ],
        if (!checked) ...[
          const SizedBox(height: 20),
          _checkAnswerButton(1),
        ],
      ],
    );
  }

  // --- Step 2: Motor Levels ---

  Widget _buildStep2MotorLevels() {
    final correctR = _result.classification.neurologicalLevels.motorRight;
    final correctL = _result.classification.neurologicalLevels.motorLeft;
    final checked = _stepChecked[2] == true;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('Determine the Motor Levels'),
        _infoBox(
          'The motor level is the most caudal key muscle graded >= 3/5, '
          'provided the segment ABOVE is graded 5/5. For levels without key '
          'muscles (C1-C4, T2-L1, S2-S5), the motor level follows the sensory '
          'level if motor function above is normal.',
        ),
        const SizedBox(height: 16),
        _buildLevelDropdown(
          label: 'Right Motor Level',
          value: _userMotorRight,
          onChanged: checked ? null : (v) => setState(() => _userMotorRight = v),
        ),
        const SizedBox(height: 12),
        _buildLevelDropdown(
          label: 'Left Motor Level',
          value: _userMotorLeft,
          onChanged: checked ? null : (v) => setState(() => _userMotorLeft = v),
        ),
        if (checked) ...[
          const SizedBox(height: 16),
          _buildFeedback(
            isCorrect: _isCorrectAnswer(_userMotorRight, correctR) &&
                _isCorrectAnswer(_userMotorLeft, correctL),
            correctAnswer: 'Right: $correctR, Left: $correctL',
            explanation:
                'Motor level rule: the key muscle must be >= 3/5 AND the key '
                'muscle at the level above must be 5/5. For non-key-muscle '
                'segments (C1-C4, T2-L1, S2-S5), the motor level equals the '
                'sensory level if all testable motor function above is normal.',
          ),
        ],
        if (!checked) ...[
          const SizedBox(height: 20),
          _checkAnswerButton(2),
        ],
      ],
    );
  }

  // --- Step 3: NLI ---

  Widget _buildStep3NLI() {
    final correctNLI = _result.classification.neurologicalLevelOfInjury;
    final checked = _stepChecked[3] == true;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('Determine the Neurological Level of Injury'),
        _infoBox(
          'The NLI is the SINGLE most caudal level where BOTH sensory AND motor '
          'function are normal on BOTH sides. It is the most ROSTRAL of the four '
          'individual levels (R sensory, L sensory, R motor, L motor).',
        ),
        const SizedBox(height: 12),
        _cardContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Your determined levels:',
                  style: AppTheme.displayFont(
                      fontSize: 13, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              _levelSummaryRow('R Sensory',
                  _userSensoryRight ?? _result.classification.neurologicalLevels.sensoryRight),
              _levelSummaryRow('L Sensory',
                  _userSensoryLeft ?? _result.classification.neurologicalLevels.sensoryLeft),
              _levelSummaryRow('R Motor',
                  _userMotorRight ?? _result.classification.neurologicalLevels.motorRight),
              _levelSummaryRow('L Motor',
                  _userMotorLeft ?? _result.classification.neurologicalLevels.motorLeft),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildLevelDropdown(
          label: 'Neurological Level of Injury (NLI)',
          value: _userNLI,
          onChanged: checked ? null : (v) => setState(() => _userNLI = v),
        ),
        if (checked) ...[
          const SizedBox(height: 16),
          _buildFeedback(
            isCorrect: _isCorrectAnswer(_userNLI, correctNLI),
            correctAnswer: correctNLI,
            explanation:
                'The NLI is the most ROSTRAL of the four levels. Compare the '
                'sensory and motor levels on each side and pick the highest '
                '(most rostral) one.',
          ),
        ],
        if (!checked) ...[
          const SizedBox(height: 20),
          _checkAnswerButton(3),
        ],
      ],
    );
  }

  Widget _levelSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(label,
                style: AppTheme.bodyFont(
                    fontSize: 12, color: AppTheme.textSecondary)),
          ),
          Text(value,
              style: AppTheme.monoFont(fontSize: 13, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  // --- Step 4: Completeness ---

  Widget _buildStep4Completeness() {
    final exam = widget.trainingCase.exam;
    final correctComplete = _result.classification.injuryComplete;
    final checked = _stepChecked[4] == true;

    // Determine correct sacral sparing answer
    // injuryComplete: 'C' = complete (no sacral sparing), 'I' = incomplete (sacral sparing present)
    final correctSacralSparing = correctComplete.contains('I');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('Determine Completeness'),
        _infoBox(
          'Sacral sparing is present if ANY of the following are true:\n'
          '  - Light touch or pin prick at S4-5 is >= 1\n'
          '  - Deep anal pressure (DAP) is present\n'
          '  - Voluntary anal contraction (VAC) is present\n\n'
          'Sacral sparing present = Incomplete injury\n'
          'No sacral sparing = Complete injury',
        ),
        const SizedBox(height: 12),
        _cardContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Sacral exam findings:',
                  style: AppTheme.displayFont(
                      fontSize: 13, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              _levelSummaryRow(
                  'R S4-5 LT', exam.right.lightTouch.s4_5),
              _levelSummaryRow(
                  'L S4-5 LT', exam.left.lightTouch.s4_5),
              _levelSummaryRow(
                  'R S4-5 PP', exam.right.pinPrick.s4_5),
              _levelSummaryRow(
                  'L S4-5 PP', exam.left.pinPrick.s4_5),
              _levelSummaryRow(
                  'DAP', exam.deepAnalPressure.label),
              _levelSummaryRow(
                  'VAC', exam.voluntaryAnalContraction.label),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Is sacral sparing present?',
          style: AppTheme.displayFont(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _optionButton(
                label: 'Yes (Incomplete)',
                isSelected: _userSacralSparing == true,
                onTap: checked
                    ? null
                    : () => setState(() => _userSacralSparing = true),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _optionButton(
                label: 'No (Complete)',
                isSelected: _userSacralSparing == false,
                onTap: checked
                    ? null
                    : () => setState(() => _userSacralSparing = false),
              ),
            ),
          ],
        ),
        if (checked) ...[
          const SizedBox(height: 16),
          _buildFeedback(
            isCorrect: _userSacralSparing == correctSacralSparing,
            correctAnswer: correctSacralSparing
                ? 'Yes -- Incomplete (sacral sparing present)'
                : 'No -- Complete (no sacral sparing)',
            explanation: correctSacralSparing
                ? 'Sacral sparing is present because at least one of the '
                    'following is true: S4-5 LT or PP >= 1, DAP present, or '
                    'VAC present. This makes the injury INCOMPLETE.'
                : 'No sacral sparing: S4-5 LT and PP are 0 (or NT without DAP), '
                    'DAP is absent, and VAC is absent. This makes the injury '
                    'COMPLETE.',
          ),
        ],
        if (!checked && _userSacralSparing != null) ...[
          const SizedBox(height: 20),
          _checkAnswerButton(4),
        ],
      ],
    );
  }

  // --- Step 5: AIS Grade ---

  Widget _buildStep5AIS() {
    final correctAIS = _result.classification.asiaImpairmentScale;
    final checked = _stepChecked[5] == true;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('Determine the AIS Grade'),
        _infoBox(
          'AIS A: No sacral sparing (complete)\n'
          'AIS B: Sensory but NOT motor incomplete\n'
          'AIS C: Motor incomplete, <50% of key muscles below NLI >= 3\n'
          'AIS D: Motor incomplete, >= 50% of key muscles below NLI >= 3\n'
          'AIS E: Normal motor and sensory function',
        ),
        const SizedBox(height: 16),
        Text(
          'Select the AIS Grade:',
          style: AppTheme.displayFont(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: ['A', 'B', 'C', 'D', 'E'].map((grade) {
            return _optionButton(
              label: 'AIS $grade',
              isSelected: _userAIS == grade,
              onTap: checked ? null : () => setState(() => _userAIS = grade),
              width: 80,
            );
          }).toList(),
        ),
        if (checked) ...[
          const SizedBox(height: 16),
          _buildFeedback(
            isCorrect: _isCorrectAnswer(_userAIS, correctAIS),
            correctAnswer: 'AIS $correctAIS',
            explanation: _buildAISExplanation(),
          ),
        ],
        if (!checked && _userAIS != null) ...[
          const SizedBox(height: 20),
          _checkAnswerButton(5),
        ],
      ],
    );
  }

  String _buildAISExplanation() {
    final ais = _result.classification.asiaImpairmentScale;
    final buf = StringBuffer();
    buf.writeln('Algorithm walkthrough:');
    buf.writeln('1. Check sacral sparing (S4-5 sensation, DAP, VAC).');

    if (ais.contains('A')) {
      buf.writeln('   -> No sacral sparing found. Injury is COMPLETE.');
      buf.writeln('2. AIS A (Complete). ZPP should be determined.');
    } else if (ais.contains('E')) {
      buf.writeln('   -> All motor and sensory function is normal.');
      buf.writeln('2. AIS E (Normal).');
    } else {
      buf.writeln('   -> Sacral sparing present. Injury is INCOMPLETE.');
      buf.writeln('2. Is there motor function below the NLI?');
      buf.writeln('   (VAC present OR motor >3 levels below motor level?)');

      if (ais.contains('B') && !ais.contains('C') && !ais.contains('D')) {
        buf.writeln('   -> No motor incomplete criteria met.');
        buf.writeln('3. AIS B (Sensory Incomplete).');
      } else {
        buf.writeln('   -> Motor incomplete criteria met.');
        buf.writeln('3. Count key muscles below single NLI with grade >= 3:');
        if (ais.contains('C') && !ais.contains('D')) {
          buf.writeln('   -> Less than 50% have grade >= 3.');
          buf.writeln('4. AIS C (Motor Incomplete).');
        } else if (ais.contains('D') && !ais.contains('C')) {
          buf.writeln('   -> 50% or more have grade >= 3.');
          buf.writeln('4. AIS D (Motor Incomplete).');
        } else {
          buf.writeln('   -> Result: AIS $ais');
        }
      }
    }
    return buf.toString();
  }

  // --- Step 6: Summary ---

  Widget _buildStep6Summary() {
    final classification = _result.classification;
    final levels = classification.neurologicalLevels;
    final zpp = classification.zoneOfPartialPreservation;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader('Results Summary'),
        _cardContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _summaryRow('R Sensory Level', _userSensoryRight, levels.sensoryRight),
              _summaryRow('L Sensory Level', _userSensoryLeft, levels.sensoryLeft),
              _summaryRow('R Motor Level', _userMotorRight, levels.motorRight),
              _summaryRow('L Motor Level', _userMotorLeft, levels.motorLeft),
              const Divider(color: AppTheme.borderSubtle),
              _summaryRow('NLI', _userNLI, classification.neurologicalLevelOfInjury),
              _summaryRow(
                'Sacral Sparing',
                _userSacralSparing == null
                    ? null
                    : _userSacralSparing! ? 'Yes' : 'No',
                classification.injuryComplete.contains('I') ? 'Yes' : 'No',
              ),
              _summaryRow('AIS Grade', _userAIS, classification.asiaImpairmentScale),
              const Divider(color: AppTheme.borderSubtle),
              _summaryRow('Completeness', null, classification.injuryComplete == 'C'
                  ? 'Complete' : classification.injuryComplete == 'I'
                  ? 'Incomplete' : classification.injuryComplete),
              if (classification.asiaImpairmentScale.contains('A')) ...[
                _summaryRow('ZPP Sensory R', null, zpp.sensoryRight),
                _summaryRow('ZPP Sensory L', null, zpp.sensoryLeft),
                _summaryRow('ZPP Motor R', null, zpp.motorRight),
                _summaryRow('ZPP Motor L', null, zpp.motorLeft),
              ],
            ],
          ),
        ),
        const SizedBox(height: 16),
        _sectionHeader('Teaching Points'),
        _cardContainer(
          child: Text(
            widget.trainingCase.teachingPoints,
            style: AppTheme.bodyFont(fontSize: 14, height: 1.6),
          ),
        ),
        const SizedBox(height: 16),
        _sectionHeader('Score Totals'),
        _buildTotalsCard(),
        const SizedBox(height: 24),
        Center(
          child: ElevatedButton.icon(
            onPressed: () => Navigator.pop(context, true),
            icon: const Icon(Icons.check_circle_outline, size: 18),
            label: const Text('Complete Case'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.successGreen,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _summaryRow(String label, String? userAnswer, String correctAnswer) {
    final isCorrect = userAnswer == null ||
        _isCorrectAnswer(userAnswer, correctAnswer);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(label,
                style: AppTheme.bodyFont(
                    fontSize: 12, color: AppTheme.textSecondary)),
          ),
          if (userAnswer != null) ...[
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Icon(
                    isCorrect ? Icons.check_circle : Icons.cancel,
                    size: 14,
                    color: isCorrect ? AppTheme.successGreen : AppTheme.dangerRed,
                  ),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      userAnswer,
                      style: AppTheme.monoFont(
                        fontSize: 12,
                        color: isCorrect
                            ? AppTheme.successGreen
                            : AppTheme.dangerRed,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          Expanded(
            flex: 2,
            child: Text(
              correctAnswer,
              style: AppTheme.monoFont(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppTheme.accentTeal,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalsCard() {
    final totals = _result.totals;
    return _cardContainer(
      child: Column(
        children: [
          Row(
            children: [
              _tableHeaderCell('', flex: 3),
              _tableHeaderCell('Right'),
              _tableHeaderCell('Left'),
              _tableHeaderCell('Total'),
            ],
          ),
          const Divider(height: 1, color: AppTheme.borderSubtle),
          _totalsRow('UE Motor', totals.right.upperExtremity,
              totals.left.upperExtremity, totals.upperExtremity),
          _totalsRow('LE Motor', totals.right.lowerExtremity,
              totals.left.lowerExtremity, totals.lowerExtremity),
          _totalsRow('Light Touch', totals.right.lightTouch,
              totals.left.lightTouch, totals.lightTouch),
          _totalsRow('Pin Prick', totals.right.pinPrick,
              totals.left.pinPrick, totals.pinPrick),
        ],
      ),
    );
  }

  Widget _totalsRow(String label, String right, String left, String total) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(label,
                style: AppTheme.bodyFont(
                    fontSize: 12, color: AppTheme.textSecondary)),
          ),
          Expanded(
            child: Text(right,
                textAlign: TextAlign.center,
                style: AppTheme.monoFont(fontSize: 12)),
          ),
          Expanded(
            child: Text(left,
                textAlign: TextAlign.center,
                style: AppTheme.monoFont(fontSize: 12)),
          ),
          Expanded(
            child: Text(total,
                textAlign: TextAlign.center,
                style: AppTheme.monoFont(
                    fontSize: 12, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // Bottom bar
  // --------------------------------------------------------------------------

  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 10,
        bottom: MediaQuery.of(context).padding.bottom + 10,
      ),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        border: Border(top: BorderSide(color: AppTheme.borderSubtle)),
      ),
      child: Row(
        children: [
          if (_currentStep > 0)
            TextButton.icon(
              onPressed: () => setState(() => _currentStep--),
              icon: const Icon(Icons.arrow_back, size: 16),
              label: const Text('Back'),
              style: TextButton.styleFrom(
                foregroundColor: AppTheme.textSecondary,
              ),
            ),
          const Spacer(),
          if (_currentStep < 6 && (_stepChecked[_currentStep] == true || _currentStep == 0))
            ElevatedButton.icon(
              onPressed: () => setState(() => _currentStep++),
              icon: const Icon(Icons.arrow_forward, size: 16),
              label: Text(_currentStep == 0 ? 'Begin Classification' : 'Next Step'),
            ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // Shared UI components
  // --------------------------------------------------------------------------

  Widget _sectionHeader(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: AppTheme.displayFont(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _cardContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.borderSubtle),
      ),
      child: child,
    );
  }

  Widget _tableHeaderCell(String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        child: Text(
          text,
          style: AppTheme.displayFont(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: AppTheme.textSecondary,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget _infoBox(String text) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.accentTeal.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
            color: AppTheme.accentTeal.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline,
              size: 16,
              color: AppTheme.accentTeal.withValues(alpha: 0.7)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: AppTheme.bodyFont(
                fontSize: 13,
                color: AppTheme.textPrimary,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLevelDropdown({
    required String label,
    required String? value,
    required ValueChanged<String?>? onChanged,
  }) {
    return _cardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: AppTheme.displayFont(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textSecondary)),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            initialValue: value,
            hint: Text('Select level',
                style: AppTheme.bodyFont(
                    fontSize: 14, color: AppTheme.textSecondary)),
            isExpanded: true,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: AppTheme.borderSubtle),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: AppTheme.borderSubtle),
              ),
            ),
            items: _levelDropdownItems.map((level) {
              return DropdownMenuItem(
                value: level,
                child: Text(level,
                    style: AppTheme.monoFont(fontSize: 14)),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _optionButton({
    required String label,
    required bool isSelected,
    VoidCallback? onTap,
    double? width,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.accentTeal.withValues(alpha: 0.1)
              : AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppTheme.accentTeal : AppTheme.borderSubtle,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: AppTheme.displayFont(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? AppTheme.accentTeal : AppTheme.textPrimary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _checkAnswerButton(int step) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          bool correct;
          switch (step) {
            case 1:
              correct = _isCorrectAnswer(
                      _userSensoryRight,
                      _result.classification.neurologicalLevels.sensoryRight) &&
                  _isCorrectAnswer(
                      _userSensoryLeft,
                      _result.classification.neurologicalLevels.sensoryLeft);
              break;
            case 2:
              correct = _isCorrectAnswer(
                      _userMotorRight,
                      _result.classification.neurologicalLevels.motorRight) &&
                  _isCorrectAnswer(
                      _userMotorLeft,
                      _result.classification.neurologicalLevels.motorLeft);
              break;
            case 3:
              correct = _isCorrectAnswer(
                  _userNLI,
                  _result.classification.neurologicalLevelOfInjury);
              break;
            case 4:
              final correctSacralSparing =
                  _result.classification.injuryComplete.contains('I');
              correct = _userSacralSparing == correctSacralSparing;
              break;
            case 5:
              correct = _isCorrectAnswer(
                  _userAIS, _result.classification.asiaImpairmentScale);
              break;
            default:
              correct = false;
          }
          setState(() {
            _stepChecked[step] = true;
            _stepCorrect[step] = correct;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryNavy,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        ),
        child: const Text('Check Answer'),
      ),
    );
  }

  Widget _buildFeedback({
    required bool isCorrect,
    required String correctAnswer,
    required String explanation,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isCorrect
            ? AppTheme.successGreen.withValues(alpha: 0.06)
            : AppTheme.dangerRed.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isCorrect
              ? AppTheme.successGreen.withValues(alpha: 0.3)
              : AppTheme.dangerRed.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isCorrect ? Icons.check_circle : Icons.cancel,
                size: 20,
                color: isCorrect ? AppTheme.successGreen : AppTheme.dangerRed,
              ),
              const SizedBox(width: 8),
              Text(
                isCorrect ? 'Correct!' : 'Incorrect',
                style: AppTheme.displayFont(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: isCorrect
                      ? AppTheme.successGreen
                      : AppTheme.dangerRed,
                ),
              ),
            ],
          ),
          if (!isCorrect) ...[
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                style: AppTheme.bodyFont(fontSize: 13),
                children: [
                  TextSpan(
                    text: 'Correct answer: ',
                    style: AppTheme.displayFont(
                        fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  TextSpan(
                    text: correctAnswer,
                    style: AppTheme.monoFont(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.accentTeal,
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 8),
          Text(
            explanation,
            style: AppTheme.bodyFont(
              fontSize: 13,
              color: AppTheme.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
