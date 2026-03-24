import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/isncsci/isncsci_algorithm.dart';
import '../../../core/isncsci/isncsci_exam_model.dart';
import '../../../core/isncsci/isncsci_result_model.dart';
import '../../../core/isncsci/isncsci_constants.dart';
import '../../../data/isncsci_training_cases.dart';

// ============================================================================
// Visual ISNCSCI Worksheet Widget
// ============================================================================

/// An interactive digital replica of the ASIA ISNCSCI worksheet form.
///
/// Provides bilateral motor and sensory score entry for all dermatome levels,
/// sacral exam toggles (DAP/VAC), and real-time ISNCSCI classification.
class ISNCSCIWorksheet extends StatefulWidget {
  const ISNCSCIWorksheet({super.key});

  @override
  State<ISNCSCIWorksheet> createState() => _ISNCSCIWorksheetState();
}

class _ISNCSCIWorksheetState extends State<ISNCSCIWorksheet> {
  // ── Score state ──────────────────────────────────────────────────────────
  // Motor: only key muscle levels C5-T1, L2-S1
  late Map<String, String> _rightMotor;
  late Map<String, String> _leftMotor;
  // Sensory: all levels C2-S4_5
  late Map<String, String> _rightLightTouch;
  late Map<String, String> _leftLightTouch;
  late Map<String, String> _rightPinPrick;
  late Map<String, String> _leftPinPrick;
  // Sacral exam
  BinaryObservation _dap = BinaryObservation.yes;
  BinaryObservation _vac = BinaryObservation.yes;
  String? _rightLowestNonKey;
  String? _leftLowestNonKey;

  // Classification result
  ISNCSCIResult? _result;
  bool _resultsPanelExpanded = true;

  // Loaded case info
  ISNCSCITrainingCase? _loadedCase;

  // Tap-cycle motor values (simplified set for quick entry)
  static const _motorCycleValues = ['5', '4', '3', '2', '1', '0', 'NT'];
  static const _sensoryCycleValues = ['2', '1', '0', 'NT'];

  // Full option lists for long-press popup
  static const _motorPopupValues = [
    '5', '4', '3', '2', '1', '0',
    '4*', '3*', '2*', '1*', '0*',
    '4**', '3**', '2**', '1**', '0**',
    'NT', 'NT*', 'NT**',
  ];
  static const _sensoryPopupValues = [
    '2', '1', '0',
    '1*', '0*',
    '1**', '0**',
    'NT', 'NT*', 'NT**',
  ];

  // Short muscle names for the grid
  static const _shortMuscleNames = <String, String>{
    'C5': 'Elbow flex',
    'C6': 'Wrist ext',
    'C7': 'Elbow ext',
    'C8': 'Finger flex',
    'T1': 'Finger abd',
    'L2': 'Hip flex',
    'L3': 'Knee ext',
    'L4': 'Ankle DF',
    'L5': 'Toe ext',
    'S1': 'Ankle PF',
  };

  @override
  void initState() {
    super.initState();
    _resetToNormal();
  }

  // ── Initialization helpers ───────────────────────────────────────────────

  void _resetToNormal() {
    _rightMotor = {for (final l in motorLevels) l: '5'};
    _leftMotor = {for (final l in motorLevels) l: '5'};
    _rightLightTouch = {for (final l in sensoryExamLevels) l: '2'};
    _leftLightTouch = {for (final l in sensoryExamLevels) l: '2'};
    _rightPinPrick = {for (final l in sensoryExamLevels) l: '2'};
    _leftPinPrick = {for (final l in sensoryExamLevels) l: '2'};
    _dap = BinaryObservation.yes;
    _vac = BinaryObservation.yes;
    _rightLowestNonKey = null;
    _leftLowestNonKey = null;
    _loadedCase = null;
    _recalculate();
  }

  void _setAllAbsent() {
    _rightMotor = {for (final l in motorLevels) l: '0'};
    _leftMotor = {for (final l in motorLevels) l: '0'};
    _rightLightTouch = {for (final l in sensoryExamLevels) l: '0'};
    _leftLightTouch = {for (final l in sensoryExamLevels) l: '0'};
    _rightPinPrick = {for (final l in sensoryExamLevels) l: '0'};
    _leftPinPrick = {for (final l in sensoryExamLevels) l: '0'};
    _dap = BinaryObservation.no;
    _vac = BinaryObservation.no;
    _rightLowestNonKey = null;
    _leftLowestNonKey = null;
    _loadedCase = null;
    _recalculate();
  }

  void _loadCase(ISNCSCITrainingCase tc) {
    final exam = tc.exam;
    // Motor
    for (final l in motorLevels) {
      _rightMotor[l] = exam.right.motor[l];
      _leftMotor[l] = exam.left.motor[l];
    }
    // Sensory
    for (final l in sensoryExamLevels) {
      _rightLightTouch[l] = exam.right.lightTouch[l];
      _leftLightTouch[l] = exam.left.lightTouch[l];
      _rightPinPrick[l] = exam.right.pinPrick[l];
      _leftPinPrick[l] = exam.left.pinPrick[l];
    }
    _dap = exam.deepAnalPressure;
    _vac = exam.voluntaryAnalContraction;
    _rightLowestNonKey = exam.right.lowestNonKeyMuscleWithMotorFunction;
    _leftLowestNonKey = exam.left.lowestNonKeyMuscleWithMotorFunction;
    _loadedCase = tc;
    _recalculate();
  }

  // ── Build Exam and classify ──────────────────────────────────────────────

  Exam _buildExam() {
    Motor buildMotor(Map<String, String> m) => Motor(
          c5: m['C5']!, c6: m['C6']!, c7: m['C7']!,
          c8: m['C8']!, t1: m['T1']!,
          l2: m['L2']!, l3: m['L3']!, l4: m['L4']!,
          l5: m['L5']!, s1: m['S1']!,
        );
    Sensory buildSensory(Map<String, String> s) => Sensory(
          c2: s['C2']!, c3: s['C3']!, c4: s['C4']!,
          c5: s['C5']!, c6: s['C6']!, c7: s['C7']!, c8: s['C8']!,
          t1: s['T1']!, t2: s['T2']!, t3: s['T3']!, t4: s['T4']!,
          t5: s['T5']!, t6: s['T6']!, t7: s['T7']!, t8: s['T8']!,
          t9: s['T9']!, t10: s['T10']!, t11: s['T11']!, t12: s['T12']!,
          l1: s['L1']!, l2: s['L2']!, l3: s['L3']!, l4: s['L4']!,
          l5: s['L5']!, s1: s['S1']!, s2: s['S2']!, s3: s['S3']!,
          s4_5: s['S4_5']!,
        );

    return Exam(
      right: ExamSide(
        motor: buildMotor(_rightMotor),
        lightTouch: buildSensory(_rightLightTouch),
        pinPrick: buildSensory(_rightPinPrick),
        lowestNonKeyMuscleWithMotorFunction: _rightLowestNonKey,
      ),
      left: ExamSide(
        motor: buildMotor(_leftMotor),
        lightTouch: buildSensory(_leftLightTouch),
        pinPrick: buildSensory(_leftPinPrick),
        lowestNonKeyMuscleWithMotorFunction: _leftLowestNonKey,
      ),
      deepAnalPressure: _dap,
      voluntaryAnalContraction: _vac,
    );
  }

  void _recalculate() {
    try {
      final exam = _buildExam();
      _result = calculateISNCSCI(exam);
    } catch (_) {
      _result = null;
    }
    if (mounted) setState(() {});
  }

  // ── Score cycling ────────────────────────────────────────────────────────

  void _cycleMotor(Map<String, String> map, String level) {
    final current = map[level]!;
    final idx = _motorCycleValues.indexOf(current);
    map[level] = _motorCycleValues[(idx + 1) % _motorCycleValues.length];
    _recalculate();
  }

  void _cycleSensory(Map<String, String> map, String level) {
    final current = map[level]!;
    final idx = _sensoryCycleValues.indexOf(current);
    map[level] = _sensoryCycleValues[(idx + 1) % _sensoryCycleValues.length];
    _recalculate();
  }

  void _showMotorPopup(
      BuildContext context, Map<String, String> map, String level) {
    _showValuePopup(context, map, level, _motorPopupValues);
  }

  void _showSensoryPopup(
      BuildContext context, Map<String, String> map, String level) {
    _showValuePopup(context, map, level, _sensoryPopupValues);
  }

  void _showValuePopup(BuildContext context, Map<String, String> map,
      String level, List<String> options) {
    final current = map[level];
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                'Set $level Score',
                style: AppTheme.displayFont(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Divider(height: 1, color: AppTheme.borderSubtle),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: options.map((val) {
                  final selected = val == current;
                  return GestureDetector(
                    onTap: () {
                      map[level] = val;
                      _recalculate();
                      Navigator.pop(ctx);
                    },
                    child: Container(
                      width: 52,
                      height: 40,
                      decoration: BoxDecoration(
                        color: selected
                            ? AppTheme.accentTeal
                            : AppTheme.surfaceLight,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: selected
                              ? AppTheme.accentTeal
                              : AppTheme.borderSubtle,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        val,
                        style: AppTheme.monoFont(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: selected ? Colors.white : AppTheme.textPrimary,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // ── Color helpers ────────────────────────────────────────────────────────

  Color _sensoryColor(String value) {
    final base = value.replaceAll('*', '');
    if (base == '0' || base == 'NT') return AppTheme.dangerRed.withValues(alpha: 0.12);
    if (base == '1') return AppTheme.warningAmber.withValues(alpha: 0.12);
    return AppTheme.successGreen.withValues(alpha: 0.10);
  }

  Color _motorColor(String value) {
    final base = value.replaceAll('*', '');
    if (base == 'NT' || base == '0') return AppTheme.dangerRed.withValues(alpha: 0.12);
    if (base == '1' || base == '2') return AppTheme.dangerRed.withValues(alpha: 0.08);
    if (base == '3') return AppTheme.warningAmber.withValues(alpha: 0.12);
    if (base == '4') return AppTheme.warningAmber.withValues(alpha: 0.08);
    return AppTheme.successGreen.withValues(alpha: 0.10);
  }

  Color _sensoryTextColor(String value) {
    final base = value.replaceAll('*', '');
    if (base == '0' || base == 'NT') return AppTheme.dangerRed;
    if (base == '1') return const Color(0xFF9A6F00);
    return AppTheme.successGreen;
  }

  Color _motorTextColor(String value) {
    final base = value.replaceAll('*', '');
    if (base == 'NT' || base == '0' || base == '1' || base == '2') {
      return AppTheme.dangerRed;
    }
    if (base == '3' || base == '4') return const Color(0xFF9A6F00);
    return AppTheme.successGreen;
  }

  // ── AIS color ────────────────────────────────────────────────────────────

  Color _aisColor(String ais) {
    final first = ais.split(',').first.replaceAll('*', '').trim();
    switch (first) {
      case 'A':
        return AppTheme.dangerRed;
      case 'B':
        return const Color(0xFFD4650F);
      case 'C':
        return AppTheme.warningAmber;
      case 'D':
        return AppTheme.successGreen;
      case 'E':
        return const Color(0xFF2E6BD6);
      default:
        return AppTheme.textSecondary;
    }
  }

  // ── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surfaceLight,
      body: Column(
        children: [
          // Main scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(),
                  if (_loadedCase != null) _buildCaseBanner(),
                  const SizedBox(height: 8),
                  _buildQuickActions(),
                  const SizedBox(height: 12),
                  _buildScoreGrid(),
                  const SizedBox(height: 12),
                  _buildSacralExam(),
                  const SizedBox(height: 12),
                  _buildResultsPanel(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Header ───────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: Column(
        children: [
          Text(
            'ISNCSCI EXAMINATION WORKSHEET',
            style: AppTheme.displayFont(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppTheme.primaryNavy,
              letterSpacing: 0.8,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            'International Standards for Neurological Classification of SCI',
            style: AppTheme.bodyFont(
              fontSize: 11,
              color: AppTheme.textSecondary,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ── Case banner ──────────────────────────────────────────────────────────

  Widget _buildCaseBanner() {
    final tc = _loadedCase!;
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppTheme.accentTeal.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppTheme.accentTeal.withValues(alpha: 0.3)),
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
                  color: AppTheme.accentTeal,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(
                  tc.difficulty.toUpperCase(),
                  style: AppTheme.monoFont(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  tc.title,
                  style: AppTheme.displayFont(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _loadedCase = null),
                child: const Icon(Icons.close, size: 16,
                    color: AppTheme.textSecondary),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            tc.clinicalScenario,
            style: AppTheme.bodyFont(
              fontSize: 11,
              color: AppTheme.textPrimary,
              height: 1.4,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // ── Quick actions ────────────────────────────────────────────────────────

  Widget _buildQuickActions() {
    return Row(
      children: [
        _actionButton(
          icon: Icons.folder_open,
          label: 'Load Case',
          onTap: _showCasePicker,
        ),
        const SizedBox(width: 8),
        _actionButton(
          icon: Icons.refresh,
          label: 'Clear All',
          onTap: () => setState(_resetToNormal),
        ),
        const SizedBox(width: 8),
        _actionButton(
          icon: Icons.block,
          label: 'Set Absent',
          onTap: () => setState(_setAllAbsent),
        ),
      ],
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: AppTheme.cardBackground,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppTheme.borderSubtle),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 14, color: AppTheme.accentTeal),
              const SizedBox(width: 4),
              Text(
                label,
                style: AppTheme.displayFont(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.accentTeal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Case picker modal ────────────────────────────────────────────────────

  void _showCasePicker() {
    final cases = ISNCSCITrainingCases.allCases;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.4,
        expand: false,
        builder: (_, controller) => Column(
          children: [
            const SizedBox(height: 8),
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.borderSubtle,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                'LOAD TRAINING CASE',
                style: AppTheme.displayFont(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const Divider(height: 1, color: AppTheme.borderSubtle),
            Expanded(
              child: ListView.separated(
                controller: controller,
                itemCount: cases.length,
                separatorBuilder: (_, _) =>
                    const Divider(height: 1, color: AppTheme.borderSubtle),
                itemBuilder: (_, i) {
                  final tc = cases[i];
                  final diffColor = tc.difficulty == 'basic'
                      ? AppTheme.successGreen
                      : tc.difficulty == 'intermediate'
                          ? AppTheme.warningAmber
                          : AppTheme.dangerRed;
                  return ListTile(
                    dense: true,
                    leading: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: diffColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    title: Text(
                      tc.title,
                      style: AppTheme.displayFont(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      tc.clinicalScenario,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.bodyFont(
                        fontSize: 11,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    trailing: Text(
                      tc.difficulty.toUpperCase(),
                      style: AppTheme.monoFont(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        color: diffColor,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(ctx);
                      setState(() => _loadCase(tc));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Main score grid ──────────────────────────────────────────────────────

  Widget _buildScoreGrid() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppTheme.borderSubtle),
      ),
      child: Column(
        children: [
          // Column headers
          _buildGridHeader(),
          const Divider(height: 1, color: AppTheme.borderSubtle),
          // Each level row
          ...sensoryExamLevels.asMap().entries.map((entry) {
            final i = entry.key;
            final level = entry.value;
            final isMotorLevel = motorLevels.contains(level);
            final isEven = i.isEven;
            return _buildLevelRow(level, isMotorLevel, isEven);
          }),
        ],
      ),
    );
  }

  Widget _buildGridHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.primaryNavy,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
      ),
      child: Row(
        children: [
          // RIGHT side header
          _headerLabel('MOTOR', 42),
          _headerLabel('LT', 36),
          _headerLabel('PP', 36),
          // Center level
          const Expanded(
            child: Center(
              child: Text(
                'LEVEL',
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  color: Colors.white70,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          // LEFT side header
          _headerLabel('PP', 36),
          _headerLabel('LT', 36),
          _headerLabel('MOTOR', 42),
        ],
      ),
    );
  }

  Widget _headerLabel(String text, double width) {
    return SizedBox(
      width: width,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w700,
            color: Colors.white70,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }

  Widget _buildLevelRow(String level, bool isMotorLevel, bool isEven) {
    // Display label: "S4_5" -> "S4-5"
    final displayLevel = level.replaceAll('_', '-');
    final muscleName = isMotorLevel ? _shortMuscleNames[level] : null;

    return Container(
      decoration: BoxDecoration(
        color: isEven ? Colors.transparent : AppTheme.surfaceMuted.withValues(alpha: 0.4),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // RIGHT motor
            _buildMotorCell(
              isMotorLevel ? _rightMotor : null,
              level,
              isRight: true,
            ),
            // RIGHT light touch
            _buildSensoryCell(_rightLightTouch, level),
            // RIGHT pin prick
            _buildSensoryCell(_rightPinPrick, level),
            // CENTER level label
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      displayLevel,
                      style: AppTheme.monoFont(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.primaryNavy,
                      ),
                    ),
                    if (muscleName != null)
                      Text(
                        muscleName,
                        style: AppTheme.bodyFont(
                          fontSize: 8,
                          color: AppTheme.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
              ),
            ),
            // LEFT pin prick
            _buildSensoryCell(_leftPinPrick, level),
            // LEFT light touch
            _buildSensoryCell(_leftLightTouch, level),
            // LEFT motor
            _buildMotorCell(
              isMotorLevel ? _leftMotor : null,
              level,
              isRight: false,
            ),
          ],
        ),
      ),
    );
  }

  // ── Score cells ──────────────────────────────────────────────────────────

  Widget _buildMotorCell(Map<String, String>? map, String level,
      {required bool isRight}) {
    if (map == null) {
      // Non-motor level: empty cell
      return const SizedBox(width: 42, height: 34);
    }
    final value = map[level]!;
    return GestureDetector(
      onTap: () => _cycleMotor(map, level),
      onLongPress: () => _showMotorPopup(context, map, level),
      child: Container(
        width: 42,
        height: 34,
        margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 1),
        decoration: BoxDecoration(
          color: _motorColor(value),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: _motorTextColor(value).withValues(alpha: 0.25),
            width: 0.5,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          value,
          style: AppTheme.monoFont(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: _motorTextColor(value),
          ),
        ),
      ),
    );
  }

  Widget _buildSensoryCell(Map<String, String> map, String level) {
    final value = map[level]!;
    return GestureDetector(
      onTap: () => _cycleSensory(map, level),
      onLongPress: () => _showSensoryPopup(context, map, level),
      child: Container(
        width: 36,
        height: 34,
        margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 1),
        decoration: BoxDecoration(
          color: _sensoryColor(value),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: _sensoryTextColor(value).withValues(alpha: 0.25),
            width: 0.5,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          value,
          style: AppTheme.monoFont(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: _sensoryTextColor(value),
          ),
        ),
      ),
    );
  }

  // ── Sacral exam section ──────────────────────────────────────────────────

  Widget _buildSacralExam() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppTheme.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SACRAL EXAMINATION',
            style: AppTheme.displayFont(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppTheme.primaryNavy,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _buildBinaryToggle(
                  label: 'DAP (Deep Anal Pressure)',
                  value: _dap,
                  onChanged: (v) {
                    _dap = v;
                    _recalculate();
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildBinaryToggle(
                  label: 'VAC (Voluntary Anal Contraction)',
                  value: _vac,
                  onChanged: (v) {
                    _vac = v;
                    _recalculate();
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Lowest Non-Key Muscle with Motor Function',
            style: AppTheme.bodyFont(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: _buildNonKeyDropdown(
                  label: 'Right',
                  value: _rightLowestNonKey,
                  onChanged: (v) {
                    _rightLowestNonKey = v;
                    _recalculate();
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildNonKeyDropdown(
                  label: 'Left',
                  value: _leftLowestNonKey,
                  onChanged: (v) {
                    _leftLowestNonKey = v;
                    _recalculate();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBinaryToggle({
    required String label,
    required BinaryObservation value,
    required ValueChanged<BinaryObservation> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.bodyFont(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: BinaryObservation.values.map((opt) {
            final selected = opt == value;
            Color bg;
            Color fg;
            if (!selected) {
              bg = AppTheme.surfaceLight;
              fg = AppTheme.textSecondary;
            } else if (opt == BinaryObservation.yes) {
              bg = AppTheme.successGreen;
              fg = Colors.white;
            } else if (opt == BinaryObservation.no) {
              bg = AppTheme.dangerRed;
              fg = Colors.white;
            } else {
              bg = AppTheme.warningAmber;
              fg = Colors.white;
            }
            return Padding(
              padding: const EdgeInsets.only(right: 6),
              child: GestureDetector(
                onTap: () => onChanged(opt),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: bg,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: selected
                          ? bg
                          : AppTheme.borderSubtle,
                    ),
                  ),
                  child: Text(
                    opt.label,
                    style: AppTheme.monoFont(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: fg,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildNonKeyDropdown({
    required String label,
    required String? value,
    required ValueChanged<String?> onChanged,
  }) {
    // Available levels for non-key muscle
    final options = <String?>[null, ...sensoryExamLevels];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.monoFont(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: AppTheme.textSecondary,
          ),
        ),
        const SizedBox(height: 2),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: AppTheme.surfaceLight,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: AppTheme.borderSubtle),
          ),
          child: DropdownButton<String?>(
            value: value,
            isExpanded: true,
            underline: const SizedBox(),
            isDense: true,
            style: AppTheme.monoFont(
              fontSize: 12,
              color: AppTheme.textPrimary,
            ),
            items: options.map((l) {
              return DropdownMenuItem<String?>(
                value: l,
                child: Text(
                  l?.replaceAll('_', '-') ?? 'None',
                  style: AppTheme.monoFont(
                    fontSize: 12,
                    color: l != null
                        ? AppTheme.textPrimary
                        : AppTheme.textSecondary,
                  ),
                ),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  // ── Results panel ────────────────────────────────────────────────────────

  Widget _buildResultsPanel() {
    final result = _result;
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppTheme.borderSubtle),
      ),
      child: Column(
        children: [
          // Header bar (collapsible toggle)
          GestureDetector(
            onTap: () =>
                setState(() => _resultsPanelExpanded = !_resultsPanelExpanded),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: AppTheme.primaryNavy,
                borderRadius: BorderRadius.vertical(
                  top: const Radius.circular(5),
                  bottom: _resultsPanelExpanded
                      ? Radius.zero
                      : const Radius.circular(5),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.analytics_outlined,
                      size: 16, color: Colors.white70),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'CLASSIFICATION RESULTS',
                      style: AppTheme.displayFont(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  if (result != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: _aisColor(
                            result.classification.asiaImpairmentScale),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'AIS ${result.classification.asiaImpairmentScale}',
                        style: AppTheme.monoFont(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  const SizedBox(width: 8),
                  Icon(
                    _resultsPanelExpanded
                        ? Icons.expand_less
                        : Icons.expand_more,
                    size: 18,
                    color: Colors.white70,
                  ),
                ],
              ),
            ),
          ),
          if (_resultsPanelExpanded && result != null) _buildResultsBody(result),
        ],
      ),
    );
  }

  Widget _buildResultsBody(ISNCSCIResult result) {
    final c = result.classification;
    final t = result.totals;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          // AIS Grade — large
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: _aisColor(c.asiaImpairmentScale).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: _aisColor(c.asiaImpairmentScale).withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              children: [
                Text(
                  'AIS Grade',
                  style: AppTheme.bodyFont(
                    fontSize: 10,
                    color: AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  c.asiaImpairmentScale,
                  style: AppTheme.monoFont(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: _aisColor(c.asiaImpairmentScale),
                  ),
                ),
                Text(
                  c.injuryComplete == 'C'
                      ? 'Complete'
                      : c.injuryComplete == 'I'
                          ? 'Incomplete'
                          : c.injuryComplete,
                  style: AppTheme.bodyFont(
                    fontSize: 11,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // NLI
          _resultRow('Neurological Level of Injury',
              c.neurologicalLevelOfInjury),
          const SizedBox(height: 8),

          // Sensory / Motor levels
          Row(
            children: [
              Expanded(
                child: _resultColumn('Sensory Level',
                    'R: ${c.neurologicalLevels.sensoryRight}',
                    'L: ${c.neurologicalLevels.sensoryLeft}'),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _resultColumn('Motor Level',
                    'R: ${c.neurologicalLevels.motorRight}',
                    'L: ${c.neurologicalLevels.motorLeft}'),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // ZPP (only meaningful for AIS A)
          if (c.asiaImpairmentScale.contains('A'))
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Expanded(
                    child: _resultColumn(
                      'ZPP Sensory',
                      'R: ${c.zoneOfPartialPreservation.sensoryRight}',
                      'L: ${c.zoneOfPartialPreservation.sensoryLeft}',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _resultColumn(
                      'ZPP Motor',
                      'R: ${c.zoneOfPartialPreservation.motorRight}',
                      'L: ${c.zoneOfPartialPreservation.motorLeft}',
                    ),
                  ),
                ],
              ),
            ),

          // Motor totals
          const Divider(color: AppTheme.borderSubtle),
          const SizedBox(height: 4),
          Text(
            'MOTOR INDEX SCORES',
            style: AppTheme.displayFont(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: AppTheme.textSecondary,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(child: _totalBox('UEMS', t.upperExtremity, '/50')),
              const SizedBox(width: 6),
              Expanded(child: _totalBox('LEMS', t.lowerExtremity, '/50')),
              const SizedBox(width: 6),
              Expanded(
                child: _totalBox(
                  'Total',
                  _addTotals(t.upperExtremity, t.lowerExtremity),
                  '/100',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Sensory totals
          Text(
            'SENSORY SCORES',
            style: AppTheme.displayFont(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: AppTheme.textSecondary,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                  child: _totalBox('Light Touch', t.lightTouch, '/112')),
              const SizedBox(width: 6),
              Expanded(child: _totalBox('Pin Prick', t.pinPrick, '/112')),
              const SizedBox(width: 6),
              Expanded(
                child: _totalBox(
                  'Total',
                  _addTotals(t.lightTouch, t.pinPrick),
                  '/224',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _addTotals(String a, String b) {
    if (a == 'ND' || b == 'ND') return 'ND';
    final ia = int.tryParse(a);
    final ib = int.tryParse(b);
    if (ia == null || ib == null) return 'ND';
    return '${ia + ib}';
  }

  Widget _resultRow(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.surfaceLight,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: AppTheme.bodyFont(
                fontSize: 11,
                color: AppTheme.textSecondary,
              ),
            ),
          ),
          Text(
            value,
            style: AppTheme.monoFont(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppTheme.primaryNavy,
            ),
          ),
        ],
      ),
    );
  }

  Widget _resultColumn(String label, String line1, String line2) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppTheme.surfaceLight,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTheme.bodyFont(
              fontSize: 10,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            line1,
            style: AppTheme.monoFont(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppTheme.primaryNavy,
            ),
          ),
          Text(
            line2,
            style: AppTheme.monoFont(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppTheme.primaryNavy,
            ),
          ),
        ],
      ),
    );
  }

  Widget _totalBox(String label, String value, String max) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      decoration: BoxDecoration(
        color: AppTheme.surfaceLight,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: AppTheme.bodyFont(
              fontSize: 9,
              color: AppTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: AppTheme.monoFont(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.primaryNavy,
                  ),
                ),
                TextSpan(
                  text: max,
                  style: AppTheme.monoFont(
                    fontSize: 10,
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
}
