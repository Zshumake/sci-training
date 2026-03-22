import '../../core/models/quiz_model.dart';

class SCIQuizBank {
  static const List<QuizQuestion> _allQuestions = [
    // =====================================================================
    // MODULE: sci-fundamentals
    // =====================================================================
    QuizQuestion(
      question:
          'A 28-year-old male is involved in a diving accident and presents with complete loss of motor and sensory function below C6. At 24 hours post-injury, he has absent bulbocavernosus reflex. What is the most accurate statement regarding his prognosis?',
      options: [
        'He has a complete SCI and will not recover any function below the level of injury',
        'Prognosis cannot be determined until spinal shock has resolved',
        'The absent bulbocavernosus reflex confirms an upper motor neuron lesion',
        'He should be classified as ASIA A at this time, and this classification is definitive',
      ],
      correctIndex: 1,
      explanation:
          'The bulbocavernosus reflex is the first reflex to return after spinal shock, typically within 24-48 hours. Its absence at 24 hours suggests spinal shock is still present. The ASIA classification should not be considered definitive until spinal shock has resolved, as some patients initially presenting as complete injuries may be reclassified as incomplete once spinal shock resolves. The 72-hour ASIA exam is the most reliable early predictor of neurological outcome.',
      moduleId: 'sci-fundamentals',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'Which of the following best distinguishes spinal shock from neurogenic shock?',
      options: [
        'Spinal shock involves hypotension and bradycardia; neurogenic shock involves areflexia',
        'Spinal shock is the temporary loss of spinal reflex activity below the level of injury; neurogenic shock is hemodynamic instability from loss of sympathetic tone',
        'Spinal shock only occurs in cervical injuries; neurogenic shock occurs at any level',
        'Spinal shock lasts 24 hours; neurogenic shock lasts weeks to months',
      ],
      correctIndex: 1,
      explanation:
          'Spinal shock refers to the temporary loss or depression of all spinal reflex activity below the level of injury, including the bulbocavernosus reflex. It is a neurological phenomenon. Neurogenic shock is a hemodynamic condition characterized by hypotension and bradycardia resulting from loss of sympathetic vascular tone, typically occurring with injuries at T6 and above. These are distinct entities that can occur simultaneously.',
      moduleId: 'sci-fundamentals',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'The most common etiology of traumatic spinal cord injury in the United States is:',
      options: [
        'Falls',
        'Motor vehicle accidents',
        'Violence/gunshot wounds',
        'Sports and recreation',
      ],
      correctIndex: 1,
      explanation:
          'Motor vehicle accidents remain the leading cause of traumatic SCI in the United States, accounting for approximately 39% of cases. Falls are the second most common cause (approximately 31%) and have been increasing in proportion, particularly among the elderly population. Violence (including gunshot wounds) accounts for approximately 13%, and sports/recreation approximately 8%.',
      moduleId: 'sci-fundamentals',
      difficulty: 'basic',
    ),
    QuizQuestion(
      question:
          'What is the most common neurological level of injury in traumatic SCI?',
      options: [
        'T12',
        'C5',
        'C4',
        'L1',
      ],
      correctIndex: 1,
      explanation:
          'C5 is the most common single neurological level of injury in traumatic SCI. Cervical injuries overall account for approximately 60% of all traumatic SCIs. The cervical spine is particularly vulnerable due to its mobility and the relatively small size of the spinal canal in relation to the spinal cord.',
      moduleId: 'sci-fundamentals',
      difficulty: 'basic',
    ),

    // =====================================================================
    // MODULE: classification-asia
    // =====================================================================
    QuizQuestion(
      question:
          'A patient has voluntary anal contraction but no motor or sensory function more than three levels below the motor level on either side. What is the ASIA Impairment Scale grade?',
      options: [
        'ASIA A',
        'ASIA B',
        'ASIA C',
        'ASIA D',
      ],
      correctIndex: 2,
      explanation:
          'ASIA C is defined as an incomplete injury where motor function is preserved below the neurological level, and more than half of key muscle functions below the single neurological level of injury have a muscle grade less than 3 (i.e., less than antigravity). The presence of voluntary anal contraction alone (with sacral sparing) makes this at least ASIA B (incomplete), and the presence of any motor function below the level makes it at least ASIA C. Since no motor function exists more than 3 levels below, fewer than half of key muscles are grade 3 or better, confirming ASIA C.',
      moduleId: 'classification-asia',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'Which dermatome is tested at the lateral aspect of the antecubital fossa (lateral elbow)?',
      options: [
        'C4',
        'C5',
        'C6',
        'C7',
      ],
      correctIndex: 1,
      explanation:
          'C5 is the key sensory point tested at the lateral (outer) aspect of the antecubital fossa, over the lateral epicondyle region. Key ASIA sensory points: C3=supraclavicular fossa, C4=top of the AC joint, C5=lateral antecubital fossa, C6=thumb dorsal surface, C7=middle finger dorsal surface, C8=little finger dorsal surface.',
      moduleId: 'classification-asia',
      difficulty: 'intermediate',
    ),
    QuizQuestion(
      question:
          'The key sensory point for the T4 dermatome is located at:',
      options: [
        'The sternal angle',
        'The nipple line',
        'The xiphoid process',
        'The costal margin',
      ],
      correctIndex: 1,
      explanation:
          'T4 corresponds to the nipple line. Other key thoracic dermatome landmarks: T2=apex of axilla, T3=third intercostal space, T6=xiphoid process, T10=umbilicus, T12=inguinal ligament. These landmarks are essential for determining sensory level in the ISNCSCI examination.',
      moduleId: 'classification-asia',
      difficulty: 'basic',
    ),
    QuizQuestion(
      question:
          'A patient with SCI has sensory preservation at S4-S5 but no motor function below the neurological level. Deep anal pressure is present but there is no voluntary anal contraction. What is the ASIA Impairment Scale classification?',
      options: [
        'ASIA A',
        'ASIA B',
        'ASIA C',
        'ASIA D',
      ],
      correctIndex: 1,
      explanation:
          'ASIA B (sensory incomplete) is defined as sensory but not motor function preserved below the neurological level, including the sacral segments S4-S5. The key distinction: ASIA A requires NO sensory or motor function at S4-S5. The presence of deep anal pressure (sensory at S4-S5) with absence of voluntary anal contraction (no motor at S4-S5) and no motor function below the neurological level defines ASIA B.',
      moduleId: 'classification-asia',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'Which key muscle is used to determine the C7 motor level?',
      options: [
        'Wrist extensors (ECR)',
        'Elbow extensors (triceps)',
        'Finger flexors (FDP)',
        'Finger abductors (ADM)',
      ],
      correctIndex: 1,
      explanation:
          'The key muscle for C7 is the elbow extensors (triceps). The ISNCSCI key muscles: C5=elbow flexors (biceps, brachialis), C6=wrist extensors (ECRL, ECRB), C7=elbow extensors (triceps), C8=finger flexors to the middle finger (FDP), T1=small finger abductors (ADM), L2=hip flexors (iliopsoas), L3=knee extensors (quadriceps), L4=ankle dorsiflexors (tibialis anterior), L5=long toe extensors (EHL), S1=ankle plantarflexors (gastrocnemius, soleus).',
      moduleId: 'classification-asia',
      difficulty: 'intermediate',
    ),
    QuizQuestion(
      question:
          'In the ISNCSCI examination, the motor level is defined as:',
      options: [
        'The most caudal level with grade 5/5 strength',
        'The most caudal key muscle with at least grade 3/5 strength, provided all key muscles above are grade 5/5',
        'The most caudal key muscle with at least grade 3/5 strength, regardless of levels above',
        'The most caudal level with any motor function present',
      ],
      correctIndex: 1,
      explanation:
          'The motor level is determined by the most caudal key muscle that has a grade of at least 3/5 (antigravity), provided that the key muscles represented by segments above that level are judged to be normal (grade 5/5). This sequential testing requirement is critical - a muscle cannot define the motor level if muscles above it are not full strength.',
      moduleId: 'classification-asia',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'The key sensory point for the S1 dermatome is located at:',
      options: [
        'The dorsum of the foot at the third metatarsophalangeal joint',
        'The lateral heel (calcaneus)',
        'The medial malleolus',
        'The popliteal fossa',
      ],
      correctIndex: 1,
      explanation:
          'S1 is tested at the lateral heel (lateral calcaneus). Key lower extremity sensory points: L1=inguinal region (halfway between ASIS and symphysis), L2=anterior mid-thigh, L3=medial femoral condyle (medial knee), L4=medial malleolus, L5=dorsum of foot at third MTP joint, S1=lateral heel, S2=popliteal fossa, S3=ischial tuberosity, S4-S5=perianal area.',
      moduleId: 'classification-asia',
      difficulty: 'intermediate',
    ),

    // =====================================================================
    // MODULE: pathophysiology
    // =====================================================================
    QuizQuestion(
      question:
          'A patient presents with weakness greater in the upper extremities than the lower extremities, with sacral sensory sparing and bladder dysfunction. Which SCI syndrome is most likely?',
      options: [
        'Anterior cord syndrome',
        'Brown-Sequard syndrome',
        'Central cord syndrome',
        'Posterior cord syndrome',
      ],
      correctIndex: 2,
      explanation:
          'Central cord syndrome is characterized by motor weakness that is disproportionately greater in the upper extremities than the lower extremities, with variable sensory loss and bladder dysfunction. It is the most common incomplete SCI syndrome and typically occurs in older patients with cervical spondylosis after hyperextension injuries. The central location of the upper extremity fibers in the corticospinal tract makes them more vulnerable to central cord damage.',
      moduleId: 'pathophysiology',
      difficulty: 'intermediate',
    ),
    QuizQuestion(
      question:
          'A patient with a penetrating injury to the left side of the spinal cord presents with ipsilateral motor paralysis and loss of proprioception, with contralateral loss of pain and temperature sensation. This presentation is consistent with:',
      options: [
        'Central cord syndrome',
        'Anterior cord syndrome',
        'Brown-Sequard syndrome',
        'Cauda equina syndrome',
      ],
      correctIndex: 2,
      explanation:
          'Brown-Sequard syndrome (spinal cord hemisection) presents with ipsilateral loss of motor function (corticospinal tract), ipsilateral loss of proprioception and vibration (dorsal columns), and contralateral loss of pain and temperature sensation (spinothalamic tract, which crosses 1-2 levels above entry). It has the best prognosis of incomplete SCI syndromes, with approximately 90% of patients regaining ambulatory function.',
      moduleId: 'pathophysiology',
      difficulty: 'intermediate',
    ),
    QuizQuestion(
      question:
          'Which incomplete SCI syndrome has the worst prognosis for neurological recovery?',
      options: [
        'Central cord syndrome',
        'Brown-Sequard syndrome',
        'Anterior cord syndrome',
        'Posterior cord syndrome',
      ],
      correctIndex: 2,
      explanation:
          'Anterior cord syndrome has the worst prognosis of the incomplete SCI syndromes, with only about 10-20% of patients recovering functional motor ability. It involves damage to the anterior two-thirds of the spinal cord (corticospinal and spinothalamic tracts), resulting in loss of motor function and pain/temperature sensation below the level of injury, with preserved proprioception and vibration (dorsal columns). Common causes include anterior spinal artery occlusion, disc herniation, and burst fractures.',
      moduleId: 'pathophysiology',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'A patient presents with saddle anesthesia, areflexic bladder, and lower motor neuron findings in the lower extremities. The most likely diagnosis is:',
      options: [
        'Conus medullaris syndrome',
        'Cauda equina syndrome',
        'Central cord syndrome',
        'Anterior cord syndrome',
      ],
      correctIndex: 1,
      explanation:
          'Cauda equina syndrome involves injury to the lumbosacral nerve roots below the conus medullaris (typically below L1-L2 vertebral level). It presents with lower motor neuron signs (areflexia, flaccidity), saddle anesthesia, areflexic (LMN) bladder, and asymmetric findings. Compared to conus medullaris syndrome, cauda equina syndrome tends to have more asymmetric, radicular pain, and a better prognosis due to peripheral nerve regeneration potential.',
      moduleId: 'pathophysiology',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'Which feature best distinguishes conus medullaris syndrome from cauda equina syndrome?',
      options: [
        'Conus medullaris presents with asymmetric LMN findings; cauda equina presents with symmetric UMN findings',
        'Conus medullaris has sudden onset with symmetric findings and early bladder dysfunction; cauda equina has gradual onset with asymmetric findings and late bladder involvement',
        'Conus medullaris affects only motor function; cauda equina affects only sensory function',
        'Conus medullaris occurs above T12; cauda equina occurs above L1',
      ],
      correctIndex: 1,
      explanation:
          'Conus medullaris syndrome (injury to the sacral cord segments, typically at T12-L1 vertebral level) presents with sudden, bilateral symmetric findings, early bladder/bowel dysfunction, and may have both UMN and LMN features. Cauda equina syndrome (injury to nerve roots below the conus) presents with gradual, asymmetric findings, severe radicular pain, late bladder involvement, and purely LMN signs. The conus ends at approximately the L1-L2 vertebral level in adults.',
      moduleId: 'pathophysiology',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'Secondary injury in SCI involves all of the following mechanisms EXCEPT:',
      options: [
        'Glutamate excitotoxicity',
        'Free radical formation',
        'Mechanical transection of axons at the time of impact',
        'Ischemia from vasospasm and thrombosis',
      ],
      correctIndex: 2,
      explanation:
          'Mechanical transection of axons at the time of impact is a primary injury mechanism, not a secondary injury mechanism. Secondary injury refers to the cascade of biochemical, vascular, and cellular events that occur in the hours to weeks following the initial trauma. These include: ischemia (vasospasm, thrombosis, loss of autoregulation), excitotoxicity (glutamate release), free radical damage/lipid peroxidation, inflammatory cell infiltration, apoptosis, and demyelination. Understanding secondary injury is critical because it represents a therapeutic window for intervention.',
      moduleId: 'pathophysiology',
      difficulty: 'intermediate',
    ),

    // =====================================================================
    // MODULE: neurogenic-bladder
    // =====================================================================
    QuizQuestion(
      question:
          'The gold standard for bladder management in patients with spinal cord injury is:',
      options: [
        'Indwelling Foley catheter',
        'Suprapubic catheter',
        'Clean intermittent catheterization (CIC)',
        'Condom catheter with external drainage',
      ],
      correctIndex: 2,
      explanation:
          'Clean intermittent catheterization (CIC) is the gold standard for bladder management in SCI. It most closely mimics normal bladder filling and emptying, has the lowest rate of urological complications (UTIs, stones, renal deterioration, bladder cancer), and preserves bladder compliance. CIC should be performed every 4-6 hours, keeping volumes below 500 mL. Indwelling catheters carry significantly higher risks of UTIs, urethral erosion, bladder stones, and bladder cancer.',
      moduleId: 'neurogenic-bladder',
      difficulty: 'basic',
    ),
    QuizQuestion(
      question:
          'A patient with a T8 complete SCI (ASIA A) is most likely to have which type of neurogenic bladder?',
      options: [
        'Areflexic (LMN) bladder with low pressure',
        'Reflexic (UMN/spastic) bladder with detrusor overactivity',
        'Normal bladder function',
        'Mixed UMN-LMN bladder',
      ],
      correctIndex: 1,
      explanation:
          'Injuries above the sacral micturition center (S2-S4) result in an upper motor neuron (UMN/spastic/reflexic) bladder characterized by detrusor overactivity (involuntary contractions) and detrusor-sphincter dyssynergia (DSD). The bladder contracts reflexively against a closed sphincter, leading to high intravesical pressures, small capacity, and risk of vesicoureteral reflux and upper tract deterioration. T8 is well above the sacral micturition center, so a UMN bladder pattern is expected.',
      moduleId: 'neurogenic-bladder',
      difficulty: 'intermediate',
    ),
    QuizQuestion(
      question:
          'Which medication is most commonly used to treat detrusor overactivity in neurogenic bladder?',
      options: [
        'Bethanechol',
        'Oxybutynin',
        'Tamsulosin',
        'Desmopressin',
      ],
      correctIndex: 1,
      explanation:
          'Oxybutynin (an anticholinergic/antimuscarinic) is the most commonly used first-line medication for detrusor overactivity in neurogenic bladder. It reduces involuntary detrusor contractions, increases bladder capacity, and decreases intravesical pressures. Other antimuscarinics include tolterodine and solifenacin. Bethanechol is a cholinergic agonist used to stimulate bladder contraction (rarely used). Tamsulosin is an alpha-blocker used for bladder outlet obstruction. Desmopressin is used for nocturia.',
      moduleId: 'neurogenic-bladder',
      difficulty: 'intermediate',
    ),
    QuizQuestion(
      question:
          'A patient with a cauda equina injury (S2-S4 nerve root damage) would be expected to have which type of bladder dysfunction?',
      options: [
        'Detrusor overactivity with detrusor-sphincter dyssynergia',
        'Areflexic (flaccid) bladder with overflow incontinence',
        'Normal detrusor function with external sphincter spasticity',
        'Hyperreflexic detrusor with competent sphincter',
      ],
      correctIndex: 1,
      explanation:
          'Injury to the sacral micturition center (S2-S4) or the cauda equina nerve roots results in a lower motor neuron (LMN/areflexic/flaccid) bladder. The detrusor muscle cannot contract effectively, leading to urinary retention, a large-capacity bladder with high compliance, and overflow incontinence. The external urethral sphincter is also denervated (flaccid). Management includes CIC and possible Valsalva or Crede maneuver (though the latter is generally discouraged due to risk of reflux).',
      moduleId: 'neurogenic-bladder',
      difficulty: 'board',
    ),

    // =====================================================================
    // MODULE: neurogenic-bowel
    // =====================================================================
    QuizQuestion(
      question:
          'A patient with a C6 complete SCI (ASIA A) would be expected to have which type of neurogenic bowel?',
      options: [
        'Lower motor neuron (areflexic) bowel',
        'Upper motor neuron (reflexic) bowel',
        'Normal bowel function',
        'Mixed UMN-LMN bowel',
      ],
      correctIndex: 1,
      explanation:
          'Injuries above the conus medullaris (S2-S4 cord segments) result in an upper motor neuron (UMN/reflexic) bowel. The reflex arc is intact, so the rectum remains tonically contracted (increased tone of the external anal sphincter). The bowel program for UMN bowel utilizes chemical (suppository) and mechanical (digital stimulation) triggers to initiate reflex-mediated evacuation. A C6 injury is well above the conus, so a UMN bowel is expected.',
      moduleId: 'neurogenic-bowel',
      difficulty: 'intermediate',
    ),
    QuizQuestion(
      question:
          'Which bowel program technique is most appropriate for a patient with a lower motor neuron (LMN/areflexic) neurogenic bowel?',
      options: [
        'Bisacodyl suppository with digital stimulation',
        'Manual evacuation with Valsalva maneuver',
        'Senna tablets alone',
        'Transanal irrigation only',
      ],
      correctIndex: 1,
      explanation:
          'LMN (areflexic) bowel results from damage to the S2-S4 cord segments or cauda equina. There is loss of reflex-mediated peristalsis, a patulous (lax) anal sphincter, and risk of incontinence. The bowel program relies on manual evacuation (digital removal of stool), gentle Valsalva, and increased dietary fiber. Digital stimulation and suppositories are less effective because they rely on an intact reflex arc. Frequent, timed evacuations are important to prevent incontinence.',
      moduleId: 'neurogenic-bowel',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'Digital stimulation as part of a bowel program works by:',
      options: [
        'Directly mechanically removing stool from the rectum',
        'Stimulating the recto-colic reflex arc to initiate peristalsis',
        'Relaxing the puborectalis muscle',
        'Increasing colonic secretions',
      ],
      correctIndex: 1,
      explanation:
          'Digital stimulation involves gentle circular motion of a gloved, lubricated finger in the rectum. It works by stimulating the recto-colic reflex, which triggers peristalsis and relaxation of the internal anal sphincter, facilitating stool evacuation. This technique is effective in UMN (reflexic) bowel because the reflex arc (S2-S4) is intact. It is less effective in LMN bowel where the reflex arc is disrupted.',
      moduleId: 'neurogenic-bowel',
      difficulty: 'intermediate',
    ),

    // =====================================================================
    // MODULE: autonomic-dysreflexia
    // =====================================================================
    QuizQuestion(
      question:
          'A patient with C5 complete SCI suddenly develops a severe headache, blood pressure of 200/110 mmHg, and bradycardia. Profuse sweating is noted above the level of injury. The first step in management is:',
      options: [
        'Administer IV labetalol',
        'Sit the patient upright and loosen any restrictive clothing',
        'Administer sublingual nifedipine',
        'Insert a Foley catheter immediately',
      ],
      correctIndex: 1,
      explanation:
          'The first step in managing autonomic dysreflexia (AD) is to sit the patient upright (to induce orthostatic reduction in BP) and loosen any restrictive clothing or binders. The next step is to identify and remove the inciting stimulus. The most common trigger is bladder distension (check for kinked or blocked catheter, or perform straight catheterization with lidocaine jelly). If the bladder is not the cause, check for fecal impaction, skin issues, or other noxious stimuli below the level of injury. Pharmacologic treatment (nifedipine, nitropaste) is used if BP remains elevated after removing the stimulus.',
      moduleId: 'autonomic-dysreflexia',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'Autonomic dysreflexia occurs in patients with SCI at or above which level?',
      options: [
        'C4',
        'T6',
        'T10',
        'L1',
      ],
      correctIndex: 1,
      explanation:
          'Autonomic dysreflexia (AD) occurs in patients with SCI at or above T6. This is because the major splanchnic sympathetic outflow (T5-L2, with the greatest contribution from T6-T10) is below the level of injury and cannot be modulated by descending inhibitory pathways. Noxious stimuli below the level of injury trigger a massive sympathetic response causing vasoconstriction and hypertension. Above the level of injury, parasympathetic-mediated compensatory responses (via intact vagus nerve) cause bradycardia, flushing, and sweating.',
      moduleId: 'autonomic-dysreflexia',
      difficulty: 'basic',
    ),
    QuizQuestion(
      question:
          'The most common trigger for autonomic dysreflexia is:',
      options: [
        'Pressure injury',
        'Bladder distension',
        'Fecal impaction',
        'Ingrown toenail',
      ],
      correctIndex: 1,
      explanation:
          'Bladder distension is the most common trigger for autonomic dysreflexia, accounting for approximately 75-85% of episodes. The second most common trigger is bowel distension/fecal impaction. Other triggers include pressure injuries, urinary tract infections, bladder or kidney stones, tight clothing, temperature extremes, ingrown toenails, fractures, DVT, sexual activity, menstruation, and labor/delivery. Any noxious stimulus below the level of injury can potentially trigger AD.',
      moduleId: 'autonomic-dysreflexia',
      difficulty: 'basic',
    ),
    QuizQuestion(
      question:
          'If blood pressure remains dangerously elevated during an episode of autonomic dysreflexia despite removing the offending stimulus, which pharmacologic agent is most appropriate?',
      options: [
        'Oral clonidine',
        'IV phenylephrine',
        'Nifedipine (bite and swallow or topical nitroglycerin paste)',
        'Oral propranolol',
      ],
      correctIndex: 2,
      explanation:
          'If blood pressure remains elevated (systolic > 150 mmHg) after sitting upright and removing the offending stimulus, pharmacologic intervention is indicated. Nifedipine (10 mg capsule, bite and swallow - not sublingual due to risk of precipitous hypotension) or 2% nitroglycerin paste (1 inch applied to the skin above the level of injury, easily removed) are first-line agents. These are rapid-onset, short-acting vasodilators. Phenylephrine is a vasoconstrictor and would worsen hypertension. Nitroglycerin paste is preferred by some because it can be wiped off if BP drops too low.',
      moduleId: 'autonomic-dysreflexia',
      difficulty: 'board',
    ),

    // =====================================================================
    // MODULE: respiratory
    // =====================================================================
    QuizQuestion(
      question:
          'The diaphragm is innervated by the phrenic nerve, which arises from which spinal nerve roots?',
      options: [
        'C1-C3',
        'C3-C5',
        'C5-C7',
        'T1-T3',
      ],
      correctIndex: 1,
      explanation:
          'The phrenic nerve arises from C3, C4, and C5 nerve roots (primarily C4), as remembered by the mnemonic "C3, 4, 5 keeps the diaphragm alive." The diaphragm is the primary muscle of inspiration, responsible for approximately 65% of tidal volume. Injuries at C3 and above will typically require mechanical ventilation. Patients with C3-C5 injuries may have partial or complete diaphragm dysfunction depending on the completeness and exact level of injury.',
      moduleId: 'respiratory',
      difficulty: 'basic',
    ),
    QuizQuestion(
      question:
          'A patient with a C4 complete SCI has decreased vital capacity and weak cough. Which respiratory parameter is most likely to be PRESERVED?',
      options: [
        'Forced expiratory volume (FEV1)',
        'Expiratory reserve volume (ERV)',
        'Inspiratory capacity (using accessory muscles)',
        'Peak cough flow',
      ],
      correctIndex: 2,
      explanation:
          'In high cervical SCI (C4), the intercostal and abdominal muscles are paralyzed. However, the accessory muscles of inspiration (sternocleidomastoid innervated by CN XI, and upper trapezius innervated by CN XI and C3-C4) are preserved. These muscles can assist with inspiration, partially preserving inspiratory capacity. Expiratory function (ERV, FEV1, peak cough flow) is severely compromised because the abdominal muscles (T6-T12) and intercostal muscles (T1-T11) are paralyzed. This results in an ineffective cough, which is the leading cause of respiratory morbidity in SCI.',
      moduleId: 'respiratory',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'The leading cause of death in the first year after spinal cord injury is:',
      options: [
        'Urinary tract infections/sepsis',
        'Pulmonary embolism',
        'Respiratory complications (pneumonia, respiratory failure)',
        'Cardiovascular disease',
      ],
      correctIndex: 2,
      explanation:
          'Respiratory complications (pneumonia, atelectasis, respiratory failure) are the leading cause of death in the acute phase and first year after SCI, particularly in cervical and high thoracic injuries. Impaired cough, retained secretions, and atelectasis predispose to pneumonia. Long-term, cardiovascular disease and infections (including urinary sepsis) become leading causes of mortality. Pulmonary embolism is also a significant risk, especially in the first 3 months.',
      moduleId: 'respiratory',
      difficulty: 'basic',
    ),
    QuizQuestion(
      question:
          'An abdominal binder in a patient with tetraplegia improves respiratory function primarily by:',
      options: [
        'Increasing chest wall compliance',
        'Supporting the diaphragm in a mechanically advantageous position by preventing abdominal visceral descent',
        'Strengthening the intercostal muscles',
        'Reducing airway resistance',
      ],
      correctIndex: 1,
      explanation:
          'In tetraplegia, the abdominal muscles are paralyzed, and in the upright position, abdominal viscera descend due to gravity, pulling the diaphragm into a flattened position that is mechanically disadvantageous for contraction. An abdominal binder provides external support, preventing visceral descent and maintaining the diaphragm in a domed position, which improves its mechanical efficiency and increases vital capacity (by approximately 10-15%) and inspiratory capacity in the seated position.',
      moduleId: 'respiratory',
      difficulty: 'board',
    ),

    // =====================================================================
    // MODULE: cardiovascular
    // =====================================================================
    QuizQuestion(
      question:
          'A patient with an acute C5 complete SCI develops persistent hypotension (BP 80/50) with a heart rate of 52 bpm. The most likely diagnosis is:',
      options: [
        'Hypovolemic shock',
        'Cardiogenic shock',
        'Neurogenic shock',
        'Septic shock',
      ],
      correctIndex: 2,
      explanation:
          'Neurogenic shock presents with hypotension AND bradycardia (or inappropriately normal heart rate) due to loss of sympathetic tone below the level of injury. In cervical and high thoracic injuries, disruption of the sympathetic chain (T1-L2) causes peripheral vasodilation (decreased SVR) and loss of cardiac sympathetic input (T1-T4) causing bradycardia. This contrasts with hypovolemic and septic shock, which present with tachycardia as a compensatory response. Treatment includes IV fluids, vasopressors (norepinephrine, phenylephrine), and atropine for symptomatic bradycardia.',
      moduleId: 'cardiovascular',
      difficulty: 'intermediate',
    ),
    QuizQuestion(
      question:
          'Orthostatic hypotension in chronic SCI is best managed initially with which of the following?',
      options: [
        'IV norepinephrine infusion',
        'Progressive upright positioning, compression stockings, and abdominal binder',
        'Permanent bed rest at 30 degrees',
        'Oral phenylephrine three times daily',
      ],
      correctIndex: 1,
      explanation:
          'Orthostatic hypotension in SCI results from loss of sympathetic vasoconstriction and impaired venous return. First-line management includes non-pharmacologic measures: progressive upright positioning (tilt table), compression stockings (thigh-high), abdominal binder, adequate hydration, salt supplementation, and slow position changes. If these are insufficient, pharmacologic options include midodrine (alpha-1 agonist), fludrocortisone (volume expansion), and droxidopa. Ephedrine and caffeine may also be used.',
      moduleId: 'cardiovascular',
      difficulty: 'intermediate',
    ),
    QuizQuestion(
      question:
          'The highest risk period for deep vein thrombosis (DVT) after acute SCI is:',
      options: [
        'First 2 weeks',
        '2-12 weeks post-injury',
        '3-6 months post-injury',
        'After 1 year post-injury',
      ],
      correctIndex: 0,
      explanation:
          'The risk of DVT/PE is highest in the first 2 weeks after acute SCI, with peak incidence between days 7-10. The overall incidence without prophylaxis can be as high as 50-100%. Risk factors include immobility, venous stasis, hypercoagulability, and loss of the skeletal muscle pump. Current guidelines recommend low-molecular-weight heparin (LMWH) as first-line prophylaxis starting within 72 hours of injury (if no contraindications) and continuing for at least 8-12 weeks. Mechanical prophylaxis (compression devices) should be used in addition.',
      moduleId: 'cardiovascular',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'Which DVT prophylaxis regimen is recommended as first-line in acute SCI?',
      options: [
        'Aspirin 81 mg daily',
        'Unfractionated heparin 5000 units subcutaneous TID',
        'Low-molecular-weight heparin (e.g., enoxaparin 40 mg subcutaneous daily)',
        'Warfarin with INR goal 2-3',
      ],
      correctIndex: 2,
      explanation:
          'Low-molecular-weight heparin (LMWH), such as enoxaparin, is the recommended first-line pharmacologic prophylaxis for DVT in acute SCI. LMWH has been shown to be superior to unfractionated heparin (UFH) and low-dose UFH alone in preventing DVT in the SCI population. It should be combined with mechanical prophylaxis (graduated compression stockings or pneumatic compression devices). Prophylaxis should begin within 72 hours of injury and continue for 8-12 weeks. An IVC filter may be considered if anticoagulation is contraindicated.',
      moduleId: 'cardiovascular',
      difficulty: 'board',
    ),

    // =====================================================================
    // MODULE: spasticity
    // =====================================================================
    QuizQuestion(
      question:
          'Spasticity is defined as a velocity-dependent increase in muscle tone due to hyperexcitability of the stretch reflex. It is a feature of:',
      options: [
        'Lower motor neuron syndrome',
        'Upper motor neuron syndrome',
        'Peripheral neuropathy',
        'Myopathy',
      ],
      correctIndex: 1,
      explanation:
          'Spasticity is a component of upper motor neuron (UMN) syndrome. It is defined as a velocity-dependent increase in tonic stretch reflexes with exaggerated tendon jerks (Lance, 1980). UMN syndrome features are divided into positive phenomena (spasticity, clonus, hyperreflexia, Babinski sign, flexor/extensor spasms) and negative phenomena (weakness, loss of dexterity, fatigability). In SCI, spasticity develops after resolution of spinal shock in injuries above the conus medullaris.',
      moduleId: 'spasticity',
      difficulty: 'basic',
    ),
    QuizQuestion(
      question:
          'A patient with T4 complete SCI has severe lower extremity spasticity that interferes with ADLs and causes painful spasms. Oral baclofen and tizanidine at maximum tolerated doses have been ineffective. The next most appropriate step is:',
      options: [
        'Surgical rhizotomy',
        'Intrathecal baclofen pump trial',
        'Botulinum toxin injections to all lower extremity muscles',
        'Oral dantrolene sodium',
      ],
      correctIndex: 1,
      explanation:
          'When oral antispasticity medications fail to adequately control spasticity, intrathecal baclofen (ITB) is the next step for diffuse spasticity, particularly in the lower extremities. An ITB trial (bolus dose via lumbar puncture, typically 50-100 mcg) is performed first to assess response. If the trial is successful (significant reduction in tone/spasms), a programmable pump is implanted. ITB delivers baclofen directly to the intrathecal space at 1/100th of the oral dose, minimizing systemic side effects. Botulinum toxin is better suited for focal spasticity.',
      moduleId: 'spasticity',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'Which oral medication for spasticity acts primarily at the muscle level rather than the central nervous system?',
      options: [
        'Baclofen',
        'Tizanidine',
        'Dantrolene sodium',
        'Diazepam',
      ],
      correctIndex: 2,
      explanation:
          'Dantrolene sodium acts directly on skeletal muscle by inhibiting calcium release from the sarcoplasmic reticulum, thereby reducing the force of muscle contraction. It is the only commonly used oral antispasticity agent that acts peripherally at the muscle level. Baclofen is a GABA-B receptor agonist acting in the spinal cord. Tizanidine is a central alpha-2 adrenergic agonist. Diazepam is a GABA-A receptor agonist in the CNS. Dantrolene carries a risk of hepatotoxicity and requires liver function monitoring.',
      moduleId: 'spasticity',
      difficulty: 'intermediate',
    ),
    QuizQuestion(
      question:
          'A sudden increase in spasticity in a patient with chronic SCI should prompt evaluation for:',
      options: [
        'Progressive spinal cord compression only',
        'Noxious stimuli below the level of injury such as UTI, pressure injury, fracture, DVT, or ingrown toenail',
        'Normal disease progression requiring increased medication doses',
        'Psychogenic overlay',
      ],
      correctIndex: 1,
      explanation:
          'A sudden increase in spasticity in a patient with chronic SCI should always prompt a search for a new noxious stimulus below the level of injury. Common causes include UTI, pressure injury, fracture, DVT, ingrown toenail, constipation/fecal impaction, kidney stone, tight clothing or orthotic, and syringomyelia. The treatment is to identify and address the underlying cause, not simply to increase antispasticity medications. This same principle applies to worsening autonomic dysreflexia.',
      moduleId: 'spasticity',
      difficulty: 'intermediate',
    ),

    // =====================================================================
    // MODULE: pain-syndromes
    // =====================================================================
    QuizQuestion(
      question:
          'According to the International Spinal Cord Injury Pain (ISCIP) classification, which of the following is classified as at-level neuropathic pain?',
      options: [
        'Shoulder pain from overuse in a wheelchair user',
        'Burning pain in the dermatomes corresponding to the neurological level of injury',
        'Abdominal pain from constipation',
        'Hip pain from heterotopic ossification',
      ],
      correctIndex: 1,
      explanation:
          'The ISCIP classification divides SCI pain into: (1) Nociceptive pain - musculoskeletal (bone, joint, muscle) and visceral (organ-related); (2) Neuropathic pain - at-level (within the zone of injury, +/- 3 dermatomes of the NLI), below-level (more than 3 dermatomes below the NLI), and other (e.g., carpal tunnel). At-level neuropathic pain is due to damage to the nerve roots or spinal cord at the level of injury and presents as burning, shooting, or electric pain in the corresponding dermatomes.',
      moduleId: 'pain-syndromes',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'First-line pharmacologic treatment for neuropathic pain after SCI includes:',
      options: [
        'Opioids (morphine, oxycodone)',
        'NSAIDs (ibuprofen, naproxen)',
        'Gabapentinoids (pregabalin, gabapentin) and/or tricyclic antidepressants (amitriptyline)',
        'Benzodiazepines (diazepam, clonazepam)',
      ],
      correctIndex: 2,
      explanation:
          'First-line treatments for neuropathic pain after SCI include gabapentinoids (pregabalin has the strongest evidence, gabapentin is also commonly used) and tricyclic antidepressants (amitriptyline, nortriptyline). Pregabalin is the only medication with Level 1 evidence for SCI neuropathic pain. Second-line agents include tramadol and SNRIs (duloxetine, venlafaxine). Opioids should be reserved for refractory cases due to addiction risk. NSAIDs are effective for nociceptive/musculoskeletal pain but not for neuropathic pain.',
      moduleId: 'pain-syndromes',
      difficulty: 'intermediate',
    ),
    QuizQuestion(
      question:
          'The most common type of pain reported by patients with chronic SCI is:',
      options: [
        'Visceral pain',
        'At-level neuropathic pain',
        'Below-level neuropathic pain',
        'Musculoskeletal (nociceptive) pain',
      ],
      correctIndex: 3,
      explanation:
          'Musculoskeletal (nociceptive) pain is the most commonly reported type of pain in chronic SCI, affecting up to 60-70% of patients. Common sources include shoulder pain (rotator cuff pathology, impingement from wheelchair propulsion), upper extremity overuse injuries, spinal pain at or near the injury site, and pain from abnormal posture. Below-level neuropathic pain is the most difficult type to treat and is reported by approximately 30-40% of patients.',
      moduleId: 'pain-syndromes',
      difficulty: 'intermediate',
    ),

    // =====================================================================
    // MODULE: pressure-injuries
    // =====================================================================
    QuizQuestion(
      question:
          'According to the NPUAP staging system, a pressure injury presenting with full-thickness skin loss with visible adipose tissue but without exposed bone, tendon, or muscle is classified as:',
      options: [
        'Stage 2',
        'Stage 3',
        'Stage 4',
        'Unstageable',
      ],
      correctIndex: 1,
      explanation:
          'Stage 3 pressure injury involves full-thickness skin loss, in which adipose (fat) tissue is visible in the wound and granulation tissue and rolled wound edges may be present. Slough and/or eschar may be present. The depth varies by anatomical location. Fascia, muscle, tendon, ligament, cartilage, and/or bone are NOT exposed. Stage 2 involves partial-thickness skin loss (intact or ruptured blister). Stage 4 involves full-thickness skin and tissue loss with exposed bone, tendon, or muscle. Unstageable has obscured wound bed covered by slough or eschar.',
      moduleId: 'pressure-injuries',
      difficulty: 'intermediate',
    ),
    QuizQuestion(
      question:
          'The most common location for pressure injuries in patients who use wheelchairs is:',
      options: [
        'Sacrum',
        'Ischial tuberosities',
        'Greater trochanters',
        'Heels',
      ],
      correctIndex: 1,
      explanation:
          'In wheelchair users, the ischial tuberosities bear the most pressure during sitting and are the most common site for pressure injuries. In bed-bound patients, the sacrum is the most common location. Other common sites include the greater trochanters (side-lying), heels (supine), and occiput (supine, especially in children). Prevention strategies for wheelchair users include pressure-relieving cushions, regular weight shifts (every 15-30 minutes), and proper wheelchair seating assessment.',
      moduleId: 'pressure-injuries',
      difficulty: 'basic',
    ),
    QuizQuestion(
      question:
          'A pressure injury with full-thickness tissue loss and exposed bone with necrotic tissue in the wound base is classified as:',
      options: [
        'Stage 3',
        'Stage 4',
        'Unstageable',
        'Deep tissue pressure injury',
      ],
      correctIndex: 1,
      explanation:
          'Stage 4 pressure injury involves full-thickness skin and tissue loss with exposed or directly palpable fascia, muscle, tendon, ligament, cartilage, or bone. Slough and/or eschar may be visible. The wound is still stageable as Stage 4 because the depth of tissue damage can be determined (bone is visible). An unstageable pressure injury is one in which the wound bed is obscured by slough or eschar such that the true depth cannot be determined. Once debrided, it would be staged as either 3 or 4.',
      moduleId: 'pressure-injuries',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'Which of the following is the most important intervention for pressure injury prevention in SCI?',
      options: [
        'Nutritional supplementation with vitamin C and zinc',
        'Regular skin inspection and pressure redistribution (weight shifts, turning schedules, appropriate support surfaces)',
        'Prophylactic surgical flap coverage of bony prominences',
        'Daily application of barrier cream to all bony prominences',
      ],
      correctIndex: 1,
      explanation:
          'Regular skin inspection and pressure redistribution are the cornerstones of pressure injury prevention. This includes: visual skin checks twice daily, weight shifts in wheelchair every 15-30 minutes, repositioning in bed every 2 hours, appropriate support surfaces (pressure-redistributing mattress and wheelchair cushion), and education. While nutrition is important for wound healing, pressure redistribution and skin monitoring are the most critical preventive measures. Patients and caregivers must be educated on these strategies.',
      moduleId: 'pressure-injuries',
      difficulty: 'basic',
    ),

    // =====================================================================
    // MODULE: sexuality-fertility
    // =====================================================================
    QuizQuestion(
      question:
          'A male patient with a complete T10 SCI (UMN lesion above the sacral segments) would most likely have which pattern of erectile function?',
      options: [
        'No erections possible',
        'Reflexogenic erections preserved, psychogenic erections absent',
        'Psychogenic erections preserved, reflexogenic erections absent',
        'Both reflexogenic and psychogenic erections preserved',
      ],
      correctIndex: 1,
      explanation:
          'In UMN lesions (above S2-S4), the sacral reflex arc is intact, preserving reflexogenic erections (mediated by the S2-S4 parasympathetic pathway via the pelvic nerves). However, psychogenic erections (mediated by the T11-L2 sympathetic pathway with descending input from the brain) are lost because the descending pathways are disrupted. In LMN lesions (at or below S2-S4), reflexogenic erections are lost but psychogenic erections may be partially preserved via the intact T11-L2 sympatholumbar pathway.',
      moduleId: 'sexuality-fertility',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'The most common method used to obtain sperm from men with SCI for fertility purposes is:',
      options: [
        'Surgical testicular sperm extraction (TESE)',
        'Penile vibratory stimulation (PVS)',
        'Electroejaculation (EEJ)',
        'Microsurgical epididymal sperm aspiration (MESA)',
      ],
      correctIndex: 1,
      explanation:
          'Penile vibratory stimulation (PVS) is the first-line and most commonly used method for sperm retrieval in men with SCI. It is non-invasive, can be performed at home, and has a success rate of approximately 60-90% in patients with injuries at T10 and above (intact ejaculatory reflex arc). If PVS fails, electroejaculation (EEJ) performed under anesthesia (or without anesthesia in complete injuries) is the next option. Surgical sperm retrieval is reserved for cases where both PVS and EEJ fail. Note: AD precautions must be taken in patients with injuries at T6 and above.',
      moduleId: 'sexuality-fertility',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'Fertility in women with SCI is:',
      options: [
        'Permanently impaired due to hormonal disruption',
        'Temporarily affected with amenorrhea averaging 3-6 months post-injury, after which fertility returns to normal',
        'Unaffected at any time post-injury',
        'Dependent on the level of injury being below T12',
      ],
      correctIndex: 1,
      explanation:
          'Women with SCI typically experience temporary amenorrhea lasting an average of 3-6 months after injury. After this period, menstruation and fertility return to baseline. Women with SCI can conceive and carry pregnancies, though they require specialized obstetric care. Key concerns during pregnancy include autonomic dysreflexia during labor (in injuries at T6 and above), increased risk of UTIs, pressure injuries, DVT, and the inability to perceive labor contractions in injuries above T10.',
      moduleId: 'sexuality-fertility',
      difficulty: 'intermediate',
    ),

    // =====================================================================
    // MODULE: msk-complications
    // =====================================================================
    QuizQuestion(
      question:
          'Heterotopic ossification (HO) in SCI most commonly occurs around which joint?',
      options: [
        'Shoulder',
        'Elbow',
        'Hip',
        'Knee',
      ],
      correctIndex: 2,
      explanation:
          'The hip is the most common site for heterotopic ossification (HO) after SCI, accounting for approximately 70-80% of cases. The knee is the second most common site. HO occurs in approximately 20-30% of SCI patients, typically presenting 1-4 months post-injury with swelling, warmth, decreased range of motion, and sometimes low-grade fever. Serum alkaline phosphatase is elevated. Triple-phase bone scan is the most sensitive early diagnostic test. Treatment includes etidronate or indomethacin for prophylaxis, aggressive ROM exercises, and surgical excision for mature HO causing functional impairment.',
      moduleId: 'msk-complications',
      difficulty: 'intermediate',
    ),
    QuizQuestion(
      question:
          'The most sensitive diagnostic test for early detection of heterotopic ossification is:',
      options: [
        'Plain radiographs',
        'CT scan',
        'Triple-phase bone scan',
        'Serum alkaline phosphatase',
      ],
      correctIndex: 2,
      explanation:
          'Triple-phase bone scan is the most sensitive test for early detection of HO, showing increased uptake weeks before radiographic changes are visible. Plain radiographs typically do not show HO until 2-6 weeks after onset, when sufficient mineralization has occurred. Serum alkaline phosphatase is a useful screening marker (elevated early) but lacks specificity. CT provides excellent anatomical detail and is useful for surgical planning. MRI can also detect early HO but is less commonly used as a screening tool.',
      moduleId: 'msk-complications',
      difficulty: 'intermediate',
    ),
    QuizQuestion(
      question:
          'A patient with chronic T6 complete SCI sustains a femoral shaft fracture after a minor fall during a transfer. The most likely underlying cause is:',
      options: [
        'Osteomalacia from vitamin D deficiency',
        'Sublesional osteoporosis from disuse and loss of mechanical loading',
        'Osteogenesis imperfecta',
        'Metastatic bone disease',
      ],
      correctIndex: 1,
      explanation:
          'Sublesional osteoporosis is extremely common in SCI, with bone mineral density loss of 25-50% in the lower extremities within the first 1-2 years after injury. It results from loss of mechanical loading, muscle paralysis, and neurogenic/vascular changes. The distal femur and proximal tibia are the most commonly affected sites and the most common fracture locations. Fractures often occur with minimal trauma during transfers, ROM exercises, or falls. Bisphosphonates and weight-bearing activities (standing frames) may slow bone loss.',
      moduleId: 'msk-complications',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'The most common upper extremity overuse injury in manual wheelchair users is:',
      options: [
        'Lateral epicondylitis',
        'Rotator cuff pathology/shoulder impingement',
        'Carpal tunnel syndrome',
        'Biceps tendinopathy',
      ],
      correctIndex: 1,
      explanation:
          'Rotator cuff pathology and shoulder impingement syndrome are the most common upper extremity complaints in manual wheelchair users, affecting 30-70% of long-term users. The repetitive overhead motion of wheelchair propulsion, transfers, and weight-relief raises leads to subacromial impingement and rotator cuff tendinopathy. Carpal tunnel syndrome is the second most common overuse injury. Prevention includes proper wheelchair ergonomics, strengthening of scapular stabilizers and rotator cuff, maintaining flexibility, and considering power mobility for community distances.',
      moduleId: 'msk-complications',
      difficulty: 'basic',
    ),

    // =====================================================================
    // MODULE: rehab-continuum
    // =====================================================================
    QuizQuestion(
      question:
          'A patient with a C5 complete (ASIA A) SCI would be expected to independently perform which of the following activities?',
      options: [
        'Independent bed mobility and transfers',
        'Feeding with adaptive equipment after setup',
        'Independent catheterization',
        'Independent dressing of lower extremities',
      ],
      correctIndex: 1,
      explanation:
          'A patient with C5 tetraplegia has intact deltoids, biceps, and brachialis (elbow flexion and shoulder motion) but lacks wrist extension (C6), elbow extension (C7), and hand function. Expected functional outcomes include: feeding with adaptive equipment (universal cuff/tenodesis splint) after setup, electric wheelchair independence, power assist or manual wheelchair on flat surfaces with rim modifications, dependent transfers (may assist with sliding board), and dependent bowel/bladder care. They typically require moderate to maximal assist for most ADLs.',
      moduleId: 'rehab-continuum',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'The tenodesis grasp is functionally important for patients with which level of cervical SCI?',
      options: [
        'C4',
        'C5',
        'C6',
        'C8',
      ],
      correctIndex: 2,
      explanation:
          'The tenodesis grasp is functionally critical at the C6 level. With intact wrist extensors (ECRL, ECRB) but no finger flexors, active wrist extension causes passive finger flexion through tenodesis effect (tightening of finger flexor tendons over the wrist). This allows a functional grasp for picking up light objects. The tenodesis grip is optimized by NOT stretching the finger flexors during therapy (maintaining their natural tightness). C6 patients can use tenodesis for feeding, writing, and some self-care tasks.',
      moduleId: 'rehab-continuum',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'A patient with C7 complete SCI would be expected to achieve which of the following?',
      options: [
        'Independent ambulation with bilateral KAFOs and forearm crutches',
        'Independent transfers, wheelchair mobility, and self-care including bowel and bladder management',
        'Independent feeding only, with dependence in all other ADLs',
        'Full hand intrinsic function for fine motor tasks',
      ],
      correctIndex: 1,
      explanation:
          'C7 tetraplegia is often considered the key level for functional independence. With intact elbow extensors (triceps), wrist flexors, and some finger extension, patients can perform independent transfers (including car transfers), independent manual wheelchair propulsion, independent pressure relief, independent self-care (feeding, grooming, bathing upper body), and independent bowel/bladder programs. They may need adaptive equipment for some tasks. The triceps function at C7 is critical for transfers and wheelchair push-ups.',
      moduleId: 'rehab-continuum',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'Which level of paraplegia is generally considered the threshold for community ambulation with KAFOs and forearm crutches?',
      options: [
        'T1',
        'T6',
        'T12',
        'L4',
      ],
      correctIndex: 2,
      explanation:
          'T12 paraplegia is generally considered the most rostral level at which community ambulation with KAFOs (knee-ankle-foot orthoses) and forearm crutches is feasible, though the energy cost is still 4-9 times that of normal walking. Patients with T12 injuries have intact hip flexors (L1-L2) that can be used for hip hiking gait pattern. Lower thoracic (T9-T12) patients may ambulate for exercise but typically use a wheelchair for functional community mobility. Patients with lumbar injuries (L3-L4 and below) have a much more realistic prospect of functional community ambulation.',
      moduleId: 'rehab-continuum',
      difficulty: 'board',
    ),

    // =====================================================================
    // ADDITIONAL QUESTIONS - Mixed modules for comprehensive coverage
    // =====================================================================
    QuizQuestion(
      question:
          'Zone of partial preservation (ZPP) is defined only in which ASIA Impairment Scale grade?',
      options: [
        'ASIA B',
        'ASIA C',
        'ASIA D',
        'ASIA A',
      ],
      correctIndex: 3,
      explanation:
          'The zone of partial preservation (ZPP) is defined ONLY in ASIA A (complete) injuries. It refers to the dermatomes and myotomes caudal to the neurological level of injury that remain partially innervated. In incomplete injuries (ASIA B, C, D), the concept of ZPP does not apply because by definition, function is preserved in the sacral segments. The ZPP is documented as the most caudal segment with some sensory or motor function on each side.',
      moduleId: 'classification-asia',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'The sacral sparing definition used to distinguish complete from incomplete SCI includes which of the following findings at S4-S5?',
      options: [
        'Preserved lower extremity reflexes only',
        'Light touch or pin prick sensation at S4-S5, deep anal pressure, or voluntary anal contraction',
        'Preserved bulbocavernosus reflex only',
        'Any motor function in the lower extremities',
      ],
      correctIndex: 1,
      explanation:
          'Sacral sparing is determined by sensory function at S4-S5 (light touch or pin prick at the perianal area), deep anal pressure (DAP), or voluntary anal contraction (VAC). If ANY of these are present, the injury is classified as incomplete (ASIA B or higher). If ALL are absent, the injury is complete (ASIA A). The bulbocavernosus reflex is a segmental reflex and does NOT constitute sacral sparing. Lower extremity motor function alone, without sacral findings, does not determine completeness.',
      moduleId: 'classification-asia',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'Posterior cord syndrome is characterized by:',
      options: [
        'Loss of motor function and pain/temperature below the level of injury with preserved proprioception',
        'Loss of proprioception and vibration with preserved motor function, pain, and temperature sensation',
        'Ipsilateral motor loss with contralateral pain/temperature loss',
        'Greater upper extremity than lower extremity weakness',
      ],
      correctIndex: 1,
      explanation:
          'Posterior cord syndrome involves damage to the dorsal columns, resulting in loss of proprioception, vibration sense, and two-point discrimination below the level of injury. Motor function (corticospinal tracts) and pain/temperature sensation (spinothalamic tracts) are preserved. This is the rarest of the incomplete SCI syndromes and is most commonly caused by posterior spinal artery infarction, vitamin B12 deficiency (subacute combined degeneration), multiple sclerosis, or tabes dorsalis.',
      moduleId: 'pathophysiology',
      difficulty: 'intermediate',
    ),
    QuizQuestion(
      question:
          'A patient with a C4 complete SCI is being weaned from the ventilator. Which respiratory technique can assist with secretion clearance?',
      options: [
        'Incentive spirometry alone',
        'Manually assisted cough (quad cough) with abdominal thrust',
        'Pursed lip breathing',
        'Active cycle breathing technique',
      ],
      correctIndex: 1,
      explanation:
          'The manually assisted cough (quad cough) involves applying an abdominal thrust synchronized with the patient\'s expiratory effort (or reflexive cough) to substitute for the paralyzed abdominal muscles. This increases intrathoracic pressure and improves peak cough flow, aiding secretion clearance. Other assisted cough techniques include mechanical insufflation-exsufflation (CoughAssist device). Incentive spirometry is useful for lung expansion but does not specifically assist with cough. Patients with C4 SCI lack the abdominal and intercostal muscle function needed for an effective independent cough.',
      moduleId: 'respiratory',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'Which of the following medications should be avoided in patients at risk for autonomic dysreflexia?',
      options: [
        'Oxybutynin',
        'Pseudoephedrine (oral decongestant)',
        'Gabapentin',
        'Docusate sodium',
      ],
      correctIndex: 1,
      explanation:
          'Sympathomimetic medications such as pseudoephedrine (an alpha-adrenergic agonist/decongestant) should be avoided in patients at risk for autonomic dysreflexia (injuries at T6 and above). These medications can cause vasoconstriction and exacerbate the hypertensive response. Other medications to use with caution include certain migraine medications (triptans), stimulant medications, and vasoconstrictors (phenylephrine nasal sprays). Oxybutynin (anticholinergic for bladder), gabapentin (neuropathic pain), and docusate (stool softener) are safe to use.',
      moduleId: 'autonomic-dysreflexia',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'A Deep Tissue Pressure Injury (DTPI) is characterized by:',
      options: [
        'Partial-thickness skin loss presenting as an open blister',
        'Intact or non-intact skin with localized area of persistent non-blanchable deep red, maroon, or purple discoloration, or epidermal separation revealing a dark wound bed',
        'Full-thickness skin loss with visible subcutaneous fat',
        'Wound bed obscured by slough and eschar',
      ],
      correctIndex: 1,
      explanation:
          'Deep Tissue Pressure Injury (DTPI) presents as intact or non-intact skin with a localized area of persistent non-blanchable deep red, maroon, or purple discoloration, or epidermal separation revealing a dark wound bed or blood-filled blister. Pain and temperature changes often precede skin color changes. DTPI results from damage to underlying soft tissue from pressure and/or shear. The wound may rapidly evolve to reveal the actual extent of tissue damage, or may resolve without tissue loss. It should not be used to describe vascular, traumatic, neuropathic, or dermatologic conditions.',
      moduleId: 'pressure-injuries',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'A patient with T3 complete SCI develops a blood pressure of 180/100 during urodynamic testing. The catheter is draining freely. The next best step is:',
      options: [
        'Continue the study, as this is a normal response',
        'Stop the study, drain the bladder, sit the patient upright, and monitor blood pressure',
        'Administer IV labetalol and continue the study',
        'Ignore the blood pressure and focus on bladder pressure measurements',
      ],
      correctIndex: 1,
      explanation:
          'Bladder distension during urodynamic testing can trigger autonomic dysreflexia in patients with injuries at T6 and above. A blood pressure of 180/100 represents a significant hypertensive episode (AD is defined as an increase of 20-40 mmHg above baseline systolic). The study should be stopped immediately, the bladder drained, and the patient positioned upright. Blood pressure should be monitored continuously. The study may be reattempted with premedication (nifedipine or topical lidocaine) and careful monitoring on a different occasion.',
      moduleId: 'autonomic-dysreflexia',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'Which SCI syndrome is most commonly seen in elderly patients with pre-existing cervical spondylosis after a hyperextension injury?',
      options: [
        'Anterior cord syndrome',
        'Brown-Sequard syndrome',
        'Central cord syndrome',
        'Cauda equina syndrome',
      ],
      correctIndex: 2,
      explanation:
          'Central cord syndrome is the most common incomplete SCI syndrome and classically occurs in elderly patients with pre-existing cervical spondylosis/stenosis who sustain a hyperextension injury (e.g., fall). The narrowed spinal canal predisposes to cord compression even without fracture or dislocation. The central gray matter and medially located upper extremity fibers in the corticospinal tract are preferentially damaged, resulting in disproportionate upper extremity weakness. Most patients recover some function, with lower extremities and bowel/bladder function recovering first.',
      moduleId: 'pathophysiology',
      difficulty: 'intermediate',
    ),
    QuizQuestion(
      question:
          'Detrusor-sphincter dyssynergia (DSD) is characterized by:',
      options: [
        'Simultaneous relaxation of the detrusor and external urethral sphincter',
        'Simultaneous contraction of the detrusor and external urethral sphincter',
        'Absent detrusor contraction with relaxed sphincter',
        'Normal coordinated voiding',
      ],
      correctIndex: 1,
      explanation:
          'Detrusor-sphincter dyssynergia (DSD) is a hallmark of suprasacral (UMN) neurogenic bladder. It occurs when the detrusor muscle contracts simultaneously with the external urethral sphincter, rather than the sphincter relaxing to allow voiding (as in normal micturition). This results in high intravesical pressures, poor bladder emptying, and increased risk of vesicoureteral reflux, hydronephrosis, and upper urinary tract deterioration. DSD is seen in SCI above the sacral micturition center (S2-S4). Treatment includes anticholinergics with CIC, botulinum toxin injection to the sphincter, or alpha-blockers.',
      moduleId: 'neurogenic-bladder',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'Annual urological surveillance for patients with SCI should include:',
      options: [
        'Cystoscopy only',
        'Renal ultrasound and assessment of renal function (creatinine, GFR)',
        'CT urogram annually',
        'No routine surveillance is needed if the patient is asymptomatic',
      ],
      correctIndex: 1,
      explanation:
          'Annual urological surveillance in SCI includes renal ultrasound (to assess for hydronephrosis, stones, renal structural changes) and serum creatinine/GFR (to monitor renal function). Urodynamic studies should be performed at baseline and periodically (especially with any change in voiding pattern, recurrent UTIs, or worsening AD). Cystoscopy may be indicated for patients with indwelling catheters (increased bladder cancer risk after 5-10 years). The goal of surveillance is to preserve upper urinary tract function, which is a major source of morbidity and was historically a leading cause of death in SCI.',
      moduleId: 'neurogenic-bladder',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'A patient with L1 paraplegia would be expected to ambulate using:',
      options: [
        'No assistive device needed',
        'KAFOs with forearm crutches using a swing-through gait pattern',
        'AFOs with a cane',
        'Wheelchair only, ambulation not feasible',
      ],
      correctIndex: 1,
      explanation:
          'A patient with L1 paraplegia has intact hip flexors (L1-L2 partial) but weak or absent knee extensors (L3), ankle dorsiflexors (L4), and plantarflexors (S1). Ambulation requires bilateral KAFOs (to stabilize the knees) and forearm crutches, typically using a swing-to or swing-through gait pattern. The energy cost is 4-9 times normal walking, so many patients use a wheelchair for community mobility and reserve ambulation for exercise. This level represents the transition zone where ambulation is technically possible but energy-demanding.',
      moduleId: 'rehab-continuum',
      difficulty: 'intermediate',
    ),
    QuizQuestion(
      question:
          'Which of the following correctly describes the relationship between vertebral level and spinal cord segments in the thoracic spine?',
      options: [
        'The spinal cord segment corresponds exactly to the same vertebral level',
        'The spinal cord segment is approximately 1-2 levels above the corresponding vertebral body',
        'The spinal cord segment is approximately 2 levels below the corresponding vertebral body (e.g., T10 vertebra overlies the T12 cord segment)',
        'There is no consistent relationship between vertebral and cord levels',
      ],
      correctIndex: 2,
      explanation:
          'Due to the differential growth of the spinal cord and vertebral column, the spinal cord segments are located at higher vertebral levels than their corresponding vertebral bodies. In the lower thoracic spine, the cord segment is approximately 2 levels higher than the vertebral body level (e.g., T10 vertebra houses approximately T12 cord segment). In the upper thoracic spine, the discrepancy is about 1 level. The conus medullaris (end of the spinal cord) typically terminates at the L1-L2 vertebral level. Below this, only cauda equina nerve roots are present.',
      moduleId: 'sci-fundamentals',
      difficulty: 'intermediate',
    ),
    QuizQuestion(
      question:
          'Syringomyelia presenting months to years after SCI is suggested by which clinical finding?',
      options: [
        'Sudden onset of bilateral lower extremity paralysis',
        'Progressive ascending loss of motor function, increased pain, or worsening spasticity above the original level of injury',
        'Improvement in neurological function below the level of injury',
        'Development of peripheral neuropathy in the upper extremities',
      ],
      correctIndex: 1,
      explanation:
          'Post-traumatic syringomyelia (syrinx formation within the spinal cord) occurs in approximately 3-4% of SCI patients, typically presenting months to years after injury. Key features include progressive loss of neurological function ascending above the original injury level, new-onset or worsening pain (often described as a burning or aching quality), increased spasticity, autonomic changes, and progressive motor weakness. MRI is the diagnostic study of choice. Surgical treatment (shunting or untethering) is indicated for progressive neurological deterioration.',
      moduleId: 'pathophysiology',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'The recommended initial dose for an intrathecal baclofen trial is:',
      options: [
        '10 mcg',
        '50 mcg',
        '500 mcg',
        '2000 mcg',
      ],
      correctIndex: 1,
      explanation:
          'The standard initial bolus dose for an intrathecal baclofen (ITB) trial is 50 mcg delivered via lumbar puncture. The patient is observed for 4-8 hours for reduction in spasticity (measured by Ashworth scale or Penn spasm frequency). If the response is inadequate, the trial may be repeated at 75 mcg (24 hours later) and then 100 mcg. A positive response (typically at least 1-2 point reduction in Ashworth scale) indicates candidacy for pump implantation. The ITB dose is approximately 1/100th of the equivalent oral dose, dramatically reducing CNS side effects.',
      moduleId: 'spasticity',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'Which key dermatome is tested at the medial malleolus?',
      options: [
        'L3',
        'L4',
        'L5',
        'S1',
      ],
      correctIndex: 1,
      explanation:
          'L4 is the key sensory point tested at the medial malleolus. The complete lower extremity key sensory points for ISNCSCI: L1=halfway between the ASIS and inguinal crease, L2=anterior mid-thigh, L3=medial femoral condyle (medial knee), L4=medial malleolus, L5=dorsum of the foot at the third MTP joint, S1=lateral heel, S2=popliteal fossa midpoint.',
      moduleId: 'classification-asia',
      difficulty: 'basic',
    ),
    QuizQuestion(
      question:
          'In a patient with SCI, an episode of autonomic dysreflexia that is not recognized and treated can result in:',
      options: [
        'Transient ischemic attack only',
        'Seizures, intracranial hemorrhage, myocardial infarction, or death',
        'Chronic hypertension but no acute complications',
        'Hypoglycemia and metabolic acidosis',
      ],
      correctIndex: 1,
      explanation:
          'Untreated autonomic dysreflexia can result in life-threatening complications including intracranial hemorrhage (stroke), seizures, myocardial infarction, cardiac arrhythmias, retinal detachment, pulmonary edema, and death. Systolic blood pressures can exceed 250-300 mmHg during severe episodes. This is why AD is considered a medical emergency requiring immediate recognition and management. All patients with injuries at T6 and above, their caregivers, and healthcare providers should be educated about AD recognition and emergency management.',
      moduleId: 'autonomic-dysreflexia',
      difficulty: 'intermediate',
    ),
    QuizQuestion(
      question:
          'Methylprednisolone use in acute SCI, as studied in the NASCIS trials, is currently:',
      options: [
        'Standard of care and recommended for all acute SCI patients',
        'No longer recommended as a standard treatment; may be considered as an option within 8 hours of injury with informed consent',
        'Recommended only for incomplete injuries',
        'Recommended only for penetrating SCI',
      ],
      correctIndex: 1,
      explanation:
          'High-dose methylprednisolone for acute SCI (NASCIS II/III protocol) is no longer recommended as a standard of care by most current guidelines (including the AO Spine/AANS/CNS 2013 guidelines). The evidence from the NASCIS trials has been widely criticized for methodological issues, and the modest neurological benefit must be weighed against significant risks (infection, GI bleeding, pneumonia, sepsis, wound complications). Current guidelines suggest it may be offered as an option (not a recommendation) if initiated within 8 hours of injury, with informed consent regarding risks.',
      moduleId: 'sci-fundamentals',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'A patient with C6 tetraplegia is most likely to use which type of wheelchair for primary mobility?',
      options: [
        'Power wheelchair exclusively',
        'Manual wheelchair with standard rims',
        'Manual wheelchair with projection (quad) rims, possibly with power assist',
        'Standing frame wheelchair',
      ],
      correctIndex: 2,
      explanation:
          'Patients with C6 tetraplegia have wrist extension (ECRL/ECRB) but lack finger flexion and grip strength. They can propel a manual wheelchair using projection (quad) rims, which have rubber-coated vertical or angled projections that allow propulsion without grip. Power-assist wheels or a power wheelchair may be needed for longer distances, hills, or outdoor use. Manual wheelchair with standard rims requires grip strength (C7-C8 and below). C6 patients can often achieve independent indoor mobility with a manual chair on flat surfaces.',
      moduleId: 'rehab-continuum',
      difficulty: 'intermediate',
    ),
    QuizQuestion(
      question:
          'Thermoregulatory dysfunction (poikilothermia) in SCI occurs because:',
      options: [
        'The hypothalamus is directly damaged in SCI',
        'Loss of sympathetic control below the level of injury impairs sweating, shivering, and peripheral vasomotor responses',
        'SCI patients have decreased metabolic rate at all times',
        'The thyroid gland is affected by SCI',
      ],
      correctIndex: 1,
      explanation:
          'SCI disrupts the sympathetic nervous system below the level of injury, impairing the body\'s ability to thermoregulate. Below the lesion level, patients cannot sweat (losing evaporative cooling), cannot shiver (losing heat production), and cannot vasoconstrict or vasodilate appropriately. This makes patients with higher-level injuries (cervical > thoracic) essentially poikilothermic (body temperature varies with environmental temperature) below the level of injury. Patients are at risk for both hypothermia and hyperthermia. The hypothalamus functions normally but cannot execute thermoregulatory responses below the lesion.',
      moduleId: 'cardiovascular',
      difficulty: 'intermediate',
    ),
  ];

  static List<QuizQuestion> getRandomQuiz(int count) {
    final shuffled = List<QuizQuestion>.from(_allQuestions)..shuffle();
    return shuffled.take(count).toList();
  }

  static List<QuizQuestion> getByModule(String moduleId) {
    return _allQuestions.where((q) => q.moduleId == moduleId).toList();
  }
}
