import 'package:flutter/material.dart';
import '../../data/module_data.dart';
import '../../data/quiz_banks/sci_quiz_bank.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/content_card.dart';
import '../../core/widgets/quiz_session_view.dart';
import 'module_content_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController _staggerController;
  final List<Animation<double>> _fadeAnimations = [];
  final List<Animation<Offset>> _slideAnimations = [];

  @override
  void initState() {
    super.initState();
    final modules = ModuleData.standardModules;

    _staggerController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800 + (modules.length * 30)),
    );

    final totalDuration = 800.0 + (modules.length * 30.0);
    for (int i = 0; i < modules.length; i++) {
      final startFraction = (i * 30.0) / totalDuration;
      final endFraction = ((i * 30.0) + 800.0) / totalDuration;
      final interval = Interval(
        startFraction.clamp(0.0, 1.0),
        endFraction.clamp(0.0, 1.0),
        curve: Curves.easeOutCubic,
      );

      _fadeAnimations.add(
        Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: _staggerController, curve: interval),
        ),
      );
      _slideAnimations.add(
        Tween<Offset>(begin: const Offset(0, 0.05), end: Offset.zero).animate(
          CurvedAnimation(parent: _staggerController, curve: interval),
        ),
      );
    }

    _staggerController.forward();
  }

  @override
  void dispose() {
    _staggerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final modules = ModuleData.standardModules;

    return Scaffold(
      backgroundColor: AppTheme.surfaceLight,
      body: CustomScrollView(
        slivers: [
          // Masthead
          SliverAppBar(
            expandedHeight: 210,
            pinned: true,
            backgroundColor: AppTheme.primaryNavy,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: AppTheme.primaryNavy,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),
                        Text(
                          'SCI Training',
                          style: AppTheme.displayFont(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: -1.0,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Spinal Cord Injury Board Review',
                          style: AppTheme.bodyFont(
                            fontSize: 14,
                            color: Colors.white70,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 14),
                        // Thin horizontal rule
                        Container(
                          height: 1,
                          color: Colors.white.withValues(alpha: 0.15),
                        ),
                        const SizedBox(height: 14),
                        // Stat pills row
                        Row(
                          children: [
                            _buildStatPill('14', 'MODULES'),
                            const SizedBox(width: 10),
                            _buildStatPill('50+', 'QUESTIONS'),
                            const SizedBox(width: 10),
                            _buildStatPill('3', 'TOOLS'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              title: Text(
                'SCI Training',
                style: AppTheme.displayFont(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: -0.3,
                ),
              ),
            ),
          ),

          // Study Tools Row
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                children: [
                  // Quiz card — tappable
                  Expanded(
                    child: _StudyToolCard(
                      label: 'Quiz',
                      subtitle: '10 Qs',
                      accentColor: AppTheme.accentTeal,
                      onTap: () {
                        final questions = SCIQuizBank.getRandomQuiz(10);
                        if (questions.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => QuizSessionView(
                                questions: questions,
                                title: 'Board Review Quiz',
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Flashcards — coming soon
                  Expanded(
                    child: _StudyToolCard(
                      label: 'Flashcards',
                      subtitle: 'Soon',
                      accentColor: AppTheme.warningAmber,
                      showSoonChip: true,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Podcasts — coming soon
                  Expanded(
                    child: _StudyToolCard(
                      label: 'Podcasts',
                      subtitle: 'Soon',
                      accentColor: AppTheme.classificationColor,
                      showSoonChip: true,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Section Divider — LEARNING PATHWAY
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Column(
                children: [
                  Container(height: 1, color: AppTheme.borderSubtle),
                  const SizedBox(height: 12),
                  Text(
                    'LEARNING PATHWAY',
                    style: AppTheme.displayFont(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2.0,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(height: 1, color: AppTheme.borderSubtle),
                ],
              ),
            ),
          ),

          // Module cards with staggered animation
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final module = modules[index];
                return SlideTransition(
                  position: _slideAnimations[index],
                  child: FadeTransition(
                    opacity: _fadeAnimations[index],
                    child: ContentCard(
                      module: module,
                      index: index,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ModuleContentScreen(module: module),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
              childCount: modules.length,
            ),
          ),

          // Bottom padding
          const SliverToBoxAdapter(
            child: SizedBox(height: 32),
          ),
        ],
      ),
    );
  }

  Widget _buildStatPill(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.12),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: AppTheme.monoFont(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppTheme.displayFont(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
              color: Colors.white60,
            ),
          ),
        ],
      ),
    );
  }
}

class _StudyToolCard extends StatelessWidget {
  const _StudyToolCard({
    required this.label,
    required this.subtitle,
    required this.accentColor,
    this.onTap,
    this.showSoonChip = false,
  });

  final String label;
  final String subtitle;
  final Color accentColor;
  final VoidCallback? onTap;
  final bool showSoonChip;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppTheme.cardBackground,
      borderRadius: BorderRadius.circular(6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppTheme.borderSubtle, width: 1),
          ),
          child: Row(
            children: [
              Container(
                width: 3,
                height: 32,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: AppTheme.displayFont(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    if (showSoonChip)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: accentColor.withValues(alpha: 0.4),
                          ),
                        ),
                        child: Text(
                          'Soon',
                          style: AppTheme.displayFont(
                            fontSize: 9,
                            fontWeight: FontWeight.w500,
                            color: accentColor,
                            letterSpacing: 0.5,
                          ),
                        ),
                      )
                    else
                      Text(
                        subtitle,
                        style: AppTheme.bodyFont(
                          fontSize: 11,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
