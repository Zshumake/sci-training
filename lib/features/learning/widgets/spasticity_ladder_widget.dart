import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/responsive_layout.dart';

// ---------------------------------------------------------------------------
// Data models
// ---------------------------------------------------------------------------

class _MedicationInfo {
  const _MedicationInfo({
    required this.name,
    required this.maxDose,
    required this.mechanism,
    required this.sideEffects,
    this.warning,
  });

  final String name;
  final String maxDose;
  final String mechanism;
  final String sideEffects;
  final String? warning;
}

class _LadderStep {
  const _LadderStep({
    required this.number,
    required this.title,
    required this.subtitle,
    required this.details,
    required this.color,
    this.medications,
    this.decisionPoint,
  });

  final int number;
  final String title;
  final String subtitle;
  final List<String> details;
  final Color color;
  final List<_MedicationInfo>? medications;
  final String? decisionPoint;
}

// ---------------------------------------------------------------------------
// Static data
// ---------------------------------------------------------------------------

const List<_MedicationInfo> _oralMedications = [
  _MedicationInfo(
    name: 'Baclofen',
    maxDose: '80 mg/day (20 mg QID)',
    mechanism: 'GABA-B agonist; inhibits spinal reflex arc at presynaptic level',
    sideEffects: 'Sedation, weakness, dizziness, withdrawal seizures if stopped abruptly',
    warning: 'NEVER stop abruptly -- can cause life-threatening withdrawal (seizures, hyperthermia, rhabdomyolysis)',
  ),
  _MedicationInfo(
    name: 'Tizanidine',
    maxDose: '36 mg/day (12 mg TID)',
    mechanism: 'Central alpha-2 adrenergic agonist; reduces excitatory neurotransmitter release',
    sideEffects: 'Sedation, dry mouth, hypotension, dizziness',
    warning: 'CYP1A2 substrate -- avoid with fluvoxamine, ciprofloxacin. Monitor LFTs (hepatotoxicity risk)',
  ),
  _MedicationInfo(
    name: 'Dantrolene',
    maxDose: '400 mg/day (100 mg QID)',
    mechanism: 'Acts PERIPHERALLY at muscle (blocks ryanodine receptor, reduces Ca2+ release from SR)',
    sideEffects: 'Weakness (direct muscle relaxant), diarrhea, hepatotoxicity',
    warning: 'Monitor LFTs every 3-6 months. Only medication that acts peripherally (not centrally)',
  ),
  _MedicationInfo(
    name: 'Diazepam',
    maxDose: '40 mg/day',
    mechanism: 'GABA-A agonist (benzodiazepine); enhances presynaptic inhibition in spinal cord',
    sideEffects: 'Sedation, dependence, cognitive impairment, respiratory depression',
  ),
  _MedicationInfo(
    name: 'Gabapentin',
    maxDose: '3600 mg/day',
    mechanism: 'Binds alpha-2-delta subunit of voltage-gated Ca2+ channels; may reduce excitatory neurotransmitter release',
    sideEffects: 'Sedation, dizziness, peripheral edema, weight gain',
  ),
  _MedicationInfo(
    name: 'Clonidine',
    maxDose: '0.4 mg/day',
    mechanism: 'Central alpha-2 agonist (similar mechanism to tizanidine)',
    sideEffects: 'Hypotension, sedation, dry mouth, rebound hypertension',
  ),
];

const List<_LadderStep> _ladderSteps = [
  _LadderStep(
    number: 1,
    title: 'Remove Noxious Stimuli',
    subtitle: 'Always the first step',
    color: Color(0xFF2A7A5F),
    details: [
      'Identify and treat underlying noxious stimuli BEFORE adding medications',
      'UTI (most common cause of acute spasticity increase)',
      'Pressure injury or skin breakdown',
      'Constipation / fecal impaction / bowel distension',
      'Ingrown toenail, ill-fitting shoes or orthotics',
      'DVT or heterotopic ossification',
      'Fracture (often occult in insensate limbs)',
      'Syrinx (post-traumatic syringomyelia)',
      'Bladder distension, stones, catheter issues',
    ],
  ),
  _LadderStep(
    number: 2,
    title: 'Stretching & Positioning',
    subtitle: 'Non-pharmacologic foundation',
    color: Color(0xFF0C7C73),
    details: [
      'Daily stretching program (30-second sustained stretches)',
      'Proper seating and wheelchair positioning',
      'Standing frame program (30-60 min/day)',
      'Serial casting for contracture management',
      'Splinting and orthoses for positioning',
      'Cryotherapy or heat modalities',
      'Functional electrical stimulation (FES)',
      'Hydrotherapy -- warm water relaxation',
    ],
  ),
  _LadderStep(
    number: 3,
    title: 'Oral Medications',
    subtitle: 'Systemic pharmacotherapy',
    color: Color(0xFF3566A0),
    details: [
      'Start low, titrate slowly to effect vs side effects',
      'May combine agents with different mechanisms',
      'Baclofen is the first-line agent for SCI spasticity',
      'Tizanidine is the second most commonly used',
      'Dantrolene is unique -- only peripheral-acting agent',
      'Balance tone reduction vs functional loss',
    ],
  ),
  _LadderStep(
    number: 4,
    title: 'Focal vs Diffuse?',
    subtitle: 'Critical decision point',
    color: Color(0xFF6B4FA0),
    details: [
      'This is the key branch point in the algorithm',
      'FOCAL spasticity: limited to 1-2 muscle groups (e.g., hip adductors, ankle plantarflexors)',
      'DIFFUSE spasticity: widespread, affecting multiple muscle groups bilaterally',
      'Focal --> proceed to chemodenervation (Step 5a)',
      'Diffuse --> consider intrathecal baclofen (Step 5b)',
      'Some patients have both focal and diffuse components',
    ],
    decisionPoint: 'Is the problematic spasticity FOCAL (1-2 muscle groups) or DIFFUSE (widespread, bilateral)?',
  ),
  _LadderStep(
    number: 5,
    title: 'Chemodenervation / ITB',
    subtitle: 'Targeted or intrathecal therapy',
    color: Color(0xFFD4880F),
    details: [
      'FOCAL --> Botulinum toxin (Botox/Dysport) or Phenol/Alcohol nerve blocks',
      '  Botox: 400 U max/session, onset 3-5 days, peak 2-6 weeks, duration 3-6 months',
      '  Phenol: 5-7% concentration, immediate onset, lasts 3-12 months, cheaper than Botox',
      '  Phenol for motor nerves (obturator nerve for hip adductors is classic target)',
      'DIFFUSE --> Intrathecal Baclofen (ITB) pump',
      '  Trial dose (50-100 mcg intrathecal) before permanent pump placement',
      '  Positive trial: Ashworth score decrease >=1 point within 4-8 hours',
      '  Programmable pump implanted in abdomen, catheter into intrathecal space',
      '  Refill every 1-6 months; battery lasts 5-7 years',
    ],
  ),
  _LadderStep(
    number: 6,
    title: 'Surgery',
    subtitle: 'Last resort interventions',
    color: Color(0xFFA63D3D),
    details: [
      'Reserved for refractory spasticity after exhausting conservative measures',
      'Tendon lengthening (e.g., Achilles tendon for equinovarus)',
      'Tendon transfer (redirect function)',
      'Tenotomy (tendon release)',
      'Selective dorsal rhizotomy (section dorsal rootlets to reduce afferent input)',
      'Myelotomy (rarely performed)',
      'Neurectomy (peripheral nerve section)',
      'Orthopedic procedures for fixed contractures',
    ],
  ),
];

const List<String> _redFlagCauses = [
  'UTI (most common)',
  'Pressure injury',
  'DVT',
  'Fracture (occult)',
  'Syrinx',
  'Constipation / fecal impaction',
  'Ingrown toenail',
  'Bladder stone / catheter issue',
  'Heterotopic ossification',
  'Medication change',
];

const List<String> _beneficialUses = [
  'Standing transfers (extensor tone assists weight-bearing)',
  'DVT prevention (muscle pump effect from spasms)',
  'Maintenance of muscle bulk and bone density',
  'Postural support and trunk stability',
  'Improved venous return and circulation',
  'Tenodesis grasp in C6 tetraplegia (finger flexor tone)',
];

const List<String> _harmfulEffects = [
  'Contracture development',
  'Pain and discomfort',
  'Sleep disruption (nocturnal spasms)',
  'Impaired hygiene and catheterization (adductor spasticity)',
  'Skin breakdown from shearing forces',
  'Impaired wheelchair positioning and seating',
  'Interference with functional activities and ADLs',
  'Falls from sudden spasms during transfers',
];

// ---------------------------------------------------------------------------
// Widget
// ---------------------------------------------------------------------------

class SpasticityLadderWidget extends StatefulWidget {
  const SpasticityLadderWidget({super.key});

  @override
  State<SpasticityLadderWidget> createState() => _SpasticityLadderWidgetState();
}

class _SpasticityLadderWidgetState extends State<SpasticityLadderWidget> {
  int? _expandedStep;
  bool _showRedFlags = false;
  bool _showBeneficial = true; // true = beneficial, false = harmful

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
            'Spasticity Management Ladder',
            style: AppTheme.displayFont(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppTheme.primaryNavy,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Tap each step to expand details. Progress upward only when lower steps are insufficient.',
            style: AppTheme.bodyFont(
              fontSize: 13,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 16),

          // Red flag toggle
          _buildRedFlagSection(),
          const SizedBox(height: 16),

          // Beneficial vs harmful toggle
          _buildBeneficialHarmfulSection(),
          const SizedBox(height: 20),

          // Ladder steps (reversed so step 6 is at top visually)
          ..._ladderSteps.reversed.map(_buildLadderStep),
        ],
      ),
      ),
    );
  }

  // -----------------------------------------------------------------------
  // Red flag sidebar
  // -----------------------------------------------------------------------

  Widget _buildRedFlagSection() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.avoidBackground,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppTheme.avoidBorder, width: 1),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _showRedFlags = !_showRedFlags),
            borderRadius: BorderRadius.circular(6),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  Icon(Icons.warning_amber_rounded,
                      color: AppTheme.dangerRed, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'RED FLAG: Sudden Increase in Spasticity',
                      style: AppTheme.displayFont(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.dangerRed,
                      ),
                    ),
                  ),
                  Icon(
                    _showRedFlags
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppTheme.dangerRed,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          if (_showRedFlags)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Always search for an underlying noxious stimulus:',
                    style: AppTheme.bodyFont(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ..._redFlagCauses.map((cause) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 6),
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                color: AppTheme.dangerRed,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                cause,
                                style: AppTheme.bodyFont(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // -----------------------------------------------------------------------
  // Beneficial vs harmful toggle
  // -----------------------------------------------------------------------

  Widget _buildBeneficialHarmfulSection() {
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
          Text(
            'Spasticity: Beneficial vs Harmful',
            style: AppTheme.displayFont(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          // Toggle row
          Container(
            decoration: BoxDecoration(
              color: AppTheme.surfaceMuted,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _showBeneficial = true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: _showBeneficial
                            ? AppTheme.successGreen
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'BENEFICIAL',
                        style: AppTheme.displayFont(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _showBeneficial
                              ? Colors.white
                              : AppTheme.textSecondary,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _showBeneficial = false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: !_showBeneficial
                            ? AppTheme.dangerRed
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'HARMFUL',
                        style: AppTheme.displayFont(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: !_showBeneficial
                              ? Colors.white
                              : AppTheme.textSecondary,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // List
          ...(_showBeneficial ? _beneficialUses : _harmfulEffects)
              .map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          _showBeneficial ? Icons.check_circle : Icons.cancel,
                          size: 15,
                          color: _showBeneficial
                              ? AppTheme.successGreen
                              : AppTheme.dangerRed,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            item,
                            style: AppTheme.bodyFont(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  )),
        ],
      ),
    );
  }

  // -----------------------------------------------------------------------
  // Ladder step card
  // -----------------------------------------------------------------------

  Widget _buildLadderStep(_LadderStep step) {
    final isExpanded = _expandedStep == step.number;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isExpanded ? step.color : AppTheme.borderSubtle,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            // Header
            InkWell(
              onTap: () => setState(
                  () => _expandedStep = isExpanded ? null : step.number),
              borderRadius: BorderRadius.circular(6),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    // Step number badge
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: step.color,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${step.number}',
                        style: AppTheme.monoFont(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            step.title,
                            style: AppTheme.displayFont(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            step.subtitle,
                            style: AppTheme.bodyFont(
                              fontSize: 12,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: AppTheme.textSecondary,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),

            // Expanded details
            if (isExpanded)
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: AppTheme.borderSubtle, width: 1),
                    left: BorderSide(color: step.color, width: 3),
                  ),
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Decision point callout
                    if (step.decisionPoint != null) ...[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F0FF),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: AppTheme.mnemonicBorder, width: 1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'DECISION POINT',
                              style: AppTheme.displayFont(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.mnemonicBorder,
                                letterSpacing: 1.0,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              step.decisionPoint!,
                              style: AppTheme.bodyFont(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                _buildBranchChip(
                                    'FOCAL', AppTheme.warningAmber),
                                const SizedBox(width: 6),
                                Icon(Icons.arrow_forward,
                                    size: 14,
                                    color: AppTheme.textSecondary),
                                const SizedBox(width: 4),
                                Text('Botox / Phenol',
                                    style: AppTheme.bodyFont(fontSize: 12)),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                _buildBranchChip(
                                    'DIFFUSE', AppTheme.accentTeal),
                                const SizedBox(width: 6),
                                Icon(Icons.arrow_forward,
                                    size: 14,
                                    color: AppTheme.textSecondary),
                                const SizedBox(width: 4),
                                Text('ITB Pump',
                                    style: AppTheme.bodyFont(fontSize: 12)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],

                    // Details list
                    ...step.details.map((detail) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 6),
                                width: 5,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: step.color,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  detail,
                                  style: AppTheme.bodyFont(fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        )),

                    // Medication cards for step 3
                    if (step.medications != null ||
                        step.number == 3) ...[
                      const SizedBox(height: 12),
                      Text(
                        'ORAL MEDICATIONS',
                        style: AppTheme.displayFont(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: step.color,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ..._oralMedications.map(_buildMedicationCard),
                    ],
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBranchChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        label,
        style: AppTheme.displayFont(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: color,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  // -----------------------------------------------------------------------
  // Medication card
  // -----------------------------------------------------------------------

  Widget _buildMedicationCard(_MedicationInfo med) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppTheme.surfaceElevated,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppTheme.borderSubtle, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.surfaceMuted,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(5)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    med.name,
                    style: AppTheme.displayFont(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  'Max: ${med.maxDose}',
                  style: AppTheme.monoFont(
                    fontSize: 11,
                    color: AppTheme.accentTeal,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMedDetailRow('MOA', med.mechanism),
                const SizedBox(height: 4),
                _buildMedDetailRow('Side Effects', med.sideEffects),
                if (med.warning != null) ...[
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppTheme.avoidBackground,
                      borderRadius: BorderRadius.circular(4),
                      border:
                          Border.all(color: AppTheme.avoidBorder, width: 1),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.warning_amber_rounded,
                            size: 14, color: AppTheme.dangerRed),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            med.warning!,
                            style: AppTheme.bodyFont(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.dangerRed,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: AppTheme.displayFont(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppTheme.textSecondary,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: AppTheme.bodyFont(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
