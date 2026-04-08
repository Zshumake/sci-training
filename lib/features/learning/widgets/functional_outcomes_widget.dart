import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/responsive_layout.dart';

// ---------------------------------------------------------------------------
// Data models
// ---------------------------------------------------------------------------

class _LevelOutcome {
  const _LevelOutcome({
    required this.level,
    required this.keyMuscles,
    required this.feeding,
    required this.dressing,
    required this.transfers,
    required this.mobility,
    required this.bowelBladder,
    required this.fimExpectation,
    required this.equipment,
    required this.independenceLevel,
    required this.energyCostMultiplier,
    this.highlight,
  });

  final String level;
  final String keyMuscles;
  final String feeding;
  final String dressing;
  final String transfers;
  final String mobility;
  final String bowelBladder;
  final String fimExpectation;
  final List<String> equipment;
  final String independenceLevel;
  final double energyCostMultiplier;
  final String? highlight;
}

// ---------------------------------------------------------------------------
// Static data
// ---------------------------------------------------------------------------

const List<_LevelOutcome> _outcomes = [
  _LevelOutcome(
    level: 'C1-C2',
    keyMuscles: 'SCM, upper trapezius. NO diaphragm.',
    feeding: 'Total assist',
    dressing: 'Total assist',
    transfers: 'Total assist (mechanical lift)',
    mobility: 'Power WC: sip-and-puff or head array. Ventilator dependent.',
    bowelBladder: 'Total assist. Indwelling or suprapubic catheter.',
    fimExpectation: 'FIM 18-25 (total dependence)',
    equipment: [
      'Power WC with tilt/recline',
      'Sip-and-puff drive control',
      'Ventilator + backup',
      'ECU (voice/sip-puff)',
      'Hospital bed',
      'Hoyer lift',
    ],
    independenceLevel: 'Total Dependence',
    energyCostMultiplier: 0,
  ),
  _LevelOutcome(
    level: 'C3',
    keyMuscles: 'Partial diaphragm (C3-C5). Weak/absent.',
    feeding: 'Total assist. Mouth stick for some tasks.',
    dressing: 'Total assist',
    transfers: 'Total assist (mechanical lift)',
    mobility: 'Power WC: sip-puff, head array, or chin. May wean from vent.',
    bowelBladder: 'Total assist.',
    fimExpectation: 'FIM 18-28',
    equipment: [
      'Power WC with tilt/recline',
      'Sip-puff or chin drive',
      'Ventilator (may wean)',
      'ECU (voice-activated)',
      'Hospital bed',
      'Hoyer lift',
    ],
    independenceLevel: 'Total Dependence',
    energyCostMultiplier: 0,
  ),
  _LevelOutcome(
    level: 'C4',
    keyMuscles: 'Diaphragm (full), trapezius, cervical paraspinals.',
    feeding: 'Total assist. Can direct care verbally.',
    dressing: 'Total assist',
    transfers: 'Total assist (mechanical lift)',
    mobility: 'Power WC: chin or head array. Independent on flat.',
    bowelBladder: 'Total assist. May direct own program.',
    fimExpectation: 'FIM 20-32',
    equipment: [
      'Power WC with tilt/recline',
      'Chin or head array drive',
      'ECU (voice-activated)',
      'Hospital bed',
      'Hoyer lift',
    ],
    independenceLevel: 'Maximal Dependence',
    energyCostMultiplier: 0,
  ),
  _LevelOutcome(
    level: 'C5',
    keyMuscles: 'Biceps, deltoid, brachialis, brachioradialis, rhomboids, serratus anterior.',
    feeding: 'Mod-independent with universal cuff after setup.',
    dressing: 'Mod-max assist grooming/dressing.',
    transfers: 'Dependent (sliding board with max assist)',
    mobility: 'Power WC (hand joystick). Manual WC flat only with quad pegs.',
    bowelBladder: 'Assist. May direct own CIC program.',
    fimExpectation: 'FIM 30-55',
    equipment: [
      'Power WC (primary) with joystick',
      'Lightweight manual WC (flat surfaces)',
      'Quad pegs / coated rims',
      'Universal cuff',
      'Mobile arm support',
      'Pressure relief cushion (ROHO/Jay)',
    ],
    independenceLevel: 'Moderate Dependence',
    energyCostMultiplier: 0,
  ),
  _LevelOutcome(
    level: 'C6',
    keyMuscles: 'Wrist extensors (ECRL, ECRB), supinator, clavicular pectoralis.',
    feeding: 'Mod-independent (tenodesis grasp). 16% full independence rate.',
    dressing: 'CG to mod-ind UE. Max assist LE. 13% independent UE dressing.',
    transfers: 'CG to mod-ind with sliding board on level surfaces. 6% independent.',
    mobility: 'Independent manual WC flat/slight inclines. Power for distance. 88% WC independence.',
    bowelBladder: 'Independent CIC with adaptive equipment (some). 3% independent bowel.',
    fimExpectation: 'FIM 45-75',
    equipment: [
      'Lightweight manual WC (primary)',
      'Coated/friction rims',
      'Power WC (distance/outdoors)',
      'Sliding board',
      'Adaptive utensils (built-up handles)',
      'Tenodesis splint',
      'Pressure relief cushion',
    ],
    independenceLevel: 'Mod-Independence (highest complete SCI for independent living)',
    energyCostMultiplier: 0,
    highlight: 'TENODESIS GRASP -- the game-changer. Active wrist extension creates passive finger flexion. Do NOT stretch finger flexors in C6 patients.',
  ),
  _LevelOutcome(
    level: 'C7',
    keyMuscles: 'Triceps, wrist flexors, finger extensors, latissimus dorsi.',
    feeding: 'Independent (may need minimal adaptive equipment).',
    dressing: 'Mod-ind to independent all dressing.',
    transfers: 'Independent depression transfers (triceps). Independent all transfers.',
    mobility: 'Independent manual WC all surfaces including curbs. Wheelies.',
    bowelBladder: 'Independent CIC. Independent bowel program with adaptive equipment.',
    fimExpectation: 'FIM 70-100',
    equipment: [
      'Ultra-lightweight rigid-frame manual WC',
      'Standard rims',
      'Pressure relief cushion',
      'Minimal adaptive equipment',
    ],
    independenceLevel: 'Independent (USUAL level for independence)',
    energyCostMultiplier: 0,
    highlight: 'C7 = USUAL INDEPENDENCE LEVEL. Triceps enable depression transfers, independent WC on all surfaces, and pressure reliefs.',
  ),
  _LevelOutcome(
    level: 'C8-T1',
    keyMuscles: 'Hand intrinsics (lumbricals, interossei), finger flexors (FDP/FDS), thumb muscles.',
    feeding: 'Fully independent.',
    dressing: 'Fully independent all dressing.',
    transfers: 'Fully independent all transfers including floor-to-WC.',
    mobility: 'Fully independent manual WC all surfaces including uneven terrain.',
    bowelBladder: 'Fully independent bladder and bowel programs.',
    fimExpectation: 'FIM 95-115',
    equipment: [
      'Ultra-lightweight rigid-frame manual WC',
      'Standard rims',
      'Pressure relief cushion',
    ],
    independenceLevel: 'Fully Independent (full hand function)',
    energyCostMultiplier: 0,
  ),
  _LevelOutcome(
    level: 'T2-T6',
    keyMuscles: 'Upper intercostals, upper back extensors.',
    feeding: 'Fully independent.',
    dressing: 'Fully independent.',
    transfers: 'Fully independent all transfers.',
    mobility: 'Independent all WC. Exercise-only ambulation (bilateral KAFOs + walker).',
    bowelBladder: 'Fully independent.',
    fimExpectation: 'FIM 100-120',
    equipment: [
      'Ultra-lightweight manual WC',
      'Pressure relief cushion',
      'Standing frame (therapeutic)',
      'Bilateral KAFOs (exercise only)',
    ],
    independenceLevel: 'Fully Independent',
    energyCostMultiplier: 9.0,
  ),
  _LevelOutcome(
    level: 'T7-T9',
    keyMuscles: 'Lower intercostals, upper abdominals (upper rectus).',
    feeding: 'Fully independent.',
    dressing: 'Fully independent.',
    transfers: 'Fully independent.',
    mobility: 'Independent all WC. Exercise-only ambulation. Improved trunk stability.',
    bowelBladder: 'Fully independent.',
    fimExpectation: 'FIM 105-120',
    equipment: [
      'Ultra-lightweight manual WC',
      'Pressure relief cushion',
      'Standing frame',
      'Bilateral KAFOs (exercise only)',
    ],
    independenceLevel: 'Fully Independent',
    energyCostMultiplier: 7.0,
  ),
  _LevelOutcome(
    level: 'T10-T12',
    keyMuscles: 'Full abdominals (rectus, obliques), lower back extensors.',
    feeding: 'Fully independent.',
    dressing: 'Fully independent.',
    transfers: 'Fully independent.',
    mobility: 'Independent all WC. Household ambulation (bilateral KAFOs + crutches). WC primary for community.',
    bowelBladder: 'Fully independent.',
    fimExpectation: 'FIM 110-122',
    equipment: [
      'Ultra-lightweight manual WC',
      'Pressure relief cushion',
      'Bilateral KAFOs',
      'Forearm crutches',
      'RGO option',
    ],
    independenceLevel: 'Fully Independent',
    energyCostMultiplier: 6.0,
  ),
  _LevelOutcome(
    level: 'L1-L2',
    keyMuscles: 'Hip flexors (iliopsoas), hip adductors.',
    feeding: 'Fully independent.',
    dressing: 'Fully independent.',
    transfers: 'Fully independent.',
    mobility: 'Household to limited community ambulation (bilateral KAFOs + crutches). WC for long distances.',
    bowelBladder: 'May be neurogenic. Often independent management.',
    fimExpectation: 'FIM 115-124',
    equipment: [
      'Lightweight manual WC (backup)',
      'Bilateral KAFOs',
      'Forearm crutches',
      'Pressure relief cushion',
    ],
    independenceLevel: 'Fully Independent',
    energyCostMultiplier: 3.0,
  ),
  _LevelOutcome(
    level: 'L3-L4',
    keyMuscles: 'Quadriceps (knee extension), hip flexors.',
    feeding: 'Fully independent.',
    dressing: 'Fully independent.',
    transfers: 'Fully independent.',
    mobility: 'Community ambulation (bilateral AFOs + crutches/canes). May not need WC.',
    bowelBladder: 'May be neurogenic. Independent management.',
    fimExpectation: 'FIM 118-126',
    equipment: [
      'Bilateral AFOs or KAFOs',
      'Forearm crutches or canes',
      'WC optional for long distances',
    ],
    independenceLevel: 'Community Ambulatory',
    energyCostMultiplier: 1.8,
  ),
  _LevelOutcome(
    level: 'L5-S1',
    keyMuscles: 'Ankle dorsiflexors (tibialis anterior), hip abductors, hamstrings.',
    feeding: 'Fully independent.',
    dressing: 'Fully independent.',
    transfers: 'Fully independent.',
    mobility: 'Community ambulation (AFO +/- cane). Near-normal gait.',
    bowelBladder: 'May still be neurogenic. Independent management.',
    fimExpectation: 'FIM 120-126',
    equipment: [
      'AFO (foot drop)',
      'Cane (optional)',
    ],
    independenceLevel: 'Community Ambulatory',
    energyCostMultiplier: 1.3,
  ),
];

// ---------------------------------------------------------------------------
// Widget
// ---------------------------------------------------------------------------

class FunctionalOutcomesWidget extends StatefulWidget {
  const FunctionalOutcomesWidget({super.key});

  @override
  State<FunctionalOutcomesWidget> createState() =>
      _FunctionalOutcomesWidgetState();
}

class _FunctionalOutcomesWidgetState extends State<FunctionalOutcomesWidget> {
  int _selectedIndex = 0;
  int? _compareIndex;
  bool _compareMode = false;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBody(
      maxWidth: ResponsiveBreakpoints.maxToolWidth,
      child: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            'Functional Outcomes by Injury Level',
            style: AppTheme.displayFont(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppTheme.primaryNavy,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Select a neurological level to view expected outcomes for complete (AIS A/B) injuries.',
            style: AppTheme.bodyFont(
              fontSize: 13,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 12),

          // Compare mode toggle
          _buildCompareToggle(),
          const SizedBox(height: 12),

          // Level selector
          _buildLevelSelector(
            label: _compareMode ? 'LEVEL 1' : 'SELECT LEVEL',
            selectedIndex: _selectedIndex,
            onSelect: (i) => setState(() => _selectedIndex = i),
            accentColor: AppTheme.accentTeal,
          ),

          if (_compareMode) ...[
            const SizedBox(height: 8),
            _buildLevelSelector(
              label: 'LEVEL 2',
              selectedIndex: _compareIndex ?? -1,
              onSelect: (i) => setState(() => _compareIndex = i),
              accentColor: AppTheme.warningAmber,
            ),
          ],
          const SizedBox(height: 16),

          // Energy cost display
          _buildEnergyCostDisplay(),
          const SizedBox(height: 16),

          // Outcome display
          if (_compareMode && _compareIndex != null)
            _buildComparisonView()
          else
            _buildOutcomeCard(_outcomes[_selectedIndex], AppTheme.accentTeal),
        ],
      ),
      ),
    );
  }

  // -----------------------------------------------------------------------
  // Compare toggle
  // -----------------------------------------------------------------------

  Widget _buildCompareToggle() {
    return GestureDetector(
      onTap: () => setState(() {
        _compareMode = !_compareMode;
        if (!_compareMode) _compareIndex = null;
      }),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: _compareMode
              ? AppTheme.accentTeal.withOpacity(0.1)
              : AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: _compareMode ? AppTheme.accentTeal : AppTheme.borderSubtle,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.compare_arrows,
              size: 18,
              color: _compareMode ? AppTheme.accentTeal : AppTheme.textSecondary,
            ),
            const SizedBox(width: 6),
            Text(
              _compareMode ? 'Comparison Mode ON' : 'Compare Two Levels',
              style: AppTheme.displayFont(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color:
                    _compareMode ? AppTheme.accentTeal : AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -----------------------------------------------------------------------
  // Level selector
  // -----------------------------------------------------------------------

  Widget _buildLevelSelector({
    required String label,
    required int selectedIndex,
    required ValueChanged<int> onSelect,
    required Color accentColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.displayFont(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: accentColor,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 36,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _outcomes.length,
            itemBuilder: (context, i) {
              final isSelected = i == selectedIndex;
              final outcome = _outcomes[i];
              // Color code by region
              Color chipColor;
              if (outcome.level.startsWith('C')) {
                chipColor = const Color(0xFF3566A0);
              } else if (outcome.level.startsWith('T')) {
                chipColor = const Color(0xFFEA580C);
              } else if (outcome.level.startsWith('L')) {
                chipColor = const Color(0xFF059669);
              } else {
                chipColor = const Color(0xFF6366F1);
              }

              return Padding(
                padding: const EdgeInsets.only(right: 6),
                child: GestureDetector(
                  onTap: () => onSelect(i),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? chipColor
                          : chipColor.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: isSelected ? chipColor : chipColor.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      outcome.level,
                      style: AppTheme.monoFont(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : chipColor,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // -----------------------------------------------------------------------
  // Energy cost bar
  // -----------------------------------------------------------------------

  Widget _buildEnergyCostDisplay() {
    // Filter to only levels with ambulation energy data
    final ambulationLevels =
        _outcomes.where((o) => o.energyCostMultiplier > 0).toList();
    if (ambulationLevels.isEmpty) {
      return const SizedBox.shrink();
    }

    final selected = _outcomes[_selectedIndex];
    final maxCost = ambulationLevels
        .map((o) => o.energyCostMultiplier)
        .reduce(math.max);

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppTheme.borderSubtle, width: 1),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Energy Cost of Ambulation',
                style: AppTheme.displayFont(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                'vs normal walking (1.0x)',
                style: AppTheme.bodyFont(
                  fontSize: 11,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Normal baseline
          _buildEnergyBar('Normal', 1.0, maxCost, AppTheme.successGreen, false),
          const SizedBox(height: 4),
          // Citation
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              'Source: Waters et al. — Energy cost of ambulation in SCI',
              style: AppTheme.bodyFont(
                fontSize: 10,
                fontStyle: FontStyle.italic,
                color: AppTheme.textSecondary,
              ),
            ),
          ),
          // All ambulatory levels
          ...ambulationLevels.map((o) {
            final isCurrentSelection = o.level == selected.level;
            final isCompare =
                _compareIndex != null && o.level == _outcomes[_compareIndex!].level;
            return Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: _buildEnergyBar(
                o.level,
                o.energyCostMultiplier,
                maxCost,
                isCurrentSelection
                    ? AppTheme.accentTeal
                    : (isCompare
                        ? AppTheme.warningAmber
                        : AppTheme.borderSubtle),
                isCurrentSelection || isCompare,
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildEnergyBar(
    String label,
    double cost,
    double maxCost,
    Color color,
    bool isHighlighted,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 55,
          child: Text(
            label,
            style: AppTheme.monoFont(
              fontSize: 11,
              fontWeight: isHighlighted ? FontWeight.w700 : FontWeight.w500,
              color: isHighlighted ? color : AppTheme.textSecondary,
            ),
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 14,
                decoration: BoxDecoration(
                  color: AppTheme.surfaceMuted,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              FractionallySizedBox(
                widthFactor: (cost / maxCost).clamp(0.0, 1.0),
                child: Container(
                  height: 14,
                  decoration: BoxDecoration(
                    color: isHighlighted
                        ? color
                        : color.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 6),
        SizedBox(
          width: 35,
          child: Text(
            '${cost}x',
            style: AppTheme.monoFont(
              fontSize: 11,
              fontWeight: isHighlighted ? FontWeight.w700 : FontWeight.w500,
              color: isHighlighted ? color : AppTheme.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  // -----------------------------------------------------------------------
  // Outcome card
  // -----------------------------------------------------------------------

  Widget _buildOutcomeCard(_LevelOutcome outcome, Color accentColor) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppTheme.borderSubtle, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.08),
              border: Border(
                left: BorderSide(color: accentColor, width: 3),
              ),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      outcome.level,
                      style: AppTheme.displayFont(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: accentColor,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        outcome.independenceLevel,
                        style: AppTheme.displayFont(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  outcome.keyMuscles,
                  style: AppTheme.bodyFont(fontSize: 13),
                ),
              ],
            ),
          ),

          // Highlight callout
          if (outcome.highlight != null)
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(12, 10, 12, 0),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppTheme.pearlBackground,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppTheme.pearlBorder, width: 1),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.star, size: 16, color: AppTheme.pearlBorder),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      outcome.highlight!,
                      style: AppTheme.bodyFont(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Detail rows
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                _buildDetailRow('Feeding', outcome.feeding, Icons.restaurant),
                _buildDetailRow(
                    'Dressing', outcome.dressing, Icons.checkroom),
                _buildDetailRow(
                    'Transfers', outcome.transfers, Icons.swap_horiz),
                _buildDetailRow(
                    'Mobility', outcome.mobility, Icons.accessible),
                _buildDetailRow(
                    'Bowel/Bladder', outcome.bowelBladder, Icons.medical_services),
                _buildDetailRow(
                    'FIM', outcome.fimExpectation, Icons.assessment),
              ],
            ),
          ),

          // Equipment
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.surfaceMuted,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'EQUIPMENT',
                  style: AppTheme.displayFont(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textSecondary,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: outcome.equipment.map((e) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.cardBackground,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                            color: AppTheme.borderSubtle, width: 1),
                      ),
                      child: Text(
                        e,
                        style: AppTheme.bodyFont(fontSize: 11),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: AppTheme.textSecondary),
          const SizedBox(width: 8),
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: AppTheme.displayFont(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppTheme.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTheme.bodyFont(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // -----------------------------------------------------------------------
  // Comparison view
  // -----------------------------------------------------------------------

  Widget _buildComparisonView() {
    final left = _outcomes[_selectedIndex];
    final right = _outcomes[_compareIndex!];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${left.level} vs ${right.level}',
          style: AppTheme.displayFont(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppTheme.primaryNavy,
          ),
        ),
        const SizedBox(height: 12),

        // Side by side comparison rows
        _buildCompareRow('Key Muscles', left.keyMuscles, right.keyMuscles),
        _buildCompareRow('Feeding', left.feeding, right.feeding),
        _buildCompareRow('Dressing', left.dressing, right.dressing),
        _buildCompareRow('Transfers', left.transfers, right.transfers),
        _buildCompareRow('Mobility', left.mobility, right.mobility),
        _buildCompareRow('Bowel/Bladder', left.bowelBladder, right.bowelBladder),
        _buildCompareRow('FIM', left.fimExpectation, right.fimExpectation),
        _buildCompareRow(
            'Independence', left.independenceLevel, right.independenceLevel),
        _buildCompareRow(
          'Equipment',
          left.equipment.join(', '),
          right.equipment.join(', '),
        ),
      ],
    );
  }

  Widget _buildCompareRow(String label, String leftVal, String rightVal) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppTheme.borderSubtle, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.surfaceMuted,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(5)),
            ),
            child: Text(
              label,
              style: AppTheme.displayFont(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppTheme.textSecondary,
              ),
            ),
          ),
          // Two columns
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Left (teal accent)
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                            color: AppTheme.accentTeal, width: 3),
                        right: BorderSide(
                            color: AppTheme.borderSubtle, width: 0.5),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _outcomes[_selectedIndex].level,
                          style: AppTheme.monoFont(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.accentTeal,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          leftVal,
                          style: AppTheme.bodyFont(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                // Right (amber accent)
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                            color: AppTheme.warningAmber, width: 3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _outcomes[_compareIndex!].level,
                          style: AppTheme.monoFont(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.warningAmber,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          rightVal,
                          style: AppTheme.bodyFont(fontSize: 12),
                        ),
                      ],
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
