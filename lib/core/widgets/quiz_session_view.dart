import 'package:flutter/material.dart';
import '../models/quiz_model.dart';
import '../theme/app_theme.dart';

class QuizSessionView extends StatefulWidget {
  final List<QuizQuestion> questions;
  final String title;

  const QuizSessionView({
    super.key,
    required this.questions,
    required this.title,
  });

  @override
  State<QuizSessionView> createState() => _QuizSessionViewState();
}

class _QuizSessionViewState extends State<QuizSessionView> {
  int _currentIndex = 0;
  int? _selectedIndex;
  bool _answered = false;
  int _correct = 0;
  int _total = 0;

  QuizQuestion get _currentQuestion => widget.questions[_currentIndex];
  bool get _isLastQuestion => _currentIndex >= widget.questions.length - 1;

  void _selectAnswer(int index) {
    if (_answered) return;
    setState(() {
      _selectedIndex = index;
      _answered = true;
      _total++;
      if (index == _currentQuestion.correctIndex) _correct++;
    });
  }

  void _nextQuestion() {
    if (_isLastQuestion) {
      _showResults();
      return;
    }
    setState(() {
      _currentIndex++;
      _selectedIndex = null;
      _answered = false;
    });
  }

  void _showResults() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: AppTheme.cardBackground,
        title: Text(
          'Quiz Complete',
          style: AppTheme.displayFont(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$_correct / $_total',
              style: AppTheme.monoFont(
                fontSize: 48,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${((_correct / _total) * 100).round()}% correct',
              style: AppTheme.displayFont(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: _correct / _total >= 0.7
                    ? AppTheme.successGreen
                    : AppTheme.dangerRed,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
            },
            child: Text(
              'Done',
              style: AppTheme.displayFont(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.accentTeal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getOptionColor(int index) {
    if (!_answered) return AppTheme.cardBackground;
    if (index == _currentQuestion.correctIndex) {
      return AppTheme.successGreen.withValues(alpha: 0.08);
    }
    if (index == _selectedIndex) {
      return AppTheme.dangerRed.withValues(alpha: 0.08);
    }
    return AppTheme.cardBackground;
  }

  Color _getOptionBorderColor(int index) {
    if (!_answered) {
      return index == _selectedIndex
          ? AppTheme.primaryNavy
          : AppTheme.borderSubtle;
    }
    if (index == _currentQuestion.correctIndex) return AppTheme.successGreen;
    if (index == _selectedIndex) return AppTheme.dangerRed;
    return AppTheme.borderSubtle;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text(
                '${_currentIndex + 1}/${widget.questions.length}',
                style: AppTheme.monoFont(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                value: (_currentIndex + 1) / widget.questions.length,
                backgroundColor: AppTheme.borderSubtle.withValues(alpha: 0.4),
                valueColor:
                    const AlwaysStoppedAnimation(AppTheme.primaryNavy),
                minHeight: 3,
              ),
            ),
            const SizedBox(height: 24),

            // Question
            Text(
              _currentQuestion.question,
              style: AppTheme.bodyFont(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                height: 1.5,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 20),

            // Options
            ...List.generate(_currentQuestion.options.length, (i) {
              return GestureDetector(
                onTap: () => _selectAnswer(i),
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: _getOptionColor(i),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: _getOptionBorderColor(i),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: !_answered
                              ? AppTheme.surfaceMuted
                              : i == _currentQuestion.correctIndex
                                  ? AppTheme.successGreen
                                      .withValues(alpha: 0.15)
                                  : i == _selectedIndex
                                      ? AppTheme.dangerRed
                                          .withValues(alpha: 0.15)
                                      : AppTheme.surfaceMuted,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          String.fromCharCode(65 + i),
                          style: AppTheme.monoFont(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: !_answered
                                ? AppTheme.textSecondary
                                : i == _currentQuestion.correctIndex
                                    ? AppTheme.successGreen
                                    : i == _selectedIndex
                                        ? AppTheme.dangerRed
                                        : AppTheme.textSecondary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _currentQuestion.options[i],
                          style: AppTheme.bodyFont(
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),
                      ),
                      if (_answered && i == _currentQuestion.correctIndex)
                        const Icon(Icons.check_circle,
                            color: AppTheme.successGreen, size: 22),
                      if (_answered &&
                          i == _selectedIndex &&
                          i != _currentQuestion.correctIndex)
                        const Icon(Icons.cancel,
                            color: AppTheme.dangerRed, size: 22),
                    ],
                  ),
                ),
              );
            }),

            // Explanation
            if (_answered) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                decoration: BoxDecoration(
                  color: AppTheme.cardBackground,
                  border: Border(
                    left: BorderSide(
                      color: AppTheme.pearlBorder,
                      width: 3,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.school_rounded,
                            color: AppTheme.pearlBorder, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          'Explanation',
                          style: AppTheme.displayFont(
                            fontWeight: FontWeight.w700,
                            color: AppTheme.primaryNavy,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _currentQuestion.explanation,
                      style: AppTheme.bodyFont(
                        fontSize: 13,
                        height: 1.5,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _nextQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.accentTeal,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Text(
                    _isLastQuestion ? 'See Results' : 'Next Question',
                    style: AppTheme.displayFont(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
