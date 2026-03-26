import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/isncsci/isncsci_algorithm.dart';
import '../../../core/isncsci/isncsci_constants.dart' as constants;
import '../../../core/isncsci/isncsci_exam_model.dart' as isncsci;

/// Converts a canonical level name (e.g. 'S4_5') to display form ('S4-5').
String _displayLevel(String level) => level.replaceAll('_', '-');

/// Returns the ordinal index for a neurological level string using the
/// canonical level list from isncsci_constants.
/// Lower index = more rostral. Returns -1 if not found.
int _levelIndex(String level) => constants.sensoryLevels.indexOf(level);

/// Interactive ISNCSCI (International Standards for Neurological Classification
/// of Spinal Cord Injury) scoring tool.
///
/// Allows bilateral entry of sensory (light touch and pin prick) scores for 28
/// dermatomes, motor scores for 10 key muscles, DAP and VAC, then
/// auto-calculates sensory levels, motor levels, NLI, AIS grade, ZPP, and
/// composite index scores.
class ISNCSCIScoringTool extends StatefulWidget {
  const ISNCSCIScoringTool({super.key});

  @override
  State<ISNCSCIScoringTool> createState() => _ISNCSCIScoringToolState();
}

class _ISNCSCIScoringToolState extends State<ISNCSCIScoringTool>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  // Sensory scores: level -> score (0, 1, or 2).
  final Map<String, int> _ltRight = {};
  final Map<String, int> _ltLeft = {};
  final Map<String, int> _ppRight = {};
  final Map<String, int> _ppLeft = {};

  // Motor scores: level -> score (0-5).
  final Map<String, int> _motorRight = {};
  final Map<String, int> _motorLeft = {};

  // Sacral exam findings.
  bool _dap = false;
  bool _vac = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _initScores();
  }

  void _initScores() {
    for (final level in constants.sensoryExamLevels) {
      _ltRight[level] = 2;
      _ltLeft[level] = 2;
      _ppRight[level] = 2;
      _ppLeft[level] = 2;
    }
    for (final level in constants.motorLevels) {
      _motorRight[level] = 5;
      _motorLeft[level] = 5;
    }
    _dap = true;
    _vac = true;
  }

  void _resetAll() {
    setState(() {
      _initScores();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Calculation helpers
  // ---------------------------------------------------------------------------

  /// Determines the sensory level on one side for a given modality map.
  /// The sensory level is the most caudal dermatome with a score of 2 where
  /// all levels rostral to it also score 2.
  // ignore: unused_element
  String _sensoryLevel(Map<String, int> scores) {
    String level = 'C1'; // intact above C2 by definition
    for (final s in constants.sensoryExamLevels) {
      if (scores[s] == 2) {
        level = s;
      } else {
        break;
      }
    }
    return level;
  }

  /// Determines the motor level on one side.
  /// The motor level is the lowest key muscle with grade >= 3 provided all
  /// key muscles above it are grade 5, AND sensory is intact (score 2) at
  /// that level for both LT and PP.
  ///
  /// For segments without a testable myotome (e.g. T2-L1), motor level is
  /// presumed to follow sensory level if sensory is intact.
  // ignore: unused_element
  String _motorLevel(
    Map<String, int> motorScores,
    Map<String, int> ltScores,
    Map<String, int> ppScores,
  ) {
    // Walk through all levels using the sensory list as the backbone.
    // Between motor-testable segments, motor function is inferred from sensory.
    final motorKeys = constants.motorLevels.toSet();
    String level = 'C1';

    for (final s in constants.sensoryExamLevels) {
      if (motorKeys.contains(s)) {
        // This level has a testable myotome.
        final motor = motorScores[s] ?? 0;
        if (motor >= 3 && _allAboveMotorNormal(s, motorScores)) {
          level = s;
          if (motor < 5) break; // can't go lower
        } else if (motor < 3) {
          break;
        } else {
          level = s;
        }
      } else {
        // Non-motor-testable segment: infer from sensory.
        if (ltScores[s] == 2 && ppScores[s] == 2) {
          level = s;
        } else {
          break;
        }
      }
    }
    return level;
  }

  /// Returns true if every motor-testable key muscle rostral to [level] scores 5.
  bool _allAboveMotorNormal(String level, Map<String, int> scores) {
    final idx = _levelIndex(level);
    for (final ml in constants.motorLevels) {
      final mi = _levelIndex(ml);
      if (mi < idx) {
        if ((scores[ml] ?? 0) < 5) return false;
      }
    }
    return true;
  }

  /// Determines whether sacral sparing is present.
  // ignore: unused_element
  bool get _sacralSparing {
    // Sensation at S4-5 (LT or PP) on either side, or DAP, or VAC.
    final ltRS45 = _ltRight['S4_5'] ?? 0;
    final ltLS45 = _ltLeft['S4_5'] ?? 0;
    final ppRS45 = _ppRight['S4_5'] ?? 0;
    final ppLS45 = _ppLeft['S4_5'] ?? 0;
    return ltRS45 > 0 || ltLS45 > 0 || ppRS45 > 0 || ppLS45 > 0 || _dap || _vac;
  }

  /// Counts how many key muscles below [nli] have grade >= 3 on both sides.
  // ignore: unused_element
  int _motorBelowWithGrade3OrMore(String nli) {
    final nliIdx = _levelIndex(nli);
    int count = 0;
    for (final ml in constants.motorLevels) {
      final mi = _levelIndex(ml);
      if (mi > nliIdx) {
        if ((_motorRight[ml] ?? 0) >= 3) count++;
        if ((_motorLeft[ml] ?? 0) >= 3) count++;
      }
    }
    return count;
  }

  /// Total number of key muscles below the NLI (both sides).
  // ignore: unused_element
  int _totalMotorBelowNLI(String nli) {
    final nliIdx = _levelIndex(nli);
    int count = 0;
    for (final ml in constants.motorLevels) {
      if (_levelIndex(ml) > nliIdx) {
        count += 2; // left and right
      }
    }
    return count;
  }

  /// Whether motor function exists more than 3 levels below the motor level
  /// on either side.
  // ignore: unused_element
  bool _motorMoreThan3BelowMotorLevel(String motorLevelR, String motorLevelL) {
    bool check(String motorLevel, Map<String, int> scores) {
      final mlIdx = _levelIndex(motorLevel);
      for (final ml in constants.motorLevels) {
        final mi = _levelIndex(ml);
        if (mi > mlIdx + 3) {
          if ((scores[ml] ?? 0) >= 1) return true;
        }
      }
      return false;
    }

    return check(motorLevelR, _motorRight) || check(motorLevelL, _motorLeft);
  }

  /// Converts the widget's internal score maps to a Praxis ISNCSCI Exam object
  /// and runs the validated algorithm to compute classification and totals.
  Map<String, String> _computeResults() {
    // Bridge: convert widget int maps to Praxis string-based Exam model.
    // Widget uses 'S45' key; Praxis uses 'S4_5' field name.
    String s(int? v) => '${v ?? 0}';

    isncsci.Sensory buildSensory(Map<String, int> scores) => isncsci.Sensory(
          c2: s(scores['C2']), c3: s(scores['C3']), c4: s(scores['C4']),
          c5: s(scores['C5']), c6: s(scores['C6']), c7: s(scores['C7']),
          c8: s(scores['C8']), t1: s(scores['T1']), t2: s(scores['T2']),
          t3: s(scores['T3']), t4: s(scores['T4']), t5: s(scores['T5']),
          t6: s(scores['T6']), t7: s(scores['T7']), t8: s(scores['T8']),
          t9: s(scores['T9']), t10: s(scores['T10']), t11: s(scores['T11']),
          t12: s(scores['T12']), l1: s(scores['L1']), l2: s(scores['L2']),
          l3: s(scores['L3']), l4: s(scores['L4']), l5: s(scores['L5']),
          s1: s(scores['S1']), s2: s(scores['S2']), s3: s(scores['S3']),
          s4_5: s(scores['S4_5']),
        );

    isncsci.Motor buildMotor(Map<String, int> scores) => isncsci.Motor(
          c5: s(scores['C5']), c6: s(scores['C6']), c7: s(scores['C7']),
          c8: s(scores['C8']), t1: s(scores['T1']), l2: s(scores['L2']),
          l3: s(scores['L3']), l4: s(scores['L4']), l5: s(scores['L5']),
          s1: s(scores['S1']),
        );

    final exam = isncsci.Exam(
      right: isncsci.ExamSide(
        motor: buildMotor(_motorRight),
        lightTouch: buildSensory(_ltRight),
        pinPrick: buildSensory(_ppRight),
      ),
      left: isncsci.ExamSide(
        motor: buildMotor(_motorLeft),
        lightTouch: buildSensory(_ltLeft),
        pinPrick: buildSensory(_ppLeft),
      ),
      voluntaryAnalContraction:
          _vac ? isncsci.BinaryObservation.yes : isncsci.BinaryObservation.no,
      deepAnalPressure:
          _dap ? isncsci.BinaryObservation.yes : isncsci.BinaryObservation.no,
    );

    // Run the validated Praxis ISNCSCI algorithm.
    final result = calculateISNCSCI(exam);
    final c = result.classification;
    final t = result.totals;

    // Normalize level names: Praxis uses 'S4_5', widget displays 'S4-5'.
    String norm(String level) => level.replaceAll('_', '-');

    // Compute total motor from UE + LE.
    final totalMotor = (t.upperExtremity != 'ND' && t.lowerExtremity != 'ND')
        ? '${int.parse(t.upperExtremity) + int.parse(t.lowerExtremity)}'
        : 'ND';
    final totalSensory = (t.lightTouch != 'ND' && t.pinPrick != 'ND')
        ? '${int.parse(t.lightTouch) + int.parse(t.pinPrick)}'
        : 'ND';

    return {
      'sensoryR': norm(c.neurologicalLevels.sensoryRight),
      'sensoryL': norm(c.neurologicalLevels.sensoryLeft),
      'motorR': norm(c.neurologicalLevels.motorRight),
      'motorL': norm(c.neurologicalLevels.motorLeft),
      'nli': norm(c.neurologicalLevelOfInjury),
      'ais': c.asiaImpairmentScale,
      'zppSensoryR': norm(c.zoneOfPartialPreservation.sensoryRight),
      'zppSensoryL': norm(c.zoneOfPartialPreservation.sensoryLeft),
      'zppMotorR': norm(c.zoneOfPartialPreservation.motorRight),
      'zppMotorL': norm(c.zoneOfPartialPreservation.motorLeft),
      'uems': t.upperExtremity,
      'lems': t.lowerExtremity,
      'totalMotor': totalMotor,
      'totalLT': t.lightTouch,
      'totalPP': t.pinPrick,
      'totalSensory': totalSensory,
    };
  }

  /// Most caudal level with any sensation (LT or PP > 0) below the sensory
  /// level on that side.
  // ignore: unused_element
  String _zppSensory(
    Map<String, int> lt,
    Map<String, int> pp,
    String sensoryLevel,
  ) {
    final slIdx = _levelIndex(sensoryLevel);
    String zpp = sensoryLevel;
    for (final level in constants.sensoryExamLevels) {
      final idx = _levelIndex(level);
      if (idx > slIdx) {
        if ((lt[level] ?? 0) > 0 || (pp[level] ?? 0) > 0) {
          zpp = level;
        }
      }
    }
    return zpp == sensoryLevel ? 'N/A' : zpp;
  }

  /// Most caudal key muscle with any motor (> 0) below the motor level on
  /// that side.
  // ignore: unused_element
  String _zppMotor(Map<String, int> motor, String motorLevel) {
    final mlIdx = _levelIndex(motorLevel);
    String zpp = motorLevel;
    for (final ml in constants.motorLevels) {
      final idx = _levelIndex(ml);
      if (idx > mlIdx) {
        if ((motor[ml] ?? 0) > 0) {
          zpp = ml;
        }
      }
    }
    return zpp == motorLevel ? 'N/A' : zpp;
  }

  // ---------------------------------------------------------------------------
  // UI
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ISNCSCI Scoring Tool'),
        backgroundColor: AppTheme.primaryNavy,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.accentTeal,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          tabs: const [
            Tab(text: 'Sensory'),
            Tab(text: 'Motor'),
            Tab(text: 'Results'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset All',
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Reset All Scores?'),
                  content: const Text(
                    'This will reset all sensory, motor, DAP, and VAC entries to their default (normal) values.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        _resetAll();
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: AppTheme.dangerRed,
                      ),
                      child: const Text('Reset'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _SensoryTab(
            ltRight: _ltRight,
            ltLeft: _ltLeft,
            ppRight: _ppRight,
            ppLeft: _ppLeft,
            dap: _dap,
            vac: _vac,
            onDapChanged: (v) => setState(() => _dap = v),
            onVacChanged: (v) => setState(() => _vac = v),
            onScoreChanged: () => setState(() {}),
          ),
          _MotorTab(
            motorRight: _motorRight,
            motorLeft: _motorLeft,
            onScoreChanged: () => setState(() {}),
          ),
          _ResultsTab(results: _computeResults()),
        ],
      ),
    );
  }
}

// =============================================================================
// Sensory Tab
// =============================================================================

class _SensoryTab extends StatelessWidget {
  const _SensoryTab({
    required this.ltRight,
    required this.ltLeft,
    required this.ppRight,
    required this.ppLeft,
    required this.dap,
    required this.vac,
    required this.onDapChanged,
    required this.onVacChanged,
    required this.onScoreChanged,
  });

  final Map<String, int> ltRight;
  final Map<String, int> ltLeft;
  final Map<String, int> ppRight;
  final Map<String, int> ppLeft;
  final bool dap;
  final bool vac;
  final ValueChanged<bool> onDapChanged;
  final ValueChanged<bool> onVacChanged;
  final VoidCallback onScoreChanged;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const Material(
            color: Color(0xFFE2E8F0),
            child: TabBar(
              indicatorColor: AppTheme.accentTeal,
              labelColor: AppTheme.primaryNavy,
              unselectedLabelColor: AppTheme.textSecondary,
              tabs: [
                Tab(text: 'Light Touch'),
                Tab(text: 'Pin Prick'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _SensoryModality(
                  rightScores: ltRight,
                  leftScores: ltLeft,
                  onScoreChanged: onScoreChanged,
                ),
                _SensoryModality(
                  rightScores: ppRight,
                  leftScores: ppLeft,
                  onScoreChanged: onScoreChanged,
                ),
              ],
            ),
          ),
          _SacralExamBar(
            dap: dap,
            vac: vac,
            onDapChanged: onDapChanged,
            onVacChanged: onVacChanged,
          ),
        ],
      ),
    );
  }
}

class _SensoryModality extends StatelessWidget {
  const _SensoryModality({
    required this.rightScores,
    required this.leftScores,
    required this.onScoreChanged,
  });

  final Map<String, int> rightScores;
  final Map<String, int> leftScores;
  final VoidCallback onScoreChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: AppTheme.primaryNavy.withValues(alpha: 0.05),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: const Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Right',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ),
              SizedBox(
                width: 48,
                child: Text(
                  'Level',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppTheme.primaryNavy,
                    fontSize: 13,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Left',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: constants.sensoryExamLevels.length,
            itemBuilder: (context, index) {
              final level = constants.sensoryExamLevels[index];
              return _SensoryRow(
                level: level,
                rightScore: rightScores[level] ?? 0,
                leftScore: leftScores[level] ?? 0,
                onRightChanged: (v) {
                  rightScores[level] = v;
                  onScoreChanged();
                },
                onLeftChanged: (v) {
                  leftScores[level] = v;
                  onScoreChanged();
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SensoryRow extends StatelessWidget {
  const _SensoryRow({
    required this.level,
    required this.rightScore,
    required this.leftScore,
    required this.onRightChanged,
    required this.onLeftChanged,
  });

  final String level;
  final int rightScore;
  final int leftScore;
  final ValueChanged<int> onRightChanged;
  final ValueChanged<int> onLeftChanged;

  @override
  Widget build(BuildContext context) {
    final isEvenIndex = constants.sensoryExamLevels.indexOf(level).isEven;
    return Container(
      color: isEvenIndex ? Colors.white : const Color(0xFFF8FAFC),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: _ScoreChips(
              score: rightScore,
              maxScore: 2,
              onChanged: onRightChanged,
            ),
          ),
          SizedBox(
            width: 48,
            child: Text(
              _displayLevel(level),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: AppTheme.primaryNavy,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: _ScoreChips(
              score: leftScore,
              maxScore: 2,
              onChanged: onLeftChanged,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Motor Tab
// =============================================================================

class _MotorTab extends StatelessWidget {
  const _MotorTab({
    required this.motorRight,
    required this.motorLeft,
    required this.onScoreChanged,
  });

  final Map<String, int> motorRight;
  final Map<String, int> motorLeft;
  final VoidCallback onScoreChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: AppTheme.primaryNavy.withValues(alpha: 0.05),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: const Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'Right',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                child: Text(
                  'Level',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppTheme.primaryNavy,
                    fontSize: 13,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'Left',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.only(bottom: 16),
            itemCount: constants.motorLevels.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final level = constants.motorLevels[index];
              // Visual separator between upper and lower extremity.
              final showSection = index == 0 || index == 5;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showSection)
                    Container(
                      width: double.infinity,
                      color: AppTheme.accentTeal.withValues(alpha: 0.1),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      child: Text(
                        index == 0
                            ? 'Upper Extremity (UEMS)'
                            : 'Lower Extremity (LEMS)',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          color: AppTheme.accentTeal,
                        ),
                      ),
                    ),
                  _MotorRow(
                    level: level,
                    muscleName: constants.motorLevelToMuscle[level] ?? level,
                    rightScore: motorRight[level] ?? 0,
                    leftScore: motorLeft[level] ?? 0,
                    onRightChanged: (v) {
                      motorRight[level] = v;
                      onScoreChanged();
                    },
                    onLeftChanged: (v) {
                      motorLeft[level] = v;
                      onScoreChanged();
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _MotorRow extends StatelessWidget {
  const _MotorRow({
    required this.level,
    required this.muscleName,
    required this.rightScore,
    required this.leftScore,
    required this.onRightChanged,
    required this.onLeftChanged,
  });

  final String level;
  final String muscleName;
  final int rightScore;
  final int leftScore;
  final ValueChanged<int> onRightChanged;
  final ValueChanged<int> onLeftChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: _ScoreChips(
              score: rightScore,
              maxScore: 5,
              onChanged: onRightChanged,
            ),
          ),
          SizedBox(
            width: 100,
            child: Column(
              children: [
                Text(
                  level,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: AppTheme.primaryNavy,
                  ),
                ),
                Text(
                  muscleName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: _ScoreChips(
              score: leftScore,
              maxScore: 5,
              onChanged: onLeftChanged,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Sacral Exam Bar (DAP / VAC)
// =============================================================================

class _SacralExamBar extends StatelessWidget {
  const _SacralExamBar({
    required this.dap,
    required this.vac,
    required this.onDapChanged,
    required this.onVacChanged,
  });

  final bool dap;
  final bool vac;
  final ValueChanged<bool> onDapChanged;
  final ValueChanged<bool> onVacChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: _YesNoToggle(
              label: 'DAP',
              subtitle: 'Deep Anal Pressure',
              value: dap,
              onChanged: onDapChanged,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _YesNoToggle(
              label: 'VAC',
              subtitle: 'Voluntary Anal Contraction',
              value: vac,
              onChanged: onVacChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class _YesNoToggle extends StatelessWidget {
  const _YesNoToggle({
    required this.label,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: AppTheme.primaryNavy,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 9, color: AppTheme.textSecondary),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _ToggleChip(
              label: 'Yes',
              selected: value,
              selectedColor: AppTheme.successGreen,
              onTap: () => onChanged(true),
            ),
            const SizedBox(width: 6),
            _ToggleChip(
              label: 'No',
              selected: !value,
              selectedColor: AppTheme.dangerRed,
              onTap: () => onChanged(false),
            ),
          ],
        ),
      ],
    );
  }
}

class _ToggleChip extends StatelessWidget {
  const _ToggleChip({
    required this.label,
    required this.selected,
    required this.selectedColor,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final Color selectedColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? selectedColor : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : AppTheme.textSecondary,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// Score Chips (shared between sensory 0-2 and motor 0-5)
// =============================================================================

class _ScoreChips extends StatelessWidget {
  const _ScoreChips({
    required this.score,
    required this.maxScore,
    required this.onChanged,
  });

  final int score;
  final int maxScore;
  final ValueChanged<int> onChanged;

  Color _chipColor(int value) {
    if (value != score) return Colors.grey.shade200;
    if (maxScore == 2) {
      switch (value) {
        case 0:
          return AppTheme.dangerRed;
        case 1:
          return AppTheme.warningAmber;
        case 2:
          return AppTheme.successGreen;
      }
    } else {
      // Motor 0-5 gradient.
      if (value == 0) return AppTheme.dangerRed;
      if (value <= 2) return AppTheme.warningAmber;
      if (value <= 4) return AppTheme.accentTeal;
      return AppTheme.successGreen;
    }
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(maxScore + 1, (i) {
        final isSelected = i == score;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: GestureDetector(
            onTap: () => onChanged(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: maxScore <= 2 ? 32 : 28,
              height: maxScore <= 2 ? 32 : 28,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _chipColor(i),
                borderRadius: BorderRadius.circular(8),
                border: isSelected
                    ? Border.all(
                        color: AppTheme.primaryNavy,
                        width: 2,
                      )
                    : null,
              ),
              child: Text(
                '$i',
                style: TextStyle(
                  color: isSelected ? Colors.white : AppTheme.textSecondary,
                  fontWeight: FontWeight.w700,
                  fontSize: maxScore <= 2 ? 14 : 12,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

// =============================================================================
// Results Tab
// =============================================================================

class _ResultsTab extends StatelessWidget {
  const _ResultsTab({required this.results});

  final Map<String, String> results;

  @override
  Widget build(BuildContext context) {
    final ais = results['ais'] ?? '?';
    final isAisA = ais == 'A';

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // AIS Grade hero card.
        _AisGradeCard(ais: ais),
        const SizedBox(height: 16),

        // NLI.
        _ResultCard(
          title: 'Neurological Level of Injury',
          children: [
            _ResultValue(label: 'NLI', value: results['nli'] ?? '?'),
          ],
        ),
        const SizedBox(height: 12),

        // Sensory Levels.
        _ResultCard(
          title: 'Sensory Levels',
          children: [
            _ResultValue(label: 'Right', value: results['sensoryR'] ?? '?'),
            _ResultValue(label: 'Left', value: results['sensoryL'] ?? '?'),
          ],
        ),
        const SizedBox(height: 12),

        // Motor Levels.
        _ResultCard(
          title: 'Motor Levels',
          children: [
            _ResultValue(label: 'Right', value: results['motorR'] ?? '?'),
            _ResultValue(label: 'Left', value: results['motorL'] ?? '?'),
          ],
        ),
        const SizedBox(height: 12),

        // ZPP (AIS A only).
        if (isAisA) ...[
          _ResultCard(
            title: 'Zone of Partial Preservation',
            titleColor: AppTheme.warningAmber,
            children: [
              _ResultValue(
                label: 'Sensory R',
                value: results['zppSensoryR'] ?? 'N/A',
              ),
              _ResultValue(
                label: 'Sensory L',
                value: results['zppSensoryL'] ?? 'N/A',
              ),
              _ResultValue(
                label: 'Motor R',
                value: results['zppMotorR'] ?? 'N/A',
              ),
              _ResultValue(
                label: 'Motor L',
                value: results['zppMotorL'] ?? 'N/A',
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],

        // Index Scores.
        _ResultCard(
          title: 'Motor Index Scores',
          children: [
            _ResultValue(
              label: 'UEMS',
              value: '${results['uems'] ?? '0'} / 50',
            ),
            _ResultValue(
              label: 'LEMS',
              value: '${results['lems'] ?? '0'} / 50',
            ),
            _ResultValue(
              label: 'Total Motor',
              value: '${results['totalMotor'] ?? '0'} / 100',
              highlight: true,
            ),
          ],
        ),
        const SizedBox(height: 12),

        _ResultCard(
          title: 'Sensory Scores',
          children: [
            _ResultValue(
              label: 'Light Touch',
              value: '${results['totalLT'] ?? '0'} / 112',
            ),
            _ResultValue(
              label: 'Pin Prick',
              value: '${results['totalPP'] ?? '0'} / 112',
            ),
            _ResultValue(
              label: 'Total Sensory',
              value: '${results['totalSensory'] ?? '0'} / 224',
              highlight: true,
            ),
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _AisGradeCard extends StatelessWidget {
  const _AisGradeCard({required this.ais});

  final String ais;

  Color get _gradeColor {
    switch (ais) {
      case 'A':
        return AppTheme.dangerRed;
      case 'B':
        return AppTheme.warningAmber;
      case 'C':
        return const Color(0xFFF97316); // orange
      case 'D':
        return AppTheme.accentTeal;
      case 'E':
        return AppTheme.successGreen;
      default:
        return AppTheme.textSecondary;
    }
  }

  String get _gradeDescription {
    switch (ais) {
      case 'A':
        return 'Complete -- No sensory or motor function preserved in sacral segments S4-S5.';
      case 'B':
        return 'Sensory Incomplete -- Sensory but not motor function preserved below the NLI, including S4-S5.';
      case 'C':
        return 'Motor Incomplete -- Motor function preserved below the NLI; fewer than half of key muscles below the NLI have grade 3 or better.';
      case 'D':
        return 'Motor Incomplete -- Motor function preserved below the NLI; at least half of key muscles below the NLI have grade 3 or better.';
      case 'E':
        return 'Normal -- Sensory and motor function are normal in all segments.';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              _gradeColor.withValues(alpha: 0.1),
              Colors.white,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'AIS Grade',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 72,
              height: 72,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _gradeColor,
                shape: BoxShape.circle,
              ),
              child: Text(
                ais,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              _gradeDescription,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                height: 1.5,
                color: AppTheme.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({
    required this.title,
    required this.children,
    this.titleColor,
  });

  final String title;
  final List<Widget> children;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: titleColor ?? AppTheme.primaryNavy,
              ),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _ResultValue extends StatelessWidget {
  const _ResultValue({
    required this.label,
    required this.value,
    this.highlight = false,
  });

  final String label;
  final String value;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color:
                  highlight ? AppTheme.primaryNavy : AppTheme.textSecondary,
              fontWeight: highlight ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: highlight
                  ? AppTheme.accentTeal.withValues(alpha: 0.12)
                  : AppTheme.primaryNavy.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              value,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: highlight ? AppTheme.accentTeal : AppTheme.primaryNavy,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
