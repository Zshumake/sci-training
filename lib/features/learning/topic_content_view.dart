import 'package:flutter/material.dart';
import '../../data/models/topic_content_model.dart';
import '../../core/theme/app_theme.dart';
import 'widgets/isncsci_scoring_tool.dart';
import 'widgets/dermatome_map_widget.dart';
import 'widgets/ais_practice_widget.dart';
import 'widgets/isncsci_classification_trainer.dart';
import 'widgets/isncsci_worksheet.dart';
import 'widgets/sci_anatomy_gallery_view.dart';

class TopicContentView extends StatelessWidget {
  final TopicData topicData;

  const TopicContentView({super.key, required this.topicData});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: topicData.tabs.length,
      child: Column(
        children: [
          TabBar(
            isScrollable: topicData.tabs.length > 3,
            labelColor: AppTheme.primaryNavy,
            unselectedLabelColor: AppTheme.textSecondary,
            indicatorColor: AppTheme.accentTeal,
            indicatorWeight: 3,
            tabs: topicData.tabs.map((t) => Tab(text: t.title)).toList(),
          ),
          Expanded(
            child: TabBarView(
              children: topicData.tabs.map((tab) {
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: tab.blocks.length,
                  itemBuilder: (context, index) {
                    return _buildBlock(tab.blocks[index], context);
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlock(ContentBlock block, BuildContext context) => switch (block) {
    HeaderBlock b => _buildHeader(b),
    TextBlock b => _buildText(b),
    PearlBlock b => _buildPearl(b),
    BulletCardBlock b => _buildBulletCard(b),
    TableBlock b => _buildTable(b),
    MnemonicBlock b => _buildMnemonic(b),
    NumberedListBlock b => _buildNumberedList(b),
    MedicationCardBlock b => _buildMedicationCard(b),
    ComparisonCardBlock b => _buildComparisonCard(b),
    ScaleBlock b => _buildScaleBlock(b),
    AnnotatedImageBlock b => _buildAnnotatedImage(b, context),
    FlowchartBlock b => _buildFlowchart(b),
    ComparisonDiagramBlock b => _buildComparisonDiagram(b),
    CustomWidgetBlock b => _buildCustomWidget(b, context),
  };

  Widget _buildHeader(HeaderBlock block) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            block.title,
            style: AppTheme.displayFont(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppTheme.primaryNavy,
              letterSpacing: -0.3,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8, bottom: 12),
            height: 1,
            color: AppTheme.borderSubtle,
          ),
        ],
      ),
    );
  }

  Widget _buildText(TextBlock block) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        block.text,
        style: block.isIntro
            ? AppTheme.bodyFont(
                fontSize: 15,
                fontStyle: FontStyle.italic,
                color: AppTheme.textPrimary,
                height: 1.6,
              )
            : AppTheme.bodyFont(
                fontSize: 14,
                color: AppTheme.textSecondary,
                height: 1.6,
              ),
      ),
    );
  }

  Widget _buildPearl(PearlBlock block) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppTheme.cardBackground,
        border: Border(
          left: BorderSide(color: AppTheme.pearlBorder, width: 3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.lightbulb_rounded,
                  color: AppTheme.pearlBorder, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  block.title,
                  style: AppTheme.displayFont(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF8B6914),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            block.text,
            style: AppTheme.bodyFont(
              fontSize: 13,
              color: AppTheme.textPrimary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletCard(BulletCardBlock block) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppTheme.borderSubtle, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            block.title,
            style: AppTheme.displayFont(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: block.themeColor,
            ),
          ),
          const SizedBox(height: 10),
          ...block.points.map((point) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\u2014 ',
                      style: AppTheme.bodyFont(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: block.themeColor,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        point,
                        style: AppTheme.bodyFont(
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildTable(TableBlock block) {
    final headerBg = block.headerColor ?? AppTheme.primaryNavy;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppTheme.borderSubtle, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (block.title.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: headerBg,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
              ),
              child: Text(
                block.title,
                style: AppTheme.displayFont(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: _buildTableContent(block.columns, block.rows, hasTitle: block.title.isNotEmpty),
          ),
        ],
      ),
    );
  }

  /// Shared Column-based table builder used by _buildTable and _buildScaleBlock.
  Widget _buildTableContent(
    List<String> columns,
    List<List<String>> rows, {
    bool hasTitle = false,
  }) {
    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Column headers
          Container(
            color: AppTheme.surfaceMuted,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: columns
                  .map((col) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Text(
                            col.toUpperCase(),
                            style: AppTheme.displayFont(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          Container(height: 1, color: AppTheme.inkLight),
          // Data rows
          ...rows.asMap().entries.map((entry) {
            final rowIndex = entry.key;
            final row = entry.value;
            final isLast = rowIndex == rows.length - 1;
            final bgColor = rowIndex.isEven
                ? AppTheme.cardBackground
                : AppTheme.surfaceLight;

            return Column(
              children: [
                Container(
                  color: bgColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    children: row
                        .map((cell) => Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Text(
                                  cell,
                                  style: AppTheme.bodyFont(
                                    fontSize: 12,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                if (!isLast)
                  Container(height: 1, color: AppTheme.inkLight),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildMnemonic(MnemonicBlock block) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppTheme.cardBackground,
        border: Border(
          left: BorderSide(color: AppTheme.mnemonicBorder, width: 3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'MEMORY AID',
            style: AppTheme.displayFont(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
              color: AppTheme.mnemonicBorder,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            block.mnemonic,
            style: AppTheme.displayFont(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            block.explanation,
            style: AppTheme.bodyFont(
              fontSize: 13,
              fontStyle: FontStyle.italic,
              color: AppTheme.textSecondary,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberedList(NumberedListBlock block) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: block.items.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.borderSubtle, width: 1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    item.key,
                    style: AppTheme.monoFont(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.accentTeal,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Text(
                      item.value,
                      style: AppTheme.bodyFont(
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMedicationCard(MedicationCardBlock block) {
    final accentColor =
        block.isAvoid ? AppTheme.avoidBorder : AppTheme.accentTeal;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppTheme.borderSubtle, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 3px left accent border
          Container(width: 3, color: accentColor),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Drug name
                  Text(
                    block.name,
                    style: AppTheme.displayFont(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Drug class chip
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border:
                          Border.all(color: AppTheme.borderSubtle, width: 1),
                    ),
                    child: Text(
                      block.drugClass,
                      style: AppTheme.displayFont(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textSecondary,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Mechanism
                  _buildMedField('MECHANISM', block.mechanism),
                  const SizedBox(height: 6),
                  // Indication
                  _buildMedField('INDICATION', block.indication),
                  if (block.dosing.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    _buildMedField('DOSING', block.dosing),
                  ],
                  if (block.sideEffects.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    _buildMedField('SIDE EFFECTS', block.sideEffects),
                  ],
                  if (block.boardPearl.isNotEmpty) ...[
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 6),
                      height: 1,
                      color: AppTheme.inkLight,
                    ),
                    Text(
                      'Board Pearl: ${block.boardPearl}',
                      style: AppTheme.bodyFont(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: AppTheme.textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.displayFont(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            color: AppTheme.textSecondary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: AppTheme.bodyFont(
            fontSize: 13,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildComparisonCard(ComparisonCardBlock block) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppTheme.borderSubtle, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 3px left accent border
          Container(width: 3, color: block.themeColor),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(block.icon, color: block.themeColor, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          block.title,
                          style: AppTheme.displayFont(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: block.themeColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    block.description,
                    style: AppTheme.bodyFont(
                      fontSize: 13,
                      height: 1.5,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...block.keyPoints.map((p) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\u2014 ',
                              style: AppTheme.bodyFont(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: block.themeColor,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                p,
                                style: AppTheme.bodyFont(
                                  fontSize: 13,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScaleBlock(ScaleBlock block) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppTheme.borderSubtle, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Scale name header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: const BoxDecoration(
              color: AppTheme.primaryNavy,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  block.scaleName,
                  style: AppTheme.displayFont(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  block.description,
                  style: AppTheme.bodyFont(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          // Table content
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: _buildTableContent(block.columns, block.rows),
          ),
          // Board pearl footer
          if (block.boardPearl != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: AppTheme.cardBackground,
                border: Border(
                  left: BorderSide(color: AppTheme.pearlBorder, width: 3),
                ),
              ),
              child: Text(
                'Board Pearl: ${block.boardPearl}',
                style: AppTheme.bodyFont(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: const Color(0xFF8B6914),
                  height: 1.4,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCustomWidget(CustomWidgetBlock block, BuildContext context) {
    String title;
    String subtitle;
    IconData icon;
    Color color;
    Widget Function(BuildContext) builder;

    switch (block.type) {
      case CustomWidgetType.asiaExamTool:
        title = 'ISNCSCI Scoring Tool';
        subtitle = 'Interactive exam — enter scores, auto-calculate NLI & AIS';
        icon = Icons.calculate_rounded;
        color = AppTheme.accentTeal;
        builder = (_) => Scaffold(
          appBar: AppBar(title: const Text('ISNCSCI Scoring Tool')),
          body: const ISNCSCIScoringTool(),
        );
      case CustomWidgetType.dermatomalMap:
        title = 'Dermatome Body Map';
        subtitle = 'Interactive diagram — study & quiz modes';
        icon = Icons.accessibility_new_rounded;
        color = const Color(0xFF7C3AED);
        builder = (_) => Scaffold(
          appBar: AppBar(title: const Text('Dermatome Map')),
          body: const DermatomeMapWidget(),
        );
      case CustomWidgetType.aisPractice:
        title = 'AIS Classification Practice';
        subtitle = '12 clinical scenarios — classify the AIS grade';
        icon = Icons.quiz_rounded;
        color = const Color(0xFFEA580C);
        builder = (_) => Scaffold(
          appBar: AppBar(title: const Text('AIS Practice Cases')),
          body: const AISPracticeWidget(),
        );
      case CustomWidgetType.classificationTrainer:
        title = 'ISNCSCI Classification Trainer';
        subtitle = '30 cases — step-by-step guided classification';
        icon = Icons.school_rounded;
        color = const Color(0xFF6366F1);
        builder = (_) => Scaffold(
          appBar: AppBar(title: const Text('Classification Trainer')),
          body: const ISNCSCIClassificationTrainer(),
        );
      case CustomWidgetType.isncsciWorksheet:
        title = 'ISNCSCI Worksheet';
        subtitle = 'Official exam form — enter scores, auto-classify';
        icon = Icons.assignment_rounded;
        color = const Color(0xFF059669);
        builder = (_) => Scaffold(
          appBar: AppBar(title: const Text('ISNCSCI Worksheet')),
          body: const ISNCSCIWorksheet(),
        );
      case CustomWidgetType.anatomyGallery:
        title = 'Anatomy Gallery';
        subtitle = '3D models, diagrams, and interactive layers';
        icon = Icons.view_in_ar_rounded;
        color = AppTheme.pathophysColor;
        builder = (_) => const SCIAnatomyGalleryView();
      default:
        title = 'Interactive Tool';
        subtitle = 'Coming soon';
        icon = Icons.construction_rounded;
        color = AppTheme.textSecondary;
        builder = (_) => Scaffold(
          appBar: AppBar(title: const Text('Coming Soon')),
          body: const Center(child: Text('This interactive tool is under development.')),
        );
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: builder),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color, color.withValues(alpha: 0.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_rounded, color: Colors.white.withValues(alpha: 0.7)),
          ],
        ),
      ),
    );
  }

  // --- Annotated Image Block ---
  Widget _buildAnnotatedImage(AnnotatedImageBlock block, BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: AppTheme.cardBackground,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppTheme.borderSubtle, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Stack(
                      children: [
                        Image.asset(
                          block.assetPath,
                          width: constraints.maxWidth,
                          fit: BoxFit.contain,
                          errorBuilder: (_, error, stack) => Container(
                            height: 200,
                            color: AppTheme.surfaceLight,
                            child: Center(
                              child: Text('Image not found', style: AppTheme.bodyFont(fontSize: 12, color: AppTheme.textSecondary)),
                            ),
                          ),
                        ),
                        ...block.annotations.map((a) {
                          return Positioned(
                            left: a.x * constraints.maxWidth - 10,
                            top: a.y * 200 - 10,
                            child: GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  backgroundColor: AppTheme.cardBackground,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                                  ),
                                  builder: (_) => Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(a.label, style: AppTheme.displayFont(fontSize: 16, fontWeight: FontWeight.w700)),
                                        const SizedBox(height: 8),
                                        Text(a.description, style: AppTheme.bodyFont(fontSize: 14, height: 1.5)),
                                        const SizedBox(height: 16),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: (a.color ?? AppTheme.accentTeal).withValues(alpha: 0.9),
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 2),
                                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 4)],
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(block.caption, style: AppTheme.bodyFont(fontSize: 12, fontStyle: FontStyle.italic, color: AppTheme.textSecondary)),
                    if (block.description != null) ...[
                      const SizedBox(height: 6),
                      Text(block.description!, style: AppTheme.bodyFont(fontSize: 13, color: AppTheme.textPrimary)),
                    ],
                    if (block.annotations.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Tap the colored dots to learn more',
                        style: AppTheme.bodyFont(fontSize: 11, color: AppTheme.textSecondary, fontStyle: FontStyle.italic),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // --- Flowchart Block ---
  Widget _buildFlowchart(FlowchartBlock block) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppTheme.borderSubtle, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: const BoxDecoration(
              color: AppTheme.primaryNavy,
              borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
            ),
            child: Row(
              children: [
                const Icon(Icons.account_tree_rounded, color: Colors.white, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(block.title, style: AppTheme.displayFont(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
                ),
              ],
            ),
          ),
          if (block.description != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
              child: Text(block.description!, style: AppTheme.bodyFont(fontSize: 12, color: AppTheme.textSecondary, fontStyle: FontStyle.italic)),
            ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: _buildFlowchartTree(block.nodes, block.edges),
          ),
        ],
      ),
    );
  }

  Widget _buildFlowchartTree(List<FlowchartNode> nodes, List<FlowchartEdge> edges) {
    final nodeMap = {for (var n in nodes) n.id: n};
    final childEdges = <String, List<FlowchartEdge>>{};
    for (var e in edges) {
      childEdges.putIfAbsent(e.fromId, () => []).add(e);
    }

    // Find root: node that is not a target of any edge
    final targets = edges.map((e) => e.toId).toSet();
    final root = nodes.firstWhere((n) => !targets.contains(n.id), orElse: () => nodes.first);

    return _buildNode(root, nodeMap, childEdges, 0);
  }

  Widget _buildNode(FlowchartNode node, Map<String, FlowchartNode> nodeMap, Map<String, List<FlowchartEdge>> childEdges, int depth) {
    final children = childEdges[node.id] ?? [];

    Color bgColor;
    Color borderColor;
    IconData? icon;
    switch (node.type) {
      case FlowchartNodeType.start:
        bgColor = AppTheme.primaryNavy.withValues(alpha: 0.1);
        borderColor = AppTheme.primaryNavy;
        icon = Icons.play_circle_outline_rounded;
      case FlowchartNodeType.decision:
        bgColor = AppTheme.warningAmber.withValues(alpha: 0.1);
        borderColor = AppTheme.warningAmber;
        icon = Icons.help_outline_rounded;
      case FlowchartNodeType.action:
        bgColor = AppTheme.accentTeal.withValues(alpha: 0.1);
        borderColor = AppTheme.accentTeal;
        icon = Icons.arrow_forward_rounded;
      case FlowchartNodeType.outcome:
        bgColor = node.color?.withValues(alpha: 0.1) ?? AppTheme.successGreen.withValues(alpha: 0.1);
        borderColor = node.color ?? AppTheme.successGreen;
        icon = Icons.check_circle_outline_rounded;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(6),
            border: Border(left: BorderSide(color: borderColor, width: 3)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 18, color: borderColor),
              const SizedBox(width: 8),
              Expanded(
                child: Text(node.text, style: AppTheme.bodyFont(fontSize: 13, color: AppTheme.textPrimary, height: 1.4)),
              ),
            ],
          ),
        ),
        if (children.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children.map((edge) {
                final childNode = nodeMap[edge.toId];
                if (childNode == null) return const SizedBox.shrink();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Container(width: 1, height: 12, color: AppTheme.borderSubtle),
                          const SizedBox(width: 8),
                          if (edge.label != null)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppTheme.surfaceMuted,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(edge.label!, style: AppTheme.monoFont(fontSize: 10, fontWeight: FontWeight.w600, color: AppTheme.textSecondary)),
                            ),
                        ],
                      ),
                    ),
                    _buildNode(childNode, nodeMap, childEdges, depth + 1),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ],
    );
  }

  // --- Comparison Diagram Block ---
  Widget _buildComparisonDiagram(ComparisonDiagramBlock block) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppTheme.borderSubtle, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 4),
            child: Text(block.title, style: AppTheme.displayFont(fontSize: 14, fontWeight: FontWeight.w700)),
          ),
          if (block.description != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 8),
              child: Text(block.description!, style: AppTheme.bodyFont(fontSize: 12, color: AppTheme.textSecondary, fontStyle: FontStyle.italic)),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 4, 10, 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildComparisonColumn(block.left)),
                const SizedBox(width: 8),
                Container(width: 1, color: AppTheme.borderSubtle),
                const SizedBox(width: 8),
                Expanded(child: _buildComparisonColumn(block.right)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonColumn(ComparisonSide side) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (side.imagePath != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                side.imagePath!,
                height: 100,
                fit: BoxFit.contain,
                errorBuilder: (_, error, stack) => const SizedBox.shrink(),
              ),
            ),
          ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            border: Border(left: BorderSide(color: side.themeColor, width: 3)),
          ),
          child: Text(side.title, style: AppTheme.displayFont(fontSize: 13, fontWeight: FontWeight.w700, color: side.themeColor)),
        ),
        const SizedBox(height: 6),
        ...side.features.map((f) => Padding(
          padding: const EdgeInsets.only(bottom: 4, left: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('\u2022 ', style: TextStyle(color: side.themeColor, fontSize: 13)),
              Expanded(child: Text(f, style: AppTheme.bodyFont(fontSize: 12, height: 1.4))),
            ],
          ),
        )),
      ],
    );
  }

}
