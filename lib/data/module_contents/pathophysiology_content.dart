import 'package:flutter/material.dart';
import '../models/topic_content_model.dart';

final TopicData pathophysiologyContent = TopicData(
  id: 'pathophysiology',
  title: 'SCI Pathophysiology',
  tabs: [
    TopicTab(
      title: 'Primary Injury',
      blocks: [
        HeaderBlock('Primary Mechanical Injury'),
        TextBlock(
          'Primary injury refers to the initial mechanical damage to the spinal cord at the moment of trauma. This damage is irreversible and sets the stage for secondary injury cascades. Understanding the biomechanics of injury helps predict injury patterns.',
          isIntro: true,
        ),
        BulletCardBlock(
          title: 'Mechanisms of Primary Injury',
          themeColor: const Color(0xFFDC2626),
          backgroundColor: const Color(0xFFFEF2F2),
          points: [
            'Compression: burst fractures, disc herniation, epidural hematoma',
            'Distraction: hyperextension, hyperflexion leading to stretching of the cord',
            'Laceration/Transection: penetrating trauma (knife, bullet), sharp bone fragments',
            'Contusion: most common mechanism; bruising of cord without complete disruption',
            'Concussion: transient neurological dysfunction without structural damage',
          ],
        ),
        TableBlock(
          title: 'Biomechanical Injury Patterns',
          columns: ['Mechanism', 'Fracture Pattern', 'Associated SCI Syndrome'],
          rows: [
            ['Hyperflexion', 'Anterior wedge compression, teardrop fracture', 'Anterior cord syndrome'],
            ['Hyperextension', 'Hangman fracture (C2), posterior element fractures', 'Central cord syndrome (esp. with spondylosis)'],
            ['Axial compression', 'Burst fracture (Jefferson C1, thoracolumbar)', 'Variable; retropulsed bone causes anterior cord compression'],
            ['Flexion-rotation', 'Facet dislocation (unilateral or bilateral)', 'Brown-Sequard (unilateral) or complete'],
            ['Distraction', 'Chance fracture (lap belt, thoracolumbar junction)', 'Variable cord or cauda equina injury'],
            ['Penetrating', 'None typical', 'Brown-Sequard or complete, depending on trajectory'],
          ],
        ),
        PearlBlock(
          'Board Pearl: Hyperextension & Central Cord',
          'Central cord syndrome most commonly results from hyperextension injury in elderly patients with pre-existing cervical spondylosis. The narrowed canal combined with inward buckling of the ligamentum flavum compresses the central cord. MRI may show no fracture.',
        ),
        BulletCardBlock(
          title: 'Pathological Changes at the Cellular Level',
          themeColor: const Color(0xFF7C3AED),
          backgroundColor: const Color(0xFFF5F3FF),
          points: [
            'Immediate disruption of cell membranes (neurons, glia, endothelium)',
            'Hemorrhage within the gray matter (central hemorrhagic necrosis)',
            'Axonal shearing and disruption of myelin sheaths',
            'Disruption of the blood-spinal cord barrier',
            'Gray matter is more susceptible than white matter (higher metabolic demand)',
            'Damage extends centrifugally from the gray matter outward over hours to days',
          ],
        ),
      ],
    ),
    TopicTab(
      title: 'Secondary Injury',
      blocks: [
        HeaderBlock('Secondary Injury Cascade'),
        TextBlock(
          'Secondary injury refers to the cascade of biochemical, cellular, and molecular events that occur in the hours to weeks following primary injury. These processes expand the zone of tissue damage beyond the initial injury site and represent potential therapeutic targets.',
          isIntro: true,
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
            'Progressive edema compresses adjacent tissue',
            'Blood-spinal cord barrier breakdown worsens edema',
          ],
        ),
        BulletCardBlock(
          title: 'Biochemical Cascades',
          themeColor: const Color(0xFF6366F1),
          backgroundColor: const Color(0xFFEEF2FF),
          points: [
            'Excitotoxicity: excessive glutamate release activates NMDA/AMPA receptors',
            'Calcium influx: triggers destructive intracellular enzyme activation',
            'Free radical formation: lipid peroxidation damages cell membranes',
            'Arachidonic acid cascade: prostaglandins, thromboxanes, leukotrienes',
            'Nitric oxide: excessive production by iNOS causes tissue damage',
            'Potassium efflux: disrupts membrane potential and neural signaling',
          ],
        ),
        BulletCardBlock(
          title: 'Inflammatory Response',
          themeColor: const Color(0xFFEA580C),
          backgroundColor: const Color(0xFFFFF7ED),
          points: [
            'Neutrophil infiltration within hours (peak 24-48 hours)',
            'Macrophage/microglial activation (peak at 5-7 days)',
            'Release of pro-inflammatory cytokines: TNF-alpha, IL-1beta, IL-6',
            'Dual role: damaging to neurons but necessary for debris clearance',
            'Chronic inflammation can persist for months to years',
            'Astrocytic scar (glial scar) forms at the injury border, inhibiting axonal regeneration',
          ],
        ),
        BulletCardBlock(
          title: 'Apoptosis (Programmed Cell Death)',
          themeColor: const Color(0xFF7C3AED),
          backgroundColor: const Color(0xFFF5F3FF),
          points: [
            'Occurs in neurons and oligodendrocytes remote from the injury epicenter',
            'Peak activity at 7-14 days post-injury',
            'Oligodendrocyte apoptosis leads to secondary demyelination',
            'Can extend the lesion over multiple spinal segments',
            'Caspase-dependent and caspase-independent pathways',
            'Potential therapeutic target for neuroprotection',
          ],
        ),
        PearlBlock(
          'Board Pearl: Secondary Injury',
          'The secondary injury cascade is the rationale for early surgical decompression and medical management. The STASCIS trial showed that early surgery (<24 hours) is associated with improved neurological outcomes compared to late surgery. Maintaining MAP 85-90 mmHg for 7 days is recommended to optimize spinal cord perfusion.',
        ),
        TableBlock(
          title: 'Timeline of Secondary Injury',
          columns: ['Phase', 'Timing', 'Key Events'],
          rows: [
            ['Acute', '0-2 hours', 'Hemorrhage, vasospasm, excitotoxicity, ionic imbalance'],
            ['Subacute', '2-48 hours', 'Edema, inflammation (neutrophils), continued ischemia, free radicals'],
            ['Intermediate', '2 days-2 weeks', 'Macrophage infiltration, apoptosis, demyelination, cyst formation begins'],
            ['Chronic', '>2 weeks', 'Wallerian degeneration, glial scar maturation, syrinx formation, axonal die-back'],
          ],
        ),
        BulletCardBlock(
          title: 'Neuroprotective Strategies',
          themeColor: const Color(0xFF059669),
          backgroundColor: const Color(0xFFECFDF5),
          points: [
            'Blood pressure augmentation: MAP 85-90 mmHg for 5-7 days',
            'Early surgical decompression: within 24 hours when feasible',
            'Avoidance of hypoxia and hyperthermia',
            'Methylprednisolone: no longer standard of care (NASCIS trials controversial)',
            'Hypothermia: under investigation, not standard',
            'Riluzole (sodium channel blocker): clinical trials ongoing',
            'Minocycline (anti-inflammatory): clinical trials ongoing',
          ],
        ),
        PearlBlock(
          'Board Pearl: Methylprednisolone',
          'The NASCIS II/III trials suggested benefit of methylprednisolone within 8 hours of injury, but the studies had significant methodological flaws. Current guidelines from AAOS and AOSpine recommend AGAINST routine use of methylprednisolone. It is considered an option by some (not a standard or guideline), and the risk of complications (infection, GI bleeding) may outweigh benefits.',
        ),
      ],
    ),
    TopicTab(
      title: 'Spinal vs Neurogenic Shock',
      blocks: [
        HeaderBlock('Spinal Shock vs Neurogenic Shock'),
        TextBlock(
          'These two conditions are frequently confused on board examinations. Spinal shock is a neurological phenomenon (areflexia), while neurogenic shock is a cardiovascular phenomenon (hemodynamic instability). They often coexist but are distinct entities.',
          isIntro: true,
        ),
        ComparisonCardBlock(
          title: 'Spinal Shock',
          themeColor: const Color(0xFF3B82F6),
          backgroundColor: const Color(0xFFEFF6FF),
          icon: Icons.flash_off,
          description: 'Transient loss of all spinal cord function (motor, sensory, reflex, autonomic) below the level of injury following acute SCI.',
          keyPoints: [
            'Loss of all reflexes below the level of injury (areflexia)',
            'Flaccid paralysis (even in UMN injuries)',
            'Absent bulbocavernosus reflex (BCR)',
            'Atonic bladder and bowel',
            'Duration: hours to weeks (average resolution 4-12 weeks)',
            'Resolution is marked by return of the bulbocavernosus reflex',
            'Delayed plantar response may be first reflex to return (in some studies)',
            'Does NOT indicate complete injury; must wait for resolution before determining completeness',
          ],
        ),
        ComparisonCardBlock(
          title: 'Neurogenic Shock',
          themeColor: const Color(0xFFDC2626),
          backgroundColor: const Color(0xFFFEF2F2),
          icon: Icons.heart_broken,
          description: 'Hemodynamic instability caused by loss of sympathetic tone, resulting in hypotension and bradycardia.',
          keyPoints: [
            'Occurs with injuries at T6 and above (loss of sympathetic outflow T1-L2)',
            'Classic triad: hypotension + bradycardia + peripheral vasodilation (warm skin)',
            'Due to unopposed vagal (parasympathetic) tone',
            'Distinct from hypovolemic/hemorrhagic shock (which causes tachycardia and cold skin)',
            'Duration: typically 1-3 weeks, but can last up to 5 weeks',
            'Treatment: IV fluids (judicious), vasopressors (norepinephrine, phenylephrine)',
            'Atropine for symptomatic bradycardia',
            'Most common in cervical and high thoracic injuries',
          ],
        ),
        PearlBlock(
          'Board Pearl: BCR & Spinal Shock',
          'The bulbocavernosus reflex (BCR) is the first reflex to return after spinal shock. It is tested by squeezing the glans penis or clitoris (or tugging on the Foley catheter) and feeling for anal sphincter contraction. Return of BCR signals end of spinal shock. If the exam remains AIS A after BCR return, the injury is likely truly complete.',
        ),
        TableBlock(
          title: 'Differentiating Spinal vs Neurogenic vs Hemorrhagic Shock',
          columns: ['Feature', 'Spinal Shock', 'Neurogenic Shock', 'Hemorrhagic Shock'],
          rows: [
            ['Definition', 'Transient areflexia', 'Loss of sympathetic tone', 'Blood volume loss'],
            ['Heart rate', 'Normal or bradycardia', 'Bradycardia', 'Tachycardia'],
            ['Blood pressure', 'Normal or low', 'Hypotension', 'Hypotension'],
            ['Skin', 'Variable', 'Warm, dry, flushed', 'Cool, clammy, pale'],
            ['Reflexes', 'Absent below level', 'Variable', 'Normal or hyperactive'],
            ['Level required', 'Any SCI level', 'T6 and above', 'Any trauma'],
            ['Treatment', 'Observation, wait for resolution', 'Fluids, vasopressors, atropine', 'Volume resuscitation, hemorrhage control'],
          ],
        ),
        BulletCardBlock(
          title: 'Phases of Spinal Shock (Ditunno Model)',
          themeColor: const Color(0xFF0D9488),
          backgroundColor: const Color(0xFFF0FDFA),
          points: [
            'Phase 1 (0-24 hours): Areflexia/hyporeflexia. Complete loss of reflexes below the injury level.',
            'Phase 2 (1-3 days): Initial reflex return. Denervation supersensitivity. Cutaneous reflexes return (delayed plantar, bulbocavernosus, cremasteric).',
            'Phase 3 (1-4 weeks): Early hyperreflexia. Deep tendon reflexes return. Detrusor hyperreflexia may begin.',
            'Phase 4 (1-12 months): Late hyperreflexia/spasticity. UMN pattern established with hyperactive reflexes, clonus, Babinski sign, and spasticity.',
          ],
        ),
        PearlBlock(
          'Board Pearl: Important Distinction',
          'Always rule out hemorrhagic shock before attributing hypotension to neurogenic shock in trauma patients. Polytrauma is common in SCI. Neurogenic shock causes WARM skin and BRADYCARDIA, while hemorrhagic shock causes COOL skin and TACHYCARDIA. The two can coexist, making clinical assessment challenging.',
        ),
      ],
    ),
  ],
);
