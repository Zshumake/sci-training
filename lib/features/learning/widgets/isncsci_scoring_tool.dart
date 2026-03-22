import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

/// Full list of sensory dermatome levels tested in the ISNCSCI exam.
const List<String> _sensoryLevels = [
  'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8',
  'T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9', 'T10', 'T11', 'T12',
  'L1', 'L2', 'L3', 'L4', 'L5',
  'S1', 'S2', 'S3', 'S45',
];

/// Motor key muscle levels and their corresponding muscle group names.
const List<MapEntry<String, String>> _motorLevels = [
  MapEntry('C5', 'Elbow flexors'),
  MapEntry('C6', 'Wrist extensors'),
  MapEntry('C7', 'Elbow extensors'),
  MapEntry('C8', 'Finger flexors'),
  MapEntry('T1', 'Finger abductors'),
  MapEntry('L2', 'Hip flexors'),
  MapEntry('L3', 'Knee extensors'),
  MapEntry('L4', 'Ankle dorsiflexors'),
  MapEntry('L5', 'Toe extensors'),
  MapEntry('S1', 'Ankle plantarflexors'),
];

/// Canonical ordering of all neurological levels for comparison purposes.
const List<String> _allLevels = [
  'C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8',
  'T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9', 'T10', 'T11', 'T12',
  'L1', 'L2', 'L3', 'L4', 'L5',
  'S1', 'S2', 'S3', 'S45',
];

/// Returns the ordinal index for a neurological level string.
/// Lower index = more rostral. Returns -1 if not found.
int _levelIndex(String level) => _allLevels.indexOf(level);

/// Returns whichever level is more rostral (lower index).
String _moreRostral(String a, String b) {
  final ia = _levelIndex(a);
  final ib = _levelIndex(b);
  if (ia < 0) return b;
  if (ib < 0) return a;
  return ia <= ib ? a : b;
}

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
    for (final level in _sensoryLevels) {
      _ltRight[level] = 2;
      _ltLeft[level] = 2;
      _ppRight[level] = 2;
      _ppLeft[level] = 2;
    }
    for (final entry in _motorLevels) {
      _motorRight[entry.key] = 5;
      _motorLeft[entry.key] = 5;
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
  String _sensoryLevel(Map<String, int> scores) {
    String level = 'C1'; // intact above C2 by definition
    for (final s in _sensoryLevels) {
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
  String _motorLevel(
    Map<String, int> motorScores,
    Map<String, int> ltScores,
    Map<String, int> ppScores,
  ) {
    // Walk through all levels using the sensory list as the backbone.
    // Between motor-testable segments, motor function is inferred from sensory.
    final motorKeys = _motorLevels.map((e) => e.key).toSet();
    String level = 'C1';

    for (final s in _sensoryLevels) {
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
    for (final entry in _motorLevels) {
      final mi = _levelIndex(entry.key);
      if (mi < idx) {
        if ((scores[entry.key] ?? 0) < 5) return false;
      }
    }
    return true;
  }

  /// Determines whether sacral sparing is present.
  bool get _sacralSparing {
    // Sensation at S4-5 (LT or PP) on either side, or DAP, or VAC.
    final ltRS45 = _ltRight['S45'] ?? 0;
    final ltLS45 = _ltLeft['S45'] ?? 0;
    final ppRS45 = _ppRight['S45'] ?? 0;
    final ppLS45 = _ppLeft['S45'] ?? 0;
    return ltRS45 > 0 || ltLS45 > 0 || ppRS45 > 0 || ppLS45 > 0 || _dap || _vac;
  }

  /// Counts how many key muscles below [nli] have grade >= 3 on both sides.
  int _motorBelowWithGrade3OrMore(String nli) {
    final nliIdx = _levelIndex(nli);
    int count = 0;
    for (final entry in _motorLevels) {
      final mi = _levelIndex(entry.key);
      if (mi > nliIdx) {
        if ((_motorRight[entry.key] ?? 0) >= 3) count++;
        if ((_motorLeft[entry.key] ?? 0) >= 3) count++;
      }
    }
    return count;
  }

  /// Total number of key muscles below the NLI (both sides).
  int _totalMotorBelowNLI(String nli) {
    final nliIdx = _levelIndex(nli);
    int count = 0;
    for (final entry in _motorLevels) {
      if (_levelIndex(entry.key) > nliIdx) {
        count += 2; // left and right
      }
    }
    return count;
  }

  /// Whether motor function exists more than 3 levels below the motor level
  /// on either side.
  bool _motorMoreThan3BelowMotorLevel(String motorLevelR, String motorLevelL) {
    bool check(String motorLevel, Map<String, int> scores) {
      final mlIdx = _levelIndex(motorLevel);
      for (final entry in _motorLevels) {
        final mi = _levelIndex(entry.key);
        if (mi > mlIdx + 3) {
          if ((scores[entry.key] ?? 0) >= 1) return true;
        }
      }
      return false;
    }

    return check(motorLevelR, _motorRight) || check(motorLevelL, _motorLeft);
  }

  /// Computes the full results map.
  Map<String, String> _computeResults() {
    // Sensory levels (most caudal intact for each modality, then take most
    // rostral across modalities for each side).
    final rLT = _sensoryLevel(_ltRight);
    final rPP = _sensoryLevel(_ppRight);
    final lLT = _sensoryLevel(_ltLeft);
    final lPP = _sensoryLevel(_ppLeft);

    final sensoryR = _moreRostral(rLT, rPP);
    final sensoryL = _moreRostral(lLT, lPP);

    // Motor levels.
    final motorR = _motorLevel(_motorRight, _ltRight, _ppRight);
    final motorL = _motorLevel(_motorLeft, _ltLeft, _ppLeft);

    // NLI is the most rostral of the four.
    String nli = sensoryR;
    nli = _moreRostral(nli, sensoryL);
    nli = _moreRostral(nli, motorR);
    nli = _moreRostral(nli, motorL);

    // AIS classification.
    String ais;
    if (!_sacralSparing) {
      ais = 'A';
    } else {
      // Check for motor incomplete.
      final hasVAC = _vac;
      final motorBelow3 = _motorMoreThan3BelowMotorLevel(motorR, motorL);
      final motorIncomplete = hasVAC || motorBelow3;

      if (!motorIncomplete) {
        // Check if any motor function below NLI.
        final anyMotorBelow = _motorBelowWithGrade3OrMore(nli) > 0;
        if (!anyMotorBelow) {
          ais = 'B';
        } else {
          // Edge case: motor function exists below NLI but not > 3 below
          // motor level and no VAC. Treat as motor incomplete.
          final totalBelow = _totalMotorBelowNLI(nli);
          final grade3Below = _motorBelowWithGrade3OrMore(nli);
          if (totalBelow > 0 && grade3Below >= (totalBelow / 2)) {
            ais = 'D';
          } else {
            ais = 'C';
          }
        }
      } else {
        // Motor incomplete: C vs D.
        final totalBelow = _totalMotorBelowNLI(nli);
        final grade3Below = _motorBelowWithGrade3OrMore(nli);
        if (totalBelow > 0 && grade3Below >= (totalBelow / 2)) {
          ais = 'D';
        } else {
          ais = 'C';
        }
      }
    }

    // Check for AIS E: all scores normal.
    bool allNormal = true;
    for (final level in _sensoryLevels) {
      if (_ltRight[level] != 2 ||
          _ltLeft[level] != 2 ||
          _ppRight[level] != 2 ||
          _ppLeft[level] != 2) {
        allNormal = false;
        break;
      }
    }
    if (allNormal) {
      for (final entry in _motorLevels) {
        if ((_motorRight[entry.key] ?? 0) != 5 ||
            (_motorLeft[entry.key] ?? 0) != 5) {
          allNormal = false;
          break;
        }
      }
    }
    if (allNormal && _dap && _vac) {
      ais = 'E';
    }

    // Zone of Partial Preservation (AIS A only).
    String zppSensoryR = 'N/A';
    String zppSensoryL = 'N/A';
    String zppMotorR = 'N/A';
    String zppMotorL = 'N/A';
    if (ais == 'A') {
      zppSensoryR = _zppSensory(_ltRight, _ppRight, sensoryR);
      zppSensoryL = _zppSensory(_ltLeft, _ppLeft, sensoryL);
      zppMotorR = _zppMotor(_motorRight, motorR);
      zppMotorL = _zppMotor(_motorLeft, motorL);
    }

    // Index scores.
    int uems = 0;
    int lems = 0;
    for (final entry in _motorLevels) {
      final r = _motorRight[entry.key] ?? 0;
      final l = _motorLeft[entry.key] ?? 0;
      final idx = _levelIndex(entry.key);
      if (idx <= _levelIndex('T1')) {
        uems += r + l;
      } else {
        lems += r + l;
      }
    }

    int totalLT = 0;
    int totalPP = 0;
    for (final level in _sensoryLevels) {
      totalLT += (_ltRight[level] ?? 0) + (_ltLeft[level] ?? 0);
      totalPP += (_ppRight[level] ?? 0) + (_ppLeft[level] ?? 0);
    }

    return {
      'sensoryR': sensoryR,
      'sensoryL': sensoryL,
      'motorR': motorR,
      'motorL': motorL,
      'nli': nli,
      'ais': ais,
      'zppSensoryR': zppSensoryR,
      'zppSensoryL': zppSensoryL,
      'zppMotorR': zppMotorR,
      'zppMotorL': zppMotorL,
      'uems': '$uems',
      'lems': '$lems',
      'totalMotor': '${uems + lems}',
      'totalLT': '$totalLT',
      'totalPP': '$totalPP',
      'totalSensory': '${totalLT + totalPP}',
    };
  }

  /// Most caudal level with any sensation (LT or PP > 0) below the sensory
  /// level on that side.
  String _zppSensory(
    Map<String, int> lt,
    Map<String, int> pp,
    String sensoryLevel,
  ) {
    final slIdx = _levelIndex(sensoryLevel);
    String zpp = sensoryLevel;
    for (final level in _sensoryLevels) {
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
  String _zppMotor(Map<String, int> motor, String motorLevel) {
    final mlIdx = _levelIndex(motorLevel);
    String zpp = motorLevel;
    for (final entry in _motorLevels) {
      final idx = _levelIndex(entry.key);
      if (idx > mlIdx) {
        if ((motor[entry.key] ?? 0) > 0) {
          zpp = entry.key;
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
            itemCount: _sensoryLevels.length,
            itemBuilder: (context, index) {
              final level = _sensoryLevels[index];
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
    final isEvenIndex = _sensoryLevels.indexOf(level).isEven;
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
              level,
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
            itemCount: _motorLevels.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final entry = _motorLevels[index];
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
                    level: entry.key,
                    muscleName: entry.value,
                    rightScore: motorRight[entry.key] ?? 0,
                    leftScore: motorLeft[entry.key] ?? 0,
                    onRightChanged: (v) {
                      motorRight[entry.key] = v;
                      onScoreChanged();
                    },
                    onLeftChanged: (v) {
                      motorLeft[entry.key] = v;
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
