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

/// Binary observation value: 'Yes', 'No', or 'NT' (not testable).
enum BinaryObservation { yes, no, nt }

/// Extension to convert [BinaryObservation] to/from its string label.
extension BinaryObservationExtension on BinaryObservation {
  String get label {
    switch (this) {
      case BinaryObservation.yes:
        return 'Yes';
      case BinaryObservation.no:
        return 'No';
      case BinaryObservation.nt:
        return 'NT';
    }
  }

  static BinaryObservation fromString(String value) {
    switch (value) {
      case 'Yes':
        return BinaryObservation.yes;
      case 'No':
        return BinaryObservation.no;
      case 'NT':
        return BinaryObservation.nt;
      default:
        throw ArgumentError('Invalid BinaryObservation value: $value');
    }
  }
}

/// Motor muscle grade values.
///
/// Valid values: '0'-'5', with optional '*' or '**' suffixes,
/// plus 'NT', 'NT*', 'NT**'.
typedef MotorMuscleValue = String;

/// Sensory point values.
///
/// Valid values: '0', '1', '2', with optional '*' or '**' suffixes,
/// plus 'NT', 'NT*', 'NT**'.
typedef SensoryPointValue = String;

/// Motor examination data for one side of the body.
///
/// Contains the 10 key muscle grades: C5-T1 (upper) and L2-S1 (lower).
class Motor {
  final MotorMuscleValue c5;
  final MotorMuscleValue c6;
  final MotorMuscleValue c7;
  final MotorMuscleValue c8;
  final MotorMuscleValue t1;
  final MotorMuscleValue l2;
  final MotorMuscleValue l3;
  final MotorMuscleValue l4;
  final MotorMuscleValue l5;
  final MotorMuscleValue s1;

  const Motor({
    required this.c5,
    required this.c6,
    required this.c7,
    required this.c8,
    required this.t1,
    required this.l2,
    required this.l3,
    required this.l4,
    required this.l5,
    required this.s1,
  });

  /// Create a Motor with all values set to a single value (e.g., '5' for normal).
  factory Motor.allSame(MotorMuscleValue value) => Motor(
        c5: value,
        c6: value,
        c7: value,
        c8: value,
        t1: value,
        l2: value,
        l3: value,
        l4: value,
        l5: value,
        s1: value,
      );

  /// Get value by level name string.
  MotorMuscleValue operator [](String level) {
    switch (level) {
      case 'C5':
        return c5;
      case 'C6':
        return c6;
      case 'C7':
        return c7;
      case 'C8':
        return c8;
      case 'T1':
        return t1;
      case 'L2':
        return l2;
      case 'L3':
        return l3;
      case 'L4':
        return l4;
      case 'L5':
        return l5;
      case 'S1':
        return s1;
      default:
        throw ArgumentError('Invalid motor level: $level');
    }
  }

  /// Returns a map of all motor level values.
  Map<String, MotorMuscleValue> toMap() => {
        'C5': c5,
        'C6': c6,
        'C7': c7,
        'C8': c8,
        'T1': t1,
        'L2': l2,
        'L3': l3,
        'L4': l4,
        'L5': l5,
        'S1': s1,
      };

  /// Returns a list of all motor values in order.
  List<MotorMuscleValue> get allValues => [c5, c6, c7, c8, t1, l2, l3, l4, l5, s1];

  /// Upper-extremity motor values (C5-T1).
  List<MotorMuscleValue> get upperValues => [c5, c6, c7, c8, t1];

  /// Lower-extremity motor values (L2-S1).
  List<MotorMuscleValue> get lowerValues => [l2, l3, l4, l5, s1];

  /// Create a copy with optional overrides.
  Motor copyWith({
    MotorMuscleValue? c5,
    MotorMuscleValue? c6,
    MotorMuscleValue? c7,
    MotorMuscleValue? c8,
    MotorMuscleValue? t1,
    MotorMuscleValue? l2,
    MotorMuscleValue? l3,
    MotorMuscleValue? l4,
    MotorMuscleValue? l5,
    MotorMuscleValue? s1,
  }) {
    return Motor(
      c5: c5 ?? this.c5,
      c6: c6 ?? this.c6,
      c7: c7 ?? this.c7,
      c8: c8 ?? this.c8,
      t1: t1 ?? this.t1,
      l2: l2 ?? this.l2,
      l3: l3 ?? this.l3,
      l4: l4 ?? this.l4,
      l5: l5 ?? this.l5,
      s1: s1 ?? this.s1,
    );
  }
}

/// Sensory examination data for one modality (light touch or pin prick)
/// on one side of the body. Contains values for C2 through S4-5.
class Sensory {
  final SensoryPointValue c2;
  final SensoryPointValue c3;
  final SensoryPointValue c4;
  final SensoryPointValue c5;
  final SensoryPointValue c6;
  final SensoryPointValue c7;
  final SensoryPointValue c8;
  final SensoryPointValue t1;
  final SensoryPointValue t2;
  final SensoryPointValue t3;
  final SensoryPointValue t4;
  final SensoryPointValue t5;
  final SensoryPointValue t6;
  final SensoryPointValue t7;
  final SensoryPointValue t8;
  final SensoryPointValue t9;
  final SensoryPointValue t10;
  final SensoryPointValue t11;
  final SensoryPointValue t12;
  final SensoryPointValue l1;
  final SensoryPointValue l2;
  final SensoryPointValue l3;
  final SensoryPointValue l4;
  final SensoryPointValue l5;
  final SensoryPointValue s1;
  final SensoryPointValue s2;
  final SensoryPointValue s3;
  final SensoryPointValue s4_5;

  const Sensory({
    required this.c2,
    required this.c3,
    required this.c4,
    required this.c5,
    required this.c6,
    required this.c7,
    required this.c8,
    required this.t1,
    required this.t2,
    required this.t3,
    required this.t4,
    required this.t5,
    required this.t6,
    required this.t7,
    required this.t8,
    required this.t9,
    required this.t10,
    required this.t11,
    required this.t12,
    required this.l1,
    required this.l2,
    required this.l3,
    required this.l4,
    required this.l5,
    required this.s1,
    required this.s2,
    required this.s3,
    required this.s4_5,
  });

  /// Create a Sensory with all values set to a single value (e.g., '2' for normal).
  factory Sensory.allSame(SensoryPointValue value) => Sensory(
        c2: value,
        c3: value,
        c4: value,
        c5: value,
        c6: value,
        c7: value,
        c8: value,
        t1: value,
        t2: value,
        t3: value,
        t4: value,
        t5: value,
        t6: value,
        t7: value,
        t8: value,
        t9: value,
        t10: value,
        t11: value,
        t12: value,
        l1: value,
        l2: value,
        l3: value,
        l4: value,
        l5: value,
        s1: value,
        s2: value,
        s3: value,
        s4_5: value,
      );

  /// Get value by level name string.
  SensoryPointValue operator [](String level) {
    switch (level) {
      case 'C2':
        return c2;
      case 'C3':
        return c3;
      case 'C4':
        return c4;
      case 'C5':
        return c5;
      case 'C6':
        return c6;
      case 'C7':
        return c7;
      case 'C8':
        return c8;
      case 'T1':
        return t1;
      case 'T2':
        return t2;
      case 'T3':
        return t3;
      case 'T4':
        return t4;
      case 'T5':
        return t5;
      case 'T6':
        return t6;
      case 'T7':
        return t7;
      case 'T8':
        return t8;
      case 'T9':
        return t9;
      case 'T10':
        return t10;
      case 'T11':
        return t11;
      case 'T12':
        return t12;
      case 'L1':
        return l1;
      case 'L2':
        return l2;
      case 'L3':
        return l3;
      case 'L4':
        return l4;
      case 'L5':
        return l5;
      case 'S1':
        return s1;
      case 'S2':
        return s2;
      case 'S3':
        return s3;
      case 'S4_5':
        return s4_5;
      default:
        throw ArgumentError('Invalid sensory level: $level');
    }
  }

  /// Returns all values as a list in C2-S4_5 order.
  List<SensoryPointValue> get allValues => [
        c2, c3, c4, c5, c6, c7, c8, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10,
        t11, t12, l1, l2, l3, l4, l5, s1, s2, s3, s4_5,
      ];

  /// Returns a map of all sensory level values.
  Map<String, SensoryPointValue> toMap() {
    final map = <String, SensoryPointValue>{};
    for (int i = 0; i < sensoryExamLevels.length; i++) {
      map[sensoryExamLevels[i]] = allValues[i];
    }
    return map;
  }

  /// Create a copy with optional overrides by level name.
  Sensory copyWithLevel(String level, SensoryPointValue value) {
    final map = toMap();
    map[level] = value;
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
}

/// One side of the examination (right or left).
class ExamSide {
  final Motor motor;
  final Sensory lightTouch;
  final Sensory pinPrick;

  /// The lowest non-key muscle with motor function on this side, if any.
  /// Used in ZPP and AIS C/D calculations.
  final String? lowestNonKeyMuscleWithMotorFunction;

  const ExamSide({
    required this.motor,
    required this.lightTouch,
    required this.pinPrick,
    this.lowestNonKeyMuscleWithMotorFunction,
  });

  /// Create an ExamSide with all normal values.
  factory ExamSide.normal() => ExamSide(
        motor: Motor.allSame('5'),
        lightTouch: Sensory.allSame('2'),
        pinPrick: Sensory.allSame('2'),
      );

  ExamSide copyWith({
    Motor? motor,
    Sensory? lightTouch,
    Sensory? pinPrick,
    String? lowestNonKeyMuscleWithMotorFunction,
  }) {
    return ExamSide(
      motor: motor ?? this.motor,
      lightTouch: lightTouch ?? this.lightTouch,
      pinPrick: pinPrick ?? this.pinPrick,
      lowestNonKeyMuscleWithMotorFunction:
          lowestNonKeyMuscleWithMotorFunction ??
              this.lowestNonKeyMuscleWithMotorFunction,
    );
  }
}

/// The complete ISNCSCI examination data.
class Exam {
  final ExamSide right;
  final ExamSide left;
  final BinaryObservation voluntaryAnalContraction;
  final BinaryObservation deepAnalPressure;

  const Exam({
    required this.right,
    required this.left,
    required this.voluntaryAnalContraction,
    required this.deepAnalPressure,
  });

  /// Create an Exam with all normal values (AIS E).
  factory Exam.normal() => Exam(
        right: ExamSide.normal(),
        left: ExamSide.normal(),
        voluntaryAnalContraction: BinaryObservation.yes,
        deepAnalPressure: BinaryObservation.yes,
      );

  Exam copyWith({
    ExamSide? right,
    ExamSide? left,
    BinaryObservation? voluntaryAnalContraction,
    BinaryObservation? deepAnalPressure,
  }) {
    return Exam(
      right: right ?? this.right,
      left: left ?? this.left,
      voluntaryAnalContraction:
          voluntaryAnalContraction ?? this.voluntaryAnalContraction,
      deepAnalPressure: deepAnalPressure ?? this.deepAnalPressure,
    );
  }
}
