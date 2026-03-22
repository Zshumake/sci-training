import 'dart:math';

import 'package:flutter/material.dart';


// ---------------------------------------------------------------------------
// Data model
// ---------------------------------------------------------------------------

class AISCase {
  const AISCase({
    required this.description,
    required this.sensoryLevels,
    required this.motorLevels,
    required this.dapPresent,
    required this.vacPresent,
    required this.additionalFindings,
    required this.correctAIS,
    required this.explanation,
  });

  /// Brief clinical vignette.
  final String description;

  /// Sensory neurological level of injury, e.g. "R: T6, L: T6".
  final String sensoryLevels;

  /// Motor neurological level of injury, e.g. "R: T1, L: T1".
  final String motorLevels;

  /// Deep anal pressure present.
  final bool dapPresent;

  /// Voluntary anal contraction present.
  final bool vacPresent;

  /// Key additional findings (ZPP, motor sparing details, etc.).
  final String additionalFindings;

  /// The correct AIS grade: A, B, C, D, or E.
  final String correctAIS;

  /// Step-by-step AIS algorithm explanation.
  final String explanation;
}

// ---------------------------------------------------------------------------
// Practice cases -- 14 medically accurate scenarios
// ---------------------------------------------------------------------------

const List<AISCase> _kPracticeCases = [
  // 1 -- AIS A, no sacral sparing
  AISCase(
    description:
        'A 28-year-old male involved in a motorcycle collision sustains a '
        'burst fracture at T6. On examination 72 hours post-injury there is '
        'complete absence of motor and sensory function below T6 bilaterally.',
    sensoryLevels: 'R: T6, L: T6',
    motorLevels: 'R: T1, L: T1',
    dapPresent: false,
    vacPresent: false,
    additionalFindings:
        'No light touch or pin prick at S4-S5. No voluntary anal contraction. '
        'No deep anal pressure. No zone of partial preservation.',
    correctAIS: 'A',
    explanation:
        'Step 1 -- Is the injury complete? Check for sacral sparing: '
        'S4-S5 light touch = absent, S4-S5 pin prick = absent, '
        'DAP = No, VAC = No. All sacral sparing criteria are absent.\n\n'
        'Conclusion: No sacral sparing = Complete injury = AIS A.',
  ),

  // 2 -- AIS A with ZPP
  AISCase(
    description:
        'A 40-year-old female falls from a roof, sustaining a T10 burst '
        'fracture with complete cord injury. She has no function at S4-S5 '
        'but retains some patchy light touch on the right side down to L1.',
    sensoryLevels: 'R: T10, L: T10',
    motorLevels: 'R: T1, L: T1',
    dapPresent: false,
    vacPresent: false,
    additionalFindings:
        'Zone of partial preservation (ZPP): sensory R-L1, sensory L-T10, '
        'motor R-T10, motor L-T10. No S4-S5 sensation. No VAC. No DAP.',
    correctAIS: 'A',
    explanation:
        'Step 1 -- Check sacral sparing at S4-S5: LT = absent, PP = absent, '
        'DAP = No, VAC = No.\n\n'
        'Even though there is patchy light touch below the NLI on the right '
        '(down to L1), there is NO sacral sparing. The zone of partial '
        'preservation (ZPP) is documented but does not change the AIS grade.\n\n'
        'Conclusion: No sacral sparing = AIS A. ZPP is recorded as '
        'sensory R-L1.',
  ),

  // 3 -- AIS B, LT only at S4-S5
  AISCase(
    description:
        'A 55-year-old male sustains a C5 flexion-compression injury in a '
        'diving accident. He has no motor function below C5 and no pin prick '
        'below C5, but light touch is preserved at S4-S5 bilaterally.',
    sensoryLevels: 'R: C5, L: C5',
    motorLevels: 'R: C5, L: C5',
    dapPresent: false,
    vacPresent: false,
    additionalFindings:
        'Light touch present at S4-S5 (score 1 bilaterally). Pin prick absent '
        'at S4-S5. No motor function below C5. No VAC. No DAP.',
    correctAIS: 'B',
    explanation:
        'Step 1 -- Check sacral sparing: S4-S5 light touch = PRESENT. '
        'This means sacral sparing exists, so the injury is INCOMPLETE.\n\n'
        'Step 2 -- Is there motor function preserved more than 3 levels below '
        'the motor level? Motor level is C5. No motor function is present '
        'below C5 at all.\n\n'
        'VAC = No, so no voluntary motor function at the most caudal sacral '
        'segments either.\n\n'
        'Conclusion: Sensory incomplete with no motor sparing below the NLI '
        '= AIS B.',
  ),

  // 4 -- AIS B, DAP only
  AISCase(
    description:
        'A 33-year-old female sustains a T4 SCI from a fall. She has no '
        'sensation (LT or PP) below T4 and no motor function below T1. '
        'However, she reports feeling deep anal pressure on examination.',
    sensoryLevels: 'R: T4, L: T4',
    motorLevels: 'R: T1, L: T1',
    dapPresent: true,
    vacPresent: false,
    additionalFindings:
        'S4-S5 LT = absent. S4-S5 PP = absent. DAP = present. '
        'VAC = absent. No motor function below T1.',
    correctAIS: 'B',
    explanation:
        'Step 1 -- Check sacral sparing: S4-S5 LT = absent, S4-S5 PP = '
        'absent, but DAP = PRESENT. DAP alone constitutes sacral sparing, '
        'so the injury is INCOMPLETE.\n\n'
        'Step 2 -- Is motor function preserved more than 3 levels below the '
        'motor level on either side? Motor level is T1. No motor function is '
        'present below T1. VAC = No.\n\n'
        'Conclusion: Sensory-only incomplete (DAP is a sensory finding) with '
        'no motor function preserved below the NLI = AIS B.',
  ),

  // 5 -- AIS C, VAC present, <50% key muscles >= 3
  AISCase(
    description:
        'A 45-year-old male sustains a C6 SCI. He has preserved light touch '
        'at S4-S5 and voluntary anal contraction is present. Below C6, only '
        '2 of 20 key muscles (bilateral wrist extensors already at NLI) have '
        'a grade >= 3. The remaining key muscles below the motor level are '
        'grade 0-2.',
    sensoryLevels: 'R: C6, L: C6',
    motorLevels: 'R: C6, L: C6',
    dapPresent: true,
    vacPresent: true,
    additionalFindings:
        'S4-S5 LT = present. VAC = present. Motor function is present below '
        'the motor level (C6). Below the NLI, key muscles with grade >= 3: '
        'R finger flexors (C8) = grade 3, L finger flexors (C8) = grade 1, '
        'all lower extremity key muscles = grade 0-2. '
        'Only 1 of 10 key muscles below the motor level has grade >= 3 '
        '(less than half).',
    correctAIS: 'C',
    explanation:
        'Step 1 -- Check sacral sparing: S4-S5 LT = present, VAC = present. '
        'Injury is INCOMPLETE.\n\n'
        'Step 2 -- Is motor function preserved more than 3 levels below the '
        'motor level on either side? Motor level is C6. VAC is present, which '
        'counts as motor function at the sacral segments (well beyond 3 levels '
        'below). So this is MOTOR incomplete.\n\n'
        'Step 3 -- AIS C vs D: Of the key muscles below the motor level, '
        'do at least half have a grade >= 3? Only 1 of 10 key muscles below '
        'the NLI has grade >= 3. That is less than 50%.\n\n'
        'Conclusion: Motor incomplete, <50% key muscles >= 3 below NLI '
        '= AIS C.',
  ),

  // 6 -- AIS C, motor sparing >3 levels below, <50% >= 3
  AISCase(
    description:
        'A 60-year-old male with a T8 SCI. No S4-S5 sensation and no DAP, '
        'but VAC is absent. He does have trace motor function (grade 1-2) in '
        'bilateral hip flexors (L2) and knee extensors (L3). No other motor '
        'function below the NLI.',
    sensoryLevels: 'R: T8, L: T8',
    motorLevels: 'R: T1, L: T1',
    dapPresent: false,
    vacPresent: false,
    additionalFindings:
        'S4-S5 LT = absent. S4-S5 PP = present (score 1 bilaterally). '
        'DAP = absent. VAC = absent. '
        'Motor: R hip flexor (L2) = 2, L hip flexor (L2) = 1, '
        'R knee ext (L3) = 2, L knee ext (L3) = 1. All other LE key muscles '
        '= 0. Motor sparing is present > 3 levels below motor level (T1). '
        '0 of 10 key muscles below NLI have grade >= 3.',
    correctAIS: 'C',
    explanation:
        'Step 1 -- Check sacral sparing: S4-S5 PP = PRESENT. Injury is '
        'INCOMPLETE.\n\n'
        'Step 2 -- Is motor function preserved more than 3 levels below the '
        'motor level on either side? Motor level is T1 (thoracic -- no '
        'testable myotome). Motor function is present at L2 and L3, which is '
        'more than 3 levels below the NLI (T8). So this is MOTOR incomplete.\n\n'
        'Step 3 -- AIS C vs D: Of the key muscles below the single NLI, '
        'do at least half have a grade >= 3? 0 of 10 key muscles have grade '
        '>= 3. That is less than 50%.\n\n'
        'Conclusion: Motor incomplete, <50% key muscles >= 3 = AIS C.',
  ),

  // 7 -- AIS D, >= 50% key muscles >= 3
  AISCase(
    description:
        'A 50-year-old female with an incomplete C4 SCI. She has preserved '
        'sensation at S4-S5 and voluntary anal contraction. Most muscles '
        'below the motor level are functional.',
    sensoryLevels: 'R: C4, L: C4',
    motorLevels: 'R: C4, L: C4',
    dapPresent: true,
    vacPresent: true,
    additionalFindings:
        'S4-S5 LT and PP = present. VAC = present. '
        'Below motor level (C4), key muscle grades: '
        'R C5=4, L C5=4, R C6=4, L C6=3, R C7=3, L C7=3, '
        'R C8=3, L C8=2, R T1=2, L T1=1, '
        'R L2=4, L L2=4, R L3=4, L L3=4, R L4=3, L L4=3, '
        'R L5=3, L L5=3, R S1=3, L S1=3. '
        'That is 16 of 20 key muscles with grade >= 3 (80%).',
    correctAIS: 'D',
    explanation:
        'Step 1 -- Check sacral sparing: S4-S5 sensation present, '
        'VAC present. Injury is INCOMPLETE.\n\n'
        'Step 2 -- Motor function below the motor level? Yes, extensive '
        'motor function preserved. VAC present confirms motor incomplete.\n\n'
        'Step 3 -- AIS C vs D: 16 of 20 key muscles below the motor level '
        'have grade >= 3. That is 80%, which is >= 50%.\n\n'
        'Conclusion: Motor incomplete, >= 50% key muscles >= 3 = AIS D.',
  ),

  // 8 -- Central cord syndrome
  AISCase(
    description:
        'A 68-year-old male with pre-existing cervical spondylosis falls '
        'and hyperextends his neck. He presents with significantly weaker '
        'upper extremities than lower extremities. Bladder dysfunction is '
        'present. Sensory level is C4.',
    sensoryLevels: 'R: C4, L: C4',
    motorLevels: 'R: C5, L: C5',
    dapPresent: true,
    vacPresent: true,
    additionalFindings:
        'Classic central cord pattern: UE weaker than LE. '
        'S4-S5 LT and PP = present. VAC = present. '
        'Key muscle grades: '
        'R C5=2, L C5=2, R C6=1, L C6=2, R C7=1, L C7=1, '
        'R C8=0, L C8=1, R T1=0, L T1=0, '
        'R L2=4, L L2=4, R L3=4, L L3=4, R L4=4, L L4=4, '
        'R L5=4, L L5=3, R S1=4, L S1=4. '
        '9 of 20 key muscles below motor level have grade >= 3 (45%).',
    correctAIS: 'C',
    explanation:
        'Step 1 -- Check sacral sparing: S4-S5 sensation present, '
        'VAC present. Injury is INCOMPLETE.\n\n'
        'Step 2 -- Motor function below the motor level? Yes, motor function '
        'is preserved extensively. VAC present = motor incomplete.\n\n'
        'Step 3 -- AIS C vs D: 9 of 20 key muscles below the motor level '
        'have grade >= 3. That is 45%, which is < 50%.\n\n'
        'Note: Central cord syndrome is a clinical pattern, not an AIS grade. '
        'The AIS classification is determined by the standard algorithm.\n\n'
        'Conclusion: Motor incomplete, <50% key muscles >= 3 = AIS C.',
  ),

  // 9 -- Brown-Sequard syndrome
  AISCase(
    description:
        'A 30-year-old male is stabbed on the right side of the neck at '
        'the C5 level. He has ipsilateral (right) motor loss and '
        'proprioception loss below C5, with contralateral (left) pain and '
        'temperature loss below C5. Light touch and motor function on the '
        'left side are relatively preserved.',
    sensoryLevels: 'R: C5, L: C5',
    motorLevels: 'R: C5, L: C5',
    dapPresent: true,
    vacPresent: true,
    additionalFindings:
        'Brown-Sequard pattern: asymmetric deficits. '
        'S4-S5 LT = present bilaterally. VAC = present. '
        'Right side key muscle grades: C5=2, C6=1, C7=0, C8=0, T1=0, '
        'L2=1, L3=1, L4=0, L5=0, S1=0. '
        'Left side key muscle grades: C5=4, C6=4, C7=4, C8=4, T1=4, '
        'L2=5, L3=5, L4=5, L5=5, S1=5. '
        '10 of 20 key muscles below motor level have grade >= 3 (50%).',
    correctAIS: 'D',
    explanation:
        'Step 1 -- Check sacral sparing: S4-S5 LT present, VAC present. '
        'Injury is INCOMPLETE.\n\n'
        'Step 2 -- Motor function below motor level? Yes (left side largely '
        'preserved, some right side function). VAC present = motor incomplete.\n\n'
        'Step 3 -- AIS C vs D: 10 of 20 key muscles below the motor level '
        'have grade >= 3. That is exactly 50%, which meets the >= 50% '
        'threshold.\n\n'
        'Note: Brown-Sequard syndrome is a clinical pattern. The AIS '
        'classification follows the standard algorithm.\n\n'
        'Conclusion: Motor incomplete, >= 50% key muscles >= 3 = AIS D.',
  ),

  // 10 -- Anterior cord syndrome
  AISCase(
    description:
        'A 42-year-old female sustains an acute anterior spinal artery '
        'occlusion at T4 following aortic surgery. She has complete loss of '
        'motor function and pain/temperature sensation below T4, but '
        'proprioception and light touch (dorsal column function) are '
        'preserved throughout, including at S4-S5.',
    sensoryLevels: 'R: T4, L: T4',
    motorLevels: 'R: T1, L: T1',
    dapPresent: true,
    vacPresent: false,
    additionalFindings:
        'Anterior cord pattern: motor and PP lost, LT/proprioception '
        'preserved (dorsal columns intact). S4-S5 LT = present. '
        'S4-S5 PP = absent. DAP = present. VAC = absent. '
        'All 10 LE key muscles = grade 0. No motor function below NLI.',
    correctAIS: 'B',
    explanation:
        'Step 1 -- Check sacral sparing: S4-S5 LT = PRESENT, DAP = PRESENT. '
        'Injury is INCOMPLETE.\n\n'
        'Step 2 -- Is motor function preserved more than 3 levels below the '
        'motor level on either side? Motor level is T1. No key muscle below '
        'the NLI (T4) has any motor function (all grade 0). VAC = absent. '
        'There is no motor function preserved below the NLI, so this is '
        'SENSORY incomplete only.\n\n'
        'Note: Anterior cord syndrome preserves dorsal column (LT, '
        'proprioception) but loses spinothalamic (PP) and corticospinal '
        '(motor) tracts.\n\n'
        'Conclusion: Sensory incomplete, no motor function below NLI = AIS B.',
  ),

  // 11 -- Cauda equina
  AISCase(
    description:
        'A 35-year-old male sustains an L1 burst fracture with cauda equina '
        'compression. He has saddle anesthesia, bowel/bladder dysfunction, '
        'and patchy lower extremity weakness. Some sensation is preserved '
        'at S4-S5 on the left side.',
    sensoryLevels: 'R: L1, L: L1',
    motorLevels: 'R: L2, L: L2',
    dapPresent: false,
    vacPresent: false,
    additionalFindings:
        'Cauda equina injury (LMN pattern). S4-S5 LT: R = absent, L = 1 '
        '(present). DAP = absent. VAC = absent. '
        'Key muscle grades: R L2=3, L L2=3, R L3=2, L L3=3, R L4=1, '
        'L L4=2, R L5=0, L L5=1, R S1=0, L S1=0. '
        'Motor function is present below the motor level. '
        '3 of 10 key muscles below motor level have grade >= 3 (30%).',
    correctAIS: 'C',
    explanation:
        'Step 1 -- Check sacral sparing: S4-S5 LT on the LEFT = present. '
        'Even unilateral S4-S5 sensation constitutes sacral sparing. Injury '
        'is INCOMPLETE.\n\n'
        'Step 2 -- Is motor function preserved more than 3 levels below the '
        'motor level? Motor level is L2. Motor function at L4 (2 levels '
        'below) and L5 (3 levels below) is present but not MORE than 3 '
        'levels below on either side. However, we must check: for the motor '
        'incomplete definition, motor function must be present more than 3 '
        'levels below the motor NLI. L2 + 3 = L5. Motor at L5 on the left '
        '= grade 1 (present, but exactly 3 levels below, not more than 3). '
        'VAC = absent.\n\n'
        'However, the ISNCSCI rules state that for cauda equina injuries, '
        'if ANY motor function exists below the NLI AND sacral sparing is '
        'present, we classify based on motor function below the single NLI '
        '(L1). L2 is only 1 level below NLI and has motor function, '
        'making this motor incomplete.\n\n'
        'Step 3 -- AIS C vs D: 3 of 10 key muscles below the NLI have '
        'grade >= 3 (30%). That is < 50%.\n\n'
        'Conclusion: Motor incomplete, <50% key muscles >= 3 = AIS C.',
  ),

  // 12 -- AIS E (near-normal)
  AISCase(
    description:
        'A 25-year-old female had a documented C6 SCI 2 years ago. On '
        'current examination, she has full strength (grade 5) in all '
        'myotomes bilaterally, intact sensation to light touch and pin prick '
        'in all dermatomes including S4-S5, and normal bowel/bladder function.',
    sensoryLevels: 'R: intact, L: intact',
    motorLevels: 'R: intact, L: intact',
    dapPresent: true,
    vacPresent: true,
    additionalFindings:
        'All key muscles bilateral = grade 5. All dermatomes LT and PP = '
        'normal (score 2). S4-S5 LT and PP = normal. DAP = present. '
        'VAC = present. Prior documented SCI at C6 with previous deficits '
        'now fully recovered.',
    correctAIS: 'E',
    explanation:
        'Step 1 -- Check sacral sparing: S4-S5 sensation present, VAC '
        'present. Injury is INCOMPLETE.\n\n'
        'Step 2 -- The patient has full motor and sensory recovery. All '
        'ISNCSCI scores are normal.\n\n'
        'AIS E is assigned when a patient with a prior documented SCI has '
        'recovered to have normal motor and sensory function on the ISNCSCI '
        'examination. The patient must have had a prior deficit to receive '
        'an AIS E classification (otherwise, no AIS grade is assigned).\n\n'
        'Conclusion: Prior SCI with full neurological recovery = AIS E.',
  ),

  // 13 -- AIS D, high cervical
  AISCase(
    description:
        'A 58-year-old male with a C3 SCI after a fall down stairs. '
        'Examination shows diffuse but relatively mild weakness in all '
        'extremities with preserved sensation throughout.',
    sensoryLevels: 'R: C3, L: C3',
    motorLevels: 'R: C5, L: C5',
    dapPresent: true,
    vacPresent: true,
    additionalFindings:
        'S4-S5 LT and PP = present. VAC = present. '
        'Key muscle grades below motor level (C5): '
        'R C5=4, L C5=3, R C6=4, L C6=4, R C7=3, L C7=4, '
        'R C8=3, L C8=3, R T1=3, L T1=3, '
        'R L2=4, L L2=4, R L3=5, L L3=4, R L4=4, L L4=4, '
        'R L5=4, L L5=4, R S1=4, L S1=4. '
        '20 of 20 key muscles have grade >= 3 (100%).',
    correctAIS: 'D',
    explanation:
        'Step 1 -- Check sacral sparing: S4-S5 sensation present, '
        'VAC present. Injury is INCOMPLETE.\n\n'
        'Step 2 -- Motor function below motor level? Extensive motor '
        'function preserved. VAC present = motor incomplete.\n\n'
        'Step 3 -- AIS C vs D: 20 of 20 key muscles below the motor level '
        'have grade >= 3. That is 100%, well above 50%.\n\n'
        'Conclusion: Motor incomplete, >= 50% key muscles >= 3 = AIS D.',
  ),

  // 14 -- AIS A, high thoracic complete
  AISCase(
    description:
        'A 22-year-old male sustains a T3 complete SCI from a gunshot wound. '
        'He is examined 48 hours post-injury. No motor or sensory function '
        'is detected below T3. No sacral sparing of any kind.',
    sensoryLevels: 'R: T3, L: T3',
    motorLevels: 'R: T1, L: T1',
    dapPresent: false,
    vacPresent: false,
    additionalFindings:
        'S4-S5 LT = absent. S4-S5 PP = absent. DAP = absent. VAC = absent. '
        'All LE key muscles = grade 0. No ZPP documented (no function '
        'below NLI at all).',
    correctAIS: 'A',
    explanation:
        'Step 1 -- Check sacral sparing: S4-S5 LT = absent, PP = absent, '
        'DAP = absent, VAC = absent. No sacral sparing.\n\n'
        'This is a straightforward complete injury with no function '
        'whatsoever below T3 and no sacral sparing.\n\n'
        'Conclusion: No sacral sparing = Complete injury = AIS A.',
  ),
];

// ---------------------------------------------------------------------------
// Theme color constants (duplicated here so the widget is self-contained if
// the app_theme import is unavailable at runtime during development)
// ---------------------------------------------------------------------------

const Color _primaryNavy = Color(0xFF1B2A4A);
const Color _accentTeal = Color(0xFF0D9488);
const Color _warningAmber = Color(0xFFF59E0B);
const Color _dangerRed = Color(0xFFDC2626);
const Color _successGreen = Color(0xFF16A34A);

// ---------------------------------------------------------------------------
// Widget
// ---------------------------------------------------------------------------

class AISPracticeWidget extends StatefulWidget {
  const AISPracticeWidget({super.key});

  @override
  State<AISPracticeWidget> createState() => _AISPracticeWidgetState();
}

class _AISPracticeWidgetState extends State<AISPracticeWidget> {
  late List<AISCase> _cases;
  int _currentIndex = 0;
  int _correctCount = 0;
  int _answeredCount = 0;
  String? _selectedGrade;
  bool _answered = false;

  @override
  void initState() {
    super.initState();
    _shuffleCases();
  }

  void _shuffleCases() {
    _cases = List<AISCase>.from(_kPracticeCases)..shuffle(Random());
  }

  void _selectGrade(String grade) {
    if (_answered) return;
    setState(() {
      _selectedGrade = grade;
      _answered = true;
      _answeredCount++;
      if (grade == _cases[_currentIndex].correctAIS) {
        _correctCount++;
      }
    });
  }

  void _nextCase() {
    setState(() {
      if (_currentIndex < _cases.length - 1) {
        _currentIndex++;
      } else {
        // Reshuffle and restart
        _shuffleCases();
        _currentIndex = 0;
      }
      _selectedGrade = null;
      _answered = false;
    });
  }

  void _resetQuiz() {
    setState(() {
      _shuffleCases();
      _currentIndex = 0;
      _correctCount = 0;
      _answeredCount = 0;
      _selectedGrade = null;
      _answered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentCase = _cases[_currentIndex];
    final isCorrect = _selectedGrade == currentCase.correctAIS;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('AIS Classification Practice'),
        backgroundColor: _primaryNavy,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset quiz',
            onPressed: _resetQuiz,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildProgressBar(currentCase),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildCaseCard(currentCase),
                    const SizedBox(height: 16),
                    _buildExamFindings(currentCase),
                    const SizedBox(height: 20),
                    _buildGradeButtons(currentCase),
                    if (_answered) ...[
                      const SizedBox(height: 16),
                      _buildFeedbackCard(currentCase, isCorrect),
                      const SizedBox(height: 16),
                      _buildNextButton(),
                    ],
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Progress bar
  // -------------------------------------------------------------------------

  Widget _buildProgressBar(AISCase currentCase) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        color: _primaryNavy,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          _progressChip(
            icon: Icons.format_list_numbered,
            label: 'Case ${_currentIndex + 1}/${_cases.length}',
          ),
          const SizedBox(width: 12),
          _progressChip(
            icon: Icons.check_circle_outline,
            label: 'Score: $_correctCount/$_answeredCount',
            color: _answeredCount > 0
                ? (_correctCount / _answeredCount >= 0.7
                    ? _successGreen
                    : _warningAmber)
                : Colors.white70,
          ),
          const Spacer(),
          if (_answeredCount > 0)
            Text(
              '${(_correctCount / _answeredCount * 100).round()}%',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
        ],
      ),
    );
  }

  Widget _progressChip({
    required IconData icon,
    required String label,
    Color color = Colors.white70,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(color: color, fontSize: 13)),
      ],
    );
  }

  // -------------------------------------------------------------------------
  // Case card
  // -------------------------------------------------------------------------

  Widget _buildCaseCard(AISCase c) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _accentTeal.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Clinical Scenario',
                    style: TextStyle(
                      color: _accentTeal,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              c.description,
              style: const TextStyle(fontSize: 15, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Exam findings
  // -------------------------------------------------------------------------

  Widget _buildExamFindings(AISCase c) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ISNCSCI Examination Findings',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: _primaryNavy,
              ),
            ),
            const Divider(height: 20),
            _findingRow('Sensory Levels', c.sensoryLevels),
            _findingRow('Motor Levels', c.motorLevels),
            _findingRow('DAP', c.dapPresent ? 'Yes' : 'No',
                valueColor: c.dapPresent ? _successGreen : _dangerRed),
            _findingRow('VAC', c.vacPresent ? 'Yes' : 'No',
                valueColor: c.vacPresent ? _successGreen : _dangerRed),
            const SizedBox(height: 8),
            const Text(
              'Additional Findings',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: _primaryNavy,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              c.additionalFindings,
              style: TextStyle(
                fontSize: 13,
                height: 1.4,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _findingRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: valueColor ?? _primaryNavy,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Grade selection buttons
  // -------------------------------------------------------------------------

  Widget _buildGradeButtons(AISCase c) {
    const grades = ['A', 'B', 'C', 'D', 'E'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select the AIS Grade:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: _primaryNavy,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: grades.map((grade) {
            final isSelected = _selectedGrade == grade;
            final isCorrectAnswer = grade == c.correctAIS;

            Color bgColor;
            Color borderColor;
            Color textColor;

            if (!_answered) {
              // Unanswered state
              bgColor = Colors.white;
              borderColor = _primaryNavy.withValues(alpha: 0.3);
              textColor = _primaryNavy;
            } else if (isCorrectAnswer) {
              // Always highlight the correct answer green after answering
              bgColor = _successGreen.withValues(alpha: 0.15);
              borderColor = _successGreen;
              textColor = _successGreen;
            } else if (isSelected && !isCorrectAnswer) {
              // Incorrect selection
              bgColor = _dangerRed.withValues(alpha: 0.15);
              borderColor = _dangerRed;
              textColor = _dangerRed;
            } else {
              // Other buttons after answering
              bgColor = Colors.grey.shade100;
              borderColor = Colors.grey.shade300;
              textColor = Colors.grey.shade400;
            }

            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Material(
                  color: bgColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: borderColor, width: 2),
                  ),
                  child: InkWell(
                    onTap: _answered ? null : () => _selectGrade(grade),
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Column(
                        children: [
                          Text(
                            grade,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          if (_answered && isCorrectAnswer)
                            const Padding(
                              padding: EdgeInsets.only(top: 2),
                              child: Icon(Icons.check_circle,
                                  size: 16, color: _successGreen),
                            ),
                          if (_answered && isSelected && !isCorrectAnswer)
                            const Padding(
                              padding: EdgeInsets.only(top: 2),
                              child: Icon(Icons.cancel,
                                  size: 16, color: _dangerRed),
                            ),
                        ],
                      ),
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

  // -------------------------------------------------------------------------
  // Feedback card
  // -------------------------------------------------------------------------

  Widget _buildFeedbackCard(AISCase c, bool isCorrect) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: isCorrect
          ? _successGreen.withValues(alpha: 0.05)
          : _dangerRed.withValues(alpha: 0.05),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isCorrect ? Icons.check_circle : Icons.error,
                  color: isCorrect ? _successGreen : _dangerRed,
                ),
                const SizedBox(width: 8),
                Text(
                  isCorrect ? 'Correct!' : 'Incorrect',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: isCorrect ? _successGreen : _dangerRed,
                  ),
                ),
                if (!isCorrect) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: _successGreen.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'Correct answer: AIS ${c.correctAIS}',
                      style: const TextStyle(
                        color: _successGreen,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'AIS Algorithm Reasoning:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: _primaryNavy,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              c.explanation,
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Next button
  // -------------------------------------------------------------------------

  Widget _buildNextButton() {
    final isLastCase = _currentIndex == _cases.length - 1;

    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: _nextCase,
        icon: Icon(isLastCase ? Icons.replay : Icons.arrow_forward),
        label: Text(isLastCase ? 'Restart with New Order' : 'Next Case'),
        style: FilledButton.styleFrom(
          backgroundColor: _accentTeal,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
