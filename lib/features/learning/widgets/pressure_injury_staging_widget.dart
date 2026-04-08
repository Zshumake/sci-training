import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/responsive_layout.dart';

// ---------------------------------------------------------------------------
// Data models
// ---------------------------------------------------------------------------

class _PIStage {
  const _PIStage({
    required this.name,
    required this.shortName,
    required this.description,
    required this.keyFeatures,
    required this.color,
  });

  final String name;
  final String shortName;
  final String description;
  final List<String> keyFeatures;
  final Color color;
}

class _BodyLocation {
  const _BodyLocation({
    required this.name,
    required this.position,
    required this.relativeX,
    required this.relativeY,
    required this.note,
  });

  final String name;
  final String position; // supine, sitting, lateral
  final double relativeX;
  final double relativeY;
  final String note;
}

class _StagingScenario {
  const _StagingScenario({
    required this.id,
    required this.description,
    required this.correctStage,
    required this.explanation,
  });

  final int id;
  final String description;
  final String correctStage;
  final String explanation;
}

// ---------------------------------------------------------------------------
// Static data
// ---------------------------------------------------------------------------

const List<_PIStage> _stages = [
  _PIStage(
    name: 'Stage I',
    shortName: 'I',
    description:
        'Intact skin with non-blanchable erythema of a localized area.',
    keyFeatures: [
      'Skin is INTACT (no open wound)',
      'Erythema does NOT blanch with fingertip pressure',
      'May feel warmer, cooler, firmer, softer, or more painful',
      'Difficult to detect in darkly pigmented skin',
      'Reactive hyperemia BLANCHES (not Stage 1)',
    ],
    color: Color(0xFF059669),
  ),
  _PIStage(
    name: 'Stage II',
    shortName: 'II',
    description:
        'Partial-thickness skin loss involving epidermis and/or dermis.',
    keyFeatures: [
      'Shallow open ulcer with RED-PINK wound bed',
      'NO slough or eschar present',
      'May present as intact or ruptured serum-filled BLISTER',
      'Does NOT include skin tears, tape burns, or MASD',
      'Partial thickness = epidermis and/or dermis',
    ],
    color: Color(0xFFEA580C),
  ),
  _PIStage(
    name: 'Stage III',
    shortName: 'III',
    description:
        'Full-thickness skin loss extending through dermis into subcutaneous fat.',
    keyFeatures: [
      'Subcutaneous FAT may be visible',
      'Bone, tendon, muscle are NOT exposed or palpable',
      'Slough may be present but does not obscure depth',
      'May include undermining and tunneling',
      'Depth varies by anatomic location',
    ],
    color: Color(0xFFDC2626),
  ),
  _PIStage(
    name: 'Stage IV',
    shortName: 'IV',
    description:
        'Full-thickness tissue loss with exposed bone, tendon, cartilage, or muscle.',
    keyFeatures: [
      'BONE, TENDON, or MUSCLE is exposed or directly palpable',
      'Slough or eschar may be present on parts of wound bed',
      'Often includes extensive undermining and tunneling',
      'HIGH risk of osteomyelitis',
      'Probe-to-bone test PPV ~89%',
    ],
    color: Color(0xFF7C3AED),
  ),
  _PIStage(
    name: 'Unstageable',
    shortName: 'U',
    description:
        'Full-thickness loss with wound bed obscured by slough and/or eschar.',
    keyFeatures: [
      'True depth CANNOT be determined',
      'Must debride slough/eschar to stage accurately',
      'Once debrided, will be Stage III or Stage IV',
      'EXCEPTION: stable dry heel eschar -- do NOT remove',
      'Heel eschar acts as natural biological cover',
    ],
    color: Color(0xFF6B7280),
  ),
  _PIStage(
    name: 'DTPI',
    shortName: 'DTPI',
    description:
        'Deep Tissue Pressure Injury: intact or non-intact skin with persistent deep red, maroon, or purple discoloration.',
    keyFeatures: [
      'Persistent non-blanchable PURPLE/MAROON discoloration',
      'Or blood-filled blister over intact or non-intact skin',
      'Damage originates at BONE-MUSCLE interface (deep to superficial)',
      'May evolve rapidly to reveal extent of injury',
      'Tissue may feel painful, firm, mushy, boggy, or temperature-different',
    ],
    color: Color(0xFF4F46E5),
  ),
  _PIStage(
    name: 'MMPI',
    shortName: 'MMPI',
    description:
        'Mucosal Membrane Pressure Injury — a SEPARATE NPIAP category that CANNOT be staged with the skin staging system.',
    keyFeatures: [
      'Located on mucous membranes (nasal, oral, urethral, etc.)',
      'Almost always caused by medical devices (NG tubes, catheters, ETT)',
      'CANNOT be assigned Stage 1-4 or Unstageable',
      'Mucosal anatomy lacks the skin layers required for NPIAP staging',
      'Document as "Mucosal Membrane Pressure Injury" — do NOT stage',
    ],
    color: Color(0xFFEC4899),
  ),
];

const List<_BodyLocation> _bodyLocations = [
  _BodyLocation(
    name: 'Sacrum',
    position: 'Supine',
    relativeX: 0.50,
    relativeY: 0.58,
    note: 'Most common PI location in supine. 2nd most common overall.',
  ),
  _BodyLocation(
    name: 'Heels',
    position: 'Supine',
    relativeX: 0.50,
    relativeY: 0.92,
    note:
        'Second most common supine location. Heel eschar exception: stable dry eschar should NOT be debrided.',
  ),
  _BodyLocation(
    name: 'Occiput',
    position: 'Supine',
    relativeX: 0.50,
    relativeY: 0.05,
    note: 'Common in ICU patients and children. Often overlooked.',
  ),
  _BodyLocation(
    name: 'Scapulae',
    position: 'Supine',
    relativeX: 0.50,
    relativeY: 0.28,
    note: 'Risk increases with poor nutrition and prolonged bed rest.',
  ),
  _BodyLocation(
    name: 'Ischial Tuberosities',
    position: 'Sitting',
    relativeX: 0.50,
    relativeY: 0.55,
    note:
        '#1 MOST COMMON PI location overall in SCI. Key risk area for wheelchair users.',
  ),
  _BodyLocation(
    name: 'Greater Trochanters',
    position: 'Lateral',
    relativeX: 0.50,
    relativeY: 0.50,
    note:
        'Most common PI location in side-lying. Risk with prolonged lateral positioning.',
  ),
];

const List<_StagingScenario> _scenarios = [
  _StagingScenario(
    id: 1,
    description:
        'A wheelchair-bound T10 paraplegic presents with a warm, reddened area over the sacrum that does not blanch when you press on it with your fingertip. The skin is intact with no open wound.',
    correctStage: 'I',
    explanation:
        'Intact skin with non-blanchable erythema = Stage 1. The key is that skin is INTACT and erythema does NOT blanch. Reactive hyperemia (normal response) would blanch with pressure.',
  ),
  _StagingScenario(
    id: 2,
    description:
        'A C6 tetraplegic has a shallow open ulcer over the left ischial tuberosity with a glistening pink-red wound bed. There is no slough or necrotic tissue visible. The wound extends through the epidermis and superficial dermis.',
    correctStage: 'II',
    explanation:
        'Partial-thickness loss with a pink-red wound bed and no slough = Stage 2. The shallow ulcer involves epidermis and dermis only.',
  ),
  _StagingScenario(
    id: 3,
    description:
        'A patient has a serum-filled intact blister over the heel that developed after 3 days in the ICU. No other skin changes are noted.',
    correctStage: 'II',
    explanation:
        'An intact serum-filled blister is classified as Stage 2. This represents partial-thickness skin injury.',
  ),
  _StagingScenario(
    id: 4,
    description:
        'A sacral wound shows full-thickness skin loss. Subcutaneous fat is visible in the wound bed. You probe the wound and cannot feel bone, tendon, or muscle. There is mild yellow slough at the wound edges.',
    correctStage: 'III',
    explanation:
        'Full-thickness loss into subcutaneous fat WITHOUT exposed bone/tendon/muscle = Stage 3. Slough may be present as long as it does not obscure the wound depth.',
  ),
  _StagingScenario(
    id: 5,
    description:
        'A large trochanteric wound reveals exposed femoral bone at the base. There is extensive undermining and tunneling. Moderate slough covers about 30% of the wound bed.',
    correctStage: 'IV',
    explanation:
        'Full-thickness loss with EXPOSED BONE = Stage 4. The presence of visible or palpable bone, tendon, or muscle defines Stage 4 regardless of other wound characteristics.',
  ),
  _StagingScenario(
    id: 6,
    description:
        'An ischial pressure injury is completely covered by thick, adherent black eschar. You cannot visualize the wound base or determine the depth of tissue involvement.',
    correctStage: 'U',
    explanation:
        'When slough or eschar obscures the wound bed such that depth CANNOT be determined, the injury is Unstageable. It will be Stage 3 or 4 once debrided.',
  ),
  _StagingScenario(
    id: 7,
    description:
        'A patient has stable, dry, adherent black eschar on the heel without erythema, fluctuance, drainage, or tenderness. The eschar is firmly attached.',
    correctStage: 'U',
    explanation:
        'This is the heel eschar EXCEPTION. Stable dry heel eschar serves as a natural biological cover and should NOT be removed. It is classified as Unstageable but does not require debridement.',
  ),
  _StagingScenario(
    id: 8,
    description:
        'Over the sacrum, you observe a localized area of persistent deep purple/maroon discoloration on intact skin. The area is painful, boggy, and cooler than surrounding tissue. No open wound is present.',
    correctStage: 'DTPI',
    explanation:
        'Persistent non-blanchable purple/maroon discoloration with intact skin, especially with tissue that is painful, boggy, and temperature-different = DTPI. Damage originates at the bone-muscle interface.',
  ),
  _StagingScenario(
    id: 9,
    description:
        'A wound that was previously classified as Stage 3 has healed significantly with granulation tissue and wound contraction. The wound now appears shallow with new epithelium forming at the edges. Should you reclassify as Stage 2?',
    correctStage: 'III',
    explanation:
        'NO reverse staging. A Stage 3 wound that is healing remains Stage 3. Document as "Stage 3, healing" or "healing Stage 3 pressure injury." The wound fills with granulation tissue, not the original tissue layers.',
  ),
  _StagingScenario(
    id: 10,
    description:
        'A patient with an NG tube develops a localized area of tissue damage on the nasal mucosa where the tube makes contact. The area shows erosion and erythema.',
    correctStage: 'MMPI',
    explanation:
        'This is a Mucosal Membrane Pressure Injury (MMPI) — a SEPARATE NPIAP category that CANNOT be staged with the skin staging system (Stages 1-4 or Unstageable). Mucosal anatomy lacks the skin layers required for NPIAP staging. Document simply as "mucosal membrane pressure injury" — do NOT assign a numerical stage.',
  ),
];

// ---------------------------------------------------------------------------
// Braden Scale
// ---------------------------------------------------------------------------

class _BradenSubscale {
  const _BradenSubscale({
    required this.name,
    required this.descriptions,
  });

  final String name;
  final Map<int, String> descriptions; // score -> description
}

const List<_BradenSubscale> _bradenSubscales = [
  _BradenSubscale(
    name: 'Sensory Perception',
    descriptions: {
      1: 'Completely Limited',
      2: 'Very Limited',
      3: 'Slightly Limited',
      4: 'No Impairment',
    },
  ),
  _BradenSubscale(
    name: 'Moisture',
    descriptions: {
      1: 'Constantly Moist',
      2: 'Very Moist',
      3: 'Occasionally Moist',
      4: 'Rarely Moist',
    },
  ),
  _BradenSubscale(
    name: 'Activity',
    descriptions: {
      1: 'Bedfast',
      2: 'Chairfast',
      3: 'Walks Occasionally',
      4: 'Walks Frequently',
    },
  ),
  _BradenSubscale(
    name: 'Mobility',
    descriptions: {
      1: 'Completely Immobile',
      2: 'Very Limited',
      3: 'Slightly Limited',
      4: 'No Limitations',
    },
  ),
  _BradenSubscale(
    name: 'Nutrition',
    descriptions: {
      1: 'Very Poor',
      2: 'Probably Inadequate',
      3: 'Adequate',
      4: 'Excellent',
    },
  ),
  _BradenSubscale(
    name: 'Friction & Shear',
    descriptions: {
      1: 'Problem',
      2: 'Potential Problem',
      3: 'No Apparent Problem',
    },
  ),
];

// ---------------------------------------------------------------------------
// Widget
// ---------------------------------------------------------------------------

class PressureInjuryStagingWidget extends StatefulWidget {
  const PressureInjuryStagingWidget({super.key});

  @override
  State<PressureInjuryStagingWidget> createState() =>
      _PressureInjuryStagingWidgetState();
}

class _PressureInjuryStagingWidgetState
    extends State<PressureInjuryStagingWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Staging quiz state
  int _currentScenario = 0;
  String? _selectedAnswer;
  bool _answered = false;

  // Body map state
  String _selectedPosition = 'Supine';
  int? _highlightedLocation;

  // Braden Scale state
  final Map<int, int> _bradenScores = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Tab bar
        Container(
          decoration: BoxDecoration(
            color: AppTheme.cardBackground,
            border:
                Border(bottom: BorderSide(color: AppTheme.borderSubtle, width: 1)),
          ),
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            labelStyle: AppTheme.displayFont(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: AppTheme.displayFont(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            labelColor: AppTheme.primaryNavy,
            unselectedLabelColor: AppTheme.textSecondary,
            indicatorColor: AppTheme.primaryNavy,
            indicatorSize: TabBarIndicatorSize.label,
            dividerColor: Colors.transparent,
            tabs: const [
              Tab(text: 'STAGING'),
              Tab(text: 'QUIZ'),
              Tab(text: 'BODY MAP'),
              Tab(text: 'BRADEN'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              ResponsiveBody(maxWidth: ResponsiveBreakpoints.maxToolWidth, child: _buildStagingReference()),
              ResponsiveBody(maxWidth: ResponsiveBreakpoints.maxToolWidth, child: _buildQuizTab()),
              ResponsiveBody(maxWidth: ResponsiveBreakpoints.maxToolWidth, child: _buildBodyMapTab()),
              ResponsiveBody(maxWidth: ResponsiveBreakpoints.maxToolWidth, child: _buildBradenTab()),
            ],
          ),
        ),
      ],
    );
  }

  // -----------------------------------------------------------------------
  // Staging reference
  // -----------------------------------------------------------------------

  Widget _buildStagingReference() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'NPIAP Pressure Injury Staging',
            style: AppTheme.displayFont(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppTheme.primaryNavy,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Stage by the deepest tissue layer visualized or palpated.',
            style: AppTheme.bodyFont(
              fontSize: 13,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 12),

          // Key rules
          _buildRulesCard(),
          const SizedBox(height: 16),

          // Stage cards
          ..._stages.map(_buildStageCard),
        ],
      ),
    );
  }

  Widget _buildRulesCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.pearlBackground,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppTheme.pearlBorder, width: 1),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'KEY RULES',
            style: AppTheme.displayFont(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppTheme.pearlBorder,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 8),
          _buildRuleRow('No reverse staging -- a healing Stage 3 remains Stage 3'),
          _buildRuleRow(
              'Heel eschar exception -- stable dry heel eschar should NOT be removed'),
          _buildRuleRow(
              'Mucosal membrane PI cannot be staged (staging is for skin only)'),
        ],
      ),
    );
  }

  Widget _buildRuleRow(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, size: 14, color: AppTheme.pearlBorder),
          const SizedBox(width: 6),
          Expanded(
            child: Text(text, style: AppTheme.bodyFont(fontSize: 13)),
          ),
        ],
      ),
    );
  }

  Widget _buildStageCard(_PIStage stage) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: stage.color, width: 3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stage.name,
                  style: AppTheme.displayFont(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: stage.color,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  stage.description,
                  style: AppTheme.bodyFont(fontSize: 13),
                ),
              ],
            ),
          ),
          // Features
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 10),
            child: Column(
              children: stage.keyFeatures
                  .map((f) => Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 6),
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                color: stage.color,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(f,
                                  style: AppTheme.bodyFont(fontSize: 12)),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  // -----------------------------------------------------------------------
  // Quiz tab
  // -----------------------------------------------------------------------

  Widget _buildQuizTab() {
    final scenario = _scenarios[_currentScenario];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress
          Row(
            children: [
              Text(
                'Scenario ${_currentScenario + 1} of ${_scenarios.length}',
                style: AppTheme.displayFont(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                'Staging Practice',
                style: AppTheme.displayFont(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
              value: (_currentScenario + 1) / _scenarios.length,
              backgroundColor: AppTheme.surfaceMuted,
              valueColor:
                  AlwaysStoppedAnimation<Color>(AppTheme.accentTeal),
              minHeight: 4,
            ),
          ),
          const SizedBox(height: 16),

          // Scenario description
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.cardBackground,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppTheme.borderSubtle, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CLINICAL SCENARIO',
                  style: AppTheme.displayFont(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.accentTeal,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  scenario.description,
                  style: AppTheme.bodyFont(fontSize: 14, height: 1.5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Answer choices
          Text(
            'Select the correct stage:',
            style: AppTheme.displayFont(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _stages.map((stage) {
              final isSelected = _selectedAnswer == stage.shortName;
              final isCorrect = stage.shortName == scenario.correctStage;
              Color bgColor = AppTheme.cardBackground;
              Color borderColor = AppTheme.borderSubtle;

              if (_answered) {
                if (isCorrect) {
                  bgColor = AppTheme.successGreen.withOpacity(0.1);
                  borderColor = AppTheme.successGreen;
                } else if (isSelected && !isCorrect) {
                  bgColor = AppTheme.avoidBackground;
                  borderColor = AppTheme.dangerRed;
                }
              } else if (isSelected) {
                bgColor = stage.color.withOpacity(0.1);
                borderColor = stage.color;
              }

              return GestureDetector(
                onTap: _answered
                    ? null
                    : () => setState(() => _selectedAnswer = stage.shortName),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: borderColor, width: 1),
                  ),
                  child: Text(
                    stage.name,
                    style: AppTheme.displayFont(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: _answered && isCorrect
                          ? AppTheme.successGreen
                          : (_answered && isSelected && !isCorrect
                              ? AppTheme.dangerRed
                              : (isSelected
                                  ? stage.color
                                  : AppTheme.textPrimary)),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),

          // Submit / Next buttons
          if (!_answered && _selectedAnswer != null)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => setState(() => _answered = true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accentTeal,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text('Check Answer',
                    style: AppTheme.displayFont(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
              ),
            ),

          // Feedback
          if (_answered) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _selectedAnswer == scenario.correctStage
                    ? AppTheme.successGreen.withOpacity(0.08)
                    : AppTheme.avoidBackground,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: _selectedAnswer == scenario.correctStage
                      ? AppTheme.successGreen
                      : AppTheme.dangerRed,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        _selectedAnswer == scenario.correctStage
                            ? Icons.check_circle
                            : Icons.cancel,
                        size: 18,
                        color: _selectedAnswer == scenario.correctStage
                            ? AppTheme.successGreen
                            : AppTheme.dangerRed,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _selectedAnswer == scenario.correctStage
                            ? 'Correct!'
                            : 'Incorrect -- Correct answer: ${scenario.correctStage}',
                        style: AppTheme.displayFont(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _selectedAnswer == scenario.correctStage
                              ? AppTheme.successGreen
                              : AppTheme.dangerRed,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    scenario.explanation,
                    style: AppTheme.bodyFont(fontSize: 13, height: 1.4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            if (_currentScenario < _scenarios.length - 1)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => setState(() {
                    _currentScenario++;
                    _selectedAnswer = null;
                    _answered = false;
                  }),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryNavy,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text('Next Scenario',
                      style: AppTheme.displayFont(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                ),
              )
            else
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => setState(() {
                    _currentScenario = 0;
                    _selectedAnswer = null;
                    _answered = false;
                  }),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.accentTeal,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text('Restart Quiz',
                      style: AppTheme.displayFont(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                ),
              ),
          ],
        ],
      ),
    );
  }

  // -----------------------------------------------------------------------
  // Body map tab
  // -----------------------------------------------------------------------

  Widget _buildBodyMapTab() {
    final positions = ['Supine', 'Sitting', 'Lateral'];
    final filteredLocations =
        _bodyLocations.where((l) => l.position == _selectedPosition).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Common Pressure Injury Locations',
            style: AppTheme.displayFont(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppTheme.primaryNavy,
            ),
          ),
          const SizedBox(height: 12),

          // Position selector
          Row(
            children: positions
                .map((p) => Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() {
                          _selectedPosition = p;
                          _highlightedLocation = null;
                        }),
                        child: Container(
                          margin: EdgeInsets.only(
                              right: p != positions.last ? 8 : 0),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: _selectedPosition == p
                                ? AppTheme.primaryNavy
                                : AppTheme.cardBackground,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: _selectedPosition == p
                                  ? AppTheme.primaryNavy
                                  : AppTheme.borderSubtle,
                              width: 1,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            p,
                            style: AppTheme.displayFont(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: _selectedPosition == p
                                  ? Colors.white
                                  : AppTheme.textPrimary,
                            ),
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 16),

          // Schematic body map
          Container(
            height: 360,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppTheme.surfaceMuted,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppTheme.borderSubtle, width: 1),
            ),
            child: Stack(
              children: [
                // Body silhouette label
                Positioned(
                  top: 12,
                  left: 12,
                  child: Text(
                    '$_selectedPosition Position',
                    style: AppTheme.displayFont(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ),
                // Body outline (simplified)
                Center(
                  child: CustomPaint(
                    size: const Size(140, 320),
                    painter: _BodyOutlinePainter(position: _selectedPosition),
                  ),
                ),
                // Location markers
                ...filteredLocations.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final loc = entry.value;
                  final isHighlighted = _highlightedLocation == idx;
                  return Positioned(
                    left: (loc.relativeX *
                            MediaQuery.of(context).size.width *
                            0.7) -
                        12,
                    top: loc.relativeY * 340,
                    child: GestureDetector(
                      onTap: () => setState(() => _highlightedLocation =
                          isHighlighted ? null : idx),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: isHighlighted
                              ? AppTheme.dangerRed
                              : AppTheme.dangerRed.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: isHighlighted
                              ? [
                                  BoxShadow(
                                    color:
                                        AppTheme.dangerRed.withOpacity(0.3),
                                    blurRadius: 6,
                                    spreadRadius: 1,
                                  ),
                                ]
                              : null,
                        ),
                        child: Text(
                          loc.name,
                          style: AppTheme.displayFont(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Location details
          ...filteredLocations.asMap().entries.map((entry) {
            final idx = entry.key;
            final loc = entry.value;
            final isHighlighted = _highlightedLocation == idx;
            return GestureDetector(
              onTap: () => setState(
                  () => _highlightedLocation = isHighlighted ? null : idx),
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isHighlighted
                      ? AppTheme.dangerRed.withOpacity(0.05)
                      : AppTheme.cardBackground,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: isHighlighted
                        ? AppTheme.dangerRed
                        : AppTheme.borderSubtle,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppTheme.dangerRed,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            loc.name,
                            style: AppTheme.displayFont(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            loc.note,
                            style: AppTheme.bodyFont(
                              fontSize: 12,
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
          }),
        ],
      ),
    );
  }

  // -----------------------------------------------------------------------
  // Braden Scale tab
  // -----------------------------------------------------------------------

  Widget _buildBradenTab() {
    int total = 0;
    bool allFilled = true;
    for (int i = 0; i < _bradenSubscales.length; i++) {
      if (_bradenScores.containsKey(i)) {
        total += _bradenScores[i]!;
      } else {
        allFilled = false;
      }
    }

    String riskCategory = '';
    Color riskColor = AppTheme.textSecondary;
    if (allFilled) {
      if (total <= 9) {
        riskCategory = 'Very High Risk';
        riskColor = AppTheme.dangerRed;
      } else if (total <= 12) {
        riskCategory = 'High Risk';
        riskColor = const Color(0xFFDC2626);
      } else if (total <= 14) {
        riskCategory = 'Moderate Risk';
        riskColor = AppTheme.warningAmber;
      } else if (total <= 18) {
        riskCategory = 'Mild Risk';
        riskColor = const Color(0xFFEA580C);
      } else {
        riskCategory = 'Low Risk';
        riskColor = AppTheme.successGreen;
      }
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Braden Scale for PI Risk',
            style: AppTheme.displayFont(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppTheme.primaryNavy,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Select a score for each subscale. Lower scores = higher risk.',
            style: AppTheme.bodyFont(
              fontSize: 13,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 16),

          // Subscale selectors
          ..._bradenSubscales.asMap().entries.map((entry) {
            final idx = entry.key;
            final subscale = entry.value;
            final selectedScore = _bradenScores[idx];

            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: AppTheme.cardBackground,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppTheme.borderSubtle, width: 1),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subscale.name,
                    style: AppTheme.displayFont(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: subscale.descriptions.entries.map((descEntry) {
                      final score = descEntry.key;
                      final desc = descEntry.value;
                      final isSelected = selectedScore == score;
                      return GestureDetector(
                        onTap: () => setState(() => _bradenScores[idx] = score),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppTheme.accentTeal.withOpacity(0.1)
                                : AppTheme.surfaceMuted,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: isSelected
                                  ? AppTheme.accentTeal
                                  : AppTheme.borderSubtle,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                '$score',
                                style: AppTheme.monoFont(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: isSelected
                                      ? AppTheme.accentTeal
                                      : AppTheme.textPrimary,
                                ),
                              ),
                              Text(
                                desc,
                                style: AppTheme.displayFont(
                                  fontSize: 10,
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: 16),

          // Total score
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: allFilled
                  ? riskColor.withOpacity(0.08)
                  : AppTheme.surfaceMuted,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: allFilled ? riskColor : AppTheme.borderSubtle,
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Text(
                  allFilled ? 'Total: $total / 23' : 'Complete all subscales',
                  style: AppTheme.monoFont(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: allFilled ? riskColor : AppTheme.textSecondary,
                  ),
                ),
                if (allFilled) ...[
                  const SizedBox(height: 4),
                  Text(
                    riskCategory,
                    style: AppTheme.displayFont(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: riskColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _bradenInterpretation(total),
                    style: AppTheme.bodyFont(
                      fontSize: 12,
                      color: AppTheme.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Reset
          if (_bradenScores.isNotEmpty)
            Center(
              child: TextButton(
                onPressed: () => setState(() => _bradenScores.clear()),
                child: Text(
                  'Reset Braden Scale',
                  style: AppTheme.displayFont(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _bradenInterpretation(int score) {
    if (score <= 9) {
      return 'Very high risk. Consider Group 2 or 3 support surface. Reposition every 2 hours. Nutritional optimization.';
    } else if (score <= 12) {
      return 'High risk. Group 2 support surface recommended. Strict repositioning schedule. Skin inspection each shift.';
    } else if (score <= 14) {
      return 'Moderate risk. Group 1 support surface. Repositioning every 2 hours. Address modifiable risk factors.';
    } else if (score <= 18) {
      return 'Mild risk. Standard mattress may suffice. Regular repositioning. Monitor for skin changes.';
    } else {
      return 'Low risk. Standard prevention measures. Regular skin assessment.';
    }
  }
}

// ---------------------------------------------------------------------------
// Body outline painter (simplified schematic)
// ---------------------------------------------------------------------------

class _BodyOutlinePainter extends CustomPainter {
  _BodyOutlinePainter({required this.position});

  final String position;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.borderSubtle
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final fillPaint = Paint()
      ..color = AppTheme.surfaceLight
      ..style = PaintingStyle.fill;

    final cx = size.width / 2;

    if (position == 'Supine') {
      // Head
      canvas.drawOval(
          Rect.fromCenter(
              center: Offset(cx, 20), width: 30, height: 35),
          fillPaint);
      canvas.drawOval(
          Rect.fromCenter(
              center: Offset(cx, 20), width: 30, height: 35),
          paint);
      // Torso
      canvas.drawRRect(
          RRect.fromRectAndRadius(
              Rect.fromLTWH(cx - 30, 40, 60, 120),
              const Radius.circular(8)),
          fillPaint);
      canvas.drawRRect(
          RRect.fromRectAndRadius(
              Rect.fromLTWH(cx - 30, 40, 60, 120),
              const Radius.circular(8)),
          paint);
      // Left arm
      canvas.drawRRect(
          RRect.fromRectAndRadius(
              Rect.fromLTWH(cx - 48, 50, 14, 80),
              const Radius.circular(6)),
          fillPaint);
      canvas.drawRRect(
          RRect.fromRectAndRadius(
              Rect.fromLTWH(cx - 48, 50, 14, 80),
              const Radius.circular(6)),
          paint);
      // Right arm
      canvas.drawRRect(
          RRect.fromRectAndRadius(
              Rect.fromLTWH(cx + 34, 50, 14, 80),
              const Radius.circular(6)),
          fillPaint);
      canvas.drawRRect(
          RRect.fromRectAndRadius(
              Rect.fromLTWH(cx + 34, 50, 14, 80),
              const Radius.circular(6)),
          paint);
      // Left leg
      canvas.drawRRect(
          RRect.fromRectAndRadius(
              Rect.fromLTWH(cx - 25, 165, 20, 130),
              const Radius.circular(6)),
          fillPaint);
      canvas.drawRRect(
          RRect.fromRectAndRadius(
              Rect.fromLTWH(cx - 25, 165, 20, 130),
              const Radius.circular(6)),
          paint);
      // Right leg
      canvas.drawRRect(
          RRect.fromRectAndRadius(
              Rect.fromLTWH(cx + 5, 165, 20, 130),
              const Radius.circular(6)),
          fillPaint);
      canvas.drawRRect(
          RRect.fromRectAndRadius(
              Rect.fromLTWH(cx + 5, 165, 20, 130),
              const Radius.circular(6)),
          paint);
    } else if (position == 'Sitting') {
      // Head
      canvas.drawOval(
          Rect.fromCenter(
              center: Offset(cx, 25), width: 30, height: 35),
          fillPaint);
      canvas.drawOval(
          Rect.fromCenter(
              center: Offset(cx, 25), width: 30, height: 35),
          paint);
      // Torso (upright)
      canvas.drawRRect(
          RRect.fromRectAndRadius(
              Rect.fromLTWH(cx - 30, 45, 60, 110),
              const Radius.circular(8)),
          fillPaint);
      canvas.drawRRect(
          RRect.fromRectAndRadius(
              Rect.fromLTWH(cx - 30, 45, 60, 110),
              const Radius.circular(8)),
          paint);
      // Thighs (horizontal)
      canvas.drawRRect(
          RRect.fromRectAndRadius(
              Rect.fromLTWH(cx - 30, 155, 60, 25),
              const Radius.circular(6)),
          fillPaint);
      canvas.drawRRect(
          RRect.fromRectAndRadius(
              Rect.fromLTWH(cx - 30, 155, 60, 25),
              const Radius.circular(6)),
          paint);
      // Lower legs (vertical)
      canvas.drawRRect(
          RRect.fromRectAndRadius(
              Rect.fromLTWH(cx - 25, 180, 20, 80),
              const Radius.circular(6)),
          fillPaint);
      canvas.drawRRect(
          RRect.fromRectAndRadius(
              Rect.fromLTWH(cx - 25, 180, 20, 80),
              const Radius.circular(6)),
          paint);
      canvas.drawRRect(
          RRect.fromRectAndRadius(
              Rect.fromLTWH(cx + 5, 180, 20, 80),
              const Radius.circular(6)),
          fillPaint);
      canvas.drawRRect(
          RRect.fromRectAndRadius(
              Rect.fromLTWH(cx + 5, 180, 20, 80),
              const Radius.circular(6)),
          paint);
    } else {
      // Lateral - side view
      // Head
      canvas.drawOval(
          Rect.fromCenter(
              center: Offset(cx, 25), width: 28, height: 35),
          fillPaint);
      canvas.drawOval(
          Rect.fromCenter(
              center: Offset(cx, 25), width: 28, height: 35),
          paint);
      // Torso (side view, narrower)
      canvas.drawRRect(
          RRect.fromRectAndRadius(
              Rect.fromLTWH(cx - 18, 45, 36, 110),
              const Radius.circular(8)),
          fillPaint);
      canvas.drawRRect(
          RRect.fromRectAndRadius(
              Rect.fromLTWH(cx - 18, 45, 36, 110),
              const Radius.circular(8)),
          paint);
      // Legs (side, stacked)
      canvas.drawRRect(
          RRect.fromRectAndRadius(
              Rect.fromLTWH(cx - 15, 160, 16, 130),
              const Radius.circular(6)),
          fillPaint);
      canvas.drawRRect(
          RRect.fromRectAndRadius(
              Rect.fromLTWH(cx - 15, 160, 16, 130),
              const Radius.circular(6)),
          paint);
      canvas.drawRRect(
          RRect.fromRectAndRadius(
              Rect.fromLTWH(cx + 1, 160, 16, 130),
              const Radius.circular(6)),
          fillPaint);
      canvas.drawRRect(
          RRect.fromRectAndRadius(
              Rect.fromLTWH(cx + 1, 160, 16, 130),
              const Radius.circular(6)),
          paint);
    }
  }

  @override
  bool shouldRepaint(covariant _BodyOutlinePainter oldDelegate) =>
      oldDelegate.position != position;
}
