import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

// ---------------------------------------------------------------------------
// Mode enum
// ---------------------------------------------------------------------------

enum DermatomeMapMode { study, quiz }

// ---------------------------------------------------------------------------
// Dermatome data model
// ---------------------------------------------------------------------------

enum _SpinalRegion { cervical, thoracic, lumbar, sacral }

class _Dermatome {
  const _Dermatome({
    required this.level,
    required this.landmark,
    required this.region,
    required this.relativeRect,
  });

  /// Spinal level label, e.g. "C5".
  final String level;

  /// Clinical landmark description.
  final String landmark;

  /// Spinal region for color-coding.
  final _SpinalRegion region;

  /// Position expressed as fractions of the canvas size so the layout scales
  /// to any screen.  (left, top, width, height) all in 0..1 range.
  final Rect relativeRect;
}

// ---------------------------------------------------------------------------
// Dermatome definitions
// ---------------------------------------------------------------------------

const List<_Dermatome> _dermatomes = [
  // -- Cervical (blue) --
  _Dermatome(
    level: 'C2',
    landmark: 'Occiput / top of head',
    region: _SpinalRegion.cervical,
    relativeRect: Rect.fromLTWH(0.38, 0.02, 0.24, 0.04),
  ),
  _Dermatome(
    level: 'C3-C4',
    landmark: 'Neck / upper shoulder',
    region: _SpinalRegion.cervical,
    relativeRect: Rect.fromLTWH(0.28, 0.10, 0.44, 0.04),
  ),
  _Dermatome(
    level: 'C5',
    landmark: 'Lateral upper arm (deltoid)',
    region: _SpinalRegion.cervical,
    relativeRect: Rect.fromLTWH(0.10, 0.18, 0.14, 0.08),
  ),
  _Dermatome(
    level: 'C6',
    landmark: 'Thumb / lateral forearm',
    region: _SpinalRegion.cervical,
    relativeRect: Rect.fromLTWH(0.04, 0.32, 0.12, 0.07),
  ),
  _Dermatome(
    level: 'C7',
    landmark: 'Middle finger',
    region: _SpinalRegion.cervical,
    relativeRect: Rect.fromLTWH(0.02, 0.40, 0.10, 0.06),
  ),
  _Dermatome(
    level: 'C8',
    landmark: 'Little finger / medial hand',
    region: _SpinalRegion.cervical,
    relativeRect: Rect.fromLTWH(0.04, 0.46, 0.10, 0.06),
  ),

  // Mirror right arm for C5-C8
  _Dermatome(
    level: 'C5',
    landmark: 'Lateral upper arm (deltoid)',
    region: _SpinalRegion.cervical,
    relativeRect: Rect.fromLTWH(0.76, 0.18, 0.14, 0.08),
  ),
  _Dermatome(
    level: 'C6',
    landmark: 'Thumb / lateral forearm',
    region: _SpinalRegion.cervical,
    relativeRect: Rect.fromLTWH(0.84, 0.32, 0.12, 0.07),
  ),
  _Dermatome(
    level: 'C7',
    landmark: 'Middle finger',
    region: _SpinalRegion.cervical,
    relativeRect: Rect.fromLTWH(0.88, 0.40, 0.10, 0.06),
  ),
  _Dermatome(
    level: 'C8',
    landmark: 'Little finger / medial hand',
    region: _SpinalRegion.cervical,
    relativeRect: Rect.fromLTWH(0.86, 0.46, 0.10, 0.06),
  ),

  // -- Thoracic (green) --
  _Dermatome(
    level: 'T1',
    landmark: 'Medial forearm / elbow',
    region: _SpinalRegion.thoracic,
    relativeRect: Rect.fromLTWH(0.14, 0.26, 0.10, 0.06),
  ),
  _Dermatome(
    level: 'T1',
    landmark: 'Medial forearm / elbow',
    region: _SpinalRegion.thoracic,
    relativeRect: Rect.fromLTWH(0.76, 0.26, 0.10, 0.06),
  ),
  _Dermatome(
    level: 'T4',
    landmark: 'Nipple line',
    region: _SpinalRegion.thoracic,
    relativeRect: Rect.fromLTWH(0.30, 0.22, 0.40, 0.05),
  ),
  _Dermatome(
    level: 'T6',
    landmark: 'Xiphoid process',
    region: _SpinalRegion.thoracic,
    relativeRect: Rect.fromLTWH(0.32, 0.28, 0.36, 0.05),
  ),
  _Dermatome(
    level: 'T10',
    landmark: 'Umbilicus (belly button)',
    region: _SpinalRegion.thoracic,
    relativeRect: Rect.fromLTWH(0.34, 0.36, 0.32, 0.05),
  ),
  _Dermatome(
    level: 'T12',
    landmark: 'Inguinal (groin) region',
    region: _SpinalRegion.thoracic,
    relativeRect: Rect.fromLTWH(0.34, 0.44, 0.32, 0.04),
  ),

  // -- Lumbar (purple) --
  _Dermatome(
    level: 'L2',
    landmark: 'Anterior thigh',
    region: _SpinalRegion.lumbar,
    relativeRect: Rect.fromLTWH(0.30, 0.52, 0.16, 0.08),
  ),
  _Dermatome(
    level: 'L2',
    landmark: 'Anterior thigh',
    region: _SpinalRegion.lumbar,
    relativeRect: Rect.fromLTWH(0.54, 0.52, 0.16, 0.08),
  ),
  _Dermatome(
    level: 'L3',
    landmark: 'Medial knee',
    region: _SpinalRegion.lumbar,
    relativeRect: Rect.fromLTWH(0.32, 0.64, 0.12, 0.06),
  ),
  _Dermatome(
    level: 'L3',
    landmark: 'Medial knee',
    region: _SpinalRegion.lumbar,
    relativeRect: Rect.fromLTWH(0.56, 0.64, 0.12, 0.06),
  ),
  _Dermatome(
    level: 'L4',
    landmark: 'Medial ankle',
    region: _SpinalRegion.lumbar,
    relativeRect: Rect.fromLTWH(0.34, 0.78, 0.10, 0.06),
  ),
  _Dermatome(
    level: 'L4',
    landmark: 'Medial ankle',
    region: _SpinalRegion.lumbar,
    relativeRect: Rect.fromLTWH(0.56, 0.78, 0.10, 0.06),
  ),
  _Dermatome(
    level: 'L5',
    landmark: 'Dorsal foot',
    region: _SpinalRegion.lumbar,
    relativeRect: Rect.fromLTWH(0.32, 0.86, 0.12, 0.06),
  ),
  _Dermatome(
    level: 'L5',
    landmark: 'Dorsal foot',
    region: _SpinalRegion.lumbar,
    relativeRect: Rect.fromLTWH(0.56, 0.86, 0.12, 0.06),
  ),

  // -- Sacral (orange) --
  _Dermatome(
    level: 'S1',
    landmark: 'Lateral heel / foot',
    region: _SpinalRegion.sacral,
    relativeRect: Rect.fromLTWH(0.30, 0.92, 0.10, 0.06),
  ),
  _Dermatome(
    level: 'S1',
    landmark: 'Lateral heel / foot',
    region: _SpinalRegion.sacral,
    relativeRect: Rect.fromLTWH(0.60, 0.92, 0.10, 0.06),
  ),
  _Dermatome(
    level: 'S2-S4/5',
    landmark: 'Perineal area',
    region: _SpinalRegion.sacral,
    relativeRect: Rect.fromLTWH(0.44, 0.48, 0.12, 0.04),
  ),
];

/// Unique dermatome levels used for quiz question generation.
final List<String> _uniqueLevels = _dermatomes
    .map((d) => d.level)
    .toSet()
    .toList()
  ..sort((a, b) {
    int rank(String s) {
      final letter = s[0];
      final num = int.tryParse(s.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
      const order = {'C': 0, 'T': 100, 'L': 200, 'S': 300};
      return (order[letter] ?? 400) + num;
    }
    return rank(a).compareTo(rank(b));
  });

// ---------------------------------------------------------------------------
// Color helpers
// ---------------------------------------------------------------------------

Color _regionBaseColor(_SpinalRegion region) {
  switch (region) {
    case _SpinalRegion.cervical:
      return const Color(0xFF3B82F6); // blue
    case _SpinalRegion.thoracic:
      return AppTheme.successGreen;
    case _SpinalRegion.lumbar:
      return const Color(0xFF8B5CF6); // purple
    case _SpinalRegion.sacral:
      return AppTheme.warningAmber;
  }
}

// ---------------------------------------------------------------------------
// DermatomeMapWidget
// ---------------------------------------------------------------------------

class DermatomeMapWidget extends StatefulWidget {
  const DermatomeMapWidget({
    super.key,
    this.mode = DermatomeMapMode.study,
  });

  final DermatomeMapMode mode;

  @override
  State<DermatomeMapWidget> createState() => _DermatomeMapWidgetState();
}

class _DermatomeMapWidgetState extends State<DermatomeMapWidget>
    with TickerProviderStateMixin {
  // -- Study mode state --
  _Dermatome? _selectedDermatome;

  // -- Quiz mode state --
  int _quizCorrect = 0;
  int _quizTotal = 0;
  int _quizQuestionCount = 12;
  late List<String> _quizQueue;
  String _currentQuizLevel = '';
  _QuizFeedback? _feedback;

  // -- Animation --
  late AnimationController _highlightController;
  late Animation<double> _highlightAnim;
  late AnimationController _feedbackController;
  late Animation<double> _feedbackAnim;

  @override
  void initState() {
    super.initState();
    _highlightController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _highlightAnim = CurvedAnimation(
      parent: _highlightController,
      curve: Curves.easeOut,
    );

    _feedbackController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _feedbackAnim = CurvedAnimation(
      parent: _feedbackController,
      curve: Curves.easeOut,
    );

    if (widget.mode == DermatomeMapMode.quiz) {
      _initQuiz();
    }
  }

  void _initQuiz() {
    final rng = Random();
    _quizQueue = List<String>.from(_uniqueLevels)..shuffle(rng);
    if (_quizQueue.length > _quizQuestionCount) {
      _quizQueue = _quizQueue.sublist(0, _quizQuestionCount);
    }
    _quizQuestionCount = _quizQueue.length;
    _quizCorrect = 0;
    _quizTotal = 0;
    _nextQuizQuestion();
  }

  void _nextQuizQuestion() {
    if (_quizQueue.isEmpty) return;
    setState(() {
      _currentQuizLevel = _quizQueue.removeAt(0);
      _feedback = null;
      _selectedDermatome = null;
    });
  }

  @override
  void dispose() {
    _highlightController.dispose();
    _feedbackController.dispose();
    super.dispose();
  }

  // -- Hit testing --

  _Dermatome? _hitTest(Offset localPosition, Size canvasSize) {
    for (final d in _dermatomes) {
      final rect = Rect.fromLTWH(
        d.relativeRect.left * canvasSize.width,
        d.relativeRect.top * canvasSize.height,
        d.relativeRect.width * canvasSize.width,
        d.relativeRect.height * canvasSize.height,
      );
      if (rect.contains(localPosition)) {
        return d;
      }
    }
    return null;
  }

  // -- Tap handling --

  void _onTapDown(TapDownDetails details, Size canvasSize) {
    final hit = _hitTest(details.localPosition, canvasSize);
    if (hit == null) return;

    if (widget.mode == DermatomeMapMode.study) {
      _handleStudyTap(hit);
    } else {
      _handleQuizTap(hit);
    }
  }

  void _handleStudyTap(_Dermatome dermatome) {
    setState(() => _selectedDermatome = dermatome);
    _highlightController.forward(from: 0);
  }

  void _handleQuizTap(_Dermatome dermatome) {
    if (_feedback != null) return; // already answered

    final correct = dermatome.level == _currentQuizLevel;
    final correctDermatome =
        _dermatomes.firstWhere((d) => d.level == _currentQuizLevel);

    setState(() {
      _quizTotal++;
      if (correct) _quizCorrect++;
      _selectedDermatome = dermatome;
      _feedback = _QuizFeedback(
        isCorrect: correct,
        tappedDermatome: dermatome,
        correctDermatome: correctDermatome,
      );
    });

    _feedbackController.forward(from: 0);

    Future.delayed(const Duration(milliseconds: 1800), () {
      if (!mounted) return;
      if (_quizTotal >= _quizQuestionCount) {
        _showQuizResults();
      } else {
        _nextQuizQuestion();
      }
    });
  }

  void _showQuizResults() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Quiz Complete!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$_quizCorrect / $_quizQuestionCount',
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryNavy,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _quizCorrect == _quizQuestionCount
                  ? 'Perfect score!'
                  : _quizCorrect >= _quizQuestionCount * 0.75
                      ? 'Great job!'
                      : 'Keep practicing!',
              style: const TextStyle(fontSize: 16, color: AppTheme.textSecondary),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              setState(() => _initQuiz());
            },
            child: const Text('Try Again'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  // -- Build --

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header / quiz prompt
        _buildHeader(),
        const SizedBox(height: 8),

        // Legend
        _buildLegend(),
        const SizedBox(height: 8),

        // Body map
        Expanded(child: _buildBodyMap()),

        // Info card (study) or feedback card (quiz)
        _buildInfoCard(),
      ],
    );
  }

  // -- Header --

  Widget _buildHeader() {
    if (widget.mode == DermatomeMapMode.study) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          'Tap a dermatome zone to learn its level and landmark.',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      );
    }

    // Quiz mode header
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              _quizTotal < _quizQuestionCount
                  ? 'Tap the location of $_currentQuizLevel'
                  : 'Quiz complete!',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppTheme.primaryNavy,
                  ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.primaryNavy,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$_quizCorrect / $_quizQuestionCount',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -- Legend --

  Widget _buildLegend() {
    const items = [
      ('Cervical', _SpinalRegion.cervical),
      ('Thoracic', _SpinalRegion.thoracic),
      ('Lumbar', _SpinalRegion.lumbar),
      ('Sacral', _SpinalRegion.sacral),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: items.map((item) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: _regionBaseColor(item.$2),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  item.$1,
                  style: const TextStyle(fontSize: 11, color: AppTheme.textSecondary),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // -- Body map --

  Widget _buildBodyMap() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final canvasSize = Size(constraints.maxWidth, constraints.maxHeight);
        return GestureDetector(
          onTapDown: (details) => _onTapDown(details, canvasSize),
          child: AnimatedBuilder(
            animation: Listenable.merge([_highlightAnim, _feedbackAnim]),
            builder: (context, _) {
              return CustomPaint(
                size: canvasSize,
                painter: _BodyMapPainter(
                  dermatomes: _dermatomes,
                  selectedDermatome: _selectedDermatome,
                  highlightProgress: _highlightAnim.value,
                  feedback: _feedback,
                  feedbackProgress: _feedbackAnim.value,
                  mode: widget.mode,
                ),
              );
            },
          ),
        );
      },
    );
  }

  // -- Info card --

  Widget _buildInfoCard() {
    if (widget.mode == DermatomeMapMode.study) {
      return _buildStudyCard();
    }
    return _buildQuizFeedbackCard();
  }

  Widget _buildStudyCard() {
    if (_selectedDermatome == null) {
      return const SizedBox(height: 80);
    }
    final d = _selectedDermatome!;
    return AnimatedBuilder(
      animation: _highlightAnim,
      builder: (context, _) {
        return Opacity(
          opacity: _highlightAnim.value.clamp(0.0, 1.0),
          child: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: _regionBaseColor(d.region).withValues(alpha:0.10),
              border: Border.all(color: _regionBaseColor(d.region), width: 1.5),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _regionBaseColor(d.region),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    d.level,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        d.level,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: _regionBaseColor(d.region),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        d.landmark,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuizFeedbackCard() {
    if (_feedback == null) {
      return const SizedBox(height: 80);
    }
    final fb = _feedback!;
    final color = fb.isCorrect ? AppTheme.successGreen : AppTheme.dangerRed;
    return AnimatedBuilder(
      animation: _feedbackAnim,
      builder: (context, _) {
        return Opacity(
          opacity: _feedbackAnim.value.clamp(0.0, 1.0),
          child: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: color.withValues(alpha:0.10),
              border: Border.all(color: color, width: 1.5),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Icon(
                  fb.isCorrect ? Icons.check_circle : Icons.cancel,
                  color: color,
                  size: 32,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    fb.isCorrect
                        ? 'Correct! ${fb.correctDermatome.level} = ${fb.correctDermatome.landmark}'
                        : 'Incorrect. ${fb.correctDermatome.level} = ${fb.correctDermatome.landmark}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Quiz feedback model
// ---------------------------------------------------------------------------

class _QuizFeedback {
  const _QuizFeedback({
    required this.isCorrect,
    required this.tappedDermatome,
    required this.correctDermatome,
  });

  final bool isCorrect;
  final _Dermatome tappedDermatome;
  final _Dermatome correctDermatome;
}

// ---------------------------------------------------------------------------
// CustomPainter -- body outline + dermatome zones
// ---------------------------------------------------------------------------

class _BodyMapPainter extends CustomPainter {
  _BodyMapPainter({
    required this.dermatomes,
    required this.selectedDermatome,
    required this.highlightProgress,
    required this.feedback,
    required this.feedbackProgress,
    required this.mode,
  });

  final List<_Dermatome> dermatomes;
  final _Dermatome? selectedDermatome;
  final double highlightProgress;
  final _QuizFeedback? feedback;
  final double feedbackProgress;
  final DermatomeMapMode mode;

  @override
  void paint(Canvas canvas, Size size) {
    _drawBodyOutline(canvas, size);
    _drawDermatomeZones(canvas, size);
  }

  // -- Body outline --

  void _drawBodyOutline(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFCBD5E1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;

    final path = Path();

    // Head
    final headCx = w * 0.50;
    final headCy = h * 0.06;
    final headRx = w * 0.08;
    final headRy = h * 0.05;
    path.addOval(Rect.fromCenter(
      center: Offset(headCx, headCy),
      width: headRx * 2,
      height: headRy * 2,
    ));

    // Neck
    path.moveTo(w * 0.46, h * 0.11);
    path.lineTo(w * 0.46, h * 0.13);
    path.moveTo(w * 0.54, h * 0.11);
    path.lineTo(w * 0.54, h * 0.13);

    // Torso
    final torso = Path();
    torso.moveTo(w * 0.34, h * 0.14);
    torso.lineTo(w * 0.26, h * 0.16); // left shoulder
    torso.lineTo(w * 0.28, h * 0.20);
    torso.lineTo(w * 0.30, h * 0.30);
    torso.lineTo(w * 0.32, h * 0.42);
    torso.lineTo(w * 0.34, h * 0.48);
    torso.lineTo(w * 0.38, h * 0.50); // left hip
    torso.lineTo(w * 0.44, h * 0.50);
    torso.lineTo(w * 0.50, h * 0.52);
    torso.lineTo(w * 0.56, h * 0.50);
    torso.lineTo(w * 0.62, h * 0.50); // right hip
    torso.lineTo(w * 0.66, h * 0.48);
    torso.lineTo(w * 0.68, h * 0.42);
    torso.lineTo(w * 0.70, h * 0.30);
    torso.lineTo(w * 0.72, h * 0.20);
    torso.lineTo(w * 0.74, h * 0.16); // right shoulder
    torso.lineTo(w * 0.66, h * 0.14);
    torso.lineTo(w * 0.54, h * 0.13);
    torso.lineTo(w * 0.46, h * 0.13);
    torso.close();
    canvas.drawPath(torso, paint);

    // Left arm
    final leftArm = Path();
    leftArm.moveTo(w * 0.26, h * 0.16);
    leftArm.lineTo(w * 0.18, h * 0.22);
    leftArm.lineTo(w * 0.12, h * 0.30);
    leftArm.lineTo(w * 0.08, h * 0.38);
    leftArm.lineTo(w * 0.05, h * 0.46);
    leftArm.lineTo(w * 0.04, h * 0.52);
    leftArm.moveTo(w * 0.26, h * 0.16);
    leftArm.moveTo(w * 0.28, h * 0.20);
    leftArm.lineTo(w * 0.20, h * 0.26);
    leftArm.lineTo(w * 0.16, h * 0.34);
    leftArm.lineTo(w * 0.12, h * 0.42);
    leftArm.lineTo(w * 0.10, h * 0.50);
    leftArm.lineTo(w * 0.08, h * 0.52);
    canvas.drawPath(leftArm, paint);

    // Right arm
    final rightArm = Path();
    rightArm.moveTo(w * 0.74, h * 0.16);
    rightArm.lineTo(w * 0.82, h * 0.22);
    rightArm.lineTo(w * 0.88, h * 0.30);
    rightArm.lineTo(w * 0.92, h * 0.38);
    rightArm.lineTo(w * 0.95, h * 0.46);
    rightArm.lineTo(w * 0.96, h * 0.52);
    rightArm.moveTo(w * 0.74, h * 0.16);
    rightArm.moveTo(w * 0.72, h * 0.20);
    rightArm.lineTo(w * 0.80, h * 0.26);
    rightArm.lineTo(w * 0.84, h * 0.34);
    rightArm.lineTo(w * 0.88, h * 0.42);
    rightArm.lineTo(w * 0.90, h * 0.50);
    rightArm.lineTo(w * 0.92, h * 0.52);
    canvas.drawPath(rightArm, paint);

    // Left leg
    final leftLeg = Path();
    leftLeg.moveTo(w * 0.38, h * 0.50);
    leftLeg.lineTo(w * 0.34, h * 0.58);
    leftLeg.lineTo(w * 0.32, h * 0.66);
    leftLeg.lineTo(w * 0.32, h * 0.76);
    leftLeg.lineTo(w * 0.34, h * 0.84);
    leftLeg.lineTo(w * 0.32, h * 0.92);
    leftLeg.lineTo(w * 0.30, h * 0.98);
    leftLeg.moveTo(w * 0.44, h * 0.50);
    leftLeg.lineTo(w * 0.44, h * 0.58);
    leftLeg.lineTo(w * 0.44, h * 0.66);
    leftLeg.lineTo(w * 0.44, h * 0.76);
    leftLeg.lineTo(w * 0.44, h * 0.84);
    leftLeg.lineTo(w * 0.44, h * 0.92);
    leftLeg.lineTo(w * 0.42, h * 0.98);
    canvas.drawPath(leftLeg, paint);

    // Right leg
    final rightLeg = Path();
    rightLeg.moveTo(w * 0.56, h * 0.50);
    rightLeg.lineTo(w * 0.56, h * 0.58);
    rightLeg.lineTo(w * 0.56, h * 0.66);
    rightLeg.lineTo(w * 0.56, h * 0.76);
    rightLeg.lineTo(w * 0.56, h * 0.84);
    rightLeg.lineTo(w * 0.56, h * 0.92);
    rightLeg.lineTo(w * 0.58, h * 0.98);
    rightLeg.moveTo(w * 0.62, h * 0.50);
    rightLeg.lineTo(w * 0.66, h * 0.58);
    rightLeg.lineTo(w * 0.68, h * 0.66);
    rightLeg.lineTo(w * 0.68, h * 0.76);
    rightLeg.lineTo(w * 0.66, h * 0.84);
    rightLeg.lineTo(w * 0.68, h * 0.92);
    rightLeg.lineTo(w * 0.70, h * 0.98);
    canvas.drawPath(rightLeg, paint);

    // Draw the head outline again on top
    canvas.drawPath(path, paint);
  }

  // -- Dermatome zones --

  void _drawDermatomeZones(Canvas canvas, Size size) {
    for (final d in dermatomes) {
      final rect = Rect.fromLTWH(
        d.relativeRect.left * size.width,
        d.relativeRect.top * size.height,
        d.relativeRect.width * size.width,
        d.relativeRect.height * size.height,
      );

      final baseColor = _regionBaseColor(d.region);
      var fillColor = baseColor.withValues(alpha:0.18);
      var borderColor = baseColor.withValues(alpha:0.5);

      // Highlight selected zone
      final isSelected = selectedDermatome != null &&
          selectedDermatome!.level == d.level;

      if (isSelected && mode == DermatomeMapMode.study) {
        fillColor = baseColor.withValues(alpha:0.15 + 0.30 * highlightProgress);
        borderColor = baseColor;
      }

      // Quiz feedback coloring
      if (feedback != null && feedbackProgress > 0) {
        final isTapped = d == feedback!.tappedDermatome;
        final isCorrectZone = d.level == feedback!.correctDermatome.level;

        if (isTapped && !feedback!.isCorrect) {
          fillColor = AppTheme.dangerRed.withValues(alpha:0.30 * feedbackProgress);
          borderColor = AppTheme.dangerRed;
        }
        if (isCorrectZone) {
          fillColor =
              AppTheme.successGreen.withValues(alpha:0.30 * feedbackProgress);
          borderColor = AppTheme.successGreen;
        }
      }

      // Draw zone rectangle with rounded corners
      final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(6));

      canvas.drawRRect(
        rrect,
        Paint()
          ..color = fillColor
          ..style = PaintingStyle.fill,
      );
      canvas.drawRRect(
        rrect,
        Paint()
          ..color = borderColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = isSelected ? 2.0 : 1.0,
      );

      // Label
      final textPainter = TextPainter(
        text: TextSpan(
          text: d.level,
          style: TextStyle(
            color: baseColor.withValues(alpha:0.9),
            fontSize: (rect.height * 0.45).clamp(8.0, 13.0),
            fontWeight: FontWeight.w700,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: rect.width);

      textPainter.paint(
        canvas,
        Offset(
          rect.center.dx - textPainter.width / 2,
          rect.center.dy - textPainter.height / 2,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _BodyMapPainter oldDelegate) {
    return oldDelegate.selectedDermatome != selectedDermatome ||
        oldDelegate.highlightProgress != highlightProgress ||
        oldDelegate.feedback != feedback ||
        oldDelegate.feedbackProgress != feedbackProgress;
  }
}

// ---------------------------------------------------------------------------
// AnimatedBuilder convenience (alias so we avoid import of foundation)
// ---------------------------------------------------------------------------
// Flutter's built-in AnimatedBuilder is used above directly from material.dart.
