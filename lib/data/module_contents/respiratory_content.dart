import 'package:flutter/material.dart';
import '../models/topic_content_model.dart';

final TopicData respiratoryContent = TopicData(
  id: 'respiratory',
  title: 'Respiratory Management',
  tabs: [
    TopicTab(
      title: 'Level-Dependent Function',
      blocks: [
        HeaderBlock('Respiratory Muscle Innervation'),
        TextBlock(
          'Respiratory compromise is the leading cause of morbidity and mortality in acute SCI. The degree of respiratory impairment directly correlates with the level of injury, as respiratory muscles are innervated at specific spinal cord levels.',
          isIntro: true,
        ),
        TableBlock(
          title: 'Respiratory Muscles by Innervation Level',
          columns: ['Muscle', 'Innervation', 'Function'],
          rows: [
            ['Sternocleidomastoid', 'CN XI (spinal accessory) + C2-C3', 'Accessory muscle of inspiration'],
            ['Trapezius', 'CN XI + C3-C4', 'Stabilizes shoulder for accessory muscle use'],
            ['Diaphragm', 'C3, C4, C5 (phrenic nerve)', 'Primary muscle of inspiration (generates 65-75% of tidal volume)'],
            ['Scalenes', 'C3-C8', 'Elevate upper ribs; accessory inspiratory muscles'],
            ['External intercostals', 'T1-T11', 'Elevate ribs during inspiration (bucket-handle motion)'],
            ['Internal intercostals', 'T1-T11', 'Depress ribs during forced expiration'],
            ['Abdominal muscles (rectus, obliques, transversus)', 'T6-T12', 'Forced expiration, cough, Valsalva'],
          ],
        ),
        MnemonicBlock(
          'Phrenic Nerve Mnemonic',
          'C3, 4, 5 keeps the diaphragm alive! The phrenic nerve is the single most important nerve for breathing. Injuries at C3 and above typically require mechanical ventilation.',
        ),
        TableBlock(
          title: 'Respiratory Impact by Injury Level',
          columns: ['Level', 'Respiratory Muscles Available', 'FVC (% predicted)', 'Cough', 'Ventilator Need'],
          rows: [
            ['C1-C2', 'None (possibly SCM if CN XI intact)', '~5-10%', 'Absent', 'Full-time ventilator dependent'],
            ['C3-C4', 'Partial or weak diaphragm, accessory muscles', '~20-30%', 'Very weak', 'Often ventilator dependent initially; some may wean'],
            ['C5-C6', 'Full diaphragm, accessory muscles', '~35-50%', 'Weak (no abdominals)', 'Usually not ventilator dependent; may need BiPAP at night'],
            ['C7-C8', 'Diaphragm, partial intercostals', '~50-60%', 'Weak', 'Rarely needs ventilator support'],
            ['T1-T6', 'Diaphragm, some intercostals', '~60-80%', 'Moderate', 'Not ventilator dependent'],
            ['T7-T12', 'Diaphragm, intercostals, partial abdominals', '~80-90%', 'Near normal', 'Not ventilator dependent'],
            ['Lumbar/Sacral', 'All respiratory muscles intact', '~Normal', 'Normal', 'No respiratory compromise'],
          ],
        ),
        PearlBlock(
          'Board Pearl: Paradoxical Breathing',
          'In cervical SCI with paralyzed intercostals, the diaphragm is the sole functioning respiratory muscle. During inspiration, the diaphragm descends, but the paralyzed chest wall collapses inward (paradoxical breathing pattern). This is the hallmark respiratory pattern of high cervical SCI. An abdominal binder can improve diaphragmatic efficiency by providing a stable base for the diaphragm to push against.',
        ),
        BulletCardBlock(
          title: 'Key Respiratory Physiology Points',
          themeColor: const Color(0xFF6366F1),
          backgroundColor: const Color(0xFFEEF2FF),
          points: [
            'FVC is reduced in proportion to the level of injury',
            'ERV (expiratory reserve volume) is most affected (requires abdominal muscles)',
            'RV (residual volume) is increased (air trapping due to weak expiration)',
            'TLC is reduced',
            'FVC may paradoxically IMPROVE in supine position in cervical SCI (gravity assists diaphragm via abdominal contents)',
            'Sleep-disordered breathing is common (up to 60% of cervical SCI patients)',
          ],
        ),
        PearlBlock(
          'Board Pearl: Supine vs Sitting FVC',
          'In cervical SCI, FVC may be 15-20% HIGHER in the supine position compared to sitting. This is because gravity pushes the abdominal contents cephalad against the diaphragm, placing it at a better mechanical advantage. This is the OPPOSITE of normal (where supine FVC is slightly lower). This is a frequently tested concept.',
        ),
      ],
    ),
    TopicTab(
      title: 'Ventilator Management',
      blocks: [
        HeaderBlock('Mechanical Ventilation & Weaning'),
        TextBlock(
          'Patients with high cervical SCI (C1-C4) may require mechanical ventilation acutely. Ventilator weaning is an important rehabilitation goal and should be pursued aggressively when appropriate.',
          isIntro: true,
        ),
        BulletCardBlock(
          title: 'Indications for Mechanical Ventilation',
          themeColor: const Color(0xFFDC2626),
          backgroundColor: const Color(0xFFFEF2F2),
          points: [
            'FVC <10-15 mL/kg (or < 1 liter)',
            'Negative inspiratory force (NIF) weaker than -20 cmH2O',
            'PaCO2 >50 mmHg with respiratory acidosis',
            'PaO2 <60 mmHg on supplemental O2',
            'Clinical signs: accessory muscle use, respiratory fatigue, paradoxical breathing',
            'Progressive decline in respiratory function (ascending edema in acute phase)',
          ],
        ),
        BulletCardBlock(
          title: 'Ventilator Weaning Protocol',
          themeColor: const Color(0xFF059669),
          backgroundColor: const Color(0xFFECFDF5),
          points: [
            'Progressive ventilator-free breathing (PVFB) is the standard approach',
            'Start with short periods of spontaneous breathing (5-15 minutes)',
            'Gradually increase free breathing time as tolerated',
            'Monitor closely: SpO2, tidal volume, respiratory rate, heart rate',
            'Rest on full ventilatory support between trials (especially at night)',
            'FVC >10 mL/kg and NIF < -20 cmH2O are favorable for weaning',
            'Inspiratory muscle training (IMT) may facilitate weaning',
            'Most C3-C4 patients can achieve some ventilator-free time',
            'C1-C2 complete injuries usually remain ventilator dependent',
          ],
        ),
        TableBlock(
          title: 'Weaning Readiness Criteria',
          columns: ['Parameter', 'Target for Weaning'],
          rows: [
            ['FVC', '>10-15 mL/kg'],
            ['NIF (MIP)', '< -20 cmH2O (more negative = better)'],
            ['Tidal volume', '>5 mL/kg spontaneous'],
            ['Respiratory rate', '<25 breaths/min during trial'],
            ['SpO2', '>95% on room air or baseline O2'],
            ['PaCO2', '<45 mmHg or stable at baseline'],
            ['Medical stability', 'No active infection, fever, or hemodynamic instability'],
          ],
        ),
        BulletCardBlock(
          title: 'Tracheostomy Considerations',
          themeColor: const Color(0xFF7C3AED),
          backgroundColor: const Color(0xFFF5F3FF),
          points: [
            'Early tracheostomy (within 7-10 days) is recommended for patients expected to require prolonged ventilation',
            'Facilitates ventilator weaning, pulmonary toilet, and oral hygiene',
            'Reduces work of breathing compared to endotracheal tube',
            'Allows for speaking valve use (Passy-Muir) for phonation',
            'Facilitates oral feeding when appropriate',
            'Decannulation may be possible as respiratory function improves',
          ],
        ),
        PearlBlock(
          'Board Pearl: Phrenic Nerve Pacing',
          'Phrenic nerve pacing (diaphragm pacing) is an option for patients with intact phrenic nerve and diaphragm (C1-C2 injury with preserved anterior horn cells at C3-C5). It allows ventilator-free breathing by electrically stimulating the phrenic nerve or diaphragm. Requires intact lower motor neurons at C3-C5. Does NOT work if phrenic nerve or anterior horn cells are destroyed.',
        ),
      ],
    ),
    TopicTab(
      title: 'Secretion Clearance',
      blocks: [
        HeaderBlock('Airway Clearance Techniques'),
        TextBlock(
          'Ineffective cough is a major contributor to respiratory morbidity in SCI. The abdominal muscles (T6-T12) are critical for generating the high expiratory flow rates needed for an effective cough. Without these muscles, secretion clearance is severely compromised.',
          isIntro: true,
        ),
        BulletCardBlock(
          title: 'Manual Assisted Cough Techniques',
          themeColor: const Color(0xFF3B82F6),
          backgroundColor: const Color(0xFFEFF6FF),
          points: [
            'Manually assisted cough (quad cough): caregiver provides abdominal thrust timed with patient\'s cough effort',
            'Self-assisted cough: patient uses arm/hand pressure on abdomen (if able)',
            'Most effective when patient can generate some inspiratory volume',
            'Coordinate thrust with glottis opening for maximum flow',
            'Train patient and caregivers in proper technique',
            'Abdominal binder provides passive support during cough',
          ],
        ),
        BulletCardBlock(
          title: 'Mechanical Insufflation-Exsufflation (MI-E)',
          themeColor: const Color(0xFF0D9488),
          backgroundColor: const Color(0xFFF0FDFA),
          points: [
            'Also known as CoughAssist device',
            'Delivers positive pressure inspiration (30-50 cmH2O) followed by rapid negative pressure (suction) to simulate cough',
            'Typical settings: +40/-40 cmH2O, 2-3 second insufflation, 2-3 second exsufflation',
            'More effective than suctioning for secretion clearance',
            'Can be used via mask, mouthpiece, or tracheostomy',
            'Recommended for patients with peak cough flow <270 L/min',
            'Use during acute respiratory infections to prevent pneumonia',
          ],
        ),
        BulletCardBlock(
          title: 'Other Airway Clearance Modalities',
          themeColor: const Color(0xFFEA580C),
          backgroundColor: const Color(0xFFFFF7ED),
          points: [
            'Chest physiotherapy (CPT): percussion, vibration, and postural drainage',
            'High-frequency chest wall oscillation (HFCWO/The Vest): vibrates secretions loose',
            'Intrapulmonary percussive ventilation (IPV): delivers mini-bursts of air',
            'Suctioning (orotracheal or via trach): use when other methods insufficient',
            'Bronchoscopy: for mucus plugging not cleared by other methods',
            'Nebulized saline or mucolytics: thin secretions for easier clearance',
            'Incentive spirometry: maintain inspiratory volumes (glossopharyngeal breathing for high cervical)',
          ],
        ),
        PearlBlock(
          'Board Pearl: Respiratory Complications',
          'Pneumonia and atelectasis are the most common respiratory complications in SCI. Respiratory disease is the #1 cause of death across ALL levels of SCI. Prevention through aggressive pulmonary toilet, secretion management, flu/pneumonia vaccination, and abdominal binders is essential. Sleep apnea screening should be performed for cervical SCI patients.',
        ),
        TableBlock(
          title: 'Respiratory Complication Prevention',
          columns: ['Complication', 'Risk Factors', 'Prevention'],
          rows: [
            ['Atelectasis', 'Weak cough, immobility, shallow breathing', 'Incentive spirometry, MI-E, assisted cough, positioning'],
            ['Pneumonia', 'Aspiration risk, poor secretion clearance', 'Aggressive pulmonary toilet, head elevation, vaccination'],
            ['Mucus plugging', 'Thick secretions, dehydration, weak cough', 'Hydration, nebulized saline, MI-E, CPT, suctioning'],
            ['Sleep apnea', 'Cervical SCI, obesity, opioid use', 'Sleep study screening, CPAP/BiPAP if indicated'],
            ['PE', 'DVT from immobility', 'DVT prophylaxis (LMWH, compression)'],
          ],
        ),
        BulletCardBlock(
          title: 'Abdominal Binder Benefits',
          themeColor: const Color(0xFF059669),
          backgroundColor: const Color(0xFFECFDF5),
          points: [
            'Substitutes for paralyzed abdominal muscles',
            'Improves FVC in the upright position by supporting the diaphragm',
            'Increases expiratory reserve volume and cough effectiveness',
            'Helps reduce paradoxical breathing pattern',
            'Should be applied in supine position before sitting up',
            'Worn during daytime upright activities; removed for sleep (supine breathing is already better)',
            'Improves speech and voice volume',
          ],
        ),
      ],
    ),
  ],
);
