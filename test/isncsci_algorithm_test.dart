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

import 'package:flutter_test/flutter_test.dart';
import 'package:sci_training/core/isncsci/isncsci_algorithm.dart';
import 'package:sci_training/core/isncsci/isncsci_exam_model.dart';
import 'package:sci_training/core/isncsci/isncsci_constants.dart';

// ============================================================================
// Helper: Build an Exam from level-based overrides
// ============================================================================

/// Creates a normal exam, then applies overrides below [injuryLevel] for
/// motor, light touch, and pin prick, setting values to [belowMotor],
/// [belowLT], and [belowPP] respectively on both sides.
///
/// [injuryLevel] should be a sensory level name (e.g., 'C5', 'T4').
/// Values AT the injury level remain normal; values BELOW become the override.
Exam buildExamWithInjuryBelow({
  required String injuryLevel,
  String belowMotor = '0',
  String belowLT = '0',
  String belowPP = '0',
  BinaryObservation vac = BinaryObservation.no,
  BinaryObservation dap = BinaryObservation.no,
  // Overrides for right side only (for asymmetric tests)
  Motor? rightMotorOverride,
  Motor? leftMotorOverride,
  Sensory? rightLTOverride,
  Sensory? leftLTOverride,
  Sensory? rightPPOverride,
  Sensory? leftPPOverride,
  String? rightLowestNonKey,
  String? leftLowestNonKey,
}) {
  final injuryIdx = sensoryLevels.indexOf(injuryLevel);
  if (injuryIdx < 0) {
    throw ArgumentError('Invalid injury level: $injuryLevel');
  }

  // Build sensory with normal values above and at injury level,
  // override values below
  Sensory buildSensory(String normalVal, String belowVal,
      [Sensory? override]) {
    if (override != null) return override;
    final map = <String, String>{};
    for (int i = 0; i < sensoryExamLevels.length; i++) {
      final level = sensoryExamLevels[i];
      final levelIdx = sensoryLevels.indexOf(level);
      map[level] = levelIdx <= injuryIdx ? normalVal : belowVal;
    }
    return Sensory(
      c2: map['C2']!,
      c3: map['C3']!,
      c4: map['C4']!,
      c5: map['C5']!,
      c6: map['C6']!,
      c7: map['C7']!,
      c8: map['C8']!,
      t1: map['T1']!,
      t2: map['T2']!,
      t3: map['T3']!,
      t4: map['T4']!,
      t5: map['T5']!,
      t6: map['T6']!,
      t7: map['T7']!,
      t8: map['T8']!,
      t9: map['T9']!,
      t10: map['T10']!,
      t11: map['T11']!,
      t12: map['T12']!,
      l1: map['L1']!,
      l2: map['L2']!,
      l3: map['L3']!,
      l4: map['L4']!,
      l5: map['L5']!,
      s1: map['S1']!,
      s2: map['S2']!,
      s3: map['S3']!,
      s4_5: map['S4_5']!,
    );
  }

  // Build motor with normal values for motor levels at/above injury,
  // override values for motor levels below
  Motor buildMotor(String normalVal, String belowVal, [Motor? override]) {
    if (override != null) return override;
    final map = <String, String>{};
    for (final ml in motorLevels) {
      final levelIdx = sensoryLevels.indexOf(ml);
      map[ml] = levelIdx <= injuryIdx ? normalVal : belowVal;
    }
    return Motor(
      c5: map['C5']!,
      c6: map['C6']!,
      c7: map['C7']!,
      c8: map['C8']!,
      t1: map['T1']!,
      l2: map['L2']!,
      l3: map['L3']!,
      l4: map['L4']!,
      l5: map['L5']!,
      s1: map['S1']!,
    );
  }

  return Exam(
    right: ExamSide(
      motor: buildMotor('5', belowMotor, rightMotorOverride),
      lightTouch: buildSensory('2', belowLT, rightLTOverride),
      pinPrick: buildSensory('2', belowPP, rightPPOverride),
      lowestNonKeyMuscleWithMotorFunction: rightLowestNonKey,
    ),
    left: ExamSide(
      motor: buildMotor('5', belowMotor, leftMotorOverride),
      lightTouch: buildSensory('2', belowLT, leftLTOverride),
      pinPrick: buildSensory('2', belowPP, leftPPOverride),
      lowestNonKeyMuscleWithMotorFunction: leftLowestNonKey,
    ),
    voluntaryAnalContraction: vac,
    deepAnalPressure: dap,
  );
}

void main() {
  group('ISNCSCI Algorithm', () {
    // ========================================================================
    // Test 1: Complete C5 AIS A - No sacral sparing
    // ========================================================================
    test('Complete C5 AIS A - no sacral sparing', () {
      // Normal at C5 and above, 0 below C5 for sensory;
      // Motor: C5 = 5, everything below = 0;
      // VAC = No, DAP = No
      final exam = buildExamWithInjuryBelow(
        injuryLevel: 'C5',
        belowMotor: '0',
        belowLT: '0',
        belowPP: '0',
        vac: BinaryObservation.no,
        dap: BinaryObservation.no,
      );

      final result = calculateISNCSCI(exam);

      expect(result.classification.injuryComplete, equals('C'));
      expect(result.classification.asiaImpairmentScale, contains('A'));
      // NLI should be C5
      expect(
          result.classification.neurologicalLevelOfInjury, contains('C5'));
    });

    // ========================================================================
    // Test 2: Incomplete C6 AIS B - Sensory at S4-5 but no motor
    // ========================================================================
    test('Incomplete C6 AIS B - sensory preserved at S4-5, no motor below', () {
      // Normal at C6, 0 below for motor;
      // Sensory: 0 below C6 except S4-5 has LT=1
      // VAC = No, DAP = No
      final rightLT = Sensory(
        c2: '2', c3: '2', c4: '2', c5: '2', c6: '2',
        c7: '0', c8: '0', t1: '0', t2: '0', t3: '0',
        t4: '0', t5: '0', t6: '0', t7: '0', t8: '0',
        t9: '0', t10: '0', t11: '0', t12: '0', l1: '0',
        l2: '0', l3: '0', l4: '0', l5: '0', s1: '0',
        s2: '0', s3: '0', s4_5: '1',
      );
      final leftLT = Sensory(
        c2: '2', c3: '2', c4: '2', c5: '2', c6: '2',
        c7: '0', c8: '0', t1: '0', t2: '0', t3: '0',
        t4: '0', t5: '0', t6: '0', t7: '0', t8: '0',
        t9: '0', t10: '0', t11: '0', t12: '0', l1: '0',
        l2: '0', l3: '0', l4: '0', l5: '0', s1: '0',
        s2: '0', s3: '0', s4_5: '1',
      );

      final exam = buildExamWithInjuryBelow(
        injuryLevel: 'C6',
        belowMotor: '0',
        belowLT: '0',
        belowPP: '0',
        vac: BinaryObservation.no,
        dap: BinaryObservation.no,
        rightLTOverride: rightLT,
        leftLTOverride: leftLT,
      );

      final result = calculateISNCSCI(exam);

      expect(result.classification.injuryComplete, equals('I'));
      expect(result.classification.asiaImpairmentScale, contains('B'));
    });

    // ========================================================================
    // Test 3: AIS C - Motor incomplete, < 50% key muscles >= 3
    // ========================================================================
    test('AIS C - motor incomplete with less than half key muscles >= 3', () {
      // Injury at C4, VAC = Yes (motor incomplete)
      // Motor: all below = 1 (< grade 3)
      final exam = buildExamWithInjuryBelow(
        injuryLevel: 'C4',
        belowMotor: '1',
        belowLT: '1',
        belowPP: '1',
        vac: BinaryObservation.yes,
        dap: BinaryObservation.no,
      );

      final result = calculateISNCSCI(exam);

      expect(result.classification.asiaImpairmentScale, contains('C'));
    });

    // ========================================================================
    // Test 4: AIS D - Motor incomplete, >= 50% key muscles >= 3
    // ========================================================================
    test('AIS D - motor incomplete with at least half key muscles >= 3', () {
      // Injury at C5. Motor: C6 = 3, C7 = 3, C8 = 3, T1 = 3,
      // L2-S1 all = 4. VAC = Yes.
      final rightMotor = Motor(
        c5: '5', c6: '3', c7: '3', c8: '3', t1: '3',
        l2: '4', l3: '4', l4: '4', l5: '4', s1: '4',
      );
      final leftMotor = Motor(
        c5: '5', c6: '3', c7: '3', c8: '3', t1: '3',
        l2: '4', l3: '4', l4: '4', l5: '4', s1: '4',
      );

      final exam = buildExamWithInjuryBelow(
        injuryLevel: 'C5',
        belowLT: '1',
        belowPP: '1',
        vac: BinaryObservation.yes,
        dap: BinaryObservation.no,
        rightMotorOverride: rightMotor,
        leftMotorOverride: leftMotor,
      );

      final result = calculateISNCSCI(exam);

      expect(result.classification.asiaImpairmentScale, contains('D'));
    });

    // ========================================================================
    // Test 5: AIS E - All normal
    // ========================================================================
    test('AIS E - completely normal examination', () {
      final exam = Exam.normal();
      final result = calculateISNCSCI(exam);

      expect(result.classification.asiaImpairmentScale, equals('E'));
      expect(result.classification.neurologicalLevelOfInjury, contains('INT'));
      expect(result.classification.injuryComplete, equals('I'));

      // Totals should be max scores
      expect(result.totals.upperExtremity, equals('50'));
      expect(result.totals.lowerExtremity, equals('50'));
      expect(result.totals.lightTouch, equals('112'));
      expect(result.totals.pinPrick, equals('112'));
    });

    // ========================================================================
    // Test 6: Asymmetric injury (Brown-Sequard pattern)
    // ========================================================================
    test('Asymmetric injury - Brown-Sequard pattern', () {
      // Right side: motor and sensory loss below C5
      // Left side: normal motor, sensory loss below C5
      final rightMotor = Motor(
        c5: '5', c6: '0', c7: '0', c8: '0', t1: '0',
        l2: '0', l3: '0', l4: '0', l5: '0', s1: '0',
      );
      final leftMotor = Motor.allSame('5');

      final exam = buildExamWithInjuryBelow(
        injuryLevel: 'C5',
        belowLT: '0',
        belowPP: '0',
        vac: BinaryObservation.yes,
        dap: BinaryObservation.yes,
        rightMotorOverride: rightMotor,
        leftMotorOverride: leftMotor,
      );

      final result = calculateISNCSCI(exam);

      // Neurological levels should differ between sides
      expect(result.classification.neurologicalLevels.motorRight,
          isNot(equals(result.classification.neurologicalLevels.motorLeft)));
    });

    // ========================================================================
    // Test 7: NT values producing ND totals
    // ========================================================================
    test('NT values produce ND totals', () {
      // Normal exam except C7 motor = NT on right side
      final rightMotor = Motor(
        c5: '5', c6: '5', c7: 'NT', c8: '5', t1: '5',
        l2: '5', l3: '5', l4: '5', l5: '5', s1: '5',
      );

      final exam = Exam(
        right: ExamSide(
          motor: rightMotor,
          lightTouch: Sensory.allSame('2'),
          pinPrick: Sensory.allSame('2'),
        ),
        left: ExamSide.normal(),
        voluntaryAnalContraction: BinaryObservation.yes,
        deepAnalPressure: BinaryObservation.yes,
      );

      final result = calculateISNCSCI(exam);

      // Right motor total should be ND
      expect(result.totals.right.motor, equals('ND'));
      expect(result.totals.right.upperExtremity, equals('ND'));
      // Left motor total should be normal (50)
      expect(result.totals.left.motor, equals('50'));
      // Combined should be ND
      expect(result.totals.upperExtremity, equals('ND'));
    });

    // ========================================================================
    // Test 8: Asterisk value handling in totals
    // ========================================================================
    test('Asterisk values are stripped for totals calculation', () {
      // Motor values with asterisks
      final rightMotor = Motor(
        c5: '5', c6: '4*', c7: '3*', c8: '2*', t1: '1*',
        l2: '5', l3: '5', l4: '5', l5: '5', s1: '5',
      );

      final exam = Exam(
        right: ExamSide(
          motor: rightMotor,
          lightTouch: Sensory.allSame('2'),
          pinPrick: Sensory.allSame('2'),
        ),
        left: ExamSide.normal(),
        voluntaryAnalContraction: BinaryObservation.yes,
        deepAnalPressure: BinaryObservation.yes,
      );

      final result = calculateISNCSCI(exam);

      // Right UE: 5 + 4 + 3 + 2 + 1 = 15
      expect(result.totals.right.upperExtremity, equals('15'));
      // Right LE: 5*5 = 25
      expect(result.totals.right.lowerExtremity, equals('25'));
      // Right motor total: 15 + 25 = 40
      expect(result.totals.right.motor, equals('40'));
    });

    // ========================================================================
    // Test 9: ZPP calculation for AIS A
    // ========================================================================
    test('ZPP calculation for complete injury (AIS A)', () {
      // Complete C6 injury with some preserved sensory below
      final rightLT = Sensory(
        c2: '2', c3: '2', c4: '2', c5: '2', c6: '2',
        c7: '1', c8: '0', t1: '0', t2: '0', t3: '0',
        t4: '0', t5: '0', t6: '0', t7: '0', t8: '0',
        t9: '0', t10: '0', t11: '0', t12: '0', l1: '0',
        l2: '0', l3: '0', l4: '0', l5: '0', s1: '0',
        s2: '0', s3: '0', s4_5: '0',
      );
      final leftLT = Sensory(
        c2: '2', c3: '2', c4: '2', c5: '2', c6: '2',
        c7: '0', c8: '0', t1: '0', t2: '0', t3: '0',
        t4: '0', t5: '0', t6: '0', t7: '0', t8: '0',
        t9: '0', t10: '0', t11: '0', t12: '0', l1: '0',
        l2: '0', l3: '0', l4: '0', l5: '0', s1: '0',
        s2: '0', s3: '0', s4_5: '0',
      );

      final exam = buildExamWithInjuryBelow(
        injuryLevel: 'C6',
        belowMotor: '0',
        belowPP: '0',
        vac: BinaryObservation.no,
        dap: BinaryObservation.no,
        rightLTOverride: rightLT,
        leftLTOverride: leftLT,
      );

      final result = calculateISNCSCI(exam);

      // Right sensory ZPP should include C7 (preserved LT=1)
      expect(
        result.classification.zoneOfPartialPreservation.sensoryRight,
        contains('C7'),
      );
    });

    // ========================================================================
    // Test 10: Motor level rule (>= 3/5 with level above 5/5)
    // ========================================================================
    test('Motor level determination with grade 3 and above grade 5', () {
      // C5 = 5, C6 = 3, C7 = 0, everything below = 0
      // Motor level should be C6 (last >= 3 with level above == 5)
      final rightMotor = Motor(
        c5: '5', c6: '3', c7: '0', c8: '0', t1: '0',
        l2: '0', l3: '0', l4: '0', l5: '0', s1: '0',
      );
      final leftMotor = Motor(
        c5: '5', c6: '3', c7: '0', c8: '0', t1: '0',
        l2: '0', l3: '0', l4: '0', l5: '0', s1: '0',
      );

      final exam = buildExamWithInjuryBelow(
        injuryLevel: 'C4',
        belowLT: '0',
        belowPP: '0',
        vac: BinaryObservation.no,
        dap: BinaryObservation.no,
        rightMotorOverride: rightMotor,
        leftMotorOverride: leftMotor,
      );

      final result = calculateISNCSCI(exam);

      // Motor level should be C6 on both sides
      // (C5 is 5 = normal, C6 is 3 >= 3 with level above 5)
      expect(result.classification.neurologicalLevels.motorRight,
          contains('C6'));
      expect(result.classification.neurologicalLevels.motorLeft,
          contains('C6'));
    });

    // ========================================================================
    // Test 11: Sensory totals calculation
    // ========================================================================
    test('Sensory totals calculation with mixed values', () {
      final rightLT = Sensory(
        c2: '2', c3: '2', c4: '2', c5: '2', c6: '2',
        c7: '1', c8: '1', t1: '0', t2: '0', t3: '0',
        t4: '0', t5: '0', t6: '0', t7: '0', t8: '0',
        t9: '0', t10: '0', t11: '0', t12: '0', l1: '0',
        l2: '0', l3: '0', l4: '0', l5: '0', s1: '0',
        s2: '0', s3: '0', s4_5: '0',
      );

      final exam = Exam(
        right: ExamSide(
          motor: Motor.allSame('5'),
          lightTouch: rightLT,
          pinPrick: Sensory.allSame('2'),
        ),
        left: ExamSide.normal(),
        voluntaryAnalContraction: BinaryObservation.yes,
        deepAnalPressure: BinaryObservation.yes,
      );

      final result = calculateISNCSCI(exam);

      // Right LT: 5*2 + 2*1 + 21*0 = 12
      expect(result.totals.right.lightTouch, equals('12'));
      // Left LT: all normal = 28 * 2 = 56
      expect(result.totals.left.lightTouch, equals('56'));
      // Combined LT: 12 + 56 = 68
      expect(result.totals.lightTouch, equals('68'));
    });

    // ========================================================================
    // Test 12: Complete T6 injury with motor totals
    // ========================================================================
    test('Complete T6 injury motor totals', () {
      final exam = buildExamWithInjuryBelow(
        injuryLevel: 'T6',
        belowMotor: '0',
        belowLT: '0',
        belowPP: '0',
        vac: BinaryObservation.no,
        dap: BinaryObservation.no,
      );

      final result = calculateISNCSCI(exam);

      // UE motor should be 25 per side (all C5-T1 = 5)
      expect(result.totals.right.upperExtremity, equals('25'));
      expect(result.totals.left.upperExtremity, equals('25'));
      // LE motor should be 0 per side (all L2-S1 = 0)
      expect(result.totals.right.lowerExtremity, equals('0'));
      expect(result.totals.left.lowerExtremity, equals('0'));
      // Combined UE = 50, LE = 0
      expect(result.totals.upperExtremity, equals('50'));
      expect(result.totals.lowerExtremity, equals('0'));
    });

    // ========================================================================
    // Test 13: NT** (double star) handling
    // ========================================================================
    test('NT** values treated as normal for level determination', () {
      // All normal except C7 motor = NT** on both sides
      // NT** should be treated as "consider normal"
      final rightMotor = Motor(
        c5: '5', c6: '5', c7: 'NT**', c8: '5', t1: '5',
        l2: '5', l3: '5', l4: '5', l5: '5', s1: '5',
      );
      final leftMotor = Motor(
        c5: '5', c6: '5', c7: 'NT**', c8: '5', t1: '5',
        l2: '5', l3: '5', l4: '5', l5: '5', s1: '5',
      );

      final exam = Exam(
        right: ExamSide(
          motor: rightMotor,
          lightTouch: Sensory.allSame('2'),
          pinPrick: Sensory.allSame('2'),
        ),
        left: ExamSide(
          motor: leftMotor,
          lightTouch: Sensory.allSame('2'),
          pinPrick: Sensory.allSame('2'),
        ),
        voluntaryAnalContraction: BinaryObservation.yes,
        deepAnalPressure: BinaryObservation.yes,
      );

      final result = calculateISNCSCI(exam);

      // NT** totals should be ND (NT values always produce ND in totals)
      expect(result.totals.right.motor, equals('ND'));
      // But classification should treat NT** as normal
      expect(result.classification.asiaImpairmentScale, contains('E'));
    });
  });
}
