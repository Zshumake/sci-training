import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

/// Interactive decision tree for neurogenic bladder management.
///
/// Guides the learner through UMN vs LMN bladder classification,
/// detrusor-sphincter dyssynergia assessment, and management selection
/// with key clinical facts at each decision node.
class BladderManagementAlgorithm extends StatefulWidget {
  const BladderManagementAlgorithm({super.key});

  @override
  State<BladderManagementAlgorithm> createState() =>
      _BladderManagementAlgorithmState();
}

class _BladderManagementAlgorithmState
    extends State<BladderManagementAlgorithm> {
  // Track the path the user has taken through the decision tree.
  // Each entry is the node ID they selected.
  final List<String> _path = [];
  String _currentNodeId = 'root';
  bool _showSummary = false;

  // All decision-tree nodes keyed by ID.
  static final Map<String, _BladderNode> _nodes = {
    // ── Root ──────────────────────────────────────────
    'root': _BladderNode(
      id: 'root',
      title: 'Neurogenic Bladder Classification',
      question: 'What type of neurogenic bladder does the patient have?',
      detail:
          'The level of SCI determines the bladder pattern. Injuries ABOVE the sacral cord (conus medullaris) produce UMN bladder. Injuries AT or BELOW the conus produce LMN bladder.',
      keyFact: 'UMN bladder = injury above conus (above S2). LMN bladder = injury at/below conus (S2-S4) or cauda equina.',
      options: [
        _NodeOption(
          label: 'UMN (Spastic) Bladder',
          subtitle: 'Injury above S2 — reflex voiding, high pressures',
          targetId: 'umn_dsd',
        ),
        _NodeOption(
          label: 'LMN (Flaccid) Bladder',
          subtitle: 'Injury at/below S2 — areflexic, overflow incontinence',
          targetId: 'lmn_overflow',
        ),
      ],
    ),

    // ── UMN Path ─────────────────────────────────────
    'umn_dsd': _BladderNode(
      id: 'umn_dsd',
      title: 'Detrusor-Sphincter Dyssynergia (DSD)',
      question: 'Is detrusor-sphincter dyssynergia present?',
      detail:
          'In UMN bladder, the pontine micturition center can no longer coordinate detrusor contraction with sphincter relaxation. The detrusor contracts against a closed external sphincter, generating dangerously high intravesical pressures.',
      keyFact: 'DSD is present in most UMN lesions. DLPP (detrusor leak point pressure) >40 cmH2O puts the upper tracts at risk for hydronephrosis and renal damage.',
      options: [
        _NodeOption(
          label: 'Yes — DSD Present',
          subtitle: 'High pressures, risk to upper tracts',
          targetId: 'umn_cic',
        ),
        _NodeOption(
          label: 'No — Overactive Detrusor Only',
          subtitle: 'Urge incontinence without DSD',
          targetId: 'umn_cic',
        ),
      ],
    ),
    'umn_cic': _BladderNode(
      id: 'umn_cic',
      title: 'First-Line Management: CIC + Anticholinergics',
      question: 'Is the patient responding to CIC and anticholinergic therapy?',
      detail:
          'Clean intermittent catheterisation (CIC) 4-6 times/day is the GOLD STANDARD for neurogenic bladder management. Combined with anticholinergics to reduce detrusor overactivity and keep DLPP <40 cmH2O.',
      keyFact:
          'CIC frequency: 4-6x/day. Target volume per catheterisation: <500 mL. Fluid intake: ~2L/day distributed evenly. DLPP target: <40 cmH2O.',
      medications: [
        _MedInfo('Oxybutynin', '5 mg PO TID (or XL 10-15 mg daily)', 'Anticholinergic. Side effects: dry mouth, constipation, cognitive impairment in elderly.'),
        _MedInfo('Tolterodine', '2 mg PO BID (or LA 4 mg daily)', 'Anticholinergic. Better CNS side-effect profile than oxybutynin.'),
        _MedInfo('Mirabegron', '25-50 mg PO daily', 'Beta-3 agonist. Relaxes detrusor WITHOUT anticholinergic side effects. Can combine with anticholinergics.'),
      ],
      options: [
        _NodeOption(
          label: 'Yes — Adequate Response',
          subtitle: 'DLPP <40, continent, no UTIs',
          targetId: 'umn_success',
        ),
        _NodeOption(
          label: 'No — Refractory',
          subtitle: 'Persistent high pressures or incontinence',
          targetId: 'umn_refractory',
        ),
      ],
    ),
    'umn_refractory': _BladderNode(
      id: 'umn_refractory',
      title: 'Refractory UMN Bladder — Advanced Options',
      question: 'Select the next-line intervention:',
      detail:
          'When CIC + anticholinergics fail to maintain safe pressures or achieve acceptable continence, escalate to more invasive interventions.',
      keyFact: 'Botulinum toxin A (200 units into detrusor) reduces detrusor overactivity for 6-9 months. Augmentation cystoplasty is definitive but irreversible.',
      options: [
        _NodeOption(
          label: 'Botulinum Toxin A (OnabotulinumtoxinA)',
          subtitle: '200 units injected into detrusor wall — repeat every 6-9 months',
          targetId: 'umn_botox_outcome',
        ),
        _NodeOption(
          label: 'Augmentation Cystoplasty',
          subtitle: 'Surgical bladder enlargement using bowel segment',
          targetId: 'umn_augmentation_outcome',
        ),
        _NodeOption(
          label: 'Sphincterotomy / Stent',
          subtitle: 'For males — converts to reflex voiding into condom catheter',
          targetId: 'umn_sphincterotomy_outcome',
        ),
      ],
    ),
    'umn_botox_outcome': _BladderNode(
      id: 'umn_botox_outcome',
      title: 'Botulinum Toxin A — Outcome',
      question: '',
      detail:
          'OnabotulinumtoxinA 200 units injected cystoscopically into the detrusor muscle. Reduces detrusor overactivity and improves compliance. Must continue CIC. Repeat every 6-9 months. FDA-approved for neurogenic detrusor overactivity.',
      keyFact: 'Onset: 2-4 weeks. Duration: 6-9 months. Risk: increased PVR (must do CIC). UTI rate may decrease due to lower pressures.',
      isTerminal: true,
    ),
    'umn_augmentation_outcome': _BladderNode(
      id: 'umn_augmentation_outcome',
      title: 'Augmentation Cystoplasty — Outcome',
      question: '',
      detail:
          'Surgical augmentation using ileal or sigmoid segment to increase bladder capacity and reduce pressures. Definitive treatment. Requires lifelong CIC. Risk of mucus production, metabolic acidosis, bladder stones, and rare malignancy at anastomosis.',
      keyFact: 'Irreversible. Must do CIC for life. Consider Mitrofanoff channel (appendicovesicostomy) for catheterisable stoma if urethral access is difficult.',
      isTerminal: true,
    ),
    'umn_sphincterotomy_outcome': _BladderNode(
      id: 'umn_sphincterotomy_outcome',
      title: 'Sphincterotomy — Outcome',
      question: '',
      detail:
          'Transurethral incision of the external sphincter to eliminate DSD. Converts bladder to low-pressure reflex voiding. Patient wears a condom catheter. Only for males. Irreversible loss of continence.',
      keyFact: 'Eliminates DSD. Reduces upper tract risk. Male only. Alternative: urethral stent (reversible). Requires condom catheter drainage.',
      isTerminal: true,
    ),
    'umn_success': _BladderNode(
      id: 'umn_success',
      title: 'Successful Management',
      question: '',
      detail:
          'Continue current regimen. Annual surveillance: renal ultrasound, urodynamics, serum creatinine. Monitor for UTIs, stones, and upper tract deterioration.',
      keyFact: 'Annual renal ultrasound is standard. Urodynamics every 1-2 years. Adjust CIC frequency if volumes consistently >500 mL.',
      isTerminal: true,
    ),

    // ── LMN Path ─────────────────────────────────────
    'lmn_overflow': _BladderNode(
      id: 'lmn_overflow',
      title: 'LMN Bladder — Overflow Incontinence',
      question: 'What is the primary management approach?',
      detail:
          'LMN (areflexic/flaccid) bladder has a large capacity, low-pressure, poorly contractile detrusor. The bladder fills and overflows. The external sphincter is flaccid (low resistance). Risk: large residual volumes, UTIs, stones.',
      keyFact: 'LMN bladder has LOW pressure (safe for upper tracts in most cases) but HIGH residual volumes. The sphincter is OPEN (denervated), so incontinence is from overflow, not high-pressure voiding.',
      options: [
        _NodeOption(
          label: 'CIC (Clean Intermittent Catheterisation)',
          subtitle: 'Gold standard — 4-6x/day, target <500 mL per cath',
          targetId: 'lmn_cic',
        ),
        _NodeOption(
          label: 'Valsalva / Crede Maneuver',
          subtitle: 'Manual expression — use with caution',
          targetId: 'lmn_crede',
        ),
      ],
    ),
    'lmn_cic': _BladderNode(
      id: 'lmn_cic',
      title: 'CIC for LMN Bladder',
      question: 'Is the patient achieving adequate drainage?',
      detail:
          'CIC remains the gold standard even for LMN bladder. Because the sphincter is denervated and open, some patients may leak between catheterisations. Alpha-agonists can increase sphincter tone.',
      keyFact: 'If leaking between CICs in LMN bladder, consider adding pseudoephedrine (alpha-agonist) to increase sphincter tone, or use a urethral compression device.',
      medications: [
        _MedInfo('Pseudoephedrine', '30-60 mg PO TID', 'Alpha-agonist. Increases urethral sphincter tone. Contraindicated in uncontrolled hypertension.'),
      ],
      options: [
        _NodeOption(
          label: 'Yes — Good Drainage, Continent',
          subtitle: 'Continue current regimen with surveillance',
          targetId: 'lmn_success',
        ),
        _NodeOption(
          label: 'No — Persistent Incontinence',
          subtitle: 'Leaking between catheterisations',
          targetId: 'lmn_surgical',
        ),
      ],
    ),
    'lmn_crede': _BladderNode(
      id: 'lmn_crede',
      title: 'Valsalva / Crede Maneuver',
      question: '',
      detail:
          'Valsalva (bearing down) and Crede (manual suprapubic compression) can assist emptying in LMN bladder. However, these are NOT recommended as primary methods due to risk of vesicoureteral reflux, hernia, rectal prolapse, and haemorrhoids.',
      keyFact: 'SAFETY CHECK: Crede/Valsalva are generally AVOIDED in UMN bladder (would push against a closed sphincter with DSD, generating dangerous pressures). Only consider in LMN bladder with confirmed open sphincter on urodynamics.',
      isTerminal: true,
      safetyWarning: 'Crede and Valsalva should only be used after urodynamic confirmation of an open, non-obstructing sphincter. Never use in UMN bladder with DSD.',
    ),
    'lmn_surgical': _BladderNode(
      id: 'lmn_surgical',
      title: 'Surgical Options for LMN Bladder',
      question: '',
      detail:
          'For refractory LMN bladder incontinence: consider artificial urinary sphincter (AUS), pubovaginal sling, or sacral nerve stimulation (limited evidence in SCI). Long-term indwelling catheter (suprapubic preferred over urethral) is a last resort.',
      keyFact: 'Indwelling catheters carry high complication rates: UTI, stones, urethral erosion, squamous cell carcinoma of bladder (with long-term use). Suprapubic is preferred over urethral if indwelling is necessary.',
      isTerminal: true,
    ),
    'lmn_success': _BladderNode(
      id: 'lmn_success',
      title: 'Successful LMN Bladder Management',
      question: '',
      detail:
          'Continue CIC regimen. Annual surveillance: renal ultrasound, urodynamics, serum creatinine. Monitor for UTIs, stones, and upper tract changes. Lower risk of upper tract damage than UMN bladder due to low pressures.',
      keyFact: 'LMN bladder is generally SAFER for upper tracts than UMN bladder because pressures are low. But large residual volumes increase UTI and stone risk.',
      isTerminal: true,
    ),
  };

  _BladderNode get _currentNode => _nodes[_currentNodeId]!;

  void _selectOption(_NodeOption option) {
    setState(() {
      _path.add(_currentNodeId);
      _currentNodeId = option.targetId;
      if (_nodes[option.targetId]!.isTerminal) {
        _showSummary = true;
      }
    });
  }

  void _goBack() {
    if (_path.isEmpty) return;
    setState(() {
      _showSummary = false;
      _currentNodeId = _path.removeLast();
    });
  }

  void _reset() {
    setState(() {
      _path.clear();
      _currentNodeId = 'root';
      _showSummary = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surfaceLight,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildBreadcrumb(),
          const SizedBox(height: 12),
          _buildNodeCard(_currentNode),
          if (_currentNode.medications != null &&
              _currentNode.medications!.isNotEmpty) ...[
            const SizedBox(height: 12),
            _buildMedicationPanel(_currentNode.medications!),
          ],
          if (_currentNode.safetyWarning != null) ...[
            const SizedBox(height: 12),
            _buildSafetyWarning(_currentNode.safetyWarning!),
          ],
          if (_showSummary) ...[
            const SizedBox(height: 16),
            _buildPathSummary(),
          ],
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildBreadcrumb() {
    final items = <String>[];
    for (final id in _path) {
      items.add(_nodes[id]!.title);
    }
    items.add(_currentNode.title);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.surfaceMuted,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          if (_path.isNotEmpty)
            GestureDetector(
              onTap: _goBack,
              child: const Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(Icons.arrow_back_rounded,
                    size: 16, color: AppTheme.accentTeal),
              ),
            ),
          Expanded(
            child: Text(
              items.join(' > '),
              style: AppTheme.monoFont(
                  fontSize: 10,
                  color: AppTheme.textSecondary,
                  letterSpacing: 0.3),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (_path.isNotEmpty)
            GestureDetector(
              onTap: _reset,
              child: const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Icon(Icons.refresh_rounded,
                    size: 16, color: AppTheme.textSecondary),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNodeCard(_BladderNode node) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppTheme.borderSubtle, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title bar
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: const BoxDecoration(
              color: AppTheme.primaryNavy,
              borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
            ),
            child: Text(
              node.title,
              style: AppTheme.displayFont(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Detail
                Text(node.detail,
                    style: AppTheme.bodyFont(
                        fontSize: 13,
                        color: AppTheme.textPrimary,
                        height: 1.5)),
                const SizedBox(height: 12),

                // Key fact callout
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.accentTeal.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(4),
                    border: const Border(
                      left:
                          BorderSide(color: AppTheme.accentTeal, width: 3),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.lightbulb_outline,
                          size: 16, color: AppTheme.accentTeal),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(node.keyFact,
                            style: AppTheme.bodyFont(
                                fontSize: 12,
                                color: AppTheme.textPrimary,
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),

                // Question
                if (node.question.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Text(node.question,
                      style: AppTheme.displayFont(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.primaryNavy)),
                  const SizedBox(height: 10),
                ],

                // Options
                if (node.options != null)
                  ...node.options!.map(
                    (opt) => _buildOption(opt),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(_NodeOption option) {
    return GestureDetector(
      onTap: () => _selectOption(option),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppTheme.accentTeal, width: 1),
        ),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: AppTheme.accentTeal.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(Icons.arrow_forward_rounded,
                  size: 16, color: AppTheme.accentTeal),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(option.label,
                      style: AppTheme.displayFont(
                          fontSize: 13, fontWeight: FontWeight.w600)),
                  if (option.subtitle != null)
                    Text(option.subtitle!,
                        style: AppTheme.bodyFont(
                            fontSize: 11,
                            color: AppTheme.textSecondary,
                            height: 1.3)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicationPanel(List<_MedInfo> meds) {
    return Container(
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
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.bladderColor.withValues(alpha: 0.1),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(5)),
            ),
            child: Row(
              children: [
                Icon(Icons.medication_rounded,
                    size: 16, color: AppTheme.bladderColor),
                const SizedBox(width: 8),
                Text('Medications',
                    style: AppTheme.displayFont(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.bladderColor)),
              ],
            ),
          ),
          ...meds.map((m) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(m.name,
                        style: AppTheme.displayFont(
                            fontSize: 12, fontWeight: FontWeight.w700)),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceLight,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(m.dose,
                          style: AppTheme.monoFont(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.bladderColor)),
                    ),
                    Text(m.notes,
                        style: AppTheme.bodyFont(
                            fontSize: 11,
                            color: AppTheme.textSecondary,
                            height: 1.4)),
                    const Divider(height: 16, color: AppTheme.inkLight),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildSafetyWarning(String warning) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.dangerRed.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
        border: const Border(
          left: BorderSide(color: AppTheme.dangerRed, width: 3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.warning_amber_rounded,
              size: 18, color: AppTheme.dangerRed),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('SAFETY WARNING',
                    style: AppTheme.monoFont(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.dangerRed,
                        letterSpacing: 1.0)),
                const SizedBox(height: 4),
                Text(warning,
                    style: AppTheme.bodyFont(
                        fontSize: 12,
                        color: AppTheme.textPrimary,
                        height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPathSummary() {
    // Collect all nodes in the path + current
    final allIds = [..._path, _currentNodeId];
    final pathNodes = allIds.map((id) => _nodes[id]!).toList();

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppTheme.successGreen, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: const BoxDecoration(
              color: AppTheme.successGreen,
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(5)),
            ),
            child: Row(
              children: [
                const Icon(Icons.check_circle_rounded,
                    color: Colors.white, size: 18),
                const SizedBox(width: 8),
                Text('Management Plan Summary',
                    style: AppTheme.displayFont(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...pathNodes.asMap().entries.map((entry) {
                  final i = entry.key;
                  final node = entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            color: AppTheme.successGreen,
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: Center(
                            child: Text('${i + 1}',
                                style: AppTheme.monoFont(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white)),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(node.title,
                              style: AppTheme.bodyFont(
                                  fontSize: 13,
                                  color: AppTheme.textPrimary)),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 12),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: _reset,
                    icon:
                        const Icon(Icons.refresh_rounded, size: 16),
                    label: const Text('Start Over'),
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

class _BladderNode {
  final String id;
  final String title;
  final String question;
  final String detail;
  final String keyFact;
  final List<_NodeOption>? options;
  final List<_MedInfo>? medications;
  final bool isTerminal;
  final String? safetyWarning;

  const _BladderNode({
    required this.id,
    required this.title,
    this.question = '',
    required this.detail,
    required this.keyFact,
    this.options,
    this.medications,
    this.isTerminal = false,
    this.safetyWarning,
  });
}

class _NodeOption {
  final String label;
  final String? subtitle;
  final String targetId;

  const _NodeOption({
    required this.label,
    this.subtitle,
    required this.targetId,
  });
}

class _MedInfo {
  final String name;
  final String dose;
  final String notes;

  const _MedInfo(this.name, this.dose, this.notes);
}
