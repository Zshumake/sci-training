// Copyright 2024 Praxis-ISNCSCI Contributors
// Ported from https://github.com/praxis-isncsci/algorithm (TypeScript)
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:sci_training/core/isncsci/isncsci_constants.dart';
import 'package:sci_training/core/isncsci/isncsci_exam_model.dart';
import 'package:sci_training/core/isncsci/isncsci_result_model.dart';

// ============================================================================
// Public API
// ============================================================================

/// Run the full ISNCSCI algorithm on an [Exam] and return the complete result
/// including classification and totals.
ISNCSCIResult calculateISNCSCI(Exam exam) {
  final classification = _classify(exam);
  final totals = _calculateTotals(exam);
  return ISNCSCIResult(classification: classification, totals: totals);
}

// ============================================================================
// Helper: remove stars from exam for internal comparisons
// ============================================================================

/// Deep-clone the exam with all '*' characters stripped from values.
// ignore: unused_element
Exam _removeStars(Exam exam) {
  // Utility to strip stars from a single value
  String strip(String v) => v.replaceAll('*', '');

  Motor stripMotor(Motor m) => Motor(
        c5: strip(m.c5),
        c6: strip(m.c6),
        c7: strip(m.c7),
        c8: strip(m.c8),
        t1: strip(m.t1),
        l2: strip(m.l2),
        l3: strip(m.l3),
        l4: strip(m.l4),
        l5: strip(m.l5),
        s1: strip(m.s1),
      );

  Sensory stripSensory(Sensory s) {
    final map = s.toMap();
    final stripped = map.map((k, v) => MapEntry(k, strip(v)));
    return Sensory(
      c2: stripped['C2']!,
      c3: stripped['C3']!,
      c4: stripped['C4']!,
      c5: stripped['C5']!,
      c6: stripped['C6']!,
      c7: stripped['C7']!,
      c8: stripped['C8']!,
      t1: stripped['T1']!,
      t2: stripped['T2']!,
      t3: stripped['T3']!,
      t4: stripped['T4']!,
      t5: stripped['T5']!,
      t6: stripped['T6']!,
      t7: stripped['T7']!,
      t8: stripped['T8']!,
      t9: stripped['T9']!,
      t10: stripped['T10']!,
      t11: stripped['T11']!,
      t12: stripped['T12']!,
      l1: stripped['L1']!,
      l2: stripped['L2']!,
      l3: stripped['L3']!,
      l4: stripped['L4']!,
      l5: stripped['L5']!,
      s1: stripped['S1']!,
      s2: stripped['S2']!,
      s3: stripped['S3']!,
      s4_5: stripped['S4_5']!,
    );
  }

  ExamSide stripSide(ExamSide side) => ExamSide(
        motor: stripMotor(side.motor),
        lightTouch: stripSensory(side.lightTouch),
        pinPrick: stripSensory(side.pinPrick),
        lowestNonKeyMuscleWithMotorFunction:
            side.lowestNonKeyMuscleWithMotorFunction,
      );

  return Exam(
    right: stripSide(exam.right),
    left: stripSide(exam.left),
    voluntaryAnalContraction: exam.voluntaryAnalContraction,
    deepAnalPressure: exam.deepAnalPressure,
  );
}

// ============================================================================
// Common helpers (ported from classification/common.ts)
// ============================================================================

/// Whether a sensory value can be interpreted as absent.
bool _canBeAbsentSensory(String value) =>
    canBeAbsentSensoryValues.contains(value);

// _isNormalSensory removed — currently unused but available if needed

/// Whether [index] falls within the range of [startLevel] to [endLevel]
/// inclusive, using [sensoryLevels] indices.
bool _levelIsBetween(int index, String startLevel, String endLevel) {
  final startIdx = sensoryLevels.indexOf(startLevel);
  final endIdx = sensoryLevels.indexOf(endLevel);
  return index >= startIdx && index <= endIdx;
}

/// Whether [value] is an abnormal sensory value.
bool _isAbnormalSensory(String value) =>
    const ['0', '1', '0*', '1*'].contains(value);

/// Whether [value] is an NT variable sensory value.
bool _isNTVariableSensory(String value) =>
    const ['0**', '1**'].contains(value);

/// Whether [value] is an NT non-variable sensory value.
bool _isNTNotVariableSensory(String value) =>
    const ['2', 'NT', 'NT**'].contains(value);

// ============================================================================
// CheckLevelResult (internal data class)
// ============================================================================

class _CheckLevelResult {
  final bool shouldContinue;
  final String? level;
  final bool variable;

  const _CheckLevelResult({
    required this.shouldContinue,
    this.level,
    required this.variable,
  });
}

// ============================================================================
// Sensory Level Determination
// ============================================================================

/// Checks the sensory level at the current position by examining the
/// next level's light touch and pin prick values.
_CheckLevelResult _checkSensoryLevel(
  ExamSide side,
  String level,
  String nextLevel,
  bool variable,
) {
  if (nextLevel == 'C1') {
    throw ArgumentError('Invalid next level: C1');
  }

  if (side.lightTouch[nextLevel] == '2' && side.pinPrick[nextLevel] == '2') {
    return _CheckLevelResult(
        shouldContinue: true, variable: variable);
  } else if (_isAbnormalSensory(side.lightTouch[nextLevel]) ||
      _isAbnormalSensory(side.pinPrick[nextLevel])) {
    return _CheckLevelResult(
      shouldContinue: false,
      level: '$level${variable ? '*' : ''}',
      variable: variable,
    );
  } else if (side.lightTouch[nextLevel] == 'NT*' ||
      side.pinPrick[nextLevel] == 'NT*') {
    return _CheckLevelResult(
      shouldContinue: false,
      level: '$level*',
      variable: true,
    );
  } else if (side.lightTouch[nextLevel] == 'NT' ||
      side.pinPrick[nextLevel] == 'NT') {
    if (_isNTVariableSensory(side.lightTouch[nextLevel]) ||
        _isNTVariableSensory(side.pinPrick[nextLevel])) {
      return _CheckLevelResult(
        shouldContinue: true,
        level: '$level${variable ? '*' : ''}',
        variable: true,
      );
    } else if (_isNTNotVariableSensory(side.lightTouch[nextLevel]) ||
        _isNTNotVariableSensory(side.pinPrick[nextLevel])) {
      return _CheckLevelResult(
        shouldContinue: true,
        level: '$level${variable ? '*' : ''}',
        variable: variable,
      );
    } else {
      throw StateError('NT branch unmatched for level $nextLevel');
    }
  } else {
    return _CheckLevelResult(
        shouldContinue: true, variable: true);
  }
}

/// Determine sensory level for one side by iterating from C1 caudally.
String _determineSensoryLevel(ExamSide side) {
  final levels = <String>[];
  bool variable = false;
  int currentIndex = 0;

  while (true) {
    final level = sensoryLevels[currentIndex];
    final nextIndex = currentIndex + 1;

    // Reached the end (S4_5)
    if (nextIndex >= sensoryLevels.length) {
      levels.add('INT${variable ? '*' : ''}');
      break;
    }

    final nextLevel = sensoryLevels[nextIndex];
    final result = _checkSensoryLevel(side, level, nextLevel, variable);

    if (result.level != null) {
      levels.add(result.level!);
    }

    variable = variable || result.variable;

    if (!result.shouldContinue) {
      break;
    }

    currentIndex++;
  }

  return levels.join(',');
}

// ============================================================================
// Motor Level Determination
// ============================================================================

/// Check motor level at a key motor level position.
_CheckLevelResult _checkMotorLevel(
  ExamSide side,
  String level,
  String nextLevel,
  bool variable,
) {
  final currentValue = side.motor[level];
  final nextValue = side.motor[nextLevel];
  bool shouldContinue = false;
  String? resultLevel;
  bool resultVariable = variable;

  // Determine continue: if current is 5 or normal-equivalent AND next is >= 3
  if (['5', '0**', '1**', '2**', '3**', '4**', 'NT**'].contains(currentValue) &&
      !['0', '1', '2', '0*', '1*', '2*', 'NT', 'NT*']
          .contains(nextValue)) {
    shouldContinue = true;
  }

  // Determine level assignment
  if (!(['5', '0**', '1**', '2**', '3**', '4**', 'NT**']
          .contains(currentValue) &&
      !['0', '1', '2', '0*', '1*', '2*', 'NT', 'NT*']
          .contains(nextValue))) {
    if (['0*', '1*', '2*', 'NT*'].contains(currentValue) ||
        (['0**', '1**', '2**'].contains(currentValue) &&
            ['0*', '1*', '2*', 'NT', 'NT*'].contains(nextValue))) {
      resultLevel = '$level*';
    } else {
      resultLevel = '$level${variable ? '*' : ''}';
    }
  }

  // Determine variable flag
  if (!['5', '3', '4', '3*', '4*', 'NT'].contains(currentValue)) {
    if (['0**', '1**', '2**', '3**', '4**', 'NT**'].contains(currentValue)) {
      if (!['0', '1', '2'].contains(nextValue)) {
        resultVariable = true;
      }
    } else {
      resultVariable = true;
    }
  } else if (currentValue == '5' &&
      ['0**', '1**', '2**'].contains(nextValue)) {
    resultVariable = true;
  }

  return _CheckLevelResult(
    shouldContinue: shouldContinue,
    level: resultLevel,
    variable: resultVariable,
  );
}

/// Check motor level before the start of key muscles (C4 or L1).
_CheckLevelResult _checkMotorLevelBeforeStartOfKeyMuscles(
  ExamSide side,
  String level,
  String nextMotorLevel,
  bool variable,
) {
  final nextValue = side.motor[nextMotorLevel];
  return _CheckLevelResult(
    shouldContinue: !['0', '1', '2'].contains(nextValue),
    level: ['0', '1', '2', '0*', '1*', '2*', 'NT', 'NT*'].contains(nextValue)
        ? '$level${variable ? '*' : ''}'
        : null,
    variable: variable || ['0**', '1**', '2**'].contains(nextValue),
  );
}

/// Check motor level using sensory values below the motor block (for T1/S1).
_CheckLevelResult _checkMotorLevelUsingSensoryValues(
  ExamSide side,
  String firstMotorLevelOfMotorBlock,
) {
  final startIndex =
      sensoryLevels.indexOf(firstMotorLevelOfMotorBlock) - 1;
  bool shouldContinue = true;
  String? level;
  bool variable = false;

  for (int i = startIndex; i <= startIndex + 5 && i < sensoryLevels.length - 1; i++) {
    final currentLevel = sensoryLevels[i];
    final nextLevel = sensoryLevels[i + 1];
    final result = _checkSensoryLevel(side, currentLevel, nextLevel, false);

    if (!result.shouldContinue) {
      shouldContinue = false;
    }
    if (result.level != null) {
      level = result.level;
    }
    if (result.variable) {
      variable = true;
    }
  }

  return _CheckLevelResult(
    shouldContinue: shouldContinue,
    level: level,
    variable: variable,
  );
}

/// Check motor level at the end of a key muscle block (T1 or S1).
_CheckLevelResult _checkMotorLevelAtEndOfKeyMuscles(
  ExamSide side,
  String level,
  bool variable,
) {
  final firstMotorLevel = level == 'T1' ? 'C5' : 'L2';
  final sensoryResult =
      _checkMotorLevelUsingSensoryValues(side, firstMotorLevel);

  // Combine motor at level with sensory result
  final currentValue = side.motor[level];
  bool shouldContinue = true;
  String? resultLevel;
  bool resultVariable = variable;

  if (['3', '4', '0*', '1*', '2*', '3*', '4*', 'NT*'].contains(currentValue) ||
      !sensoryResult.shouldContinue) {
    shouldContinue = false;
  }

  if (currentValue == 'NT' ||
      !(['5', '0**', '1**', '2**', '3**', '4**', 'NT**']
              .contains(currentValue) &&
          sensoryResult.shouldContinue &&
          sensoryResult.level == null)) {
    if (['0*', '1*', '2*', 'NT*'].contains(currentValue) ||
        (['0**', '1**', '2**'].contains(currentValue) &&
            (sensoryResult.level != null || !sensoryResult.shouldContinue))) {
      resultLevel = '$level*';
    } else {
      resultLevel = '$level${variable ? '*' : ''}';
    }
  }

  if (['0*', '1*', '2*', 'NT*', '0**', '1**', '2**'].contains(currentValue) ||
      (['3**', '4**', 'NT**'].contains(currentValue) &&
          sensoryResult.shouldContinue) ||
      (['5', 'NT'].contains(currentValue) &&
          sensoryResult.shouldContinue &&
          sensoryResult.variable &&
          sensoryResult.level == null)) {
    resultVariable = true;
  }

  return _CheckLevelResult(
    shouldContinue: shouldContinue,
    level: resultLevel,
    variable: resultVariable,
  );
}

/// Determine motor level for one side by iterating from C1 caudally.
String _determineMotorLevel(ExamSide side, BinaryObservation vac) {
  final levels = <String>[];
  bool variable = false;
  int currentIndex = 0;

  while (true) {
    final i = currentIndex;
    final level = sensoryLevels[i];

    _CheckLevelResult result;

    // Dispatch by level category
    if (_levelIsBetween(i, 'C1', 'C3') ||
        _levelIsBetween(i, 'T2', 'T12') ||
        _levelIsBetween(i, 'S2', 'S3')) {
      // Sensory regions
      final nextLevel = sensoryLevels[i + 1];
      result = _checkSensoryLevel(side, level, nextLevel, variable);
    } else if (level == 'C4') {
      result = _checkMotorLevelBeforeStartOfKeyMuscles(
          side, 'C4', 'C5', variable);
    } else if (level == 'L1') {
      result = _checkMotorLevelBeforeStartOfKeyMuscles(
          side, 'L1', 'L2', variable);
    } else if (_levelIsBetween(i, 'C5', 'C8')) {
      final motorIndex = i - 4;
      final motorLevel = motorLevels[motorIndex];
      final motorNextLevel = motorLevels[motorIndex + 1];
      result = _checkMotorLevel(side, motorLevel, motorNextLevel, variable);
    } else if (_levelIsBetween(i, 'L2', 'L5')) {
      final motorIndex = i - 16;
      final motorLevel = motorLevels[motorIndex];
      final motorNextLevel = motorLevels[motorIndex + 1];
      result = _checkMotorLevel(side, motorLevel, motorNextLevel, variable);
    } else if (level == 'T1') {
      result = _checkMotorLevelAtEndOfKeyMuscles(side, 'T1', variable);
    } else if (level == 'S1') {
      result = _checkMotorLevelAtEndOfKeyMuscles(side, 'S1', variable);
    } else {
      // S4_5 - VAC handling
      if (vac == BinaryObservation.no) {
        if (levels.contains('S3') || levels.contains('S3*')) {
          result = _CheckLevelResult(
              shouldContinue: false, variable: variable);
        } else {
          result = _CheckLevelResult(
            shouldContinue: false,
            level: 'S3${variable ? '*' : ''}',
            variable: variable,
          );
        }
      } else if (vac == BinaryObservation.nt) {
        if (levels.contains('S3') || levels.contains('S3*')) {
          result = _CheckLevelResult(
            shouldContinue: false,
            level: 'INT${variable ? '*' : ''}',
            variable: variable,
          );
        } else {
          // Add both S3 and INT
          levels.add('S3${variable ? '*' : ''}');
          result = _CheckLevelResult(
            shouldContinue: false,
            level: 'INT${variable ? '*' : ''}',
            variable: variable,
          );
        }
      } else {
        // VAC is Yes
        result = _CheckLevelResult(
          shouldContinue: false,
          level: 'INT${variable ? '*' : ''}',
          variable: variable,
        );
      }
      if (result.level != null) {
        levels.add(result.level!);
      }
      break;
    }

    variable = variable || result.variable;

    if (result.level != null) {
      levels.add(result.level!);
    }

    if (!result.shouldContinue) {
      break;
    }

    currentIndex++;
  }

  return levels.join(',');
}

// ============================================================================
// Neurological Levels
// ============================================================================

NeurologicalLevels _determineNeurologicalLevels(Exam exam) {
  return NeurologicalLevels(
    sensoryRight: _determineSensoryLevel(exam.right),
    sensoryLeft: _determineSensoryLevel(exam.left),
    motorRight: _determineMotorLevel(exam.right, exam.voluntaryAnalContraction),
    motorLeft: _determineMotorLevel(exam.left, exam.voluntaryAnalContraction),
  );
}

// ============================================================================
// Neurological Level of Injury (NLI)
// ============================================================================

/// Combine bilateral results for one level without motor.
_CheckLevelResult _checkNLILevelWithoutMotor(
  Exam exam,
  String level,
  String nextLevel,
  bool variable,
) {
  final rightResult =
      _checkSensoryLevel(exam.right, level, nextLevel, false);
  final leftResult =
      _checkSensoryLevel(exam.left, level, nextLevel, false);

  final shouldContinue = rightResult.shouldContinue && leftResult.shouldContinue;
  final resultVariable = variable ||
      rightResult.variable ||
      leftResult.variable;

  String? resultLevel;
  if (rightResult.level != null || leftResult.level != null) {
    // There's an issue on at least one side; use the current level with variability
    if (rightResult.level != null && leftResult.level != null) {
      // If they differ (one has star, one doesn't), add star
      final hasStar = (rightResult.level?.contains('*') ?? false) ||
          (leftResult.level?.contains('*') ?? false) ||
          resultVariable;
      resultLevel = '$level${hasStar ? '*' : ''}';
    } else {
      // One side is normal, one is abnormal
      resultLevel = '$level${resultVariable ? '*' : ''}';
    }
  }

  if (!shouldContinue && resultLevel == null) {
    resultLevel = '$level${resultVariable ? '*' : ''}';
  }

  return _CheckLevelResult(
    shouldContinue: shouldContinue && resultLevel == null,
    level: resultLevel,
    variable: resultVariable,
  );
}

/// Combine bilateral results for one level with motor.
_CheckLevelResult _checkNLILevelWithMotor(
  Exam exam,
  int sensoryIndex,
  bool variable,
) {
  final level = sensoryLevels[sensoryIndex];
  String nextLevel;

  // Check sensory bilaterally
  if (sensoryIndex + 1 < sensoryLevels.length) {
    nextLevel = sensoryLevels[sensoryIndex + 1];
  } else {
    return _CheckLevelResult(
      shouldContinue: false,
      level: 'INT${variable ? '*' : ''}',
      variable: variable,
    );
  }

  final rightSensory = _checkSensoryLevel(exam.right, level, nextLevel, false);
  final leftSensory = _checkSensoryLevel(exam.left, level, nextLevel, false);

  bool resultVariable = variable || rightSensory.variable || leftSensory.variable;

  // If sensory is not intact on either side, stop
  if (!rightSensory.shouldContinue || !leftSensory.shouldContinue ||
      rightSensory.level != null || leftSensory.level != null) {
    return _CheckLevelResult(
      shouldContinue: false,
      level: '$level${resultVariable ? '*' : ''}',
      variable: resultVariable,
    );
  }

  // Check motor bilaterally if this is a motor level
  if (motorLevels.contains(level)) {
    final rightMotorVal = exam.right.motor[level];
    final leftMotorVal = exam.left.motor[level];

    // Both must be >= 3 equivalent to continue
    final rightGrade = int.tryParse(rightMotorVal.replaceAll('*', '')) ?? -1;
    final leftGrade = int.tryParse(leftMotorVal.replaceAll('*', '')) ?? -1;

    bool rightOk = rightGrade >= 3 || rightMotorVal == 'NT' ||
        rightMotorVal == 'NT*' || rightMotorVal == 'NT**' ||
        ['3**', '4**', '0**', '1**', '2**'].contains(rightMotorVal);
    bool leftOk = leftGrade >= 3 || leftMotorVal == 'NT' ||
        leftMotorVal == 'NT*' || leftMotorVal == 'NT**' ||
        ['3**', '4**', '0**', '1**', '2**'].contains(leftMotorVal);

    if (rightMotorVal.contains('*') || leftMotorVal.contains('*')) {
      resultVariable = true;
    }

    if (!rightOk || !leftOk) {
      return _CheckLevelResult(
        shouldContinue: false,
        level: '$level${resultVariable ? '*' : ''}',
        variable: resultVariable,
      );
    }
  }

  return _CheckLevelResult(
    shouldContinue: true,
    variable: resultVariable,
  );
}

/// Determine the Neurological Level of Injury.
///
/// The NLI is the most rostral level where bilateral sensory and motor
/// function is intact.
String _determineNeurologicalLevelOfInjury(Exam exam) {
  final levels = <String>[];
  bool variable = false;

  for (int i = 0; i < sensoryLevels.length; i++) {
    final level = sensoryLevels[i];

    if (level == 'S4_5') {
      // Reached the end with everything intact
      levels.add('INT${variable ? '*' : ''}');
      break;
    }

    final nextLevel = sensoryLevels[i + 1];

    _CheckLevelResult result;

    // Sensory-only regions
    if (_levelIsBetween(i, 'C1', 'C4') ||
        _levelIsBetween(i, 'T2', 'L1') ||
        _levelIsBetween(i, 'S2', 'S3')) {
      result = _checkNLILevelWithoutMotor(exam, level, nextLevel, variable);
    } else {
      // Motor regions
      result = _checkNLILevelWithMotor(exam, i, variable);
    }

    variable = variable || result.variable;

    if (result.level != null) {
      levels.add(result.level!);
    }

    if (!result.shouldContinue) {
      break;
    }
  }

  if (levels.isEmpty) {
    levels.add('C1');
  }

  return levels.join(',');
}

// ============================================================================
// Injury Complete
// ============================================================================

String _determineInjuryComplete(Exam exam) {
  final allS4_5 = [
    exam.right.lightTouch['S4_5'],
    exam.right.pinPrick['S4_5'],
    exam.left.lightTouch['S4_5'],
    exam.left.pinPrick['S4_5'],
  ];

  if (exam.voluntaryAnalContraction == BinaryObservation.no &&
      exam.deepAnalPressure == BinaryObservation.no) {
    if (allS4_5.every((v) => v == '0')) {
      return 'C';
    } else if (allS4_5.every((v) => ['0', '0*'].contains(v))) {
      return 'C*,I*';
    } else if (allS4_5.every((v) => ['0', '0**'].contains(v))) {
      return 'I*';
    }
  }

  if (exam.voluntaryAnalContraction != BinaryObservation.yes &&
      exam.deepAnalPressure != BinaryObservation.yes &&
      allS4_5.every(_canBeAbsentSensory)) {
    return 'C,I';
  } else {
    return 'I';
  }
}

// ============================================================================
// ASIA Impairment Scale
// ============================================================================

/// Helper for AIS calculations.
class _CheckAISResult {
  final bool result;
  final bool variable;
  const _CheckAISResult({required this.result, required this.variable});
}

/// Map sensory index to the starting motor index for checking motor below NLI.
int _startingMotorIndex(int sensoryIndex) {
  // C1-C4 (idx 0-3): start at motor index 0 (C5)
  if (sensoryIndex <= 3) return 0;
  // C5-T1 (idx 4-8): start at sensoryIndex - 3
  if (sensoryIndex <= 8) return sensoryIndex - 3;
  // T2-L1 (idx 9-20): start at motor index 5 (L2)
  if (sensoryIndex <= 20) return 5;
  // L2-S1 (idx 21-25): start at sensoryIndex - 16
  if (sensoryIndex <= 25) return sensoryIndex - 16;
  // S2+ : past all motor levels
  return motorLevels.length;
}

/// Check if sensory is preserved at sacral segments.
_CheckAISResult _isSensoryPreserved(Exam exam) {
  if (exam.deepAnalPressure == BinaryObservation.yes) {
    return const _CheckAISResult(result: true, variable: false);
  }

  final s4_5Values = [
    exam.right.lightTouch['S4_5'],
    exam.right.pinPrick['S4_5'],
    exam.left.lightTouch['S4_5'],
    exam.left.pinPrick['S4_5'],
  ];

  final hasPreserved = s4_5Values.any((v) => !_canBeAbsentSensory(v));
  final allAbsent = s4_5Values.every((v) => v == '0');

  if (hasPreserved) {
    return const _CheckAISResult(result: true, variable: false);
  }

  if (exam.deepAnalPressure == BinaryObservation.nt) {
    return const _CheckAISResult(result: true, variable: true);
  }

  if (!allAbsent) {
    // Some have star values
    return const _CheckAISResult(result: true, variable: true);
  }

  return const _CheckAISResult(result: false, variable: false);
}

/// Check AIS A: Is injury complete?
String? _checkASIAImpairmentScaleA(String injuryComplete) {
  if (injuryComplete.contains('C')) {
    return injuryComplete.contains('*') ? 'A*' : 'A';
  }
  return null;
}

/// Check if motor function can be absent more than 3 levels below motor level.
_CheckAISResult _canHaveNoMotorFunctionMoreThanThreeLevelsBelow(
  Motor motor,
  String motorLevel,
  String? lowestNonKeyMuscle,
) {
  bool variable = false;

  for (final m in motorLevel.split(',')) {
    final cleanLevel = m.replaceAll('*', '');
    final index = (cleanLevel == 'INT')
        ? sensoryLevels.indexOf('S4_5')
        : sensoryLevels.indexOf(cleanLevel) + 4;

    final startingIndex = _startingMotorIndex(index);

    bool noMotorFunction = true;
    for (int i = startingIndex; i < motorLevels.length; i++) {
      final level = motorLevels[i];
      if (motor[level] == '0*' || motor[level] == '0**') {
        variable = true;
      }
      if (!['0', 'NT', 'NT*', '0*'].contains(motor[level]) ||
          level == lowestNonKeyMuscle) {
        noMotorFunction = false;
        if (motor[level] == '0*') {
          variable = true;
        }
        break;
      }
    }
    if (noMotorFunction) {
      return _CheckAISResult(result: true, variable: variable);
    }
  }

  return const _CheckAISResult(result: false, variable: false);
}

/// Check AIS B: Sensory incomplete, motor complete.
String? _checkASIAImpairmentScaleB(
    Exam exam, NeurologicalLevels neurologicalLevels) {
  final sensoryPreserved = _isSensoryPreserved(exam);
  if (!sensoryPreserved.result) return null;

  // Motor must not be preserved
  final leftMotorResult = _canHaveNoMotorFunctionMoreThanThreeLevelsBelow(
    exam.left.motor,
    neurologicalLevels.motorLeft,
    exam.left.lowestNonKeyMuscleWithMotorFunction,
  );
  final rightMotorResult = _canHaveNoMotorFunctionMoreThanThreeLevelsBelow(
    exam.right.motor,
    neurologicalLevels.motorRight,
    exam.right.lowestNonKeyMuscleWithMotorFunction,
  );

  final motorNotPreserved = exam.voluntaryAnalContraction != BinaryObservation.yes &&
      rightMotorResult.result &&
      leftMotorResult.result;
  final motorVariable =
      exam.voluntaryAnalContraction == BinaryObservation.no &&
          (leftMotorResult.variable || rightMotorResult.variable);

  if (motorNotPreserved) {
    final isVariable = sensoryPreserved.variable || motorVariable;
    return isVariable ? 'B*' : 'B';
  }

  return null;
}

/// Check if motor is incomplete (VAC present or motor > 3 levels below NLI).
bool _canBeMotorIncomplete(Exam exam, NeurologicalLevels neurologicalLevels) {
  if (exam.voluntaryAnalContraction != BinaryObservation.no) {
    return true;
  }

  final sensoryPreserved = _isSensoryPreserved(exam);
  if (!sensoryPreserved.result) return false;

  // Check for motor function more than 3 levels below on either side
  for (final entry in [
    MapEntry(exam.right, neurologicalLevels.motorRight),
    MapEntry(exam.left, neurologicalLevels.motorLeft),
  ]) {
    final side = entry.key;
    final motorLevel = entry.value;

    for (final m in motorLevel.split(',')) {
      final cleanLevel = m.replaceAll('*', '');
      final index = (cleanLevel == 'INT')
          ? sensoryLevels.indexOf('S4_5')
          : sensoryLevels.indexOf(cleanLevel) + 4;
      final startingIndex = _startingMotorIndex(index);

      for (int i = startingIndex; i < motorLevels.length; i++) {
        final value = side.motor[motorLevels[i]];
        if (!['0', 'NT', 'NT*', '0*'].contains(value)) {
          return true;
        }
        if (value == '0**') return true;
      }
    }
  }

  return false;
}

/// Helper to check if muscle value can be < 3.
bool _canHaveMuscleGradeLessThan3(String value) =>
    ['0', '1', '2', 'NT', 'NT*'].contains(value);

/// Helper to check if muscle value can be variably < 3.
bool _canHaveVariableMuscleGradeLessThan3(String value) =>
    ['0*', '1*', '2*'].contains(value);

/// Check AIS C: Motor incomplete, < half of key muscles below NLI >= grade 3.
String? _checkASIAImpairmentScaleC(
  Exam exam,
  String injuryComplete,
  NeurologicalLevels neurologicalLevels,
  String neurologicalLevelOfInjury,
) {
  if (!_canBeMotorIncomplete(exam, neurologicalLevels)) return null;

  // Count key muscles below NLI with grade < 3
  for (final nli in neurologicalLevelOfInjury.split(',')) {
    final cleanNLI = nli.replaceAll('*', '');
    final nliSensoryIndex = (cleanNLI == 'INT')
        ? sensoryLevels.indexOf('S4_5')
        : sensoryLevels.indexOf(cleanNLI);
    final startMotorIdx = _startingMotorIndex(nliSensoryIndex + 1);

    if (startMotorIdx >= motorLevels.length) continue;

    int totalMuscles = motorLevels.length - startMotorIdx;
    int lessThan3Count = 0;
    int variableLessThan3Count = 0;

    for (int side = 0; side < 2; side++) {
      final motor = side == 0 ? exam.right.motor : exam.left.motor;
      for (int mi = startMotorIdx; mi < motorLevels.length; mi++) {
        final value = motor[motorLevels[mi]];
        if (_canHaveMuscleGradeLessThan3(value)) {
          lessThan3Count++;
        } else if (_canHaveVariableMuscleGradeLessThan3(value)) {
          variableLessThan3Count++;
        }
      }
    }

    final totalBilateral = totalMuscles * 2;
    final halfThreshold = totalBilateral / 2;

    // For AIS C: more than half of key muscles below NLI have grade < 3
    if (lessThan3Count > halfThreshold) {
      return 'C';
    }
    if ((lessThan3Count + variableLessThan3Count) > halfThreshold) {
      return 'C*';
    }
  }

  return null;
}

/// Helper: can muscle grade be >= 3.
bool _canHaveMuscleGradeAtLeast3(String value) =>
    !['0', '1', '2'].contains(value);

/// Helper: can muscle grade be variably >= 3.
bool _canHaveVariableMuscleGradeAtLeast3(String value) =>
    ['0*', '1*', '2*', '0**', '1**', '2**'].contains(value);

/// Check AIS D: Motor incomplete, >= half of key muscles below NLI >= grade 3.
String? _checkASIAImpairmentScaleD(
  Exam exam,
  String injuryComplete,
  NeurologicalLevels neurologicalLevels,
  String neurologicalLevelOfInjury,
) {
  if (!_canBeMotorIncomplete(exam, neurologicalLevels)) return null;

  for (final nli in neurologicalLevelOfInjury.split(',')) {
    final cleanNLI = nli.replaceAll('*', '');
    final nliSensoryIndex = (cleanNLI == 'INT')
        ? sensoryLevels.indexOf('S4_5')
        : sensoryLevels.indexOf(cleanNLI);
    final startMotorIdx = _startingMotorIndex(nliSensoryIndex + 1);

    if (startMotorIdx >= motorLevels.length) continue;

    int totalMuscles = motorLevels.length - startMotorIdx;
    int atLeast3Count = 0;
    int variableAtLeast3Count = 0;

    for (int side = 0; side < 2; side++) {
      final motor = side == 0 ? exam.right.motor : exam.left.motor;
      for (int mi = startMotorIdx; mi < motorLevels.length; mi++) {
        final value = motor[motorLevels[mi]];
        if (_canHaveMuscleGradeAtLeast3(value) &&
            !_canHaveVariableMuscleGradeAtLeast3(value)) {
          atLeast3Count++;
        } else if (_canHaveVariableMuscleGradeAtLeast3(value)) {
          variableAtLeast3Count++;
        }
      }
    }

    final totalBilateral = totalMuscles * 2;
    final halfThreshold = totalBilateral / 2;

    if (atLeast3Count >= halfThreshold) {
      return 'D';
    }
    if ((atLeast3Count + variableAtLeast3Count) >= halfThreshold) {
      return 'D*';
    }
  }

  return null;
}

/// Check AIS E: Normal exam.
String? _checkASIAImpairmentScaleE(
    String neurologicalLevelOfInjury, BinaryObservation vac) {
  if (vac != BinaryObservation.no) {
    if (neurologicalLevelOfInjury.contains('INT*')) {
      return 'E*';
    } else if (neurologicalLevelOfInjury.contains('INT')) {
      return 'E';
    }
  }
  return null;
}

/// Determine the ASIA Impairment Scale classification.
String _determineASIAImpairmentScale(
  Exam exam,
  String injuryComplete,
  NeurologicalLevels neurologicalLevels,
  String neurologicalLevelOfInjury,
) {
  // Special case: E first
  final aisE = _checkASIAImpairmentScaleE(
      neurologicalLevelOfInjury, exam.voluntaryAnalContraction);
  if (aisE == 'E') return 'E';

  final results = <String>[];

  final aisA = _checkASIAImpairmentScaleA(injuryComplete);
  if (aisA != null) results.add(aisA);

  final aisB = _checkASIAImpairmentScaleB(exam, neurologicalLevels);
  if (aisB != null) results.add(aisB);

  final aisC = _checkASIAImpairmentScaleC(
      exam, injuryComplete, neurologicalLevels, neurologicalLevelOfInjury);
  if (aisC != null) results.add(aisC);

  final aisD = _checkASIAImpairmentScaleD(
      exam, injuryComplete, neurologicalLevels, neurologicalLevelOfInjury);
  if (aisD != null) results.add(aisD);

  if (aisE != null) results.add(aisE);

  if (results.isEmpty) {
    // Fallback
    return 'ND';
  }

  return results.join(',');
}

// ============================================================================
// Zone of Partial Preservation
// ============================================================================

/// Determine Sensory ZPP for one side.
String _determineSensoryZPP(
    ExamSide side, BinaryObservation deepAnalPressure) {
  // Check if applicable
  if (deepAnalPressure == BinaryObservation.yes) return 'NA';

  // Check S4-5 preservation
  final s4_5CanBeAbsent = _canBeAbsentSensory(side.lightTouch['S4_5']) &&
      _canBeAbsentSensory(side.pinPrick['S4_5']);
  if (!s4_5CanBeAbsent) return 'NA';

  final zpp = <String>[];

  // Check sacral level (S4_5) for NA addition
  final sacralLT = side.lightTouch['S4_5'];
  final sacralPP = side.pinPrick['S4_5'];
  final sacralAbsent = sacralLT == '0' && sacralPP == '0';

  if (deepAnalPressure == BinaryObservation.nt) {
    zpp.add('NA');
  } else if (deepAnalPressure == BinaryObservation.no && !sacralAbsent) {
    zpp.add('NA');
  }

  // Iterate from S3 to C2 (excluding C1)
  final s3Index = sensoryLevels.indexOf('S3');
  for (int i = s3Index; i >= 1; i--) {
    final level = sensoryLevels[i];
    final lt = side.lightTouch[level];
    final pp = side.pinPrick[level];

    // Both absent -> continue
    if (lt == '0' && pp == '0') continue;

    // Check if can be absent
    if (!_canBeAbsentSensory(lt) || !_canBeAbsentSensory(pp)) {
      // Sensory found, add and stop
      zpp.add(level);
      break;
    }

    // NT-like values
    final hasNT = ['NT', 'NT*'].contains(lt) || ['NT', 'NT*'].contains(pp);
    if (hasNT) {
      zpp.add(level);
      continue;
    }

    // Star values (0*) - add with star and continue
    zpp.add('$level*');

    if (i == 1) break; // Reached C2
  }

  // If we iterated all the way to C1
  if (zpp.isEmpty ||
      (zpp.length == 1 && zpp[0] == 'NA')) {
    // Check if we need to add C1
  }

  // Sort: NA first, then by level order
  zpp.sort((a, b) {
    final aIdx =
        a == 'NA' ? -1 : sensoryLevels.indexOf(a.replaceAll('*', ''));
    final bIdx =
        b == 'NA' ? -1 : sensoryLevels.indexOf(b.replaceAll('*', ''));
    return aIdx.compareTo(bIdx);
  });

  return zpp.isEmpty ? 'NA' : zpp.join(',');
}

/// Determine Motor ZPP for one side.
String _determineMotorZPP(
  ExamSide side,
  BinaryObservation vac,
  String ais,
  String motorLevel,
) {
  // Check if applicable
  if (vac == BinaryObservation.yes) return 'NA';

  final zpp = <String>[];

  if (vac == BinaryObservation.nt) {
    zpp.add('NA');
  }

  // Determine search range
  final cleanMotorLevel = motorLevel.replaceAll('*', '');
  final motorLevelParts = cleanMotorLevel.split(',');
  final top = motorLevelParts.first;
  final lowestMotorLevel = motorLevelParts.last;

  final levelBelowS1Pattern = RegExp(r'(S2|S3|INT)\*?(,|$)');
  final hasMotorBelowS1 = levelBelowS1Pattern.hasMatch(motorLevel);
  final bottom = hasMotorBelowS1
      ? (lowestMotorLevel == 'INT' ? 'S3' : lowestMotorLevel)
      : 'S1';

  final topIndex = sensoryLevels.indexOf(top);
  final bottomIndex = sensoryLevels.indexOf(bottom);

  if (topIndex < 0 || bottomIndex < 0) return zpp.isEmpty ? 'NA' : zpp.join(',');

  // Test non-key muscle consideration
  final testNonKeyMuscle =
      side.lowestNonKeyMuscleWithMotorFunction != null &&
          ais.toUpperCase().contains('C');

  // Iterate from bottom to top
  for (int i = bottomIndex; i >= topIndex; i--) {
    final level = sensoryLevels[i];
    final isMotorLevel = motorLevels.contains(level);

    if (isMotorLevel) {
      final motorValue = side.motor[level];

      // Has motor function (grades 1-5, NT**, 0**)
      final hasMotorFunction =
          RegExp(r'^[1-5]|^(?:NT|0)\*\*$').hasMatch(motorValue);

      if (hasMotorFunction) {
        if (testNonKeyMuscle &&
            side.lowestNonKeyMuscleWithMotorFunction != null) {
          final nonKeyIdx = sensoryLevels
              .indexOf(side.lowestNonKeyMuscleWithMotorFunction!);
          if (nonKeyIdx - i > 3) {
            // Override by non-key muscle
            continue;
          }
        }
        zpp.add(level);
        break;
      }

      // NT or 0* - add and continue
      if (RegExp(r'^(NT\*?$)|(0\*$)').hasMatch(motorValue)) {
        zpp.add(level);
        continue;
      }

      // No motor function
      continue;
    } else {
      // Sensory level - check if it's in the motor level values
      if (cleanMotorLevel.contains(level)) {
        zpp.add(level);
        continue;
      }
    }
  }

  // Add non-key muscle if needed
  if (testNonKeyMuscle &&
      side.lowestNonKeyMuscleWithMotorFunction != null &&
      !zpp.contains(side.lowestNonKeyMuscleWithMotorFunction)) {
    zpp.add(side.lowestNonKeyMuscleWithMotorFunction!);
  }

  // Sort: NA first, then by level order
  zpp.sort((a, b) {
    final aIdx =
        a == 'NA' ? -1 : sensoryLevels.indexOf(a.replaceAll('*', ''));
    final bIdx =
        b == 'NA' ? -1 : sensoryLevels.indexOf(b.replaceAll('*', ''));
    return aIdx.compareTo(bIdx);
  });

  return zpp.isEmpty ? 'NA' : zpp.join(',');
}

/// Determine Zone of Partial Preservation for all four quadrants.
ZoneOfPartialPreservation _determineZoneOfPartialPreservation(
  Exam exam,
  String ais,
  NeurologicalLevels neurologicalLevels,
) {
  return ZoneOfPartialPreservation(
    sensoryRight:
        _determineSensoryZPP(exam.right, exam.deepAnalPressure),
    sensoryLeft:
        _determineSensoryZPP(exam.left, exam.deepAnalPressure),
    motorRight: _determineMotorZPP(
      exam.right,
      exam.voluntaryAnalContraction,
      ais,
      neurologicalLevels.motorRight,
    ),
    motorLeft: _determineMotorZPP(
      exam.left,
      exam.voluntaryAnalContraction,
      ais,
      neurologicalLevels.motorLeft,
    ),
  );
}

// ============================================================================
// Classification (main orchestrator)
// ============================================================================

Classification _classify(Exam exam) {
  final neurologicalLevels = _determineNeurologicalLevels(exam);
  final neurologicalLevelOfInjury =
      _determineNeurologicalLevelOfInjury(exam);
  final injuryComplete = _determineInjuryComplete(exam);
  final ais = _determineASIAImpairmentScale(
    exam,
    injuryComplete,
    neurologicalLevels,
    neurologicalLevelOfInjury,
  );
  final zpp = _determineZoneOfPartialPreservation(
    exam,
    ais,
    neurologicalLevels,
  );

  return Classification(
    neurologicalLevels: neurologicalLevels,
    neurologicalLevelOfInjury: neurologicalLevelOfInjury,
    injuryComplete: injuryComplete,
    asiaImpairmentScale: ais,
    zoneOfPartialPreservation: zpp,
  );
}

// ============================================================================
// Totals Calculation
// ============================================================================

/// Calculate the numeric total of motor values for the specified option.
String _calculateMotorTotal(Motor motor, String option) {
  List<String> values;

  if (option == 'all') {
    values = motor.allValues;
  } else if (option == 'upper') {
    values = motor.upperValues;
  } else if (option == 'lower') {
    values = motor.lowerValues;
  } else {
    throw ArgumentError("option should be one of 'all', 'upper', 'lower'");
  }

  if (values.any((v) => ntValues.contains(v))) {
    return notDeterminable;
  }

  final total = values
      .map((v) => int.parse(v.replaceAll('*', '')))
      .reduce((a, b) => a + b);
  return total.toString();
}

/// Calculate the numeric total of sensory values for one modality on one side.
String _calculateSensoryTotal(Sensory sensory) {
  final values = sensory.allValues;

  if (values.any((v) => ntValues.contains(v))) {
    return notDeterminable;
  }

  final total = values
      .map((v) => int.parse(v.replaceAll('*', '')))
      .reduce((a, b) => a + b);
  return total.toString();
}

/// Add two total strings together, returning ND if either is ND.
String _addTotals(List<String> values) {
  if (values.contains(notDeterminable)) {
    return notDeterminable;
  }

  final total = values
      .map((v) => int.parse(v.replaceAll('*', '')))
      .reduce((a, b) => a + b);
  return total.toString();
}

/// Calculate side totals for one side.
SideTotals _calculateSideTotals(ExamSide side) {
  return SideTotals(
    motor: _calculateMotorTotal(side.motor, 'all'),
    upperExtremity: _calculateMotorTotal(side.motor, 'upper'),
    lowerExtremity: _calculateMotorTotal(side.motor, 'lower'),
    lightTouch: _calculateSensoryTotal(side.lightTouch),
    pinPrick: _calculateSensoryTotal(side.pinPrick),
  );
}

/// Calculate combined totals for both sides.
Totals _calculateTotals(Exam exam) {
  final left = _calculateSideTotals(exam.left);
  final right = _calculateSideTotals(exam.right);

  return Totals(
    left: left,
    right: right,
    upperExtremity: _addTotals([right.upperExtremity, left.upperExtremity]),
    lowerExtremity: _addTotals([right.lowerExtremity, left.lowerExtremity]),
    lightTouch: _addTotals([right.lightTouch, left.lightTouch]),
    pinPrick: _addTotals([right.pinPrick, left.pinPrick]),
  );
}
