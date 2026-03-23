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

    // =====================================================================
    // NEW QUESTIONS BATCH 2 — HIGH-YIELD BOARD TOPICS
    // =====================================================================

    // =====================================================================
    // SCI FUNDAMENTALS — NEW
    // =====================================================================
    QuizQuestion(
      question:
          'The estimated lifetime cost for a patient who sustains a high cervical (C1-C4) SCI at age 25 is approximately:',
      options: [
        '\$1.2 million',
        '\$2.5 million',
        '\$5.1 million',
        '\$8.7 million',
      ],
      correctIndex: 2,
      explanation:
          'The estimated lifetime cost for high tetraplegia (C1-C4) sustained at age 25 is approximately \$5.1 million (2019 dollars). This includes direct costs (medical, rehabilitation, attendant care, equipment) and indirect costs (lost wages, productivity). First-year costs alone exceed \$1.1 million. Costs decrease with lower injury levels: low tetraplegia (C5-C8) approximately \$3.7 million, paraplegia approximately \$2.5 million. These figures underscore the enormous economic burden of SCI and the importance of prevention.',
      moduleId: 'sci-fundamentals',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'Which factor is the strongest predictor of return to employment after spinal cord injury?',
      options: [
        'Injury level (cervical vs. thoracic)',
        'Education level prior to injury',
        'Age at time of injury',
        'ASIA Impairment Scale grade',
      ],
      correctIndex: 1,
      explanation:
          'Education level is the single strongest predictor of return to work after SCI. Higher education levels are associated with sedentary or knowledge-based occupations that are more compatible with physical disability. Other important predictors include younger age at injury, incomplete injury, higher motivation, pre-injury employment history, and access to vocational rehabilitation. Overall employment rates after SCI range from 12-40% depending on study and population.',
      moduleId: 'sci-fundamentals',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'The incidence of noncontiguous spinal fractures in patients with acute spinal column injuries is approximately:',
      options: [
        '1-3%',
        '5-10%',
        '12-28%',
        '40-50%',
      ],
      correctIndex: 2,
      explanation:
          'Noncontiguous spinal fractures occur in approximately 12-28% of patients with acute spinal column injuries. This high incidence mandates imaging of the entire spine when a spinal fracture is identified at any level. Noncontiguous fractures may be missed if only the symptomatic level is imaged, potentially resulting in secondary neurological injury. Full spine screening (CT) is now standard of care in trauma evaluation when any spinal fracture is discovered.',
      moduleId: 'sci-fundamentals',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'Concomitant traumatic brain injury (TBI) occurs in approximately what percentage of patients with cervical spinal cord injury?',
      options: [
        '10%',
        '25%',
        '60%',
        '80%',
      ],
      correctIndex: 2,
      explanation:
          'TBI occurs in approximately 60% of patients with cervical SCI. Overall, approximately 47% of all traumatic SCI patients have concomitant injuries. The high co-occurrence of TBI with cervical SCI reflects shared mechanisms (high-energy trauma, falls, motor vehicle collisions). Concomitant TBI complicates rehabilitation due to cognitive and behavioral deficits, and may limit the accuracy of the neurological examination. Screening for TBI is essential in all cervical SCI patients.',
      moduleId: 'sci-fundamentals',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'Average acute care and inpatient rehabilitation length of stay for SCI has changed dramatically over the decades. In the 1970s it averaged 122 days; by 2015 it averaged approximately:',
      options: [
        '92 days',
        '72 days',
        '46 days',
        '21 days',
      ],
      correctIndex: 2,
      explanation:
          'Average length of stay for acute care plus inpatient rehabilitation has decreased from 122 days in the 1970s to approximately 46 days by 2015. This reflects changes in healthcare delivery, insurance reimbursement, earlier mobilization protocols, and increased use of outpatient and community-based rehabilitation. While shorter stays may reduce costs, there are concerns about whether patients are achieving optimal functional outcomes and are adequately prepared for community reintegration within these shortened timeframes.',
      moduleId: 'sci-fundamentals',
      difficulty: 'intermediate',
    ),
    QuizQuestion(
      question:
          'Approximately what percentage of traumatic SCI patients have at least one concomitant injury (e.g., long bone fractures, thoracic injury, TBI)?',
      options: [
        '15%',
        '25%',
        '47%',
        '75%',
      ],
      correctIndex: 2,
      explanation:
          'Approximately 47% of traumatic SCI patients have concomitant injuries. These include long bone fractures, thoracic/abdominal injuries, traumatic brain injury, and pelvic fractures. The presence of concomitant injuries complicates the acute management of SCI, may delay rehabilitation, and can independently affect functional outcomes. A thorough trauma evaluation is essential to identify all injuries in the acute setting.',
      moduleId: 'sci-fundamentals',
      difficulty: 'intermediate',
    ),

    // =====================================================================
    // ASIA/ISNCSCI — NEW
    // =====================================================================
    QuizQuestion(
      question:
          'In the ISNCSCI examination, non-key muscle groups tested below the single neurological level of injury are used primarily to distinguish between:',
      options: [
        'ASIA A and ASIA B',
        'ASIA B and ASIA C',
        'ASIA C and ASIA D',
        'ASIA D and ASIA E',
      ],
      correctIndex: 1,
      explanation:
          'Non-key muscle groups (e.g., diaphragm, deltoid, hip adductors, hamstrings) are used to help distinguish ASIA B (sensory incomplete) from ASIA C (motor incomplete) when there is no voluntary motor function in key muscles more than three levels below the motor level. If a non-key muscle more than three levels below the motor level has at least grade 1 strength, the patient is classified as ASIA C rather than B. This recognizes preserved motor function that may not be captured by the 10 key muscle pairs alone.',
      moduleId: 'classification-asia',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'In the ISNCSCI classification, the motor level is defined as the most caudal key muscle with at least grade 3/5 strength, provided the segment above is at least:',
      options: [
        'Grade 3/5',
        'Grade 4/5',
        'Grade 5/5',
        'Any grade of motor function',
      ],
      correctIndex: 2,
      explanation:
          'The motor level determination requires the key muscle at the tested level to be at least grade 3/5 (antigravity), AND the key muscle represented by the segment above must be grade 5/5 (normal). This sequential criterion prevents isolated preserved segments from being misinterpreted as the motor level. For example, if C6 wrist extensors are 4/5 but C5 biceps is only 3/5, the motor level is C4 (not C5 or C6), because C5 does not meet the 5/5 requirement for the segment above C6.',
      moduleId: 'classification-asia',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'The neurological level of injury (NLI) on the ISNCSCI is determined as:',
      options: [
        'The most CAUDAL level with normal motor and sensory function on both sides',
        'The most ROSTRAL of the four sensory and motor levels (right/left sensory, right/left motor)',
        'The average of the right and left motor levels',
        'The level with the greatest difference between right and left function',
      ],
      correctIndex: 1,
      explanation:
          'The single neurological level of injury (NLI) is the most ROSTRAL (highest) of the four determined levels: right sensory level, left sensory level, right motor level, and left motor level. This convention ensures that the NLI reflects the highest point of impairment on either side. For example, if right sensory = C6, left sensory = C5, right motor = C6, left motor = C7, the NLI is C5.',
      moduleId: 'classification-asia',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'Epiconus syndrome involves injury to spinal cord segments L4-S1, which anatomically reside at which vertebral level?',
      options: [
        'L4-S1 vertebral levels',
        'T11-T12 vertebral levels',
        'L1-L2 vertebral levels',
        'T9-T10 vertebral levels',
      ],
      correctIndex: 1,
      explanation:
          'Epiconus syndrome involves damage to L4-S1 spinal cord segments, which are anatomically located at approximately the T11-T12 vertebral level due to the discrepancy between cord segment and vertebral levels. It produces a mixed UMN/LMN picture with LMN signs in L4-S1 myotomes (knee flexion, ankle, toe muscles) and preserved UMN bladder function (the S2-S4 sacral micturition center is spared). This distinguishes it from conus medullaris syndrome (S2-S5 segments) and cauda equina syndrome (nerve roots below the conus).',
      moduleId: 'classification-asia',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'The key sensory point for the L4 dermatome on the ISNCSCI examination is located at:',
      options: [
        'The dorsum of the foot at the third MTP joint',
        'The lateral heel',
        'The medial malleolus',
        'The anterior mid-thigh',
      ],
      correctIndex: 2,
      explanation:
          'The L4 key sensory point is the medial malleolus. Critical dermatome landmarks for the ISNCSCI: C5=lateral antecubital fossa, C6=thumb, C7=middle finger, C8=little finger, T1=medial elbow, T4=nipple line, T10=umbilicus, L1=inguinal region, L2=anterior mid-thigh, L3=medial femoral condyle, L4=medial malleolus, L5=dorsum of foot at third MTP, S1=lateral heel, S2=popliteal fossa, S3=ischial tuberosity, S4-S5=perianal area.',
      moduleId: 'classification-asia',
      difficulty: 'basic',
    ),
    QuizQuestion(
      question:
          'An ASIA B patient with preserved pin prick sensation (but not light touch alone) at S4-S5 has what approximate probability of converting to a motor-incomplete (ASIA C or D) classification?',
      options: [
        '10-20%',
        '30-40%',
        '50-70%',
        '90-100%',
      ],
      correctIndex: 2,
      explanation:
          'Pin prick preservation at S4-S5 in ASIA B patients carries a 50-70% probability of conversion to motor-incomplete (ASIA C or D) status. In contrast, preservation of only light touch (without pin prick) carries only a 10-20% conversion rate. This distinction is prognostically important because pin prick is carried by small myelinated A-delta and unmyelinated C fibers in the spinothalamic tract, which are more closely associated with motor tract (corticospinal) preservation. This finding has important implications for prognosis counseling.',
      moduleId: 'classification-asia',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'Central cord syndrome accounts for approximately what percentage of all incomplete SCI cases?',
      options: [
        '10%',
        '25%',
        '50%',
        '75%',
      ],
      correctIndex: 2,
      explanation:
          'Central cord syndrome is the most common incomplete SCI syndrome, accounting for approximately 50% of all incomplete SCI cases and approximately 9% of all traumatic SCI. It is characterized by greater weakness in the upper extremities than lower extremities, with variable sensory loss and bladder dysfunction. It most commonly occurs in elderly patients with pre-existing cervical spondylosis after hyperextension injuries. The prognosis for functional recovery is generally favorable, with lower extremity recovery preceding upper extremity recovery.',
      moduleId: 'classification-asia',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'In the ISNCSCI examination, when sensory function is tested at a key point and the patient reports altered sensation (decreased or increased) compared to the face (reference point), this is graded as:',
      options: [
        '0 = absent',
        '1 = altered (impaired)',
        '2 = normal',
        'NT = not testable',
      ],
      correctIndex: 1,
      explanation:
          'In the ISNCSCI sensory grading system: 0 = absent (no sensation), 1 = altered (impaired — either decreased or increased sensation compared to the face reference point), 2 = normal (same as the face). The face is used as the normal reference dermatome because it is innervated by the trigeminal nerve (CN V) and is unaffected by spinal cord injury. Both light touch and pin prick are graded independently at each key sensory point using this 0-1-2 scale.',
      moduleId: 'classification-asia',
      difficulty: 'intermediate',
    ),

    // =====================================================================
    // PATHOPHYSIOLOGY / ACUTE — NEW
    // =====================================================================
    QuizQuestion(
      question:
          'Succinylcholine is contraindicated after SCI beginning approximately 48 hours post-injury due to:',
      options: [
        'Increased risk of malignant hyperthermia',
        'Upregulation of extrajunctional (immature) acetylcholine receptors causing life-threatening hyperkalemia',
        'Direct toxic effect on the injured spinal cord',
        'Interaction with methylprednisolone used in NASCIS protocols',
      ],
      correctIndex: 1,
      explanation:
          'After denervation injury (including SCI), extrajunctional (immature, fetal-type) acetylcholine receptors proliferate across the entire muscle membrane surface, rather than being confined to the neuromuscular junction. When succinylcholine depolarizes these widespread receptors, massive potassium efflux occurs, causing life-threatening hyperkalemia and potentially fatal cardiac arrhythmias. This risk begins approximately 48 hours after injury and may persist for 6 months to indefinitely. Non-depolarizing neuromuscular blocking agents (e.g., rocuronium, vecuronium) should be used instead.',
      moduleId: 'pathophysiology',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'The NASCIS II trial concluded that high-dose methylprednisolone improved outcomes if administered within what time window after acute SCI?',
      options: [
        '3 hours',
        '8 hours',
        '24 hours',
        '48 hours',
      ],
      correctIndex: 1,
      explanation:
          'The NASCIS II trial (1990) concluded that methylprednisolone (30 mg/kg bolus then 5.4 mg/kg/hr for 23 hours) improved neurological outcomes if started within 8 hours of injury. NASCIS I (1984) compared high-dose vs. low-dose methylprednisolone (no placebo) and found no difference. NASCIS III (1997) suggested that patients treated between 3-8 hours should receive 48 hours of methylprednisolone instead of 24 hours. All three trials have been criticized for methodological issues, and current guidelines no longer recommend methylprednisolone as standard of care.',
      moduleId: 'pathophysiology',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'The STASCIS (Surgical Timing in Acute Spinal Cord Injury Study) trial demonstrated that early surgical decompression (<24 hours) resulted in what outcome compared to late surgery?',
      options: [
        'No significant difference in neurological outcomes',
        '2.8 times more likely to improve by at least 2 AIS grades',
        'Increased surgical complication rates that offset neurological gains',
        'Benefit only in ASIA A complete injuries',
      ],
      correctIndex: 1,
      explanation:
          'The STASCIS trial (2012) demonstrated that patients who underwent early surgical decompression (within 24 hours of injury) were 2.8 times more likely to improve by at least 2 AIS grades compared to those who had late surgery (after 24 hours). This landmark study provided strong evidence supporting early surgical intervention in acute traumatic SCI. Early decompression is thought to limit secondary injury by restoring spinal cord perfusion and reducing ongoing mechanical compression.',
      moduleId: 'pathophysiology',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'According to the Denis three-column model of spinal stability, the middle column consists of:',
      options: [
        'Anterior longitudinal ligament and anterior half of the vertebral body',
        'Posterior longitudinal ligament, posterior annulus fibrosus, and posterior wall of the vertebral body',
        'Supraspinous and interspinous ligaments, ligamentum flavum, and facet capsules',
        'Laminae, pedicles, and transverse processes',
      ],
      correctIndex: 1,
      explanation:
          'The Denis three-column model divides the spine into: Anterior column = anterior longitudinal ligament (ALL), anterior annulus fibrosus, and anterior half of the vertebral body. Middle column = posterior longitudinal ligament (PLL), posterior annulus fibrosus, and posterior wall of the vertebral body. Posterior column = supraspinous/interspinous ligaments, ligamentum flavum, facet capsules, and posterior bony elements. Instability is defined as failure of two or more columns. The middle column is considered the most important for stability.',
      moduleId: 'pathophysiology',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'Type II odontoid fractures in elderly patients have a nonunion rate of approximately:',
      options: [
        '5-10%',
        '15-20%',
        '26-36%',
        '50-60%',
      ],
      correctIndex: 2,
      explanation:
          'Type II odontoid (dens) fractures occur through the base of the odontoid process and have a notoriously high nonunion rate of 26-36% in elderly patients treated conservatively with external immobilization. The poor blood supply at the base of the dens contributes to this high nonunion rate. Type I fractures (tip avulsion) and Type III fractures (extending into the C2 body with its cancellous bone) have much better healing rates. Surgical fixation (anterior odontoid screw or posterior C1-C2 fusion) may be considered in elderly patients to improve union rates.',
      moduleId: 'pathophysiology',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'The SOMI (sternal-occipital-mandibular immobilizer) orthosis provides approximately 93% restriction of cervical flexion but only what percentage of extension restriction?',
      options: [
        '93%',
        '72%',
        '42%',
        '15%',
      ],
      correctIndex: 2,
      explanation:
          'The SOMI brace provides excellent restriction of cervical flexion (approximately 93%) but poor restriction of extension (approximately 42%). This is because its design relies on sternal, mandibular, and occipital contact points that primarily resist forward motion. For injuries requiring extension restriction, a cervicothoracic orthosis (CTO) such as a Minerva brace, Yale brace, or a halo vest is more appropriate. The halo vest remains the most rigid cervical orthosis, restricting approximately 96% of flexion-extension.',
      moduleId: 'pathophysiology',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'Chance fractures (flexion-distraction injuries) are associated with concurrent abdominal visceral injury in approximately what percentage of cases?',
      options: [
        '10%',
        '25%',
        '50%',
        '75%',
      ],
      correctIndex: 2,
      explanation:
          'Chance fractures are associated with abdominal organ injuries (bowel, mesentery, spleen, pancreas, kidney) in approximately 50% of cases. These injuries classically occur from lap seatbelt restraints during motor vehicle accidents, where the seatbelt acts as a fulcrum causing a flexion-distraction mechanism through all three spinal columns. The same force that causes the spinal injury compresses the abdominal viscera. A thorough abdominal evaluation (CT abdomen/pelvis) is mandatory in all patients with Chance-type fractures.',
      moduleId: 'pathophysiology',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'SCIWORA (Spinal Cord Injury Without Radiographic Abnormality) is more common in pediatric patients because:',
      options: [
        'Children have a higher incidence of penetrating spinal injuries',
        'The pediatric spine can stretch up to 5 cm without disruption, but the spinal cord ruptures after only 5-6 mm of stretch',
        'Pediatric spinal cords have less myelin and are more vulnerable to compression',
        'Children have larger spinal canals relative to the spinal cord',
      ],
      correctIndex: 1,
      explanation:
          'SCIWORA occurs because the pediatric spine is inherently more elastic than the spinal cord. The immature vertebral column (with its cartilaginous end plates, horizontally oriented facets, and ligamentous laxity) can stretch up to 5 cm without disruption, while the spinal cord ruptures after only 5-6 mm of elongation. This differential elasticity allows the spine to momentarily deform (causing cord injury) and then recoil to its normal position, leaving no evidence on plain radiographs or CT. MRI can detect intramedullary signal abnormalities. SCIWORA accounts for up to 20-30% of pediatric SCIs.',
      moduleId: 'pathophysiology',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'The primary mechanism of secondary injury during the acute vascular phase (first few hours) after SCI involves:',
      options: [
        'Wallerian degeneration of axons',
        'Hemorrhagic necrosis of central gray matter and ischemia from vasospasm, thrombosis, and loss of autoregulation',
        'Demyelination of white matter tracts by oligodendrocyte apoptosis',
        'Glial scar formation blocking axonal regeneration',
      ],
      correctIndex: 1,
      explanation:
          'The acute vascular phase of secondary injury (minutes to hours) is characterized by hemorrhagic necrosis of the central gray matter (which has a higher metabolic demand and richer blood supply) and progressive ischemia. Vasospasm of the anterior spinal artery and its sulcal branches, microthrombosis, and loss of autoregulation contribute to expanding ischemia. Hemorrhage begins centrally and extends outward. Later phases involve excitotoxicity (hours), inflammatory cell infiltration (days), and apoptosis/demyelination (days to weeks).',
      moduleId: 'pathophysiology',
      difficulty: 'intermediate',
    ),

    // =====================================================================
    // NEUROGENIC BLADDER — NEW
    // =====================================================================
    QuizQuestion(
      question:
          'Detrusor-sphincter dyssynergia (DSD) occurs in suprasacral SCI due to loss of coordination from which brainstem center?',
      options: [
        'Medullary reticular formation',
        'Pontine micturition center (Barrington nucleus)',
        'Locus coeruleus',
        'Nucleus ambiguus',
      ],
      correctIndex: 1,
      explanation:
          'The pontine micturition center (PMC, also called Barrington nucleus or the M-region of the pons) coordinates normal voiding by simultaneously activating detrusor contraction and inhibiting external urethral sphincter activity. In suprasacral SCI, the spinal micturition reflex arc (S2-S4) is intact but is disconnected from the PMC. This loss of pontine coordination results in simultaneous contraction of the detrusor and external sphincter (DSD), generating dangerous intravesical pressures that can lead to upper tract deterioration.',
      moduleId: 'neurogenic-bladder',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'What detrusor leak point pressure (DLPP) threshold, identified by McGuire, is associated with upper urinary tract deterioration?',
      options: [
        '20 cmH2O',
        '40 cmH2O',
        '60 cmH2O',
        '80 cmH2O',
      ],
      correctIndex: 1,
      explanation:
          'McGuire demonstrated that sustained detrusor leak point pressures (DLPP) above 40 cmH2O are associated with a high risk of upper urinary tract deterioration, including vesicoureteral reflux, hydronephrosis, and renal damage. This landmark finding established 40 cmH2O as the critical threshold for guiding bladder management decisions. Patients with DLPP above this threshold require treatment to reduce intravesical pressures, typically with anticholinergic medications and clean intermittent catheterization. Urodynamic monitoring is essential.',
      moduleId: 'neurogenic-bladder',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'The neurogenic bladder dysfunction classification matrix categorizes problems by the combination of:',
      options: [
        'Injury level (cervical vs. thoracic) and completeness (A vs. B)',
        'Failure to store vs. failure to empty, due to either the bladder (detrusor) or the outlet (sphincter)',
        'Sympathetic vs. parasympathetic dysfunction',
        'Acute vs. chronic phase of injury',
      ],
      correctIndex: 1,
      explanation:
          'The functional classification of neurogenic bladder dysfunction uses a 2x2 matrix: the problem is either failure to STORE or failure to EMPTY, and the cause is either the BLADDER (detrusor) or the OUTLET (sphincter). This yields four categories: (1) Failure to store/bladder = detrusor overactivity, (2) Failure to store/outlet = sphincter incompetence, (3) Failure to empty/bladder = detrusor underactivity, (4) Failure to empty/outlet = DSD or sphincter obstruction. A patient can have problems in more than one category.',
      moduleId: 'neurogenic-bladder',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'A known complication of augmentation cystoplasty (bladder augmentation using bowel segment) includes:',
      options: [
        'Spontaneous voiding recovery',
        'Metabolic acidosis from bowel mucosa absorbing urinary solutes, mucus production, and risk of perforation',
        'Resolution of detrusor overactivity without need for CIC',
        'Improved natural sensation of bladder fullness',
      ],
      correctIndex: 1,
      explanation:
          'Augmentation cystoplasty uses a detubularized segment of bowel (usually ileum) to increase bladder capacity and reduce intravesical pressures. Complications include: metabolic hyperchloremic acidosis (bowel mucosa absorbs chloride and ammonium from urine), excessive mucus production (requiring bladder irrigation), risk of perforation (reduced bladder sensation), vitamin B12 deficiency (if ileum is used), and a small long-term risk of malignancy at the anastomosis site. Patients must perform CIC lifelong after augmentation.',
      moduleId: 'neurogenic-bladder',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'Capsaicin and resiniferatoxin have been investigated for intravesical use in neurogenic detrusor overactivity because they:',
      options: [
        'Stimulate detrusor contraction to improve emptying',
        'Desensitize C-fiber afferents, reducing involuntary detrusor contractions',
        'Strengthen the external urethral sphincter',
        'Promote bladder mucosal regeneration',
      ],
      correctIndex: 1,
      explanation:
          'Capsaicin (from chili peppers) and its ultra-potent analog resiniferatoxin act on TRPV1 (vanilloid) receptors on C-fiber bladder afferents. After SCI, a switch from A-delta to C-fiber mediated micturition reflex contributes to detrusor overactivity. Intravesical instillation of these agents causes initial C-fiber excitation followed by desensitization, reducing involuntary detrusor contractions. Resiniferatoxin is approximately 1000 times more potent than capsaicin with less initial irritation. These are considered investigational alternatives when standard treatments fail.',
      moduleId: 'neurogenic-bladder',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'Urea-splitting organisms such as Proteus mirabilis are clinically significant in SCI patients because they cause:',
      options: [
        'Hemorrhagic cystitis',
        'Alkaline urine that promotes struvite (magnesium ammonium phosphate) calculi formation',
        'Direct nephrotoxicity',
        'Antibiotic resistance to all cephalosporins',
      ],
      correctIndex: 1,
      explanation:
          'Urea-splitting organisms (Proteus, Klebsiella, Pseudomonas, some Staphylococcus) produce urease, which hydrolyzes urea into ammonia and carbon dioxide. This alkalinizes the urine (pH >7.2), which promotes precipitation of magnesium ammonium phosphate (struvite) and calcium phosphate (apatite) crystals, forming infection stones (staghorn calculi). SCI patients are at high risk due to neurogenic bladder, chronic catheterization, urinary stasis, and recurrent UTIs. Prevention involves adequate hydration, regular catheterization, and prompt treatment of UTIs.',
      moduleId: 'neurogenic-bladder',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'Botulinum toxin injection into the detrusor muscle for neurogenic detrusor overactivity works by:',
      options: [
        'Blocking nicotinic receptors at the neuromuscular junction',
        'Inhibiting acetylcholine release from parasympathetic nerve terminals at the detrusor muscle',
        'Directly relaxing smooth muscle calcium channels',
        'Stimulating beta-3 adrenergic receptors on the detrusor',
      ],
      correctIndex: 1,
      explanation:
          'OnabotulinumtoxinA (Botox) injected into the detrusor muscle inhibits the release of acetylcholine from parasympathetic nerve terminals by cleaving SNARE proteins (specifically SNAP-25), preventing vesicle fusion and neurotransmitter release. This reduces involuntary detrusor contractions, increases bladder capacity, and lowers intravesical pressures. The typical dose is 200 units for neurogenic detrusor overactivity. Effects last 6-9 months, and repeat injections are required. CIC may be needed post-injection due to urinary retention.',
      moduleId: 'neurogenic-bladder',
      difficulty: 'intermediate',
    ),

    // =====================================================================
    // NEUROGENIC BOWEL — NEW
    // =====================================================================
    QuizQuestion(
      question:
          'The internal anal sphincter (IAS) provides approximately what percentage of resting anal tone?',
      options: [
        '30-40%',
        '50-60%',
        '70-85%',
        '95-100%',
      ],
      correctIndex: 2,
      explanation:
          'The internal anal sphincter (IAS), a smooth muscle structure under autonomic (involuntary) control, provides 70-85% of resting anal continence tone. The external anal sphincter (EAS), a striated muscle under somatic (voluntary, pudendal nerve S2-S4) control, provides the remaining 15-30% and is responsible for voluntary squeeze and the continence reflex during sudden increases in intra-abdominal pressure. In LMN bowel, the EAS is flaccid, leaving only the IAS for continence, which is often insufficient.',
      moduleId: 'neurogenic-bowel',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'PEG-based (polyethylene glycol-based) bisacodyl suppositories are preferred over hydrogenated vegetable oil-based suppositories primarily because:',
      options: [
        'They are less expensive',
        'They dissolve faster, resulting in a shorter bowel program time',
        'They have fewer systemic side effects',
        'They are available over the counter',
      ],
      correctIndex: 1,
      explanation:
          'PEG-based (polyethylene glycol) bisacodyl suppositories dissolve at body temperature more rapidly than hydrogenated vegetable oil (HVO)-based suppositories, resulting in faster contact with the rectal mucosa and a significantly shorter bowel program duration (often 30-60 minutes shorter). Shorter bowel program time improves patient quality of life, reduces caregiver burden, and decreases time on the commode (reducing pressure injury risk). The active ingredient (bisacodyl) is the same in both formulations.',
      moduleId: 'neurogenic-bowel',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'For acute colonic pseudo-obstruction (Ogilvie syndrome) refractory to conservative management in an SCI patient, which pharmacologic agent can be administered to promote colonic decompression?',
      options: [
        'Metoclopramide 10 mg IV',
        'Neostigmine 2 mg IV with cardiac monitoring',
        'Ondansetron 4 mg IV',
        'Methylnaltrexone 8 mg subcutaneous',
      ],
      correctIndex: 1,
      explanation:
          'Neostigmine (2 mg IV given over 3-5 minutes) is used for acute colonic pseudo-obstruction (Ogilvie syndrome) that fails conservative management (NPO, NG tube, rectal tube, correction of electrolytes, discontinuation of opioids/anticholinergics). As an acetylcholinesterase inhibitor, it increases parasympathetic stimulation to the colon, promoting motility and decompression. It must be given with continuous cardiac monitoring because it can cause symptomatic bradycardia (atropine should be at bedside). Cecal diameter >12 cm carries risk of perforation.',
      moduleId: 'neurogenic-bowel',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'Superior mesenteric artery (SMA) syndrome in SCI patients is caused by compression of the duodenum when the aortomesenteric angle decreases below:',
      options: [
        '45 degrees',
        '25 degrees',
        '60 degrees',
        '10 degrees',
      ],
      correctIndex: 1,
      explanation:
          'SMA syndrome occurs when the third portion of the duodenum is compressed between the SMA and the aorta. Normally the aortomesenteric angle is 38-65 degrees, maintained by retroperitoneal fat. When this angle narrows below 25 degrees (or the aortomesenteric distance decreases below 8 mm), duodenal compression occurs. SCI patients are at risk due to rapid weight loss, prolonged supine positioning, and body cast/brace application. Symptoms include bilious vomiting, abdominal distension, and weight loss. Treatment includes nutritional support, left lateral or prone positioning, and potentially duodenojejunostomy.',
      moduleId: 'neurogenic-bowel',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'Which gastric motility medication should be used with caution in SCI patients with injuries at T6 and above because it can mask the symptoms of AD?',
      options: [
        'Polyethylene glycol',
        'Metoclopramide',
        'Senna',
        'Docusate',
      ],
      correctIndex: 1,
      explanation:
          'Metoclopramide is a dopamine antagonist used to enhance gastric motility. It can also lower the blood pressure through its anti-dopaminergic effects, which may mask the hypertensive symptoms of autonomic dysreflexia in susceptible patients (T6 and above). Additionally, fecal impaction and bowel distension (the second most common AD trigger) may go unrecognized if GI symptoms are suppressed. Clinicians should be cautious with any medication that may mask or alter the presentation of AD in at-risk patients.',
      moduleId: 'neurogenic-bowel',
      difficulty: 'intermediate',
    ),

    // =====================================================================
    // AUTONOMIC DYSREFLEXIA — NEW
    // =====================================================================
    QuizQuestion(
      question:
          'Silent autonomic dysreflexia (asymptomatic AD) has been documented in approximately what percentage of AD episodes in monitored studies?',
      options: [
        '5%',
        '15%',
        '43%',
        '80%',
      ],
      correctIndex: 2,
      explanation:
          'Studies using ambulatory blood pressure monitoring have demonstrated that approximately 43% of AD episodes are asymptomatic (silent AD), meaning significant blood pressure elevations occur without the patient experiencing typical symptoms such as headache, sweating, or flushing. Silent AD is clinically concerning because patients may not seek treatment, leading to sustained hypertensive episodes that can cause end-organ damage over time. This finding supports the importance of routine blood pressure monitoring during provocative procedures (urodynamics, bowel programs) in at-risk patients.',
      moduleId: 'autonomic-dysreflexia',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'A patient with T4 SCI is using nitroglycerin paste to manage an episode of AD. Which medication class is ABSOLUTELY CONTRAINDICATED due to risk of life-threatening hypotension?',
      options: [
        'Calcium channel blockers (nifedipine)',
        'PDE5 inhibitors (sildenafil, tadalafil)',
        'Alpha-1 blockers (prazosin)',
        'ACE inhibitors (captopril)',
      ],
      correctIndex: 1,
      explanation:
          'PDE5 inhibitors (sildenafil, tadalafil, vardenafil) are absolutely contraindicated with nitrates (nitroglycerin paste, sublingual nitroglycerin). Both drugs cause vasodilation through the nitric oxide-cGMP pathway, and their combined use can cause severe, refractory, life-threatening hypotension. This is particularly relevant in SCI patients because PDE5 inhibitors are commonly used for erectile dysfunction. Clinicians and patients must be aware that if a PDE5 inhibitor has been used recently (within 24-72 hours depending on the agent), nitrates must NOT be used for AD management; nifedipine should be used instead.',
      moduleId: 'autonomic-dysreflexia',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'In a pregnant woman with SCI at T5, the presentation of autonomic dysreflexia during labor can be confused with:',
      options: [
        'Gestational diabetes',
        'Preeclampsia/eclampsia',
        'Placenta previa',
        'Postpartum depression',
      ],
      correctIndex: 1,
      explanation:
          'AD during labor in women with SCI at T6 and above can mimic preeclampsia/eclampsia, as both present with hypertension and potentially headache. However, AD is episodic (triggered by uterine contractions), associated with bradycardia (preeclampsia has tachycardia), and has sweating/flushing above the injury level. Preeclampsia typically has proteinuria and edema. Distinguishing between these conditions is critical because treatment differs: AD requires identifying and removing the noxious stimulus (epidural anesthesia can prevent AD during labor), while preeclampsia requires delivery and possibly magnesium sulfate.',
      moduleId: 'autonomic-dysreflexia',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'ECG changes observed during episodes of autonomic dysreflexia can include:',
      options: [
        'Only sinus tachycardia',
        'QT prolongation, premature ventricular contractions, and risk of reentrant arrhythmias',
        'Persistent ST elevation indicating acute MI',
        'Right bundle branch block only',
      ],
      correctIndex: 1,
      explanation:
          'AD episodes can cause significant ECG changes including QT prolongation, premature atrial and ventricular contractions (PACs, PVCs), ST-T wave changes, and risk of reentrant arrhythmias due to the extreme autonomic imbalance (massive sympathetic activation below the lesion with parasympathetic dominance above). Severe, prolonged AD episodes can lead to myocardial ischemia and even infarction. Bradycardia is the most common rhythm change due to vagal (parasympathetic) response to hypertension. Cardiac monitoring is warranted during severe AD episodes.',
      moduleId: 'autonomic-dysreflexia',
      difficulty: 'board',
    ),

    // =====================================================================
    // RESPIRATORY — NEW
    // =====================================================================
    QuizQuestion(
      question:
          'A vital capacity below what threshold generally indicates the need for ventilatory support in acute SCI?',
      options: [
        '3 liters',
        '2 liters',
        '1 liter',
        '500 mL',
      ],
      correctIndex: 2,
      explanation:
          'A vital capacity (VC) below 1 liter (approximately 15-20 mL/kg) is generally considered the threshold for ventilatory support in acute SCI. Other indications include progressive decline in VC, PaO2 <60 mmHg, PaCO2 >50 mmHg, and respiratory fatigue. Serial VC measurements (every 4-6 hours in acute cervical SCI) are critical because respiratory function may deteriorate in the first 48-72 hours due to ascending cord edema. Patients with VC 1-1.5 liters should be closely monitored in an ICU setting.',
      moduleId: 'respiratory',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'Paradoxical breathing pattern in high cervical SCI is characterized by:',
      options: [
        'Normal chest and abdominal wall movement during inspiration',
        'Inward movement of the chest wall with outward abdominal distension during inspiration',
        'Symmetric bilateral chest expansion with no abdominal movement',
        'Outward movement of the chest wall with inward abdominal retraction during inspiration',
      ],
      correctIndex: 1,
      explanation:
          'Paradoxical breathing occurs when the diaphragm contracts (moving the abdomen outward) during inspiration, but the paralyzed intercostal muscles cannot stabilize the rib cage, causing the chest wall to be drawn inward by the negative intrathoracic pressure generated by diaphragmatic descent. This inefficient breathing pattern increases the work of breathing and reduces tidal volume. It is most prominent in the supine position initially but may improve over time as spasticity develops in the intercostal muscles, providing passive chest wall stabilization.',
      moduleId: 'respiratory',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'In patients with chronic cervical SCI, forced vital capacity (FVC) may paradoxically IMPROVE over the first several months due to:',
      options: [
        'Regeneration of phrenic nerve axons',
        'Development of intercostal spasticity providing passive chest wall stabilization',
        'Compensatory lung hypertrophy',
        'Resolution of pulmonary edema',
      ],
      correctIndex: 1,
      explanation:
          'As spasticity develops in the intercostal muscles (typically weeks to months after injury), the chest wall becomes passively stabilized, reducing paradoxical chest wall motion during inspiration. This improved chest wall mechanics results in a measurable increase in FVC and other pulmonary function parameters. This improvement is one example of spasticity having a beneficial functional effect. However, patients remain at significant risk for respiratory complications due to impaired cough and secretion clearance.',
      moduleId: 'respiratory',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'Phrenic nerve pacing (diaphragm pacing) for ventilator-dependent patients with high cervical SCI requires:',
      options: [
        'Intact C3-C5 lower motor neurons (phrenic nerve must be intact)',
        'Only intact C1-C2 upper motor neurons',
        'An intact vagus nerve',
        'Intact intercostal muscle innervation at T1-T6',
      ],
      correctIndex: 0,
      explanation:
          'Phrenic nerve pacing requires intact C3-C5 lower motor neurons (anterior horn cells) and intact phrenic nerves bilaterally. The pacer stimulates the phrenic nerve, causing diaphragmatic contraction for inspiration. Candidates must have bilateral phrenic nerve integrity confirmed by phrenic nerve conduction studies and/or fluoroscopic assessment of diaphragm movement with electrical stimulation. Patients with lower motor neuron damage at C3-C5 (e.g., extensive anterior horn cell destruction) are NOT candidates. Phrenic pacing can improve quality of life by eliminating or reducing ventilator dependence.',
      moduleId: 'respiratory',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'Glossopharyngeal breathing (frog breathing) in patients with high cervical SCI assists ventilation by:',
      options: [
        'Strengthening the diaphragm through exercise',
        'Using the tongue and pharyngeal muscles to sequentially gulp air into the lungs',
        'Recruiting accessory muscles of the neck',
        'Creating negative pressure through pursed lip exhalation',
      ],
      correctIndex: 1,
      explanation:
          'Glossopharyngeal breathing (GPB) is a technique in which the patient uses the tongue, pharynx, and larynx to sequentially gulp small volumes of air (40-200 mL per gulp) into the lungs, progressively increasing lung volume. Multiple gulps (6-9) constitute one breath. GPB can provide temporary ventilator-free breathing time for patients who are otherwise ventilator dependent, serving as a safety mechanism during equipment failure. It can add 500-1000 mL to vital capacity and is taught as a key self-rescue technique.',
      moduleId: 'respiratory',
      difficulty: 'intermediate',
    ),

    // =====================================================================
    // CARDIOVASCULAR — NEW
    // =====================================================================
    QuizQuestion(
      question:
          'The characteristic cardiovascular transition seen over time in high-level SCI is:',
      options: [
        'Persistent neurogenic shock throughout life',
        'Transition from orthostatic hypotension in the acute phase to risk of autonomic dysreflexia in the chronic phase',
        'Progressive hypertension due to renal artery stenosis',
        'Normalization of all cardiovascular parameters within 6 months',
      ],
      correctIndex: 1,
      explanation:
          'Patients with high-level SCI (at or above T6) characteristically transition from a state dominated by orthostatic hypotension and neurogenic shock in the acute phase (due to loss of sympathetic vascular tone) to a chronic state where autonomic dysreflexia becomes the predominant cardiovascular concern. This transition occurs as spinal reflex circuits below the injury reorganize and become hyperexcitable. Both conditions reflect the underlying disruption of supraspinal sympathetic control, but they manifest differently as the neurological state evolves.',
      moduleId: 'cardiovascular',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'Current guidelines recommend initiating LMWH for DVT prophylaxis in acute SCI within what time frame?',
      options: [
        '6 hours',
        '24 hours',
        '72 hours',
        '7 days',
      ],
      correctIndex: 2,
      explanation:
          'LMWH (e.g., enoxaparin) for DVT prophylaxis should be initiated within 72 hours of acute SCI, provided there are no active hemorrhagic contraindications. Prophylaxis should continue for at least 8-12 weeks post-injury (the highest risk period for thromboembolic events). Mechanical prophylaxis (pneumatic compression devices, graduated compression stockings) should begin immediately on admission and be used in conjunction with pharmacologic prophylaxis. IVC filter placement may be considered when anticoagulation is absolutely contraindicated.',
      moduleId: 'cardiovascular',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'The mnemonic for remembering that poikilothermia (impaired temperature regulation) occurs with SCI at or above T8 is:',
      options: [
        '"T-EIGHT-ture" (temperature)',
        '"T8 = thermostat off"',
        '"Eight is great for heat"',
        '"C3-4-5 keeps alive"',
      ],
      correctIndex: 0,
      explanation:
          'The mnemonic "temp-EIGHT-ture" helps recall that injuries at or above T8 are associated with significant poikilothermia (inability to regulate body temperature). At this level and above, sufficient loss of sympathetic control over cutaneous blood flow, sweating, and shivering impairs the body\'s thermoregulatory responses below the injury level. Patients become susceptible to both hypothermia and hyperthermia based on environmental conditions. Higher injuries (cervical) produce more severe poikilothermia.',
      moduleId: 'cardiovascular',
      difficulty: 'intermediate',
    ),
    QuizQuestion(
      question:
          'Takotsubo cardiomyopathy (stress-induced cardiomyopathy) in acute SCI is characterized by:',
      options: [
        'Coronary artery occlusion causing territorial infarction',
        'Transient left ventricular apical ballooning with wall motion abnormalities in the absence of obstructive coronary disease',
        'Chronic progressive dilated cardiomyopathy',
        'Right ventricular failure from pulmonary hypertension',
      ],
      correctIndex: 1,
      explanation:
          'Takotsubo cardiomyopathy (stress cardiomyopathy) can occur in acute SCI, particularly cervical injuries, due to the catecholamine surge during the acute injury. It presents with chest pain, ECG changes mimicking myocardial infarction (ST elevation, T-wave inversions), elevated troponin, and characteristic transient apical ballooning of the left ventricle on echocardiography. Coronary angiography reveals no obstructive coronary disease. It is usually reversible with supportive care. Awareness is important to avoid unnecessary invasive coronary interventions.',
      moduleId: 'cardiovascular',
      difficulty: 'board',
    ),

    // =====================================================================
    // SPASTICITY — NEW
    // =====================================================================
    QuizQuestion(
      question:
          'In the Tardieu Scale assessment of spasticity, R1 and R2 represent:',
      options: [
        'R1 = resting muscle tone, R2 = tone during voluntary contraction',
        'R1 = angle of catch at fast velocity (dynamic component), R2 = passive range of motion at slow velocity (static component)',
        'R1 = strength of spastic reflex, R2 = frequency of spasms',
        'R1 = right side, R2 = left side',
      ],
      correctIndex: 1,
      explanation:
          'The Tardieu Scale assesses spasticity by comparing muscle reaction at different velocities of stretch. R1 is the angle of muscle reaction (catch or clonus) during a FAST passive stretch (capturing the dynamic/velocity-dependent component of spasticity). R2 is the passive range of motion measured during a SLOW stretch (capturing the static component, including contracture). The difference between R2 and R1 represents the dynamic component of spasticity amenable to treatment with antispasticity agents. A small R2-R1 difference suggests fixed contracture.',
      moduleId: 'spasticity',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'The antibiotic ciprofloxacin is dangerous to co-administer with tizanidine because:',
      options: [
        'Ciprofloxacin induces CYP3A4, accelerating tizanidine metabolism',
        'Ciprofloxacin inhibits CYP1A2, causing up to a 10-fold increase in tizanidine serum levels',
        'Both drugs cause QT prolongation through the same mechanism',
        'Ciprofloxacin converts tizanidine to a toxic metabolite',
      ],
      correctIndex: 1,
      explanation:
          'Ciprofloxacin is a potent inhibitor of CYP1A2, which is the primary hepatic enzyme responsible for tizanidine metabolism. Co-administration can increase tizanidine serum levels by up to 10-fold, causing severe hypotension, excessive sedation, and potentially dangerous bradycardia. This is a clinically critical drug interaction because both drugs are commonly prescribed in the SCI population (ciprofloxacin for UTIs, tizanidine for spasticity). Other CYP1A2 inhibitors (fluvoxamine) pose similar risks. Alternative antibiotics or antispasticity agents should be used.',
      moduleId: 'spasticity',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'Intrathecal baclofen (ITB) pump withdrawal is considered a medical emergency. The recommended rescue medication for acute ITB withdrawal is:',
      options: [
        'Oral baclofen only',
        'Cyproheptadine (serotonin antagonist) along with benzodiazepines and reinstitution of intrathecal baclofen',
        'IV methylprednisolone',
        'Dantrolene sodium IV',
      ],
      correctIndex: 1,
      explanation:
          'ITB withdrawal is a potentially fatal medical emergency presenting with rebound spasticity, hyperthermia, rhabdomyolysis, disseminated intravascular coagulation (DIC), multi-organ failure, and seizures. It can mimic neuroleptic malignant syndrome or malignant hyperthermia. Management includes: (1) reinstitution of intrathecal baclofen delivery (troubleshoot pump/catheter), (2) cyproheptadine (serotonin antagonist) as a specific rescue agent, (3) high-dose oral baclofen and benzodiazepines as temporizing measures, (4) supportive care in ICU. Dantrolene may help with hyperthermia but does not address the underlying mechanism.',
      moduleId: 'spasticity',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'Which antispasticity medication is the ONLY one that acts peripherally at the skeletal muscle level?',
      options: [
        'Baclofen',
        'Tizanidine',
        'Diazepam',
        'Dantrolene sodium',
      ],
      correctIndex: 3,
      explanation:
          'Dantrolene sodium is the only commonly used oral antispasticity agent that acts peripherally at the skeletal muscle level. It works by inhibiting calcium release from the sarcoplasmic reticulum, directly reducing the force of muscle contraction. All other first-line antispasticity agents act centrally: baclofen (GABA-B agonist in the spinal cord), tizanidine (alpha-2 adrenergic agonist in the brainstem/spinal cord), and diazepam (GABA-A receptor modulator in the CNS). Dantrolene carries a risk of hepatotoxicity requiring liver function monitoring.',
      moduleId: 'spasticity',
      difficulty: 'intermediate',
    ),
    QuizQuestion(
      question:
          'Abrupt discontinuation of oral baclofen can cause:',
      options: [
        'Only mild rebound spasticity',
        'Seizures, hallucinations, hyperthermia, and potentially fatal withdrawal syndrome',
        'Peripheral neuropathy',
        'Permanent increase in spasticity',
      ],
      correctIndex: 1,
      explanation:
          'Abrupt discontinuation of oral baclofen can precipitate a life-threatening withdrawal syndrome including seizures, hallucinations, psychosis, hyperthermia, rebound severe spasticity, rhabdomyolysis, and multi-organ failure. This occurs because chronic baclofen use causes downregulation of GABA-B receptors; sudden removal leads to uncontrolled excitatory neural activity. Baclofen must always be tapered gradually (reduce by 5-10 mg every few days). This risk exists for both oral and intrathecal baclofen, with ITB withdrawal being even more severe due to higher CNS concentrations.',
      moduleId: 'spasticity',
      difficulty: 'board',
    ),

    // =====================================================================
    // PAIN SYNDROMES — NEW
    // =====================================================================
    QuizQuestion(
      question:
          'Which medication is the ONLY one with FDA approval specifically for neuropathic pain related to spinal cord injury?',
      options: [
        'Gabapentin',
        'Amitriptyline',
        'Pregabalin',
        'Duloxetine',
      ],
      correctIndex: 2,
      explanation:
          'Pregabalin (Lyrica) is the ONLY medication with FDA approval specifically for the treatment of neuropathic pain associated with spinal cord injury. It binds to the alpha-2-delta subunit of voltage-gated calcium channels, reducing excitatory neurotransmitter release. While gabapentin has a similar mechanism, it has not received specific FDA approval for SCI neuropathic pain. Pregabalin has Level 1 evidence (multiple RCTs) supporting its efficacy in SCI neuropathic pain. Common side effects include dizziness, somnolence, weight gain, and peripheral edema.',
      moduleId: 'pain-syndromes',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'In the ISCIP (International Spinal Cord Injury Pain) classification, Tier 1 categorizes pain as:',
      options: [
        'Mild, moderate, or severe',
        'Nociceptive or neuropathic',
        'Acute, subacute, or chronic',
        'Central or peripheral',
      ],
      correctIndex: 1,
      explanation:
          'The ISCIP classification uses a three-tier system. Tier 1 divides SCI pain into two broad categories: nociceptive and neuropathic. Tier 2 further classifies each type: nociceptive into musculoskeletal and visceral; neuropathic into at-level, below-level, and other neuropathic pain. Tier 3 specifies the primary pain source or pathology (e.g., shoulder impingement, syringomyelia, compressive neuropathy). This systematic classification framework improves communication, guides treatment selection, and facilitates research across centers.',
      moduleId: 'pain-syndromes',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'At-level neuropathic pain in SCI is defined as pain occurring within how many dermatomes of the neurological level of injury?',
      options: [
        'At the exact level only',
        'Within 1 dermatome above or below',
        'Within 3 dermatomes above or below (plus/minus 3)',
        'Within 5 dermatomes below only',
      ],
      correctIndex: 2,
      explanation:
          'At-level neuropathic pain is defined as neuropathic pain perceived within plus or minus 3 dermatomes of the neurological level of injury (NLI). Pain more than 3 dermatomes below the NLI is classified as below-level neuropathic pain. At-level pain is thought to arise from damage to the nerve roots, dorsal root entry zone, or spinal cord gray matter at the level of injury, while below-level pain is attributed to abnormal processing in the central somatosensory pathways. The two types may respond differently to treatment.',
      moduleId: 'pain-syndromes',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'DREZ (Dorsal Root Entry Zone) lesioning for intractable at-level neuropathic pain targets which Rexed laminae of the spinal cord?',
      options: [
        'Laminae VI-IX (ventral horn motor neurons)',
        'Laminae I-V (dorsal horn sensory processing)',
        'Lamina X (central canal region)',
        'Laminae VII-VIII (intermediate zone)',
      ],
      correctIndex: 1,
      explanation:
          'DREZ lesioning is a neurosurgical procedure that creates thermal lesions in Rexed laminae I-V of the dorsal horn at the level of injury. These laminae contain the neurons responsible for receiving, processing, and transmitting nociceptive (pain) signals, including the substantia gelatinosa (lamina II) where C-fiber and A-delta afferents synapse. By destroying these hyperactive pain processing neurons, DREZ lesioning can provide significant relief for intractable at-level neuropathic pain, particularly segmental, burning, or lancinating pain. It is most effective for at-level rather than below-level pain.',
      moduleId: 'pain-syndromes',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'Below-level neuropathic pain in SCI is generally the most difficult pain type to treat. Which of the following is true regarding this pain?',
      options: [
        'It only occurs in complete (ASIA A) injuries',
        'It is perceived diffusely below the NLI, is often described as burning or tingling, and may be present in areas with no sensation to examination',
        'It responds well to NSAIDs and acetaminophen',
        'Surgical decompression typically resolves it',
      ],
      correctIndex: 1,
      explanation:
          'Below-level neuropathic pain occurs more than 3 dermatomes below the NLI. It is described as burning, tingling, squeezing, or electric and can be perceived in areas with complete sensory loss on clinical examination (phantom-type pain). It occurs in both complete and incomplete injuries. It is thought to arise from central sensitization and reorganization of spinal cord and supraspinal somatosensory processing. Treatment is challenging; first-line agents include pregabalin and gabapentin, but response rates are moderate at best.',
      moduleId: 'pain-syndromes',
      difficulty: 'intermediate',
    ),

    // =====================================================================
    // PRESSURE INJURIES — NEW
    // =====================================================================
    QuizQuestion(
      question:
          'According to the NPUAP guidelines, once a pressure injury has been staged, it should:',
      options: [
        'Be reverse-staged as it heals (e.g., Stage 4 becomes Stage 3, then Stage 2)',
        'NOT be reverse-staged; a healing Stage 4 is documented as "healing Stage 4" or "Stage 4 with granulation"',
        'Be restaged weekly based on current wound appearance',
        'Be reclassified as unstageable once it begins healing',
      ],
      correctIndex: 1,
      explanation:
          'The NPUAP explicitly states that pressure injuries should NOT be reverse-staged. A Stage 4 pressure injury that is healing does not become a Stage 3 or Stage 2 because the tissue that fills the wound is granulation and scar tissue, not the muscle, subcutaneous fat, and dermis that were originally lost. Reverse-staging falsely implies that original tissue has been restored. Proper documentation describes the wound as "healing Stage 4" with descriptors of the wound bed (granulation percentage, dimensions, drainage).',
      moduleId: 'pressure-injuries',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'A pressure injury involving a mucosal membrane (e.g., from a medical device in the mouth or urethra) is classified as:',
      options: [
        'Stage 1',
        'Stage 2',
        'Mucosal membrane pressure injury (cannot be numerically staged)',
        'Deep tissue pressure injury',
      ],
      correctIndex: 2,
      explanation:
          'Mucosal membrane pressure injuries are found on mucous membranes (oral, urethral, vaginal, rectal) with a history of a medical device in use at the location. Due to the anatomy of mucosal tissues (no keratinized epithelium, no subcutaneous tissue layers comparable to skin), these injuries CANNOT be numerically staged using the standard NPUAP staging system. They are simply documented as "mucosal membrane pressure injury." Common causes include endotracheal tubes, nasogastric tubes, urinary catheters, and oral airways.',
      moduleId: 'pressure-injuries',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'The probe-to-bone test for osteomyelitis underlying a pressure injury has an approximate positive predictive value of:',
      options: [
        '50%',
        '65%',
        '89%',
        '99%',
      ],
      correctIndex: 2,
      explanation:
          'The probe-to-bone test (using a sterile metal probe to palpate bone through a wound) has a positive predictive value of approximately 89% for osteomyelitis in the setting of pressure injuries. If the probe touches bone, there is a very high likelihood of osteomyelitis. This simple bedside test can help guide the need for further imaging (MRI is the most sensitive and specific imaging modality) and biopsy (bone biopsy with culture is the gold standard for confirming osteomyelitis and identifying the causative organism). A negative probe-to-bone test does not exclude osteomyelitis.',
      moduleId: 'pressure-injuries',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'For assessing nutritional status in wound healing, prealbumin (transthyretin) is preferred over albumin because:',
      options: [
        'Prealbumin is more abundant in serum',
        'Prealbumin has a shorter half-life (2-3 days vs. 20 days for albumin), making it a more responsive marker of acute nutritional changes',
        'Prealbumin is more specific for protein intake',
        'Albumin is not measurable in standard laboratory tests',
      ],
      correctIndex: 1,
      explanation:
          'Prealbumin (transthyretin) has a half-life of approximately 2-3 days, compared to albumin\'s half-life of approximately 20 days. This shorter half-life makes prealbumin a more sensitive and responsive indicator of acute changes in nutritional status and response to nutritional interventions. A prealbumin level below 15 mg/dL indicates significant malnutrition and impaired wound healing capacity. Albumin, while useful, reflects nutritional status from weeks ago and is also affected by inflammation, liver disease, and fluid status, reducing its specificity.',
      moduleId: 'pressure-injuries',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'A Marjolin ulcer should be suspected and biopsy performed when a chronic pressure injury or wound:',
      options: [
        'Fails to heal within 2 weeks despite appropriate treatment',
        'Has been present for over 10 years and shows changes in appearance (raised edges, increased drainage, friable tissue)',
        'Develops a foul odor during the first month of treatment',
        'Shows signs of cellulitis around the wound margins',
      ],
      correctIndex: 1,
      explanation:
          'A Marjolin ulcer is a squamous cell carcinoma (SCC) that arises in chronic wounds, burn scars, or pressure injuries, typically after more than 10 years of chronicity. Warning signs include changes in wound appearance (raised or everted edges, increased or bloody drainage, friable/fungating tissue, failure to heal despite optimal treatment, or new pain in a previously insensate area). Biopsy of any chronic wound that undergoes unexplained changes after prolonged duration is mandatory to rule out malignant transformation. These SCCs are typically aggressive with metastatic potential.',
      moduleId: 'pressure-injuries',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'The recurrence rate of pressure injuries after surgical flap closure is approximately:',
      options: [
        '5-10%',
        '15-20%',
        '30-60%',
        '80-90%',
      ],
      correctIndex: 2,
      explanation:
          'Pressure injury recurrence after surgical flap closure is distressingly high, approximately 30-60% depending on the study and follow-up period. This high recurrence rate reflects the persistence of underlying risk factors: ongoing insensibility, immobility, incontinence, malnutrition, and behavioral factors (non-adherence to pressure relief). Successful outcomes require comprehensive patient education, psychosocial support, optimized equipment (pressure-redistributing surfaces), and lifelong commitment to pressure relief. Surgical closure should not be performed unless the patient demonstrates understanding and compliance with prevention strategies.',
      moduleId: 'pressure-injuries',
      difficulty: 'board',
    ),

    // =====================================================================
    // SEXUALITY & FERTILITY — NEW
    // =====================================================================
    QuizQuestion(
      question:
          'Reflexogenic erections are preserved in approximately what percentage of men with upper motor neuron (suprasacral) SCI?',
      options: [
        '25%',
        '50%',
        'Greater than 90%',
        '100%',
      ],
      correctIndex: 2,
      explanation:
          'Reflexogenic erections are preserved in greater than 90% of men with UMN (suprasacral) SCI because the sacral reflex arc (S2-S4) remains intact. In contrast, only approximately 25% of men with LMN (sacral/cauda equina) injuries retain erectile function (psychogenic erections via the T11-L2 sympatholumbar pathway). For erectile dysfunction in SCI, first-line treatment is PDE5 inhibitors (sildenafil, tadalafil); second-line includes intracavernosal injection therapy (alprostadil); third-line includes vacuum erection devices and penile prosthesis implantation.',
      moduleId: 'sexuality-fertility',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'Penile vibratory stimulation (PVS) for sperm retrieval in men with SCI has the highest success rate (approximately 86%) in patients with injuries at or above:',
      options: [
        'C5',
        'T6',
        'T10',
        'L1',
      ],
      correctIndex: 2,
      explanation:
          'PVS success rates are highest (approximately 86%) in men with injuries at T10 and above because the ejaculatory reflex arc (T11-L2 sympathetic, S2-S4 somatic) is intact. Below T10, the success rate drops significantly because the reflex pathway may be partially or completely disrupted. If PVS fails, electroejaculation (EEJ) is the next option. AD precautions are essential during PVS and EEJ in patients with injuries at T6 and above. Nifedipine prophylaxis may be administered prior to the procedure.',
      moduleId: 'sexuality-fertility',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'In evaluating male infertility after SCI, which semen analysis finding is the worst predictive factor for achieving pregnancy?',
      options: [
        'Low sperm count',
        'Poor motility',
        'Leukocytospermia (elevated white blood cells in semen)',
        'Abnormal morphology',
      ],
      correctIndex: 2,
      explanation:
          'Leukocytospermia (elevated white blood cells in semen) is the worst predictive factor for fertility outcomes in men with SCI. The elevated WBCs produce reactive oxygen species (ROS) that cause oxidative damage to sperm DNA and membranes, significantly reducing sperm viability and fertilization capacity. Men with SCI commonly have abnormal semen parameters including low motility, high WBC counts, and elevated seminal cytokines. Treatment strategies include frequent ejaculation (to reduce stasis), anti-inflammatory agents, and assisted reproductive techniques (IUI, IVF, ICSI).',
      moduleId: 'sexuality-fertility',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'The most common testicular biopsy finding in men with chronic SCI is:',
      options: [
        'Sertoli cell-only syndrome',
        'Normal spermatogenesis',
        'Seminiferous tubule atrophy (with impaired spermatogenesis)',
        'Testicular carcinoma in situ',
      ],
      correctIndex: 2,
      explanation:
          'Seminiferous tubule atrophy with varying degrees of impaired spermatogenesis is the most common histological finding on testicular biopsy in men with chronic SCI. Multiple factors contribute: scrotal hyperthermia (due to prolonged sitting in wheelchair), recurrent UTIs, elevated intrascrotal temperature from impaired thermoregulation, stasis of seminal fluid, and possible endocrine dysfunction. Despite these changes, spermatogenesis is usually sufficient for assisted reproduction (IVF/ICSI) even when natural ejaculation and fertility are impaired.',
      moduleId: 'sexuality-fertility',
      difficulty: 'board',
    ),

    // =====================================================================
    // MSK COMPLICATIONS & REHAB CONTINUUM — NEW
    // =====================================================================
    QuizQuestion(
      question:
          'Expected functional outcomes for a patient with C6 complete (ASIA A) SCI include independence in feeding at approximately what rate?',
      options: [
        '16%',
        '50%',
        '75%',
        '95%',
      ],
      correctIndex: 0,
      explanation:
          'According to functional outcome data, only approximately 16% of patients with C6 complete SCI achieve full independence in feeding (without setup or adaptive equipment assistance). However, independence in wheelchair propulsion on flat surfaces is much higher at approximately 88%. C6 patients have intact wrist extensors but lack finger flexors and intrinsics, relying on tenodesis grasp. They typically require adaptive equipment and setup assistance for feeding, can perform some transfers with a sliding board, and can achieve modified independence in grooming and upper body dressing.',
      moduleId: 'rehab-continuum',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'The energy cost of ambulation for a patient with thoracic-level paraplegia using KAFOs and crutches is approximately how many times greater than normal walking?',
      options: [
        '2-3 times',
        '6-12 times',
        '15-20 times',
        '25-30 times',
      ],
      correctIndex: 1,
      explanation:
          'Ambulation at thoracic levels with KAFOs and crutches requires approximately 6-12 times the energy expenditure of normal walking. This enormous energy cost is the primary reason why most thoracic-level paraplegics who initially learn to walk with orthoses ultimately abandon ambulation in favor of wheelchair mobility for community function. The higher the injury level, the greater the energy cost. Only about 5-10% of thoracic-level paraplegics continue to ambulate functionally in the community long-term. Wheelchair mobility is typically 10-20% more efficient than normal walking.',
      moduleId: 'rehab-continuum',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'The earliest laboratory marker to become elevated in heterotopic ossification (HO) is:',
      options: [
        'ESR (erythrocyte sedimentation rate)',
        'C-reactive protein (CRP)',
        'Serum alkaline phosphatase',
        'Serum calcium',
      ],
      correctIndex: 2,
      explanation:
          'Serum alkaline phosphatase is the earliest laboratory marker to rise in HO, often elevating before clinical or radiographic findings are apparent. However, it is not specific for HO (can be elevated in fractures, liver disease, etc.). The triple-phase bone scan is the most sensitive early imaging test, showing uptake before radiographic changes. Plain radiographs may not show HO until 2-6 weeks after onset. CT provides the best anatomical detail for surgical planning. The combination of elevated alkaline phosphatase with clinical suspicion (swelling, warmth, decreased ROM around a joint below the injury level) should prompt bone scan.',
      moduleId: 'msk-complications',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'Carpal tunnel syndrome (CTS) affects approximately what percentage of long-term manual wheelchair users?',
      options: [
        '5-10%',
        '20-30%',
        '40-66%',
        '80-90%',
      ],
      correctIndex: 2,
      explanation:
          'Carpal tunnel syndrome affects approximately 40-66% of long-term manual wheelchair users, making it one of the most prevalent upper extremity overuse injuries in this population. The repetitive forces on the wrist during wheelchair propulsion, transfers, and weight-relief raises cause chronic compression of the median nerve in the carpal tunnel. This is particularly concerning because hand function is critical for independence in SCI. Prevention includes proper wheelchair ergonomics, gloves, ergonomic push rims, limiting repetitive strain, and considering power mobility for longer distances.',
      moduleId: 'msk-complications',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'The FIM (Functional Independence Measure) maximum total score is 126, which is composed of:',
      options: [
        'Motor score 91 + cognitive score 35',
        'Motor score 100 + cognitive score 26',
        'Motor score 78 + cognitive score 48',
        'Motor score 105 + cognitive score 21',
      ],
      correctIndex: 0,
      explanation:
          'The FIM total maximum score is 126 points, composed of a motor subscale (91 points, 13 items) and a cognitive subscale (35 points, 5 items). Each of the 18 items is scored 1 (total assist) to 7 (complete independence). Motor items cover self-care (eating, grooming, bathing, dressing upper/lower, toileting), sphincter control (bladder, bowel), transfers (bed/chair, toilet, tub/shower), and locomotion (walk/wheelchair, stairs). Cognitive items cover comprehension, expression, social interaction, problem solving, and memory.',
      moduleId: 'rehab-continuum',
      difficulty: 'intermediate',
    ),
    QuizQuestion(
      question:
          'The primary surgical procedure for restoring active elbow extension in C5-C6 tetraplegia involves:',
      options: [
        'Biceps to triceps tendon transfer',
        'Posterior deltoid to triceps tendon transfer',
        'Latissimus dorsi to triceps transfer',
        'Brachioradialis to triceps transfer',
      ],
      correctIndex: 1,
      explanation:
          'Posterior deltoid to triceps tendon transfer is the most common surgical procedure to restore active elbow extension in patients with C5-C6 tetraplegia. The posterior deltoid (innervated by C5-C6, axillary nerve) serves as the donor muscle, and its tendon is lengthened with a graft and attached to the triceps tendon. Restoration of elbow extension greatly improves reach, wheelchair propulsion, transfers, and weight-relief raises. Candidates must have a strong (at least 4/5) posterior deltoid and be at least 6-12 months post-injury with stable neurological status.',
      moduleId: 'msk-complications',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'Osteoporosis below the level of SCI results in the greatest bone mineral density loss at which skeletal sites?',
      options: [
        'Lumbar spine and femoral neck',
        'Distal femur and proximal tibia',
        'Calcaneus and metatarsals',
        'Iliac crest and sacrum',
      ],
      correctIndex: 1,
      explanation:
          'Sublesional osteoporosis in SCI produces the greatest bone mineral density (BMD) loss at the distal femur and proximal tibia, which are also the most common fracture sites. BMD at these sites can decrease by 25-50% within the first 1-2 years after injury and continues to decline, reaching a steady state at 3-8 years. Notably, the lumbar spine may show falsely normal or elevated BMD on DXA due to degenerative changes, heterotopic ossification, or compression fracture artifact. DXA scanning at the distal femur and proximal tibia is recommended for accurate assessment.',
      moduleId: 'msk-complications',
      difficulty: 'board',
    ),
    QuizQuestion(
      question:
          'A patient with T1 paraplegia should be expected to achieve independence in all of the following EXCEPT:',
      options: [
        'Manual wheelchair propulsion on all surfaces',
        'All transfers including floor-to-wheelchair',
        'Complete self-care including bowel and bladder programs',
        'Independent ambulation without assistive devices',
      ],
      correctIndex: 3,
      explanation:
          'Patients with T1 complete paraplegia have full upper extremity function (including hand intrinsics) and can achieve independence in virtually all wheelchair-level activities: all ADLs, transfers (including floor-to-wheelchair), manual wheelchair propulsion on all surfaces, driving with hand controls, and independent bowel and bladder management. However, they cannot ambulate independently without assistive devices because all lower extremity motor function is absent. Ambulation would require bilateral KAFOs and crutches with extremely high energy cost, making it impractical for community mobility.',
      moduleId: 'rehab-continuum',
      difficulty: 'intermediate',
    ),
    QuizQuestion(
      question:
          'Which imaging modality is most sensitive for early detection of heterotopic ossification AND most specific for confirming the diagnosis?',
      options: [
        'Triple-phase bone scan for both sensitivity and specificity',
        'Triple-phase bone scan is most sensitive early; CT is most specific for anatomical detail',
        'Plain radiographs for both',
        'MRI for both sensitivity and specificity',
      ],
      correctIndex: 1,
      explanation:
          'Triple-phase bone scan is the most sensitive imaging modality for early detection of HO, showing increased uptake in all three phases before any radiographic changes are visible (weeks earlier than plain films). However, it lacks specificity (can be positive with fractures, infection, or DVT). CT scan provides the best anatomical detail and specificity, clearly delineating the extent and maturity of HO and its relationship to neurovascular structures, making it essential for surgical planning. Plain radiographs remain useful for monitoring maturation but are insensitive in early disease.',
      moduleId: 'msk-complications',
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
