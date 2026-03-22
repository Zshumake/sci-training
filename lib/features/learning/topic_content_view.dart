import 'package:flutter/material.dart';
import '../../data/models/topic_content_model.dart';
import '../../core/theme/app_theme.dart';
import 'widgets/isncsci_scoring_tool.dart';
import 'widgets/dermatome_map_widget.dart';
import 'widgets/ais_practice_widget.dart';

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

  Widget _buildBlock(ContentBlock block, BuildContext context) {
    if (block is HeaderBlock) return _buildHeader(block);
    if (block is TextBlock) return _buildText(block);
    if (block is PearlBlock) return _buildPearl(block);
    if (block is BulletCardBlock) return _buildBulletCard(block);
    if (block is TableBlock) return _buildTable(block);
    if (block is MnemonicBlock) return _buildMnemonic(block);
    if (block is NumberedListBlock) return _buildNumberedList(block);
    if (block is MedicationCardBlock) return _buildMedicationCard(block);
    if (block is ComparisonCardBlock) return _buildComparisonCard(block);
    if (block is ScaleBlock) return _buildScaleBlock(block);
    if (block is CustomWidgetBlock) return _buildCustomWidget(block, context);
    return const SizedBox.shrink();
  }

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
      case CustomWidgetType.bladderManagementAlgorithm:
        title = 'AIS Classification Practice';
        subtitle = '12 clinical scenarios — classify the AIS grade';
        icon = Icons.quiz_rounded;
        color = const Color(0xFFEA580C);
        builder = (_) => Scaffold(
          appBar: AppBar(title: const Text('AIS Practice Cases')),
          body: const AISPracticeWidget(),
        );
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

}
