import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_theme.dart';

/// A collapsible/expandable panel showing the anterior and posterior dermatome
/// maps side by side (on wide screens) or in tabs (on narrow screens).
///
/// Features:
/// - Anterior and posterior views with toggle or side-by-side layout
/// - Pinch-to-zoom on the SVG images
/// - "Key Sensory Points" quick-reference table below the images
/// - Can be used standalone or embedded in other widgets
/// - Collapsible header so it doesn't take too much space when not needed
class DermatomeReferencePanel extends StatefulWidget {
  const DermatomeReferencePanel({
    super.key,
    this.initiallyExpanded = false,
    this.showHeader = true,
    this.showKeyTable = true,
    this.embedded = false,
  });

  /// Whether the panel starts expanded.
  final bool initiallyExpanded;

  /// Whether to show the collapsible header bar.
  final bool showHeader;

  /// Whether to show the key sensory points table.
  final bool showKeyTable;

  /// When true, removes outer padding/margin for embedding in other widgets.
  final bool embedded;

  @override
  State<DermatomeReferencePanel> createState() =>
      _DermatomeReferencePanelState();
}

class _DermatomeReferencePanelState extends State<DermatomeReferencePanel> {
  late bool _expanded;
  bool _keyTableExpanded = false;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded || !widget.showHeader;
  }

  @override
  Widget build(BuildContext context) {
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.showHeader) _buildHeader(),
        if (_expanded) ...[
          const SizedBox(height: 8),
          _DermatomeImageViewer(embedded: widget.embedded),
          if (widget.showKeyTable) ...[
            const SizedBox(height: 12),
            _buildKeyTableSection(),
          ],
        ],
      ],
    );

    if (widget.embedded) return content;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppTheme.borderSubtle),
      ),
      clipBehavior: Clip.antiAlias,
      child: content,
    );
  }

  Widget _buildHeader() {
    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: AppTheme.accentTeal.withValues(alpha: 0.06),
          border: Border(
            bottom: BorderSide(
              color: _expanded ? AppTheme.borderSubtle : Colors.transparent,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.accessibility_new_rounded,
              color: AppTheme.accentTeal,
              size: 20,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Dermatome Reference',
                style: AppTheme.displayFont(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.accentTeal,
                ),
              ),
            ),
            Icon(
              _expanded
                  ? Icons.keyboard_arrow_up_rounded
                  : Icons.keyboard_arrow_down_rounded,
              color: AppTheme.textSecondary,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyTableSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.embedded ? 0 : 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () => setState(() => _keyTableExpanded = !_keyTableExpanded),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.surfaceMuted.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  const Icon(Icons.format_list_numbered_rounded,
                      size: 16, color: AppTheme.textSecondary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Key Sensory Points (28 Dermatomes)',
                      style: AppTheme.displayFont(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ),
                  Icon(
                    _keyTableExpanded
                        ? Icons.expand_less
                        : Icons.expand_more,
                    size: 18,
                    color: AppTheme.textSecondary,
                  ),
                ],
              ),
            ),
          ),
          if (_keyTableExpanded) ...[
            const SizedBox(height: 6),
            const _KeySensoryPointsTable(),
          ],
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// =============================================================================
// Dermatome Image Viewer -- handles responsive layout (tabs vs side-by-side)
// =============================================================================

class _DermatomeImageViewer extends StatefulWidget {
  const _DermatomeImageViewer({this.embedded = false});

  final bool embedded;

  @override
  State<_DermatomeImageViewer> createState() => _DermatomeImageViewerState();
}

class _DermatomeImageViewerState extends State<_DermatomeImageViewer>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isWide = screenWidth > 800;

    if (isWide) {
      return _buildSideBySide();
    }
    return _buildTabbed();
  }

  Widget _buildSideBySide() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.embedded ? 0 : 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _DermatomeImageCard(
              assetPath: 'assets/infographics/anatomy/dermatome_anterior.svg',
              label: 'Anterior View',
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _DermatomeImageCard(
              assetPath: 'assets/infographics/anatomy/dermatome_posterior.svg',
              label: 'Posterior View',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabbed() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: widget.embedded ? 0 : 12),
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.surfaceMuted,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TabBar(
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                color: AppTheme.accentTeal,
                borderRadius: BorderRadius.circular(8),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: AppTheme.textSecondary,
              labelStyle: AppTheme.displayFont(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: AppTheme.displayFont(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              dividerColor: Colors.transparent,
              tabs: const [
                Tab(text: 'Anterior'),
                Tab(text: 'Posterior'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 420,
          child: TabBarView(
            controller: _tabController,
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: widget.embedded ? 0 : 12),
                child: _DermatomeImageCard(
                  assetPath:
                      'assets/infographics/anatomy/dermatome_anterior.svg',
                  label: 'Anterior View',
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: widget.embedded ? 0 : 12),
                child: _DermatomeImageCard(
                  assetPath:
                      'assets/infographics/anatomy/dermatome_posterior.svg',
                  label: 'Posterior View',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// Single dermatome image card with InteractiveViewer
// =============================================================================

class _DermatomeImageCard extends StatelessWidget {
  const _DermatomeImageCard({
    required this.assetPath,
    required this.label,
  });

  final String assetPath;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.borderSubtle),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6),
            color: AppTheme.primaryNavy.withValues(alpha: 0.04),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: AppTheme.displayFont(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppTheme.textSecondary,
                letterSpacing: 0.5,
              ),
            ),
          ),
          SizedBox(
            height: 380,
            child: InteractiveViewer(
              minScale: 1.0,
              maxScale: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SvgPicture.asset(
                  assetPath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Key sensory points reference table
// =============================================================================

class _KeySensoryPointsTable extends StatelessWidget {
  const _KeySensoryPointsTable();

  static const _keySensoryPoints = <(String, String)>[
    ('C2', 'At least 1 cm lateral to occipital protuberance (ISNCSCI 2019)'),
    ('C3', 'Supraclavicular fossa'),
    ('C4', 'Top of AC joint'),
    ('C5', 'Lateral antecubital fossa'),
    ('C6', 'Thumb (dorsal surface)'),
    ('C7', 'Middle finger (dorsal surface)'),
    ('C8', 'Little finger (dorsal surface)'),
    ('T1', 'Medial antecubital fossa'),
    ('T2', 'Apex of axilla'),
    ('T3', '3rd intercostal space'),
    ('T4', 'Nipple line'),
    ('T5', '5th intercostal space'),
    ('T6', 'Xiphoid process'),
    ('T7', 'Between T6 and T10'),
    ('T8', 'Between T6 and T10'),
    ('T9', 'Between T6 and T10'),
    ('T10', 'Umbilicus'),
    ('T11', 'Between T10 and T12'),
    ('T12', 'Inguinal ligament midpoint'),
    ('L1', 'Half distance T12\u2013L2'),
    ('L2', 'Mid-anterior thigh'),
    ('L3', 'Medial femoral condyle'),
    ('L4', 'Medial malleolus'),
    ('L5', 'Dorsum of foot at 3rd MTP'),
    ('S1', 'Lateral heel'),
    ('S2', 'Popliteal fossa midline'),
    ('S3', 'Ischial tuberosity'),
    ('S4-5', 'Perianal area'),
  ];

  Color _regionColor(String level) {
    if (level.startsWith('C')) return const Color(0xFF3B82F6);
    if (level.startsWith('T')) return const Color(0xFF059669);
    if (level.startsWith('L')) return const Color(0xFF7C3AED);
    return const Color(0xFFEA580C); // sacral
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppTheme.borderSubtle),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Header row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            color: AppTheme.primaryNavy.withValues(alpha: 0.06),
            child: Row(
              children: [
                SizedBox(
                  width: 50,
                  child: Text(
                    'Level',
                    style: AppTheme.displayFont(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.primaryNavy,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Key Sensory Point',
                    style: AppTheme.displayFont(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.primaryNavy,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Data rows
          for (var i = 0; i < _keySensoryPoints.length; i++)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              color: i.isEven
                  ? Colors.transparent
                  : AppTheme.surfaceMuted.withValues(alpha: 0.35),
              child: Row(
                children: [
                  SizedBox(
                    width: 50,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: _regionColor(_keySensoryPoints[i].$1)
                            .withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        _keySensoryPoints[i].$1,
                        style: AppTheme.monoFont(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: _regionColor(_keySensoryPoints[i].$1),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _keySensoryPoints[i].$2,
                      style: AppTheme.bodyFont(
                        fontSize: 12,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// =============================================================================
// Convenience: Show dermatome reference as a bottom sheet
// =============================================================================

/// Shows the dermatome reference panel in a modal bottom sheet.
///
/// Can be called from any widget to show the reference without navigating away.
void showDermatomeReferenceSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppTheme.cardBackground,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (ctx) => DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Column(
          children: [
            // Drag handle
            Container(
              margin: const EdgeInsets.only(top: 8, bottom: 4),
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.borderSubtle,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Row(
                children: [
                  const Icon(Icons.accessibility_new_rounded,
                      color: AppTheme.accentTeal, size: 22),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Dermatome Reference Map',
                      style: AppTheme.displayFont(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.primaryNavy,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: () => Navigator.pop(ctx),
                    color: AppTheme.textSecondary,
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: AppTheme.borderSubtle),
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.only(bottom: 24),
                child: const DermatomeReferencePanel(
                  showHeader: false,
                  initiallyExpanded: true,
                  embedded: true,
                ),
              ),
            ),
          ],
        );
      },
    ),
  );
}
