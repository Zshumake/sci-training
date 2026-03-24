import '../core/isncsci/isncsci_exam_model.dart';

/// A complete ISNCSCI training case with exam data and metadata.
class ISNCSCITrainingCase {
  final String id;
  final String title;
  final String clinicalScenario;
  final String difficulty; // 'basic', 'intermediate', 'advanced'
  final Exam exam;
  final String teachingPoints;

  const ISNCSCITrainingCase({
    required this.id,
    required this.title,
    required this.clinicalScenario,
    required this.difficulty,
    required this.exam,
    required this.teachingPoints,
  });
}

// ---------------------------------------------------------------------------
// Helper: build a Sensory with normal values down to a cutoff, then abnormal
// ---------------------------------------------------------------------------

const List<String> _sensoryOrder = [
  'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8',
  'T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9', 'T10', 'T11', 'T12',
  'L1', 'L2', 'L3', 'L4', 'L5',
  'S1', 'S2', 'S3', 'S4_5',
];

/// Build a Sensory where levels down to [lastNormal] are '2',
/// the next [impairedCount] levels are [impairedValue] (default '1'),
/// and everything below is [belowValue] (default '0').
Sensory _buildSensory({
  required String lastNormal,
  int impairedCount = 0,
  String impairedValue = '1',
  String belowValue = '0',
  Map<String, String>? overrides,
}) {
  final idx = _sensoryOrder.indexOf(lastNormal);
  final map = <String, String>{};
  for (int i = 0; i < _sensoryOrder.length; i++) {
    if (i <= idx) {
      map[_sensoryOrder[i]] = '2';
    } else if (i <= idx + impairedCount) {
      map[_sensoryOrder[i]] = impairedValue;
    } else {
      map[_sensoryOrder[i]] = belowValue;
    }
  }
  if (overrides != null) map.addAll(overrides);
  return Sensory(
    c2: map['C2']!, c3: map['C3']!, c4: map['C4']!,
    c5: map['C5']!, c6: map['C6']!, c7: map['C7']!, c8: map['C8']!,
    t1: map['T1']!, t2: map['T2']!, t3: map['T3']!, t4: map['T4']!,
    t5: map['T5']!, t6: map['T6']!, t7: map['T7']!, t8: map['T8']!,
    t9: map['T9']!, t10: map['T10']!, t11: map['T11']!, t12: map['T12']!,
    l1: map['L1']!, l2: map['L2']!, l3: map['L3']!, l4: map['L4']!,
    l5: map['L5']!, s1: map['S1']!, s2: map['S2']!, s3: map['S3']!,
    s4_5: map['S4_5']!,
  );
}

const List<String> _motorOrder = ['C5', 'C6', 'C7', 'C8', 'T1', 'L2', 'L3', 'L4', 'L5', 'S1'];

/// Build a Motor where key muscles down to [lastNormal] are '5',
/// the next [weakCount] muscles are [weakValue] (default '3'),
/// and everything below is [belowValue] (default '0').
Motor _buildMotor({
  String? lastNormal,
  int weakCount = 0,
  String weakValue = '3',
  String belowValue = '0',
  Map<String, String>? overrides,
}) {
  final idx = lastNormal != null ? _motorOrder.indexOf(lastNormal) : -1;
  final map = <String, String>{};
  for (int i = 0; i < _motorOrder.length; i++) {
    if (i <= idx) {
      map[_motorOrder[i]] = '5';
    } else if (i <= idx + weakCount) {
      map[_motorOrder[i]] = weakValue;
    } else {
      map[_motorOrder[i]] = belowValue;
    }
  }
  if (overrides != null) map.addAll(overrides);
  return Motor(
    c5: map['C5']!, c6: map['C6']!, c7: map['C7']!,
    c8: map['C8']!, t1: map['T1']!,
    l2: map['L2']!, l3: map['L3']!, l4: map['L4']!,
    l5: map['L5']!, s1: map['S1']!,
  );
}

// ============================================================================
// 30 Training Cases
// ============================================================================

class ISNCSCITrainingCases {
  static final List<ISNCSCITrainingCase> allCases = [

    // ========================================================================
    // BASIC 1-5: Straightforward complete injuries (AIS A)
    // ========================================================================

    // Case 1: Complete C5 Tetraplegia
    ISNCSCITrainingCase(
      id: 'basic-01',
      title: 'Complete C5 Tetraplegia',
      clinicalScenario:
          'A 22-year-old male dives into a shallow pool and sustains a C5 burst '
          'fracture. Exam at 72 hours shows complete absence of motor and sensory '
          'function below C5 bilaterally. No sacral sparing.',
      difficulty: 'basic',
      exam: Exam(
        right: ExamSide(
          motor: _buildMotor(lastNormal: 'C5', belowValue: '0'),
          lightTouch: _buildSensory(lastNormal: 'C5'),
          pinPrick: _buildSensory(lastNormal: 'C5'),
        ),
        left: ExamSide(
          motor: _buildMotor(lastNormal: 'C5', belowValue: '0'),
          lightTouch: _buildSensory(lastNormal: 'C5'),
          pinPrick: _buildSensory(lastNormal: 'C5'),
        ),
        voluntaryAnalContraction: BinaryObservation.no,
        deepAnalPressure: BinaryObservation.no,
      ),
      teachingPoints:
          'In a symmetric complete injury, all four individual levels (R/L sensory, '
          'R/L motor) are the same. The NLI is straightforwardly C5. No sacral '
          'sparing (no S4-5 sensation, no DAP, no VAC) means AIS A. ZPP is C5 '
          'on all four categories since there is no function below the NLI.',
    ),

    // Case 2: Complete C6 Tetraplegia
    ISNCSCITrainingCase(
      id: 'basic-02',
      title: 'Complete C6 Tetraplegia',
      clinicalScenario:
          'A 35-year-old woman is in a rollover MVC and sustains a C6 '
          'fracture-dislocation. Exam shows intact motor and sensory function '
          'through C6 bilaterally with complete loss below. No sacral sparing.',
      difficulty: 'basic',
      exam: Exam(
        right: ExamSide(
          motor: _buildMotor(lastNormal: 'C6', belowValue: '0'),
          lightTouch: _buildSensory(lastNormal: 'C6'),
          pinPrick: _buildSensory(lastNormal: 'C6'),
        ),
        left: ExamSide(
          motor: _buildMotor(lastNormal: 'C6', belowValue: '0'),
          lightTouch: _buildSensory(lastNormal: 'C6'),
          pinPrick: _buildSensory(lastNormal: 'C6'),
        ),
        voluntaryAnalContraction: BinaryObservation.no,
        deepAnalPressure: BinaryObservation.no,
      ),
      teachingPoints:
          'C6 is the "tenodesis" level -- wrist extension enables functional grasp. '
          'This is a straightforward complete injury. Sensory level C6, motor level '
          'C6 bilaterally. NLI = C6. AIS A because no sacral sparing. Remember that '
          'C6 motor level means C6 (wrist extensors) is >= 3/5 AND C5 above is 5/5.',
    ),

    // Case 3: Complete T6 Paraplegia
    ISNCSCITrainingCase(
      id: 'basic-03',
      title: 'Complete T6 Paraplegia',
      clinicalScenario:
          'A 40-year-old construction worker falls from scaffolding and sustains '
          'a T6 burst fracture. All upper extremity motor and sensory function '
          'is normal. Sensory is normal through T6 bilaterally with complete loss '
          'below. No sacral sparing.',
      difficulty: 'basic',
      exam: Exam(
        right: ExamSide(
          motor: Motor.allSame('5'),
          lightTouch: _buildSensory(lastNormal: 'T6'),
          pinPrick: _buildSensory(lastNormal: 'T6'),
        ),
        left: ExamSide(
          motor: Motor.allSame('5'),
          lightTouch: _buildSensory(lastNormal: 'T6'),
          pinPrick: _buildSensory(lastNormal: 'T6'),
        ),
        voluntaryAnalContraction: BinaryObservation.no,
        deepAnalPressure: BinaryObservation.no,
      ),
      teachingPoints:
          'T6 is a non-key-muscle level (T2-L1). Since all upper extremity key '
          'muscles are 5/5 and sensory is normal through T6, the motor level '
          'follows the sensory level. Motor level = T6 bilaterally. NLI = T6. '
          'AIS A. Note: all 10 key muscles per side are 5/5 but the motor level '
          'is T6 because thoracic segments have no key muscle -- motor level '
          'defaults to sensory level when motor above is normal.',
    ),

    // Case 4: Complete T10 Paraplegia
    ISNCSCITrainingCase(
      id: 'basic-04',
      title: 'Complete T10 Paraplegia',
      clinicalScenario:
          'A 28-year-old is shot in the back at the T10 level. All upper extremity '
          'function is normal. Sensory is intact through T10 bilaterally with '
          'complete loss below. No lower extremity motor function. No sacral sparing.',
      difficulty: 'basic',
      exam: Exam(
        right: ExamSide(
          motor: _buildMotor(lastNormal: 'T1', belowValue: '0'),
          lightTouch: _buildSensory(lastNormal: 'T10'),
          pinPrick: _buildSensory(lastNormal: 'T10'),
        ),
        left: ExamSide(
          motor: _buildMotor(lastNormal: 'T1', belowValue: '0'),
          lightTouch: _buildSensory(lastNormal: 'T10'),
          pinPrick: _buildSensory(lastNormal: 'T10'),
        ),
        voluntaryAnalContraction: BinaryObservation.no,
        deepAnalPressure: BinaryObservation.no,
      ),
      teachingPoints:
          'Sensory level = T10 bilaterally. Motor level = T10 bilaterally (follows '
          'sensory level since T10 has no key muscle and all upper extremity motors '
          'are normal). NLI = T10. AIS A. All lower extremity key muscles (L2-S1) '
          'are 0/5 because the injury is above these levels.',
    ),

    // Case 5: Complete L1 Paraplegia
    ISNCSCITrainingCase(
      id: 'basic-05',
      title: 'Complete L1 Paraplegia',
      clinicalScenario:
          'A 55-year-old sustains an L1 burst fracture in a fall from a ladder. '
          'All sensation is normal through L1 bilaterally with complete loss below. '
          'All upper extremity motors are normal. No lower extremity motor function. '
          'No sacral sparing.',
      difficulty: 'basic',
      exam: Exam(
        right: ExamSide(
          motor: _buildMotor(lastNormal: 'T1', belowValue: '0'),
          lightTouch: _buildSensory(lastNormal: 'L1'),
          pinPrick: _buildSensory(lastNormal: 'L1'),
        ),
        left: ExamSide(
          motor: _buildMotor(lastNormal: 'T1', belowValue: '0'),
          lightTouch: _buildSensory(lastNormal: 'L1'),
          pinPrick: _buildSensory(lastNormal: 'L1'),
        ),
        voluntaryAnalContraction: BinaryObservation.no,
        deepAnalPressure: BinaryObservation.no,
      ),
      teachingPoints:
          'L1 is the last non-key-muscle level before L2. Sensory level = L1 '
          'bilaterally. Motor level = L1 (follows sensory since L1 has no key '
          'muscle and all UE motors are normal). NLI = L1. AIS A. L2 hip flexors '
          'are 0/5 because the injury is at L1.',
    ),

    // ========================================================================
    // BASIC 6-10: Straightforward incomplete injuries (AIS B, C, D)
    // ========================================================================

    // Case 6: AIS B -- Sensory incomplete T8
    ISNCSCITrainingCase(
      id: 'basic-06',
      title: 'Sensory Incomplete T8 (AIS B)',
      clinicalScenario:
          'A 30-year-old falls from a horse and sustains a T8 fracture. Sensory '
          'is normal through T8 bilaterally with absent motor and sensory function '
          'below, except the patient can feel light touch at S4-5 (perianal area). '
          'DAP is present. No VAC. No motor function below the NLI.',
      difficulty: 'basic',
      exam: Exam(
        right: ExamSide(
          motor: Motor.allSame('5').copyWith(l2: '0', l3: '0', l4: '0', l5: '0', s1: '0'),
          lightTouch: _buildSensory(lastNormal: 'T8', overrides: {'S4_5': '1'}),
          pinPrick: _buildSensory(lastNormal: 'T8'),
        ),
        left: ExamSide(
          motor: Motor.allSame('5').copyWith(l2: '0', l3: '0', l4: '0', l5: '0', s1: '0'),
          lightTouch: _buildSensory(lastNormal: 'T8', overrides: {'S4_5': '1'}),
          pinPrick: _buildSensory(lastNormal: 'T8'),
        ),
        voluntaryAnalContraction: BinaryObservation.no,
        deepAnalPressure: BinaryObservation.yes,
      ),
      teachingPoints:
          'Sacral sparing is present (light touch at S4-5 and DAP). This makes '
          'the injury incomplete. No VAC and no motor function below the NLI means '
          'no motor sparing, so this is AIS B (sensory incomplete). The key '
          'distinction: sacral sparing present but no motor below NLI = AIS B.',
    ),

    // Case 7: AIS C -- Motor incomplete C7
    ISNCSCITrainingCase(
      id: 'basic-07',
      title: 'Motor Incomplete C7 (AIS C)',
      clinicalScenario:
          'A 45-year-old sustains a C7 SCI in a fall. Motor and sensory function '
          'are normal through C7 bilaterally. Below C7, there is scattered weak '
          'motor function. VAC is present. Less than half of key muscles below '
          'the NLI have grade 3 or better.',
      difficulty: 'basic',
      exam: Exam(
        right: ExamSide(
          motor: _buildMotor(lastNormal: 'C7', overrides: {
            'C8': '2', 'T1': '1', 'L2': '1', 'L3': '0', 'L4': '0', 'L5': '0', 'S1': '0',
          }),
          lightTouch: _buildSensory(lastNormal: 'C7', impairedCount: 3, belowValue: '1'),
          pinPrick: _buildSensory(lastNormal: 'C7', impairedCount: 2, belowValue: '1'),
        ),
        left: ExamSide(
          motor: _buildMotor(lastNormal: 'C7', overrides: {
            'C8': '2', 'T1': '1', 'L2': '1', 'L3': '0', 'L4': '0', 'L5': '0', 'S1': '0',
          }),
          lightTouch: _buildSensory(lastNormal: 'C7', impairedCount: 3, belowValue: '1'),
          pinPrick: _buildSensory(lastNormal: 'C7', impairedCount: 2, belowValue: '1'),
        ),
        voluntaryAnalContraction: BinaryObservation.yes,
        deepAnalPressure: BinaryObservation.yes,
      ),
      teachingPoints:
          'VAC present automatically makes this at least AIS C (motor incomplete). '
          'To distinguish C from D, count key muscles below the single NLI (C7) '
          'with grade >= 3. Below C7: C8=2, T1=1, L2=1, L3=0, L4=0, L5=0, S1=0 '
          'on each side. That is 0 out of 14 muscles >= 3 (0%). Since < 50%, '
          'this is AIS C.',
    ),

    // Case 8: AIS D -- Motor incomplete T12
    ISNCSCITrainingCase(
      id: 'basic-08',
      title: 'Motor Incomplete T12 (AIS D)',
      clinicalScenario:
          'A 60-year-old with cervical stenosis falls and develops a T12 SCI. '
          'All sensation is normal through T12 bilaterally. Upper extremity motors '
          'are normal. Lower extremity key muscles are mostly 3/5 or better. VAC '
          'is present. DAP is present.',
      difficulty: 'basic',
      exam: Exam(
        right: ExamSide(
          motor: Motor.allSame('5').copyWith(l2: '4', l3: '4', l4: '3', l5: '3', s1: '2'),
          lightTouch: _buildSensory(lastNormal: 'T12', impairedCount: 6, impairedValue: '1', belowValue: '1',
            overrides: {'S4_5': '1'}),
          pinPrick: _buildSensory(lastNormal: 'T12', impairedCount: 6, impairedValue: '1', belowValue: '1',
            overrides: {'S4_5': '1'}),
        ),
        left: ExamSide(
          motor: Motor.allSame('5').copyWith(l2: '4', l3: '3', l4: '3', l5: '3', s1: '2'),
          lightTouch: _buildSensory(lastNormal: 'T12', impairedCount: 6, impairedValue: '1', belowValue: '1',
            overrides: {'S4_5': '1'}),
          pinPrick: _buildSensory(lastNormal: 'T12', impairedCount: 6, impairedValue: '1', belowValue: '1',
            overrides: {'S4_5': '1'}),
        ),
        voluntaryAnalContraction: BinaryObservation.yes,
        deepAnalPressure: BinaryObservation.yes,
      ),
      teachingPoints:
          'Sacral sparing present (S4-5 sensation, DAP, VAC). VAC present means '
          'motor incomplete (at least AIS C). Below the NLI (T12), count key muscles '
          'with grade >= 3: R side L2=4, L3=4, L4=3, L5=3 (4 of 5), L side L2=4, '
          'L3=3, L4=3, L5=3 (4 of 5). Total 8 of 10 muscles >= 3 = 80%. Since '
          '>= 50%, this is AIS D.',
    ),

    // Case 9: AIS B -- Sensory incomplete C5 with DAP only
    ISNCSCITrainingCase(
      id: 'basic-09',
      title: 'Sensory Incomplete C5 (AIS B, DAP Only)',
      clinicalScenario:
          'A 19-year-old rugby player sustains a C5 SCI. Complete motor and '
          'sensory loss below C5 bilaterally. No sensation at S4-5 for LT or PP, '
          'but deep anal pressure IS appreciated. No VAC.',
      difficulty: 'basic',
      exam: Exam(
        right: ExamSide(
          motor: _buildMotor(lastNormal: 'C5', belowValue: '0'),
          lightTouch: _buildSensory(lastNormal: 'C5'),
          pinPrick: _buildSensory(lastNormal: 'C5'),
        ),
        left: ExamSide(
          motor: _buildMotor(lastNormal: 'C5', belowValue: '0'),
          lightTouch: _buildSensory(lastNormal: 'C5'),
          pinPrick: _buildSensory(lastNormal: 'C5'),
        ),
        voluntaryAnalContraction: BinaryObservation.no,
        deepAnalPressure: BinaryObservation.yes,
      ),
      teachingPoints:
          'This case teaches that DAP alone constitutes sacral sparing. Even though '
          'S4-5 LT and PP are 0 and there is no VAC, the presence of DAP means '
          'sacral sparing is present, making this incomplete. No motor function '
          'below NLI and no VAC means AIS B. DAP can be the sole sacral sparing '
          'finding that differentiates AIS A from AIS B.',
    ),

    // Case 10: AIS D -- Motor incomplete L2
    ISNCSCITrainingCase(
      id: 'basic-10',
      title: 'Motor Incomplete L2 (AIS D)',
      clinicalScenario:
          'A 50-year-old sustains an L2 SCI in a fall. Sensory and motor function '
          'are normal through L2 bilaterally. Below, most key muscles have '
          'functional strength. Sacral sparing is present with sensation at '
          'S4-5 and VAC.',
      difficulty: 'basic',
      exam: Exam(
        right: ExamSide(
          motor: Motor.allSame('5').copyWith(l3: '4', l4: '4', l5: '3', s1: '3'),
          lightTouch: _buildSensory(lastNormal: 'L2', impairedCount: 5, impairedValue: '1',
            overrides: {'S4_5': '1'}),
          pinPrick: _buildSensory(lastNormal: 'L2', impairedCount: 5, impairedValue: '1',
            overrides: {'S4_5': '1'}),
        ),
        left: ExamSide(
          motor: Motor.allSame('5').copyWith(l3: '4', l4: '3', l5: '3', s1: '3'),
          lightTouch: _buildSensory(lastNormal: 'L2', impairedCount: 5, impairedValue: '1',
            overrides: {'S4_5': '1'}),
          pinPrick: _buildSensory(lastNormal: 'L2', impairedCount: 5, impairedValue: '1',
            overrides: {'S4_5': '1'}),
        ),
        voluntaryAnalContraction: BinaryObservation.yes,
        deepAnalPressure: BinaryObservation.yes,
      ),
      teachingPoints:
          'NLI = L2. VAC present means motor incomplete. Below L2: R side L3=4, '
          'L4=4, L5=3, S1=3 (all 4 >= 3); L side L3=4, L4=3, L5=3, S1=3 (all 4 '
          '>= 3). Total: 8 of 8 key muscles below NLI >= 3 = 100%. AIS D.',
    ),

    // ========================================================================
    // INTERMEDIATE 11-15: Asymmetric injuries with different R/L levels
    // ========================================================================

    // Case 11: Asymmetric C5/C7 tetraplegia (AIS A)
    ISNCSCITrainingCase(
      id: 'inter-01',
      title: 'Asymmetric Complete Tetraplegia (R:C5, L:C7)',
      clinicalScenario:
          'A 33-year-old sustains a cervical SCI in a skiing accident. The right '
          'side shows motor and sensory function intact through C5 only. The left '
          'side is intact through C7. No sacral sparing.',
      difficulty: 'intermediate',
      exam: Exam(
        right: ExamSide(
          motor: _buildMotor(lastNormal: 'C5', belowValue: '0'),
          lightTouch: _buildSensory(lastNormal: 'C5'),
          pinPrick: _buildSensory(lastNormal: 'C5'),
        ),
        left: ExamSide(
          motor: _buildMotor(lastNormal: 'C7', belowValue: '0'),
          lightTouch: _buildSensory(lastNormal: 'C7'),
          pinPrick: _buildSensory(lastNormal: 'C7'),
        ),
        voluntaryAnalContraction: BinaryObservation.no,
        deepAnalPressure: BinaryObservation.no,
      ),
      teachingPoints:
          'Asymmetric injury: R sensory=C5, R motor=C5, L sensory=C7, L motor=C7. '
          'The NLI is the MOST ROSTRAL of the four levels, so NLI = C5 (the right '
          'side). AIS A because no sacral sparing. ZPP must be determined for each '
          'side separately. This case teaches that NLI reflects the worst side.',
    ),

    // Case 12: Asymmetric sensory/motor levels (AIS B)
    ISNCSCITrainingCase(
      id: 'inter-02',
      title: 'Asymmetric Sensory Incomplete (R:T4, L:T8)',
      clinicalScenario:
          'A 42-year-old sustains a thoracic SCI. Right side: sensory normal '
          'through T4, left side sensory normal through T8. All upper extremity '
          'motors normal. No motor function in lower extremities. Light touch '
          'present at S4-5 bilaterally. DAP present, no VAC.',
      difficulty: 'intermediate',
      exam: Exam(
        right: ExamSide(
          motor: Motor.allSame('5').copyWith(l2: '0', l3: '0', l4: '0', l5: '0', s1: '0'),
          lightTouch: _buildSensory(lastNormal: 'T4', overrides: {'S4_5': '1'}),
          pinPrick: _buildSensory(lastNormal: 'T4'),
        ),
        left: ExamSide(
          motor: Motor.allSame('5').copyWith(l2: '0', l3: '0', l4: '0', l5: '0', s1: '0'),
          lightTouch: _buildSensory(lastNormal: 'T8', overrides: {'S4_5': '1'}),
          pinPrick: _buildSensory(lastNormal: 'T8'),
        ),
        voluntaryAnalContraction: BinaryObservation.no,
        deepAnalPressure: BinaryObservation.yes,
      ),
      teachingPoints:
          'R sensory=T4, L sensory=T8. R motor=T4, L motor=T8 (follows sensory '
          'in non-key-muscle levels). NLI = T4 (most rostral of R:T4, L:T8). '
          'Sacral sparing present (LT at S4-5, DAP). No motor below NLI, no VAC, '
          'so AIS B. This case demonstrates asymmetric sensory levels and how NLI '
          'is determined.',
    ),

    // Case 13: Motor/sensory dissociation (AIS C)
    ISNCSCITrainingCase(
      id: 'inter-03',
      title: 'Motor-Sensory Dissociation (Sensory C6, Motor C5)',
      clinicalScenario:
          'A 27-year-old sustains a cervical SCI. Sensory is normal through C6 '
          'bilaterally. However, the C6 key muscle (wrist extensors) is only 2/5 '
          'bilaterally, with C5 being 5/5. Scattered weak function below. '
          'VAC present.',
      difficulty: 'intermediate',
      exam: Exam(
        right: ExamSide(
          motor: _buildMotor(overrides: {
            'C5': '5', 'C6': '2', 'C7': '1', 'C8': '0', 'T1': '0',
            'L2': '0', 'L3': '0', 'L4': '0', 'L5': '0', 'S1': '0',
          }),
          lightTouch: _buildSensory(lastNormal: 'C6', impairedCount: 4, belowValue: '1',
            overrides: {'S4_5': '1'}),
          pinPrick: _buildSensory(lastNormal: 'C6', impairedCount: 3, belowValue: '1',
            overrides: {'S4_5': '1'}),
        ),
        left: ExamSide(
          motor: _buildMotor(overrides: {
            'C5': '5', 'C6': '2', 'C7': '1', 'C8': '0', 'T1': '0',
            'L2': '0', 'L3': '0', 'L4': '0', 'L5': '0', 'S1': '0',
          }),
          lightTouch: _buildSensory(lastNormal: 'C6', impairedCount: 4, belowValue: '1',
            overrides: {'S4_5': '1'}),
          pinPrick: _buildSensory(lastNormal: 'C6', impairedCount: 3, belowValue: '1',
            overrides: {'S4_5': '1'}),
        ),
        voluntaryAnalContraction: BinaryObservation.yes,
        deepAnalPressure: BinaryObservation.yes,
      ),
      teachingPoints:
          'Motor and sensory levels can differ! Sensory level = C6 (normal LT and '
          'PP through C6). Motor level = C5 (C6 wrist extensors are 2/5, which is '
          '< 3/5, so motor level is C5 since C5 is the most caudal key muscle >= 3 '
          'with the level above normal). NLI = C5 (most rostral of C6 sensory and '
          'C5 motor). VAC present so motor incomplete. Count muscles below NLI: '
          '0 of 14 >= 3. AIS C.',
    ),

    // Case 14: Asymmetric motor levels (AIS D)
    ISNCSCITrainingCase(
      id: 'inter-04',
      title: 'Asymmetric Motor Incomplete (R:L2, L:L4)',
      clinicalScenario:
          'A 48-year-old sustains a lumbar SCI. The right side has motor and '
          'sensory function intact through L2. The left side is intact through L4. '
          'Below these levels, there is preserved motor function bilaterally with '
          'most muscles functional. VAC and DAP present.',
      difficulty: 'intermediate',
      exam: Exam(
        right: ExamSide(
          motor: Motor.allSame('5').copyWith(l3: '4', l4: '3', l5: '2', s1: '1'),
          lightTouch: _buildSensory(lastNormal: 'L2', impairedCount: 5, impairedValue: '1',
            overrides: {'S4_5': '1'}),
          pinPrick: _buildSensory(lastNormal: 'L2', impairedCount: 5, impairedValue: '1',
            overrides: {'S4_5': '1'}),
        ),
        left: ExamSide(
          motor: Motor.allSame('5').copyWith(l5: '4', s1: '3'),
          lightTouch: _buildSensory(lastNormal: 'L4', impairedCount: 3, impairedValue: '1',
            overrides: {'S4_5': '1'}),
          pinPrick: _buildSensory(lastNormal: 'L4', impairedCount: 3, impairedValue: '1',
            overrides: {'S4_5': '1'}),
        ),
        voluntaryAnalContraction: BinaryObservation.yes,
        deepAnalPressure: BinaryObservation.yes,
      ),
      teachingPoints:
          'R sensory=L2, R motor=L2 (L3 is 4/5 but L2 is 5/5, so motor=L2). '
          'L sensory=L4, L motor=L4 (L5 is 4/5, L4 is 5/5, so motor=L4). '
          'NLI = L2 (most rostral). VAC present so motor incomplete. Count key '
          'muscles below L2: R side L3=4, L4=3, L5=2, S1=1 (2 of 4 >= 3 = 50%); '
          'L side L3=5, L4=5, L5=4, S1=3 (4 of 4 >= 3). Total 6 of 8 >= 3 = 75%. '
          'AIS D (>= 50%).',
    ),

    // Case 15: Asymmetric sensory with sacral sparing one side only
    ISNCSCITrainingCase(
      id: 'inter-05',
      title: 'Asymmetric with Unilateral Sacral Sparing (AIS B)',
      clinicalScenario:
          'A 38-year-old sustains a T6 SCI. Right side sensory normal through T6, '
          'left side sensory normal through T8. No motor function below. Right side '
          'has impaired light touch at S4-5, left side has absent S4-5 sensation. '
          'DAP present. No VAC.',
      difficulty: 'intermediate',
      exam: Exam(
        right: ExamSide(
          motor: Motor.allSame('5').copyWith(l2: '0', l3: '0', l4: '0', l5: '0', s1: '0'),
          lightTouch: _buildSensory(lastNormal: 'T6', overrides: {'S4_5': '1'}),
          pinPrick: _buildSensory(lastNormal: 'T6'),
        ),
        left: ExamSide(
          motor: Motor.allSame('5').copyWith(l2: '0', l3: '0', l4: '0', l5: '0', s1: '0'),
          lightTouch: _buildSensory(lastNormal: 'T8'),
          pinPrick: _buildSensory(lastNormal: 'T8'),
        ),
        voluntaryAnalContraction: BinaryObservation.no,
        deepAnalPressure: BinaryObservation.yes,
      ),
      teachingPoints:
          'Sacral sparing is determined by ANY preserved sacral function: the right '
          'side has LT at S4-5 = 1, plus DAP is present. Even though the left side '
          'has no S4-5 sensation, sacral sparing is present and the injury is '
          'incomplete. No motor below NLI and no VAC = AIS B. R sensory=T6, '
          'L sensory=T8. NLI = T6.',
    ),

    // ========================================================================
    // INTERMEDIATE 16-20: Non-key muscle function (AIS B vs C distinction)
    // ========================================================================

    // Case 16: AIS C via VAC alone (all key muscles 0)
    ISNCSCITrainingCase(
      id: 'inter-06',
      title: 'Motor Incomplete via VAC Only (AIS C)',
      clinicalScenario:
          'A 25-year-old sustains a T6 SCI. Complete sensory and motor loss below '
          'T6, EXCEPT the patient has preserved light touch at S4-5 and voluntary '
          'anal contraction. All key muscles in the lower extremities are 0/5.',
      difficulty: 'intermediate',
      exam: Exam(
        right: ExamSide(
          motor: Motor.allSame('5').copyWith(l2: '0', l3: '0', l4: '0', l5: '0', s1: '0'),
          lightTouch: _buildSensory(lastNormal: 'T6', overrides: {'S4_5': '1'}),
          pinPrick: _buildSensory(lastNormal: 'T6', overrides: {'S4_5': '1'}),
        ),
        left: ExamSide(
          motor: Motor.allSame('5').copyWith(l2: '0', l3: '0', l4: '0', l5: '0', s1: '0'),
          lightTouch: _buildSensory(lastNormal: 'T6', overrides: {'S4_5': '1'}),
          pinPrick: _buildSensory(lastNormal: 'T6', overrides: {'S4_5': '1'}),
        ),
        voluntaryAnalContraction: BinaryObservation.yes,
        deepAnalPressure: BinaryObservation.yes,
      ),
      teachingPoints:
          'VAC = motor function at sacral segments = motor incomplete = at minimum '
          'AIS C. Even though ALL key muscles below the NLI are 0/5, VAC alone '
          'makes this AIS C, not AIS B. Count muscles below T6: all 10 key muscles '
          '(L2-S1 bilateral) are 0/5, so 0 of 10 >= 3 (0%). Since < 50%, AIS C. '
          'This is a key board pearl: VAC present = at least AIS C.',
    ),

    // Case 17: AIS B with motor function NOT more than 3 levels below
    ISNCSCITrainingCase(
      id: 'inter-07',
      title: 'Sensory Incomplete with Motor 2 Levels Below (AIS B)',
      clinicalScenario:
          'A 35-year-old sustains a C6 SCI. Sensory normal through C6 bilaterally '
          'with S4-5 sensation preserved. No VAC. Motor normal through C6, with '
          'weak C7 (2/5) and C8 (1/5) bilaterally -- motor function is present '
          'but only 2 levels below the motor level, not more than 3.',
      difficulty: 'intermediate',
      exam: Exam(
        right: ExamSide(
          motor: _buildMotor(lastNormal: 'C6', overrides: {
            'C7': '2', 'C8': '1', 'T1': '0',
            'L2': '0', 'L3': '0', 'L4': '0', 'L5': '0', 'S1': '0',
          }),
          lightTouch: _buildSensory(lastNormal: 'C6', impairedCount: 4, belowValue: '0',
            overrides: {'S4_5': '1'}),
          pinPrick: _buildSensory(lastNormal: 'C6', impairedCount: 3, belowValue: '0',
            overrides: {'S4_5': '1'}),
        ),
        left: ExamSide(
          motor: _buildMotor(lastNormal: 'C6', overrides: {
            'C7': '2', 'C8': '1', 'T1': '0',
            'L2': '0', 'L3': '0', 'L4': '0', 'L5': '0', 'S1': '0',
          }),
          lightTouch: _buildSensory(lastNormal: 'C6', impairedCount: 4, belowValue: '0',
            overrides: {'S4_5': '1'}),
          pinPrick: _buildSensory(lastNormal: 'C6', impairedCount: 3, belowValue: '0',
            overrides: {'S4_5': '1'}),
        ),
        voluntaryAnalContraction: BinaryObservation.no,
        deepAnalPressure: BinaryObservation.yes,
      ),
      teachingPoints:
          'Sacral sparing present (S4-5 LT, DAP) = incomplete. No VAC. Motor '
          'function exists below the motor level (C7=2, C8=1), but it is only 1-2 '
          'levels below the motor level (C6), NOT more than 3 levels below. For '
          'motor incomplete status without VAC, motor must be preserved MORE THAN '
          '3 levels below the motor level on either side. Since it is not, this '
          'remains AIS B despite having some motor function.',
    ),

    // Case 18: AIS C with motor > 3 levels below motor level (no VAC)
    ISNCSCITrainingCase(
      id: 'inter-08',
      title: 'Motor Incomplete via Motor >3 Below (AIS C, No VAC)',
      clinicalScenario:
          'A 41-year-old sustains a C5 SCI. Sensory normal through C5 bilaterally '
          'with S4-5 LT preserved. No VAC. Motor: C5=5, C6=2, C7=0, C8=0, T1=0. '
          'However, the LEFT L2 hip flexor has 2/5 strength -- motor function is '
          'present more than 3 levels below the motor level on the left.',
      difficulty: 'intermediate',
      exam: Exam(
        right: ExamSide(
          motor: _buildMotor(lastNormal: 'C5', belowValue: '0'),
          lightTouch: _buildSensory(lastNormal: 'C5', impairedCount: 3, belowValue: '0',
            overrides: {'S4_5': '1'}),
          pinPrick: _buildSensory(lastNormal: 'C5', impairedCount: 2, belowValue: '0',
            overrides: {'S4_5': '1'}),
        ),
        left: ExamSide(
          motor: _buildMotor(lastNormal: 'C5', overrides: {
            'C6': '2', 'C7': '0', 'C8': '0', 'T1': '0',
            'L2': '2', 'L3': '0', 'L4': '0', 'L5': '0', 'S1': '0',
          }),
          lightTouch: _buildSensory(lastNormal: 'C5', impairedCount: 3, belowValue: '0',
            overrides: {'S4_5': '1'}),
          pinPrick: _buildSensory(lastNormal: 'C5', impairedCount: 2, belowValue: '0',
            overrides: {'S4_5': '1'}),
        ),
        voluntaryAnalContraction: BinaryObservation.no,
        deepAnalPressure: BinaryObservation.yes,
      ),
      teachingPoints:
          'No VAC, but sacral sparing present (S4-5 LT, DAP) = incomplete. To be '
          'motor incomplete without VAC, motor function must exist MORE THAN 3 '
          'levels below the motor level on EITHER side. Left motor level is C5. '
          'Left L2 has motor function, which is more than 3 key muscle levels below '
          'C5 (counting C6, C7, C8, T1, then L2). This makes it motor incomplete '
          '= AIS C (< 50% of key muscles below NLI >= 3).',
    ),

    // Case 19: AIS B vs C -- non-key muscle decides
    ISNCSCITrainingCase(
      id: 'inter-09',
      title: 'Non-Key Muscle Determines AIS B vs C',
      clinicalScenario:
          'A 30-year-old sustains a T10 SCI. Sensory normal through T10 '
          'bilaterally. S4-5 LT = 1 bilaterally. DAP present. No VAC. All lower '
          'extremity key muscles (L2-S1) are 0/5. However, the patient has '
          'palpable hip adductor contraction (non-key muscle for L2) on the '
          'right side.',
      difficulty: 'intermediate',
      exam: Exam(
        right: ExamSide(
          motor: Motor.allSame('5').copyWith(l2: '0', l3: '0', l4: '0', l5: '0', s1: '0'),
          lightTouch: _buildSensory(lastNormal: 'T10', overrides: {'S4_5': '1'}),
          pinPrick: _buildSensory(lastNormal: 'T10', overrides: {'S4_5': '1'}),
          lowestNonKeyMuscleWithMotorFunction: 'L2',
        ),
        left: ExamSide(
          motor: Motor.allSame('5').copyWith(l2: '0', l3: '0', l4: '0', l5: '0', s1: '0'),
          lightTouch: _buildSensory(lastNormal: 'T10', overrides: {'S4_5': '1'}),
          pinPrick: _buildSensory(lastNormal: 'T10', overrides: {'S4_5': '1'}),
        ),
        voluntaryAnalContraction: BinaryObservation.no,
        deepAnalPressure: BinaryObservation.yes,
      ),
      teachingPoints:
          'No VAC, but sacral sparing present = incomplete. All key muscles below '
          'NLI are 0/5. Without non-key muscle assessment, this would be AIS B. '
          'However, the right hip adductor (non-key muscle for L2) has motor '
          'function, and L2 is more than 3 levels below the motor level (T10). '
          'Non-key muscles can be used to determine motor incomplete status. '
          'This makes it AIS C, not AIS B. Key teaching: non-key muscles matter '
          'for the AIS B vs C distinction.',
    ),

    // Case 20: AIS B despite non-key muscle function (within 3 levels)
    ISNCSCITrainingCase(
      id: 'inter-10',
      title: 'AIS B Despite Non-Key Muscle (Within 3 Levels)',
      clinicalScenario:
          'A 29-year-old sustains an L1 SCI. Sensory normal through L1. S4-5 LT = '
          '1. DAP present. No VAC. All lower extremity key muscles 0/5. Patient has '
          'palpable hip flexor contraction on the right (non-key muscle at L2), but '
          'L2 is only 1 level below the motor level.',
      difficulty: 'intermediate',
      exam: Exam(
        right: ExamSide(
          motor: Motor.allSame('5').copyWith(l2: '0', l3: '0', l4: '0', l5: '0', s1: '0'),
          lightTouch: _buildSensory(lastNormal: 'L1', overrides: {'S4_5': '1'}),
          pinPrick: _buildSensory(lastNormal: 'L1', overrides: {'S4_5': '1'}),
          lowestNonKeyMuscleWithMotorFunction: 'L2',
        ),
        left: ExamSide(
          motor: Motor.allSame('5').copyWith(l2: '0', l3: '0', l4: '0', l5: '0', s1: '0'),
          lightTouch: _buildSensory(lastNormal: 'L1', overrides: {'S4_5': '1'}),
          pinPrick: _buildSensory(lastNormal: 'L1', overrides: {'S4_5': '1'}),
        ),
        voluntaryAnalContraction: BinaryObservation.no,
        deepAnalPressure: BinaryObservation.yes,
      ),
      teachingPoints:
          'Sacral sparing present = incomplete. No VAC. Motor level = L1 (follows '
          'sensory). Non-key muscle function at L2 (hip flexor) is only 1 level '
          'below the motor level -- NOT more than 3 levels below. The "more than 3 '
          'levels below" rule applies to non-key muscles as well. Since motor '
          'function is not > 3 levels below the motor level, this is AIS B, not C. '
          'Contrast with Case 19 where the non-key muscle was > 3 levels below.',
    ),

    // ========================================================================
    // ADVANCED 21-25: NT values, asterisk values, ZPP determination
    // ========================================================================

    // Case 21: NT values in motor exam
    ISNCSCITrainingCase(
      id: 'adv-01',
      title: 'NT Motor Values in Tetraplegia',
      clinicalScenario:
          'A 44-year-old with a C6 SCI has a right upper extremity cast preventing '
          'testing of the C7 (triceps) and C8 (finger flexors) key muscles. These '
          'are recorded as NT. Other values are testable. No sacral sparing.',
      difficulty: 'advanced',
      exam: Exam(
        right: ExamSide(
          motor: _buildMotor(lastNormal: 'C6', overrides: {
            'C7': 'NT', 'C8': 'NT', 'T1': '0',
            'L2': '0', 'L3': '0', 'L4': '0', 'L5': '0', 'S1': '0',
          }),
          lightTouch: _buildSensory(lastNormal: 'C6'),
          pinPrick: _buildSensory(lastNormal: 'C6'),
        ),
        left: ExamSide(
          motor: _buildMotor(lastNormal: 'C6', belowValue: '0'),
          lightTouch: _buildSensory(lastNormal: 'C6'),
          pinPrick: _buildSensory(lastNormal: 'C6'),
        ),
        voluntaryAnalContraction: BinaryObservation.no,
        deepAnalPressure: BinaryObservation.no,
      ),
      teachingPoints:
          'NT values introduce ambiguity. The right motor level could be C6, C7, '
          'or C8 depending on the untestable muscles\' true strength. The algorithm '
          'may return multiple possible values for the right motor level. Motor '
          'totals become "ND" (not determinable) when NT values are present. '
          'This case teaches how NT affects level determination and totals.',
    ),

    // Case 22: Asterisk (*) values -- consider normal
    ISNCSCITrainingCase(
      id: 'adv-02',
      title: 'Asterisk Values (Non-SCI Condition)',
      clinicalScenario:
          'A 62-year-old with pre-existing peripheral neuropathy sustains a T10 '
          'SCI. Sensory in the feet is impaired due to the neuropathy, not the SCI. '
          'These values are marked with asterisks (*) to indicate non-SCI cause. '
          'No sacral sparing.',
      difficulty: 'advanced',
      exam: Exam(
        right: ExamSide(
          motor: Motor.allSame('5').copyWith(l2: '0', l3: '0', l4: '0', l5: '0', s1: '0'),
          lightTouch: _buildSensory(lastNormal: 'T10', overrides: {
            'S1': '1*', 'S2': '1*',
          }),
          pinPrick: _buildSensory(lastNormal: 'T10', overrides: {
            'S1': '1*', 'S2': '1*',
          }),
        ),
        left: ExamSide(
          motor: Motor.allSame('5').copyWith(l2: '0', l3: '0', l4: '0', l5: '0', s1: '0'),
          lightTouch: _buildSensory(lastNormal: 'T10', overrides: {
            'S1': '1*', 'S2': '1*',
          }),
          pinPrick: _buildSensory(lastNormal: 'T10', overrides: {
            'S1': '1*', 'S2': '1*',
          }),
        ),
        voluntaryAnalContraction: BinaryObservation.no,
        deepAnalPressure: BinaryObservation.no,
      ),
      teachingPoints:
          'Single-asterisk (*) values mean the impairment is due to a non-SCI '
          'condition (like peripheral neuropathy). The algorithm treats these as '
          '"could be normal or abnormal" -- the true value is unknown. This can '
          'produce variable results. S1 and S2 are 1* meaning the impairment at '
          'those levels may not be from the SCI. This introduces ambiguity in '
          'determining ZPP.',
    ),

    // Case 23: ZPP determination in AIS A with scattered function
    ISNCSCITrainingCase(
      id: 'adv-03',
      title: 'ZPP Determination with Scattered Function',
      clinicalScenario:
          'A 31-year-old sustains a C8 SCI. No sacral sparing. Below C8, there is '
          'scattered sensory and motor function: T1 motor 2/5, T2-T4 LT = 1, '
          'left L2 motor 1/5. All other values below injury are 0.',
      difficulty: 'advanced',
      exam: Exam(
        right: ExamSide(
          motor: _buildMotor(lastNormal: 'C8', overrides: {
            'T1': '2', 'L2': '0', 'L3': '0', 'L4': '0', 'L5': '0', 'S1': '0',
          }),
          lightTouch: _buildSensory(lastNormal: 'C8', overrides: {
            'T1': '1', 'T2': '1', 'T3': '1', 'T4': '1',
          }),
          pinPrick: _buildSensory(lastNormal: 'C8', overrides: {
            'T1': '1', 'T2': '1',
          }),
        ),
        left: ExamSide(
          motor: _buildMotor(lastNormal: 'C8', overrides: {
            'T1': '1', 'L2': '1', 'L3': '0', 'L4': '0', 'L5': '0', 'S1': '0',
          }),
          lightTouch: _buildSensory(lastNormal: 'C8', overrides: {
            'T1': '1', 'T2': '1', 'T3': '1',
          }),
          pinPrick: _buildSensory(lastNormal: 'C8', overrides: {
            'T1': '1',
          }),
        ),
        voluntaryAnalContraction: BinaryObservation.no,
        deepAnalPressure: BinaryObservation.no,
      ),
      teachingPoints:
          'AIS A with zone of partial preservation. ZPP is the most CAUDAL segment '
          'with any preserved function, reported separately for each modality and '
          'side. Sensory ZPP right: T4 (last level with LT or PP > 0). Sensory ZPP '
          'left: T3. Motor ZPP right: T1 (last motor > 0). Motor ZPP left: L2 '
          '(left L2 hip flexor = 1/5). ZPP only applies to AIS A injuries.',
    ),

    // Case 24: Double-asterisk (**) values -- consider normal
    ISNCSCITrainingCase(
      id: 'adv-04',
      title: 'Double-Asterisk Values (Consider Normal)',
      clinicalScenario:
          'A 58-year-old with a T6 SCI has a skin graft at the T8 dermatome '
          'bilaterally. Sensation at T8 cannot be properly tested and is marked '
          'as 0** (consider normal for classification). All other values are '
          'straightforward. No sacral sparing.',
      difficulty: 'advanced',
      exam: Exam(
        right: ExamSide(
          motor: Motor.allSame('5').copyWith(l2: '0', l3: '0', l4: '0', l5: '0', s1: '0'),
          lightTouch: _buildSensory(lastNormal: 'T7', overrides: {
            'T8': '0**', 'T9': '0', 'T10': '0',
          }),
          pinPrick: _buildSensory(lastNormal: 'T7', overrides: {
            'T8': '0**', 'T9': '0', 'T10': '0',
          }),
        ),
        left: ExamSide(
          motor: Motor.allSame('5').copyWith(l2: '0', l3: '0', l4: '0', l5: '0', s1: '0'),
          lightTouch: _buildSensory(lastNormal: 'T7', overrides: {
            'T8': '0**', 'T9': '0', 'T10': '0',
          }),
          pinPrick: _buildSensory(lastNormal: 'T7', overrides: {
            'T8': '0**', 'T9': '0', 'T10': '0',
          }),
        ),
        voluntaryAnalContraction: BinaryObservation.no,
        deepAnalPressure: BinaryObservation.no,
      ),
      teachingPoints:
          'Double-asterisk (**) means "consider normal" -- the value is 0 but '
          'should be treated as if it could be 2 (normal) for classification. '
          'T8 = 0** means the sensory level COULD be T8 (if T8 is considered '
          'normal) or T7 (if T8 is taken at face value). The algorithm may return '
          'variable sensory levels. This teaches how non-SCI conditions affect '
          'classification.',
    ),

    // Case 25: NT in sacral exam affecting completeness
    ISNCSCITrainingCase(
      id: 'adv-05',
      title: 'NT at S4-5 Affecting Completeness',
      clinicalScenario:
          'A 36-year-old sustains a T8 SCI. Sensory normal through T8 bilaterally. '
          'S4-5 light touch and pin prick are recorded as NT (patient has perianal '
          'burns preventing testing). DAP is NT. VAC is No. All LE motors 0/5.',
      difficulty: 'advanced',
      exam: Exam(
        right: ExamSide(
          motor: Motor.allSame('5').copyWith(l2: '0', l3: '0', l4: '0', l5: '0', s1: '0'),
          lightTouch: _buildSensory(lastNormal: 'T8', overrides: {'S4_5': 'NT'}),
          pinPrick: _buildSensory(lastNormal: 'T8', overrides: {'S4_5': 'NT'}),
        ),
        left: ExamSide(
          motor: Motor.allSame('5').copyWith(l2: '0', l3: '0', l4: '0', l5: '0', s1: '0'),
          lightTouch: _buildSensory(lastNormal: 'T8', overrides: {'S4_5': 'NT'}),
          pinPrick: _buildSensory(lastNormal: 'T8', overrides: {'S4_5': 'NT'}),
        ),
        voluntaryAnalContraction: BinaryObservation.no,
        deepAnalPressure: BinaryObservation.nt,
      ),
      teachingPoints:
          'When S4-5 sensation and DAP are NT, sacral sparing cannot be determined. '
          'The injury could be complete (AIS A) or incomplete (AIS B). The algorithm '
          'will return variable completeness. VAC is No, so if sacral sparing is '
          'absent this is AIS A; if present, AIS B. This teaches how untestable '
          'sacral segments create classification ambiguity.',
    ),

    // ========================================================================
    // ADVANCED 26-30: Syndrome patterns
    // ========================================================================

    // Case 26: Central Cord Syndrome
    ISNCSCITrainingCase(
      id: 'adv-06',
      title: 'Central Cord Syndrome',
      clinicalScenario:
          'A 65-year-old with cervical spondylosis falls and develops upper '
          'extremity weakness greater than lower extremity weakness, classic for '
          'central cord syndrome. Sensory is relatively preserved. Arms weaker '
          'than legs. Sacral sparing present.',
      difficulty: 'advanced',
      exam: Exam(
        right: ExamSide(
          motor: const Motor(
            c5: '3', c6: '2', c7: '1', c8: '1', t1: '1',
            l2: '4', l3: '4', l4: '4', l5: '3', s1: '3',
          ),
          lightTouch: _buildSensory(lastNormal: 'C4', impairedCount: 24, impairedValue: '1',
            overrides: {'S4_5': '1'}),
          pinPrick: _buildSensory(lastNormal: 'C4', impairedCount: 24, impairedValue: '1',
            overrides: {'S4_5': '1'}),
        ),
        left: ExamSide(
          motor: const Motor(
            c5: '3', c6: '2', c7: '1', c8: '1', t1: '1',
            l2: '4', l3: '4', l4: '4', l5: '4', s1: '3',
          ),
          lightTouch: _buildSensory(lastNormal: 'C4', impairedCount: 24, impairedValue: '1',
            overrides: {'S4_5': '1'}),
          pinPrick: _buildSensory(lastNormal: 'C4', impairedCount: 24, impairedValue: '1',
            overrides: {'S4_5': '1'}),
        ),
        voluntaryAnalContraction: BinaryObservation.yes,
        deepAnalPressure: BinaryObservation.yes,
      ),
      teachingPoints:
          'Central cord syndrome: upper extremity weakness > lower extremity '
          'weakness, with relatively preserved sensation. Classic in older adults '
          'with cervical spondylosis. Sensory level = C4 (last fully normal). '
          'Motor level = C4 (C5 = 3/5 but there is no key muscle above C5, and '
          'sensory at C4 is normal, so motor follows sensory at C4). Sacral sparing '
          'present. VAC present = motor incomplete. Count muscles below C4: many '
          'LE muscles >= 3. Likely AIS D. Best prognosis of all SCI syndromes.',
    ),

    // Case 27: Brown-Sequard Syndrome
    ISNCSCITrainingCase(
      id: 'adv-07',
      title: 'Brown-Sequard Syndrome (Hemisection)',
      clinicalScenario:
          'A 28-year-old is stabbed on the right side of the neck at C6. The right '
          'side shows ipsilateral motor loss and proprioceptive loss below C6. The '
          'left side shows contralateral pain/temperature loss but preserved motor '
          'and light touch. Sacral sparing present bilaterally.',
      difficulty: 'advanced',
      exam: Exam(
        right: ExamSide(
          motor: _buildMotor(lastNormal: 'C6', overrides: {
            'C7': '1', 'C8': '0', 'T1': '0',
            'L2': '1', 'L3': '1', 'L4': '0', 'L5': '0', 'S1': '0',
          }),
          lightTouch: _buildSensory(lastNormal: 'C6', impairedCount: 4, impairedValue: '1', belowValue: '1',
            overrides: {'S4_5': '1'}),
          pinPrick: _buildSensory(lastNormal: 'C6', impairedCount: 2, impairedValue: '1', belowValue: '1',
            overrides: {'S4_5': '1'}),
        ),
        left: ExamSide(
          motor: Motor.allSame('5'),
          lightTouch: Sensory.allSame('2'),
          pinPrick: _buildSensory(lastNormal: 'C6', impairedCount: 22, impairedValue: '1',
            overrides: {'S4_5': '1'}),
        ),
        voluntaryAnalContraction: BinaryObservation.yes,
        deepAnalPressure: BinaryObservation.yes,
      ),
      teachingPoints:
          'Brown-Sequard (hemisection): ipsilateral motor and LT loss, '
          'contralateral PP loss. R sensory = C6 (both LT and PP must be 2 -- PP '
          'is actually impaired below C6 on the right too). L sensory level depends '
          'on PP. L motor = intact (all 5/5). The dissociation between sides is '
          'characteristic. Sacral sparing present, VAC present = motor incomplete. '
          'Has the best recovery prognosis of incomplete injuries.',
    ),

    // Case 28: Anterior Cord Syndrome
    ISNCSCITrainingCase(
      id: 'adv-08',
      title: 'Anterior Cord Syndrome',
      clinicalScenario:
          'A 52-year-old has an aortic dissection that causes anterior spinal '
          'artery occlusion at T6. Motor function and pain/temperature sensation '
          'are lost below T6. Light touch (posterior columns) is preserved. '
          'Sacral sparing for LT present.',
      difficulty: 'advanced',
      exam: Exam(
        right: ExamSide(
          motor: Motor.allSame('5').copyWith(l2: '0', l3: '0', l4: '0', l5: '0', s1: '0'),
          lightTouch: Sensory.allSame('2'),
          pinPrick: _buildSensory(lastNormal: 'T6'),
        ),
        left: ExamSide(
          motor: Motor.allSame('5').copyWith(l2: '0', l3: '0', l4: '0', l5: '0', s1: '0'),
          lightTouch: Sensory.allSame('2'),
          pinPrick: _buildSensory(lastNormal: 'T6'),
        ),
        voluntaryAnalContraction: BinaryObservation.no,
        deepAnalPressure: BinaryObservation.yes,
      ),
      teachingPoints:
          'Anterior cord syndrome: motor and pain/temperature (spinothalamic tract) '
          'lost, but light touch and proprioception (posterior columns) preserved. '
          'Sensory level is determined by BOTH LT AND PP -- since PP is absent below '
          'T6 but LT is intact everywhere, the sensory level is T6 (PP limits it). '
          'Wait -- sensory level requires BOTH modalities to be 2. LT is 2 '
          'everywhere but PP is 0 below T6, so sensory level = T6. Motor = T6 '
          '(follows sensory, no LE motor). DAP present = sacral sparing = incomplete. '
          'No VAC, no motor below NLI = AIS B. Worst prognosis of incomplete injuries.',
    ),

    // Case 29: Cauda Equina Syndrome
    ISNCSCITrainingCase(
      id: 'adv-09',
      title: 'Cauda Equina Syndrome',
      clinicalScenario:
          'A 45-year-old presents with acute onset bilateral leg weakness, saddle '
          'anesthesia, and urinary retention after a massive L2-3 disc herniation. '
          'Upper extremity exam is completely normal. Patchy, asymmetric lower '
          'extremity weakness. LMN pattern.',
      difficulty: 'advanced',
      exam: Exam(
        right: ExamSide(
          motor: Motor.allSame('5').copyWith(l2: '3', l3: '4', l4: '2', l5: '1', s1: '0'),
          lightTouch: _buildSensory(lastNormal: 'L1', overrides: {
            'L2': '1', 'L3': '1', 'L4': '1', 'L5': '0', 'S1': '0', 'S2': '0',
            'S3': '0', 'S4_5': '0',
          }),
          pinPrick: _buildSensory(lastNormal: 'L1', overrides: {
            'L2': '1', 'L3': '1', 'L4': '0', 'L5': '0', 'S1': '0', 'S2': '0',
            'S3': '0', 'S4_5': '0',
          }),
        ),
        left: ExamSide(
          motor: Motor.allSame('5').copyWith(l2: '4', l3: '3', l4: '3', l5: '2', s1: '1'),
          lightTouch: _buildSensory(lastNormal: 'L1', overrides: {
            'L2': '1', 'L3': '1', 'L4': '1', 'L5': '1', 'S1': '0', 'S2': '0',
            'S3': '0', 'S4_5': '0',
          }),
          pinPrick: _buildSensory(lastNormal: 'L1', overrides: {
            'L2': '1', 'L3': '1', 'L4': '1', 'L5': '0', 'S1': '0', 'S2': '0',
            'S3': '0', 'S4_5': '0',
          }),
        ),
        voluntaryAnalContraction: BinaryObservation.no,
        deepAnalPressure: BinaryObservation.no,
      ),
      teachingPoints:
          'Cauda equina: LMN injury to nerve roots, typically asymmetric. No sacral '
          'sparing (S4-5 = 0, no DAP, no VAC) = AIS A despite the patchy pattern. '
          'Sensory level = L1 bilaterally (last level with 2/2 for both LT and PP). '
          'Motor level = L1 (follows sensory). NLI = L1. ZPP varies by side due to '
          'asymmetric pattern. Cauda equina is classified by ISNCSCI despite being '
          'a PNS injury. Better recovery potential than cord injuries.',
    ),

    // Case 30: Conus Medullaris Syndrome
    ISNCSCITrainingCase(
      id: 'adv-10',
      title: 'Conus Medullaris Syndrome',
      clinicalScenario:
          'A 40-year-old sustains an L1 burst fracture damaging the conus '
          'medullaris. Symmetric motor and sensory loss below L1. Saddle '
          'anesthesia present. Bladder dysfunction. Mixed UMN/LMN pattern.',
      difficulty: 'advanced',
      exam: Exam(
        right: ExamSide(
          motor: Motor.allSame('5').copyWith(l2: '2', l3: '1', l4: '0', l5: '0', s1: '0'),
          lightTouch: _buildSensory(lastNormal: 'L1', overrides: {
            'L2': '1', 'L3': '1',
          }),
          pinPrick: _buildSensory(lastNormal: 'L1', overrides: {
            'L2': '1',
          }),
        ),
        left: ExamSide(
          motor: Motor.allSame('5').copyWith(l2: '2', l3: '1', l4: '0', l5: '0', s1: '0'),
          lightTouch: _buildSensory(lastNormal: 'L1', overrides: {
            'L2': '1', 'L3': '1',
          }),
          pinPrick: _buildSensory(lastNormal: 'L1', overrides: {
            'L2': '1',
          }),
        ),
        voluntaryAnalContraction: BinaryObservation.no,
        deepAnalPressure: BinaryObservation.no,
      ),
      teachingPoints:
          'Conus medullaris syndrome: symmetric, sudden onset, early bladder '
          'involvement. The conus is the terminal end of the spinal cord (L1-L2 '
          'vertebral level). No sacral sparing = AIS A. Sensory level = L1 '
          'bilaterally. Motor level = L1 (follows sensory). NLI = L1. ZPP: '
          'sensory R=L3, sensory L=L3, motor R=L3, motor L=L3 (most caudal '
          'segment with any function). Compare with cauda equina: conus is '
          'symmetric UMN pattern, cauda is asymmetric LMN pattern.',
    ),
  ];
}
