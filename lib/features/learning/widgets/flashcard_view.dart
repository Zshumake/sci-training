import 'package:flutter/material.dart';
import '../../../data/models/flashcard_model.dart';
import '../../../core/theme/app_theme.dart';

class FlashcardView extends StatefulWidget {
  final List<Flashcard> cards;
  final String title;

  const FlashcardView({super.key, required this.cards, required this.title});

  @override
  State<FlashcardView> createState() => _FlashcardViewState();
}

class _FlashcardViewState extends State<FlashcardView> {
  int _currentIndex = 0;
  bool _showBack = false;
  int _knewIt = 0;
  int _needsWork = 0;

  Flashcard get _card => widget.cards[_currentIndex];
  bool get _isLast => _currentIndex >= widget.cards.length - 1;

  void _flip() => setState(() => _showBack = !_showBack);

  void _next(bool knew) {
    setState(() {
      if (knew) {
        _knewIt++;
      } else {
        _needsWork++;
      }
    });
    if (_isLast) {
      _showResults();
    } else {
      setState(() {
        _currentIndex++;
        _showBack = false;
      });
    }
  }

  void _showResults() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: AppTheme.cardBackground,
        title: Text(
          'Session Complete',
          style: AppTheme.displayFont(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      '$_knewIt',
                      style: AppTheme.monoFont(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.successGreen,
                      ),
                    ),
                    Text(
                      'Knew It',
                      style: AppTheme.bodyFont(
                        fontSize: 13,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '$_needsWork',
                      style: AppTheme.monoFont(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.dangerRed,
                      ),
                    ),
                    Text(
                      'Needs Work',
                      style: AppTheme.bodyFont(
                        fontSize: 13,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
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
                '${_currentIndex + 1}/${widget.cards.length}',
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Progress
            ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                value: (_currentIndex + 1) / widget.cards.length,
                backgroundColor: AppTheme.borderSubtle.withValues(alpha: 0.4),
                valueColor:
                    const AlwaysStoppedAnimation(AppTheme.primaryNavy),
                minHeight: 3,
              ),
            ),
            const SizedBox(height: 24),
            // Card
            Expanded(
              child: GestureDetector(
                onTap: _flip,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    key: ValueKey('$_currentIndex-$_showBack'),
                    width: double.infinity,
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: _showBack
                          ? const Color(0xFFF5F0E8)
                          : AppTheme.cardBackground,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: _showBack
                            ? AppTheme.accentTeal.withValues(alpha: 0.4)
                            : AppTheme.borderSubtle,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _showBack ? 'ANSWER' : 'QUESTION',
                          style: AppTheme.displayFont(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2.0,
                            color: _showBack
                                ? AppTheme.accentTeal
                                : AppTheme.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          _showBack ? _card.back : _card.front,
                          style: _showBack
                              ? AppTheme.displayFont(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  height: 1.5,
                                  color: AppTheme.textPrimary,
                                )
                              : AppTheme.bodyFont(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5,
                                  color: AppTheme.textPrimary,
                                ),
                          textAlign: TextAlign.center,
                        ),
                        if (!_showBack) ...[
                          const SizedBox(height: 24),
                          Text(
                            'Tap to reveal answer',
                            style: AppTheme.bodyFont(
                              fontSize: 13,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Buttons
            if (_showBack)
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _next(false),
                      icon: const Icon(Icons.refresh_rounded, size: 18),
                      label: Text(
                        'Needs Work',
                        style: AppTheme.displayFont(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.dangerRed,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _next(true),
                      icon: const Icon(Icons.check_rounded, size: 18),
                      label: Text(
                        'Knew It',
                        style: AppTheme.displayFont(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.successGreen,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                    ),
                  ),
                ],
              )
            else
              const SizedBox(height: 52),
          ],
        ),
      ),
    );
  }
}
