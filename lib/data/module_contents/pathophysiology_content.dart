import 'package:flutter/material.dart';
import '../models/topic_content_model.dart';

final TopicData pathophysiologyContent = TopicData(
  id: 'pathophysiology',
  title: 'SCI Pathophysiology',
  tabs: [
    // ==========================================
    // TAB 1: PRIMARY INJURY
    // ==========================================
    TopicTab(
      title: 'Primary Injury',
      blocks: [
        HeaderBlock('Primary Mechanical Injury'),
        TextBlock(
          'Primary injury refers to the initial mechanical damage to the spinal cord at the moment of trauma. This damage is irreversible and sets the stage for secondary injury cascades. Understanding the biomechanics helps predict injury patterns and associated SCI syndromes.',
          isIntro: true,
        ),
        BulletCardBlock(
          title: 'Mechanisms of Primary Injury',
          themeColor: const Color(0xFFDC2626),
          backgroundColor: const Color(0xFFFEF2F2),
          points: [
            'Compression: burst fractures, disc herniation, epidural hematoma — most common mechanism',
            'Contusion: bruising of cord without complete disruption — most common pathology in blunt SCI',
            'Distraction: hyperextension/hyperflexion stretching of the cord and vascular structures',
            'Laceration/Transection: penetrating trauma (knife, bullet), sharp bone fragments',
            'Concussion: transient neurological dysfunction without structural damage (rare in isolation)',
            'Shear: rotational forces causing axonal injury and vascular disruption',
          ],
        ),
        AnnotatedImageBlock(
          assetPath: 'assets/infographics/anatomy/servier_brain_sagittal.png',
          caption: 'Spinal Cord Cross-Section — Major Tracts',
          description: 'The spinal cord is organized with white matter (tracts) surrounding a central butterfly-shaped gray matter core. Understanding tract locations is essential for predicting injury patterns.',
          annotations: [
            AnnotationPoint(x: 0.50, y: 0.30, label: 'Dorsal Columns (Posterior)', description: 'Fasciculus gracilis (medial, LE) and cuneatus (lateral, UE). Carry proprioception, vibration, discriminative touch. Preserved in anterior cord syndrome.', color: Color(0xFF3B82F6)),
            AnnotationPoint(x: 0.25, y: 0.50, label: 'Lateral Corticospinal Tract', description: 'Voluntary motor. Somatotopic: cervical fibers medial, sacral lateral. Central cord syndrome preferentially damages cervical (UE) fibers.', color: Color(0xFFDC2626)),
            AnnotationPoint(x: 0.30, y: 0.65, label: 'Lateral Spinothalamic Tract', description: 'Pain and temperature. Crosses within 1-2 segments at the anterior white commissure. Lost in anterior cord syndrome.', color: Color(0xFFEA580C)),
            AnnotationPoint(x: 0.50, y: 0.70, label: 'Anterior Horn (Gray Matter)', description: 'Contains alpha and gamma motor neurons (LMN). More vulnerable than white matter due to higher metabolic demand. Central hemorrhagic necrosis begins here.', color: Color(0xFF7C3AED)),
            AnnotationPoint(x: 0.50, y: 0.40, label: 'Dorsal Horn (Gray Matter)', description: 'Receives sensory afferent input. Substantia gelatinosa (Lamina II) modulates pain (gate control theory).', color: Color(0xFF059669)),
            AnnotationPoint(x: 0.70, y: 0.55, label: 'IML Column (T1-L2)', description: 'Intermediolateral cell column contains sympathetic preganglionic neurons. Critical for understanding autonomic dysreflexia.', color: Color(0xFF0D9488)),
          ],
        ),
        HeaderBlock('Biomechanical Injury Patterns'),
        TableBlock(
          title: 'Mechanism → Fracture → SCI Syndrome',
          columns: ['Mechanism', 'Typical Fracture', 'Associated SCI Pattern'],
          rows: [
            ['Hyperflexion', 'Anterior wedge\ncompression,\nteardrop fracture', 'Anterior cord syndrome'],
            ['Hyperextension', 'Hangman (C2),\nposterior element\nfractures', 'Central cord syndrome\n(esp. with spondylosis)'],
            ['Axial compression', 'Burst fracture\n(Jefferson C1,\nthoracolumbar)', 'Variable; retropulsed bone\ncauses anterior cord\ncompression'],
            ['Flexion-rotation', 'Facet dislocation\n(unilateral or\nbilateral)', 'Brown-Séquard (unilateral)\nor complete (bilateral)'],
            ['Flexion-distraction', 'Chance fracture\n(T12-L2)', 'Variable cord or\ncauda equina injury'],
            ['Penetrating', 'None typical', 'Brown-Séquard or complete,\ndepending on trajectory'],
          ],
        ),
        PearlBlock(
          'Board Pearl: Central Cord Syndrome Update',
          'Historically, central cord syndrome was attributed to the somatotopic lamination of the corticospinal tract (cervical fibers medial, sacral lateral). More recently per Cuccurullo, this proposed lamination has NOT been proven in humans, and CCS is now felt to be predominantly a WHITE MATTER injury rather than a gray matter injury. However, the classic teaching of UE > LE weakness remains clinically valid.',
        ),
        HeaderBlock('Pathological Changes at the Cellular Level'),
        BulletCardBlock(
          title: 'Immediate Tissue Damage',
          themeColor: const Color(0xFF7C3AED),
          backgroundColor: const Color(0xFFF5F3FF),
          points: [
            'Immediate disruption of cell membranes (neurons, glia, endothelium)',
            'Central hemorrhagic necrosis within the gray matter (minutes)',
            'Axonal shearing and disruption of myelin sheaths',
            'Disruption of the blood-spinal cord barrier',
            'Gray matter is MORE susceptible than white matter (higher metabolic demand, richer vascularity)',
            'Damage extends centrifugally from the gray matter outward over hours to days',
            'Central gray matter hemorrhage within first hour → expands peripherally',
            'White matter edema and demyelination develop over subsequent hours-days',
          ],
        ),
        PearlBlock(
          'Board Pearl: Gray > White Matter Vulnerability',
          'Gray matter is more vulnerable to injury than white matter because of its higher metabolic demand and richer blood supply. The central hemorrhagic necrosis pattern begins in gray matter within minutes and expands outward. This centrifugal spread is why early decompression and blood pressure support are critical.',
        ),
      ],
    ),
    // ==========================================
    // TAB 2: SECONDARY INJURY
    // ==========================================
    TopicTab(
      title: 'Secondary Injury',
      blocks: [
        HeaderBlock('Secondary Injury Cascade'),
        TextBlock(
          'Secondary injury refers to the cascade of biochemical, cellular, and molecular events that occur in the hours to weeks following primary injury. These processes expand the zone of tissue damage and represent the primary therapeutic targets for neuroprotection.',
          isIntro: true,
        ),
        ComparisonDiagramBlock(
          title: 'Primary vs Secondary Injury',
          description: 'Primary injury is immediate and irreversible. Secondary injury is a progressive cascade that represents the therapeutic window for neuroprotection.',
          left: ComparisonSide(
            title: 'Primary Injury',
            features: [
              'Immediate mechanical damage',
              'Irreversible at the moment of impact',
              'Compression, contusion, laceration',
              'Cell membrane disruption',
              'Central hemorrhagic necrosis',
              'Axonal shearing',
              'Gray matter more vulnerable',
              'Prevention is the only strategy',
            ],
            themeColor: Color(0xFFDC2626),
          ),
          right: ComparisonSide(
            title: 'Secondary Injury',
            features: [
              'Hours to weeks after trauma',
              'Potentially modifiable (therapeutic target)',
              'Excitotoxicity (glutamate/calcium)',
              'Free radical damage',
              'Inflammatory cascades',
              'Apoptosis (peak 7-14 days)',
              'Glial scar formation',
              'MAP 85-90 mmHg for 5-7 days',
            ],
            themeColor: Color(0xFFEA580C),
          ),
        ),
        BulletCardBlock(
          title: 'Vascular Mechanisms',
          themeColor: const Color(0xFFDC2626),
          backgroundColor: const Color(0xFFFEF2F2),
          points: [
            'Hemorrhage and vasospasm in the central gray matter',
            'Loss of autoregulation of spinal cord blood flow',
            'Ischemia from microvascular thrombosis and edema',
            'Reperfusion injury with free radical generation',
            'Progressive edema compresses adjacent tissue (secondary compression)',
            'Blood-spinal cord barrier breakdown worsens edema',
            'Systemic hypotension (neurogenic shock) further reduces perfusion',
          ],
        ),
        BulletCardBlock(
          title: 'Biochemical Cascades',
          themeColor: const Color(0xFF6366F1),
          backgroundColor: const Color(0xFFEEF2FF),
          points: [
            'EXCITOTOXICITY: excessive glutamate release activates NMDA/AMPA receptors → massive calcium influx',
            'CALCIUM INFLUX: triggers destructive intracellular enzymes (calpains, phospholipases, endonucleases)',
            'FREE RADICALS: lipid peroxidation damages cell membranes; iron from hemorrhage catalyzes Fenton reaction',
            'ARACHIDONIC ACID cascade: prostaglandins, thromboxanes, leukotrienes worsen inflammation and vasospasm',
            'NITRIC OXIDE: excessive production by inducible NOS (iNOS) causes oxidative damage',
            'POTASSIUM EFFLUX: disrupts membrane potential, depolarization block of neural signaling',
          ],
        ),
        BulletCardBlock(
          title: 'Inflammatory Response',
          themeColor: const Color(0xFFEA580C),
          backgroundColor: const Color(0xFFFFF7ED),
          points: [
            'Neutrophil infiltration within hours (peak 24-48 hours)',
            'Macrophage/microglial activation (peak at 5-7 days)',
            'Release of pro-inflammatory cytokines: TNF-α, IL-1β, IL-6',
            'Dual role: damaging to neurons but necessary for debris clearance and repair',
            'Chronic inflammation can persist for months to years',
            'Astrocytic scar (glial scar) forms at the injury border — physical barrier to axonal regeneration',
            'Chondroitin sulfate proteoglycans (CSPGs) in glial scar chemically inhibit axon growth',
          ],
        ),
        BulletCardBlock(
          title: 'Apoptosis (Programmed Cell Death)',
          themeColor: const Color(0xFF7C3AED),
          backgroundColor: const Color(0xFFF5F3FF),
          points: [
            'Distinct from necrosis — organized, energy-dependent cell death',
            'Occurs in neurons and OLIGODENDROCYTES remote from the injury epicenter',
            'Peak activity at 7-14 days post-injury',
            'Oligodendrocyte apoptosis → secondary demyelination of intact axons',
            'Can extend the functional lesion over multiple spinal segments',
            'Caspase-dependent and caspase-independent pathways',
            'Potential therapeutic target — caspase inhibitors under investigation',
          ],
        ),
        HeaderBlock('Timeline of Secondary Injury'),
        TableBlock(
          title: 'Secondary Injury Phases',
          columns: ['Phase', 'Timing', 'Key Events'],
          headerColor: const Color(0xFFDC2626),
          rows: [
            ['Immediate', '0-2 hours', 'Hemorrhage, vasospasm, excitotoxicity,\nionic imbalance, membrane disruption'],
            ['Acute', '2-48 hours', 'Edema, neutrophil infiltration,\ncontinued ischemia, free radical\ndamage, blood-cord barrier breakdown'],
            ['Subacute', '2 days-2 weeks', 'Macrophage infiltration, apoptosis peak,\noligodendrocyte death, demyelination,\ncyst formation begins'],
            ['Chronic', '>2 weeks-\nmonths', 'Wallerian degeneration, glial scar\nmaturation, syrinx formation,\naxonal die-back, chronic inflammation'],
          ],
        ),
        HeaderBlock('Neuroprotective Strategies'),
        BulletCardBlock(
          title: 'Current Evidence-Based Approaches',
          themeColor: const Color(0xFF059669),
          backgroundColor: const Color(0xFFECFDF5),
          points: [
            'Blood pressure augmentation: MAP 85-90 mmHg for 5-7 days (AANS/CNS guidelines)',
            'Early surgical decompression: within 24 hours when feasible (STASCIS trial)',
            'Avoidance of secondary insults: hypoxia, hypotension, hyperthermia',
            'Spinal immobilization and proper transfer to prevent additional injury',
          ],
        ),
        BulletCardBlock(
          title: 'Methylprednisolone — The Controversy',
          themeColor: const Color(0xFFDC2626),
          backgroundColor: const Color(0xFFFEF2F2),
          points: [
            'NASCIS I (1984): compared low-dose vs high-dose MPSS — no significant difference; NO placebo control',
            'NASCIS II (1990): MPSS vs naloxone vs placebo — post-hoc analysis showed modest benefit if given within 8 hours',
            'NASCIS II protocol: 30 mg/kg bolus + 5.4 mg/kg/hr × 23 hrs (if started within 3 hrs) or × 48 hrs (if started 3-8 hrs)',
            'NASCIS III (1997): 24-hr vs 48-hr MPSS vs tirilazad — post-hoc subgroup analysis only',
            'If >8 hours since injury: do NOT administer (potential harm)',
            'AANS/CNS 2013 guidelines: recommend AGAINST routine use',
            'Risks: wound infection, GI hemorrhage, sepsis, pneumonia, PE, hyperglycemia',
            'Modest benefit (~4 points on motor scale) of questionable functional significance',
          ],
        ),
        PearlBlock(
          'Board Pearl: Methylprednisolone',
          'Board answer: Methylprednisolone is NO LONGER standard of care for acute SCI. The NASCIS II/III trials had significant methodological flaws. Current guidelines recommend AGAINST routine use. The risks (infection, GI bleeding, hyperglycemia) may outweigh unproven benefits. However, it remains "an option" in some guidelines — know both sides for boards.',
        ),
        BulletCardBlock(
          title: 'Emerging Therapies (Investigational)',
          themeColor: const Color(0xFF0D9488),
          backgroundColor: const Color(0xFFF0FDFA),
          points: [
            'Riluzole: sodium channel blocker, reduces excitotoxicity — Phase II/III trials',
            'Minocycline: anti-inflammatory, reduces apoptosis — clinical trials',
            'Hypothermia: systemic or local cooling — under investigation',
            'Stem cell therapies: neural stem cells, mesenchymal stem cells — early trials',
            'Anti-Nogo antibodies: block axon growth inhibitors in myelin',
            'Chondroitinase ABC: degrades CSPGs in glial scar to promote regeneration',
            'Epidural electrical stimulation: has shown some functional recovery in chronic SCI',
          ],
        ),
        PearlBlock(
          'Board Pearl: STASCIS Trial',
          'The STASCIS trial showed early decompression (<24 hours) patients were 2.8x more likely to achieve ≥2 AIS grade improvement (19.8% vs 8.8% in late surgery). Current AANS/CNS 2024 guidelines recommend early surgical decompression within 24 hours for cervical SCI.',
        ),
        HeaderBlock('Succinylcholine Avoidance'),
        BulletCardBlock(
          title: 'Life-Threatening Hyperkalemia Risk',
          themeColor: const Color(0xFFDC2626),
          backgroundColor: const Color(0xFFFEF2F2),
          points: [
            'Succinylcholine is CONTRAINDICATED after 48 hours following SCI',
            'Denervation supersensitivity → proliferation of extrajunctional acetylcholine receptors across entire muscle membrane',
            'Succinylcholine depolarizes these receptors → massive potassium efflux → fatal cardiac arrhythmias',
            'Risk begins ~48 hours post-injury and persists INDEFINITELY',
            'Safe to use within the first 24-48 hours (before receptor upregulation)',
            'Alternatives: non-depolarizing agents (rocuronium, vecuronium, cisatracurium)',
          ],
        ),
        PearlBlock(
          'Board Pearl: Succinylcholine Timing',
          'Succinylcholine is SAFE within the first 24-48 hours after SCI (before extrajunctional receptor upregulation). After 48 hours, it must be permanently avoided due to the risk of fatal hyperkalemia. Use non-depolarizing agents (rocuronium) instead. This is a classic board question.',
        ),
      ],
    ),
    // ==========================================
    // TAB 3: SPINAL SHOCK
    // ==========================================
    TopicTab(
      title: 'Spinal Shock',
      blocks: [
        HeaderBlock('Spinal Shock'),
        TextBlock(
          'Spinal shock is a temporary loss or depression of all spinal reflex activity below the level of injury following acute SCI. It is a NEUROLOGICAL phenomenon distinct from neurogenic shock (cardiovascular). Understanding the phases and reflex return patterns is essential for board exams.',
          isIntro: true,
        ),
        BulletCardBlock(
          title: 'Definition & Key Features',
          themeColor: const Color(0xFF3B82F6),
          backgroundColor: const Color(0xFFEFF6FF),
          points: [
            'Temporary loss of ALL spinal reflex activity below the level of injury',
            'May not occur in all patients',
            'Flaccid paralysis (even in UMN injuries — mimics LMN pattern)',
            'Loss of all reflexes below the level: DTRs, cutaneous reflexes, autonomic reflexes',
            'Atonic bladder and bowel (areflexic)',
            'Loss of vasomotor tone, sweating, and piloerection below the lesion',
            'Cannot determine true completeness of injury during spinal shock',
            'Must wait for resolution before performing definitive ISNCSCI classification',
          ],
        ),
        PearlBlock(
          'Board Pearl: Spinal Shock & Classification',
          'You CANNOT determine if an injury is truly complete (AIS A) during spinal shock because all reflexes are absent. The injury may APPEAR complete during spinal shock but later prove to be incomplete once reflexes return. Wait for resolution of spinal shock (BCR return) before making prognostic statements about completeness.',
        ),
        HeaderBlock('Phases of Spinal Shock (Ditunno Model)'),
        NumberedListBlock([
          MapEntry('Phase 1', '0-24 hours: AREFLEXIA — Complete loss of all reflexes below injury level. All motor function absent (flaccid). This is the classic "spinal shock" period.'),
          MapEntry('Phase 2', '1-3 days: INITIAL REFLEX RETURN — Denervation supersensitivity develops. Cutaneous reflexes return first: (1) Delayed plantar response (first to return), (2) Bulbocavernosus reflex (BCR), (3) Cremasteric reflex, (4) Anal wink.'),
          MapEntry('Phase 3', '1-4 weeks: EARLY HYPERREFLEXIA — Deep tendon reflexes return. Muscle stretch reflexes become active. Detrusor hyperreflexia may begin. Babinski sign may appear.'),
          MapEntry('Phase 4', '1-12 months: SPASTICITY — Muscle stretch reflexes become hyperactive. Full UMN pattern established: hyperreflexia, clonus, Babinski sign, spasticity. Flexor then extensor spasms develop.'),
        ]),
        HeaderBlock('Reflex Return After Spinal Shock'),
        BulletCardBlock(
          title: 'Delayed Plantar Response',
          themeColor: const Color(0xFF7C3AED),
          backgroundColor: const Color(0xFFF5F3FF),
          points: [
            'Usually the FIRST reflex to return after spinal shock',
            'Elicited by stroking the lateral plantar aspect of the foot (same area as Babinski)',
            'BUT requires DEEP PRESSURE rather than light stimulus',
            'Response is DELAYED compared to normal plantar response',
            'Toes flex and then relax slowly',
            'If PERSISTENT, correlates with complete injury and poor LE recovery prognosis',
          ],
        ),
        BulletCardBlock(
          title: 'Bulbocavernosus Reflex (BCR)',
          themeColor: const Color(0xFFDC2626),
          backgroundColor: const Color(0xFFFEF2F2),
          points: [
            'Usually returns within 24 hours (often first or second reflex to return)',
            'Tests S2-S4 reflex arc (pudendal nerve)',
            'Elicited by: squeezing the glans penis/clitoris OR tugging on the Foley catheter',
            'Positive response: contraction of the anal sphincter (felt on digital rectal exam)',
            'Return of BCR signals END of spinal shock',
            'If BCR does NOT return by 24 hours, suspect LMN injury (conus/cauda equina)',
            'After BCR returns: if exam is still AIS A → injury is likely truly complete',
          ],
        ),
        PearlBlock(
          'Board Pearl: BCR Return = Key Decision Point',
          'The BCR return marks the end of spinal shock. At this point, you can reliably classify the injury. If the exam remains AIS A (no sacral sparing) after BCR returns, the injury is very likely truly complete, with only ~10-15% chance of converting to incomplete at 1 year. Failure of BCR to return suggests LMN (conus/cauda equina) injury.',
        ),
        BulletCardBlock(
          title: 'Anal Wink (Perianal Reflex)',
          themeColor: const Color(0xFF0D9488),
          backgroundColor: const Color(0xFFF0FDFA),
          points: [
            'Perianal stimulation (pinprick or scratch) causes contraction of the external anal sphincter',
            'Tests S2-S4 reflex arc (same as BCR)',
            'Indicates similar findings as BCR',
            'Returns in Phase 2 of spinal shock',
          ],
        ),
        MnemonicBlock(
          'Spinal Shock Phases: "All Reflexes Return Spastic"',
          'Phase 1: Areflexia (0-24h) → Phase 2: Reflex Return — cutaneous reflexes (1-3d) → Phase 3: Reflex hyperactivity — DTRs return (1-4wk) → Phase 4: Spasticity established (1-12mo). Remember: cutaneous reflexes return BEFORE deep tendon reflexes.',
        ),
      ],
    ),
    // ==========================================
    // TAB 4: NEUROGENIC SHOCK
    // ==========================================
    TopicTab(
      title: 'Neurogenic Shock',
      blocks: [
        HeaderBlock('Neurogenic Shock'),
        TextBlock(
          'Neurogenic shock is a cardiovascular/hemodynamic phenomenon caused by loss of sympathetic tone after SCI. It is distinct from spinal shock (neurological areflexia) though they often coexist. Distinguishing neurogenic shock from hemorrhagic shock in trauma patients is critical.',
          isIntro: true,
        ),
        ComparisonDiagramBlock(
          title: 'Spinal Shock vs Neurogenic Shock',
          description: 'These are two completely different phenomena that commonly coexist in acute cervical SCI. Confusing the two is a common board trap.',
          left: ComparisonSide(
            title: 'Spinal Shock',
            features: [
              'NEUROLOGICAL phenomenon',
              'Transient areflexia below injury',
              'Flaccid paralysis (even in UMN)',
              'Occurs at ANY SCI level',
              'Duration: hours to weeks',
              'End marker: BCR return',
              'Treatment: observation/wait',
              'Cannot classify AIS during',
            ],
            themeColor: Color(0xFF3B82F6),
          ),
          right: ComparisonSide(
            title: 'Neurogenic Shock',
            features: [
              'CARDIOVASCULAR phenomenon',
              'Hypotension + bradycardia + warm skin',
              'Loss of sympathetic tone',
              'Only with T6 AND ABOVE injuries',
              'Duration: 1-5 weeks',
              'End: hemodynamic stability',
              'Treatment: fluids + vasopressors',
              'Target MAP 85-90 mmHg x 5-7 days',
            ],
            themeColor: Color(0xFFDC2626),
          ),
        ),
        BulletCardBlock(
          title: 'Pathophysiology',
          themeColor: const Color(0xFFDC2626),
          backgroundColor: const Color(0xFFFEF2F2),
          points: [
            'Occurs with injuries at T6 AND ABOVE (loss of sympathetic outflow from IML at T1-L2)',
            'Loss of sympathetic tone → peripheral vasodilation → decreased SVR → hypotension',
            'Unopposed vagal (parasympathetic) tone → bradycardia',
            'Loss of cardiac sympathetic innervation (T1-T4) worsens bradycardia',
            'Decreased venous return due to venous pooling',
            'Most common and most severe in CERVICAL and HIGH THORACIC injuries',
            'Duration: typically 1-5 weeks',
          ],
        ),
        BulletCardBlock(
          title: 'Classic Triad',
          themeColor: const Color(0xFF3B82F6),
          backgroundColor: const Color(0xFFEFF6FF),
          points: [
            '1. HYPOTENSION (low SVR from vasodilation)',
            '2. BRADYCARDIA (unopposed vagal tone)',
            '3. PERIPHERAL VASODILATION → warm, dry, flushed skin (especially below injury level)',
          ],
        ),
        HeaderBlock('Neurogenic vs Hemorrhagic Shock'),
        TableBlock(
          title: 'Critical Differentiation in Trauma',
          columns: ['Feature', 'Neurogenic Shock', 'Hemorrhagic Shock'],
          headerColor: const Color(0xFFDC2626),
          rows: [
            ['Cause', 'Loss of sympathetic tone\n(T6 and above)', 'Blood volume loss\n(any trauma)'],
            ['Heart rate', 'BRADYCARDIA', 'TACHYCARDIA'],
            ['Blood pressure', 'Hypotension', 'Hypotension'],
            ['Skin', 'WARM, dry, flushed\n(vasodilation)', 'COOL, clammy, pale\n(vasoconstriction)'],
            ['Peripheral veins', 'Dilated', 'Collapsed'],
            ['Response to fluids', 'Partial, may need\nvasopressors', 'Good initial response'],
            ['Level of consciousness', 'Usually alert', 'May be altered'],
          ],
        ),
        PearlBlock(
          'Board Pearl: Rule Out Hemorrhage First',
          'ALWAYS rule out hemorrhagic shock before attributing hypotension to neurogenic shock in trauma patients. Polytrauma is common with SCI. The key differentiators: neurogenic = WARM skin + BRADYCARDIA; hemorrhagic = COOL skin + TACHYCARDIA. The two can COEXIST, making clinical assessment challenging. When in doubt, treat for hemorrhage first.',
        ),
        HeaderBlock('Treatment of Neurogenic Shock'),
        BulletCardBlock(
          title: 'Management Algorithm',
          themeColor: const Color(0xFF059669),
          backgroundColor: const Color(0xFFECFDF5),
          points: [
            'IV fluids: judicious volume resuscitation (avoid fluid overload → pulmonary edema)',
            'Vasopressors: first-line for persistent hypotension after volume resuscitation',
            '  - Norepinephrine: alpha-1 + beta-1 agonist (vasoconstriction + heart rate support)',
            '  - Phenylephrine: pure alpha-1 (vasoconstriction only — use with caution if bradycardic)',
            '  - Dopamine: dose-dependent alpha and beta effects',
            'Atropine: for symptomatic bradycardia (blocks vagal tone)',
            'Target: MAP 85-90 mmHg for 5-7 days (AANS/CNS guidelines)',
            'Temporary pacing may be needed for severe, refractory bradycardia',
          ],
        ),
        PearlBlock(
          'Board Pearl: MAP Target',
          'Current AANS/CNS guidelines recommend maintaining MAP 85-90 mmHg for 5-7 days following acute SCI to optimize spinal cord perfusion. This is the single most consistently supported hemodynamic intervention. Vasopressors (norepinephrine preferred) should be used if fluids alone are insufficient.',
        ),
        HeaderBlock('Spinal vs Neurogenic Shock — Master Comparison'),
        TableBlock(
          title: 'The Two "Shocks" in SCI',
          columns: ['Feature', 'Spinal Shock', 'Neurogenic Shock'],
          headerColor: const Color(0xFF7C3AED),
          rows: [
            ['Type', 'NEUROLOGICAL\nphenomenon', 'CARDIOVASCULAR\nphenomenon'],
            ['Definition', 'Transient areflexia\nbelow injury', 'Loss of sympathetic\ntone → hemodynamic\ninstability'],
            ['Key finding', 'Absent reflexes,\nflaccid paralysis', 'Hypotension +\nbradycardia +\nwarm skin'],
            ['Level required', 'ANY SCI level', 'T6 AND ABOVE'],
            ['Duration', 'Hours to weeks\n(avg 4-12 weeks\nfor full resolution)', '1-3 weeks\n(up to 5 weeks)'],
            ['End marker', 'Return of BCR', 'Resolution of\nhemodynamic\ninstability'],
            ['Treatment', 'Observation;\nwait for resolution', 'Fluids, vasopressors,\natropine; MAP target\n85-90 mmHg'],
            ['Can coexist?', 'YES — both commonly present together in acute cervical/high thoracic SCI', ''],
          ],
        ),
        MnemonicBlock(
          'Spinal vs Neurogenic: "Spinal = Silent reflexes, Neurogenic = No blood pressure"',
          'Spinal shock = neurological (reflexes disappear). Neurogenic shock = cardiovascular (blood pressure drops with bradycardia and warm skin). Both occur together in cervical SCI but are fundamentally different processes.',
        ),
      ],
    ),
    // ==========================================
    // TAB 5: IMPORTANT AUTONOMIC LEVELS
    // ==========================================
    TopicTab(
      title: 'Key Levels',
      blocks: [
        HeaderBlock('Important Autonomic Levels in SCI'),
        TextBlock(
          'Specific spinal cord levels have critical importance for autonomic function. Understanding these levels is essential for predicting and managing medical complications of SCI.',
          isIntro: true,
        ),
        TableBlock(
          title: 'Critical Autonomic Levels',
          columns: ['Level', 'Significance', 'Clinical Implication'],
          headerColor: const Color(0xFF0D9488),
          rows: [
            ['T1-L2', 'Sympathetic outflow\n(IML column)', 'Loss above this → loss of\nsympathetic control below'],
            ['T1-T4', 'Cardiac sympathetic\ninnervation', 'Loss → bradycardia, reduced\ncardiac contractility'],
            ['T6 and above', 'AD threshold;\northostatic hypotension', 'At risk for autonomic\ndysreflexia and orthostasis'],
            ['T8 and above', 'Thermoregulation\n(temp-eight-ture)', 'Cannot regulate body\ntemperature (poikilothermia)'],
            ['T6-T12', 'Abdominal\nmusculature', 'Loss → impaired cough,\nreduced respiratory reserve'],
            ['S2-S4', 'Parasympathetic\noutflow', 'Controls bladder detrusor,\nbowel, sexual function,\nexternal sphincters'],
          ],
        ),
        MnemonicBlock(
          'T8 = "Temp-EIGHT-ture"',
          'Injuries above T8 lose the ability to regulate body temperature. Remember: T8 = temp-EIGHT-ture. These patients are POIKILOTHERMIC — their body temperature varies with the environment. They need environmental temperature management.',
        ),
        PearlBlock(
          'Board Pearl: T6 — The Magic Number',
          'T6 is the critical autonomic level for boards. Injuries at T6 AND ABOVE are at risk for: (1) Autonomic dysreflexia, (2) Orthostatic hypotension, (3) Neurogenic shock. This is because T6 and above means loss of splanchnic bed sympathetic control (the largest vascular bed in the body). Below T6, enough sympathetic tone remains to compensate.',
        ),
        HeaderBlock('Orthostatic Hypotension in SCI'),
        BulletCardBlock(
          title: 'Pathophysiology & Management',
          themeColor: const Color(0xFF3B82F6),
          backgroundColor: const Color(0xFFEFF6FF),
          points: [
            'Occurs with lesions at T6 and above',
            'Transient reflex depression from lack of sympathetic outflow',
            'Triggered by tilting patient upright >60 degrees',
            'T1-L2 responsible for tachycardia, vasoconstriction, and increased BP',
            'Heart and blood vessels supplied by T1-T7',
            'Baroreceptors sense BP drop → attempt to increase sympathetic output → but efferent pathway interrupted by SCI',
            'Tachycardia may occur (baroreceptor response via intact vagus nerve) but is insufficient to compensate',
            'Orthostasis tends to IMPROVE over time as spinal reflexes develop',
          ],
        ),
        BulletCardBlock(
          title: 'Management of Orthostatic Hypotension',
          themeColor: const Color(0xFF059669),
          backgroundColor: const Color(0xFFECFDF5),
          points: [
            'Repositioning: Trendelenburg / recline wheelchair back',
            'Elastic stockings / compression hose',
            'Abdominal binder (compresses splanchnic bed)',
            'Tilt table accommodation (gradual upright progression)',
            'Increase fluid intake',
            'Pharmacologic agents:',
            '  - Salt tablets: 1g four times daily',
            '  - Midodrine (ProAmatine): alpha-1 agonist, 2.5-10mg TID',
            '  - Fludrocortisone (Florinef): mineralocorticoid, 0.05-0.1mg daily',
            '  - Droxidopa (Northera): 100mg TID',
            'CAUTION: Once orthostasis improves, patient may be at risk for AD',
          ],
        ),
        PearlBlock(
          'Board Pearl: Orthostasis → AD Transition',
          'Per Cuccurullo: Once orthostatic hypotension improves in SCI patients, they may become at risk for autonomic dysreflexia. This is because the spinal reflexes that develop to compensate for orthostasis (vasoconstriction below the injury level) can become the same reflexes that trigger AD. This transition is a classic board concept.',
        ),
        HeaderBlock('Autonomic Dysreflexia Preview'),
        BulletCardBlock(
          title: 'Key Concepts (Detailed in AD Module)',
          themeColor: const Color(0xFFDC2626),
          backgroundColor: const Color(0xFFFEF2F2),
          points: [
            'Occurs in T6 and above injuries',
            'Massive imbalanced sympathetic discharge below the injury level',
            'Triggered by noxious stimulus below injury (bladder distension #1, bowel impaction #2)',
            'Affects 48-90% of susceptible patients',
            'Status post spinal shock — usually within first 6 months after SCI',
            'If untreated: retinal hemorrhage, CVA, MI, seizure, SAH, DEATH',
            'See Autonomic Dysreflexia module for complete management algorithm',
          ],
        ),
        HeaderBlock('Poikilothermia'),
        BulletCardBlock(
          title: 'Temperature Dysregulation',
          themeColor: const Color(0xFFEA580C),
          backgroundColor: const Color(0xFFFFF7ED),
          points: [
            'Injuries above T8 lose ability to regulate body temperature',
            'Central temperature regulation center is in the hypothalamus',
            'Hypothalamus sends signals via spinal cord → interrupted in SCI',
            'Below the injury: cannot sweat (no cooling) and cannot shiver/vasoconstrict (no warming)',
            'Body temperature varies with environmental temperature (poikilothermia)',
            'Risk of hypothermia in cold environments and hyperthermia in hot environments',
            'Management: environmental temperature control, appropriate clothing, monitoring',
            'Can mimic fever — always rule out infection before attributing temperature elevation to poikilothermia',
          ],
        ),
        PearlBlock(
          'Board Pearl: Fever vs Poikilothermia',
          'In SCI patients above T8, elevated body temperature can be from either infection OR poikilothermia (environmental exposure). Always work up for infection first. Key clinical pearl: poikilothermic temperature elevation responds to environmental cooling; infectious fever does not respond as readily and has other associated signs (elevated WBC, localizing symptoms).',
        ),
        HeaderBlock('Key Fracture Pearls for Pathophysiology'),
        PearlBlock(
          'Board Pearl: Chance Fracture & Abdominal Injuries',
          'Chance (flexion-distraction) fractures at T12-L2 are associated with intra-abdominal injuries (solid organ, hollow viscus) in up to 50% of cases, typically from lap seatbelt mechanism. Always evaluate the abdomen when a Chance fracture is identified.',
        ),
        PearlBlock(
          'Board Pearl: SCIWORA — Pediatric Spine Elasticity',
          'The pediatric vertebral column can stretch up to 5 cm without disruption, but the spinal cord ruptures after only 5-6 mm of stretch. This mismatch explains why children sustain cord injury without radiographic abnormality (SCIWORA). More severe neurologic injury and higher cervical levels occur in children under 8 years.',
        ),
        PearlBlock(
          'Board Pearl: Odontoid Type II Nonunion',
          'Type II odontoid fractures have a nonunion rate of 26-36% in elderly patients due to poor blood supply at the dens base and osteoporotic bone. Elderly patients may require surgical fixation (anterior odontoid screw or posterior C1-C2 fusion) rather than halo immobilization.',
        ),
        PearlBlock(
          'Board Pearl: SOMI Brace Limitation',
          'The SOMI brace provides excellent flexion restriction (93%) but poor extension control (only 42%). It is NOT appropriate for extension-type injuries. The halo vest provides the most rigid external immobilization and is best for upper cervical injuries (C1-C2).',
        ),
        PearlBlock(
          'Board Pearl: Halo Vest Complications',
          'Halo vest complications include: pin loosening, pin site infection, skull penetration (especially in osteoporotic bone and children), ring migration, pressure injuries under the vest, reduced pulmonary function, dysphagia, and pin discomfort. In elderly patients, halo use is associated with higher complication and mortality rates compared to surgical fixation.',
        ),
      ],
    ),
  ],
);
