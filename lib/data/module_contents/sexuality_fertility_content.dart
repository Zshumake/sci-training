import 'package:flutter/material.dart';
import '../models/topic_content_model.dart';

final TopicData sexualityFertilityContent = TopicData(
  id: 'sexuality-fertility',
  title: 'Sexuality & Fertility',
  tabs: [
    TopicTab(
      title: 'Male Sexual Function',
      blocks: [
        HeaderBlock('Male Sexual Function After SCI'),
        TextBlock(
          'Sexual dysfunction is one of the most significant quality-of-life concerns for men with SCI. Understanding the neuroanatomy of erection and ejaculation is essential for predicting function and guiding treatment.',
          isIntro: true,
        ),
        BulletCardBlock(
          title: 'Neuroanatomy of Erection',
          themeColor: const Color(0xFF3B82F6),
          backgroundColor: const Color(0xFFEFF6FF),
          points: [
            'Reflexogenic erection: mediated by the sacral parasympathetic reflex arc (S2-S4)',
            'Stimulus: direct genital stimulation activating the pudendal nerve afferents',
            'Efferents: pelvic nerve (parasympathetic) releases nitric oxide causing cavernosal smooth muscle relaxation',
            'Requires intact sacral cord segments (S2-S4) and reflex arc',
            'Present in UMN lesions (suprasacral/above S2) = reflex arc intact',
            'Absent in complete LMN lesions (sacral cord/cauda equina damage)',
          ],
        ),
        BulletCardBlock(
          title: 'Psychogenic Erection',
          themeColor: const Color(0xFF7C3AED),
          backgroundColor: const Color(0xFFF5F3FF),
          points: [
            'Mediated by cerebral input through the thoracolumbar sympathetic outflow (T11-L2)',
            'Stimulus: mental arousal (visual, auditory, fantasy)',
            'Pathway: descends from brain through lateral columns to T11-L2 sympathetic neurons',
            'Requires intact connection between brain and T11-L2 segments',
            'Present in complete LMN (sacral) lesions IF T11-L2 connections to brain are intact',
            'Absent in complete UMN lesions above T11 (pathway disrupted)',
            'May be partially preserved in incomplete injuries at any level',
          ],
        ),
        TableBlock(
          title: 'Erectile Function by Injury Type',
          columns: ['Lesion Type', 'Reflexogenic', 'Psychogenic', 'Clinical Scenario'],
          rows: [
            ['Complete UMN (above T11)', 'YES (sacral arc intact)', 'NO (pathway interrupted)', 'Cervical/thoracic complete: reflexogenic only; erection with touch but not mental arousal'],
            ['Complete UMN (T11-S1)', 'YES', 'Variable', 'Thoracolumbar: reflexogenic; psychogenic may be partially preserved'],
            ['Complete LMN (S2-S4 damage)', 'NO (sacral arc destroyed)', 'Possible (T11-L2 pathway may be intact)', 'Conus/cauda equina: psychogenic erections possible but often insufficient for intercourse'],
            ['Incomplete (any level)', 'Variable', 'Variable', 'Better prognosis overall; both types may be partially preserved'],
          ],
        ),
        MnemonicBlock(
          'Erection Mnemonic',
          'Point and Shoot: Parasympathetic = Point (erection via pelvic nerve, S2-S4), Sympathetic = Shoot (ejaculation/emission via hypogastric nerve, T11-L2). Reflexogenic erection needs an intact S2-S4 arc. Psychogenic erection needs intact T11-L2 plus brain connection.',
        ),
        MedicationCardBlock(
          name: 'Sildenafil (Viagra)',
          drugClass: 'PDE5 Inhibitor',
          mechanism: 'Inhibits phosphodiesterase type 5, preventing breakdown of cGMP, which maintains smooth muscle relaxation and blood flow in the corpus cavernosum',
          indication: 'First-line pharmacologic treatment for erectile dysfunction in SCI',
          dosing: '25-100 mg PO 30-60 minutes before sexual activity; max once daily',
          sideEffects: 'Headache, flushing, nasal congestion, visual disturbances, hypotension. ABSOLUTELY CONTRAINDICATED with nitrates (risk of fatal hypotension - critical in AD management with nitropaste)',
          boardPearl: 'PDE5 inhibitors are first-line for ED in SCI. CRITICAL CONTRAINDICATION: cannot use within 24-48 hours of nitrate administration. Since nitropaste is used for AD, patients on PDE5 inhibitors who develop AD cannot receive nitropaste. Alternative AD medications must be used (nifedipine, hydralazine).',
        ),
        BulletCardBlock(
          title: 'Other ED Treatments',
          themeColor: const Color(0xFF0D9488),
          backgroundColor: const Color(0xFFF0FDFA),
          points: [
            'Tadalafil (Cialis): longer acting PDE5 inhibitor (up to 36 hours); daily low-dose option',
            'Intracavernosal injection: alprostadil (PGE1) or trimix (alprostadil + papaverine + phentolamine)',
            'Intraurethral alprostadil (MUSE): suppository placed in urethra',
            'Vacuum erection device (VED): external negative pressure with constriction ring',
            'Penile prosthesis: inflatable or semi-rigid; last resort after other methods fail',
            'Vibrostimulation: may trigger reflex erections in UMN lesions',
          ],
        ),
      ],
    ),
    TopicTab(
      title: 'Female Sexual Function',
      blocks: [
        HeaderBlock('Female Sexual Function After SCI'),
        TextBlock(
          'Female sexual function after SCI has historically received less research attention than male function. However, women with SCI experience significant changes in sexual response, lubrication, and orgasmic ability.',
          isIntro: true,
        ),
        BulletCardBlock(
          title: 'Sexual Response Changes',
          themeColor: const Color(0xFF7C3AED),
          backgroundColor: const Color(0xFFF5F3FF),
          points: [
            'Reflex lubrication (S2-S4): analogous to reflexogenic erection in males',
            'Psychogenic lubrication (T11-L2): analogous to psychogenic erection',
            'Same UMN/LMN patterns apply as in males for genital arousal',
            'Genital sensation may be absent or altered depending on injury level and completeness',
            'Orgasm is possible in some women with SCI (reported in 50% of women with incomplete injuries)',
            'Orgasm may be achieved through stimulation of intact erogenous zones above the level of injury',
            'Fantasy and mental imagery can contribute to arousal and satisfaction',
          ],
        ),
        BulletCardBlock(
          title: 'Menstrual and Reproductive Effects',
          themeColor: const Color(0xFF3B82F6),
          backgroundColor: const Color(0xFFEFF6FF),
          points: [
            'Amenorrhea: temporary (average 5-6 months post-injury) due to stress response',
            'Menses typically resume within 6-12 months; long-term fertility is usually PRESERVED',
            'Ovulation and conception ability are generally unaffected',
            'Contraception counseling is important (avoid estrogen-containing methods due to DVT risk)',
            'Preferred contraceptive methods: IUD, progesterone-only pills/implants, barrier methods',
            'Combined oral contraceptives (estrogen) are relatively contraindicated due to increased VTE risk',
          ],
        ),
        BulletCardBlock(
          title: 'Pregnancy Considerations in SCI',
          themeColor: const Color(0xFFDC2626),
          backgroundColor: const Color(0xFFFEF2F2),
          points: [
            'Women with SCI can have safe pregnancies with proper management',
            'Increased risk: UTI, pressure injuries, DVT/PE, autonomic dysreflexia during labor',
            'AD during labor is the most dangerous complication (injuries T6 and above)',
            'Labor pain may not be perceived; monitor for uterine contractions (tocodynamometry)',
            'Epidural anesthesia is RECOMMENDED to prevent AD during labor',
            'Preterm labor may go unrecognized due to absent sensation',
            'Increased bladder infections during pregnancy',
            'Respiratory compromise may worsen in high cervical injuries during pregnancy',
            'Multidisciplinary team approach: OB, PM&R, anesthesia, nursing',
          ],
        ),
        PearlBlock(
          'Board Pearl: Pregnancy & AD',
          'The most dangerous complication of pregnancy in women with SCI at T6 and above is autonomic dysreflexia triggered by labor contractions. Epidural anesthesia is the recommended approach to block the afferent noxious stimuli from uterine contractions. AD during labor can be confused with preeclampsia; the key difference is that AD resolves when the stimulus is removed and has characteristic above/below level signs.',
        ),
      ],
    ),
    TopicTab(
      title: 'Fertility',
      blocks: [
        HeaderBlock('Fertility After SCI'),
        TextBlock(
          'Male fertility is significantly affected by SCI, while female fertility is generally preserved. Understanding ejaculatory dysfunction and sperm retrieval techniques is essential for board preparation.',
          isIntro: true,
        ),
        BulletCardBlock(
          title: 'Male Fertility Challenges',
          themeColor: const Color(0xFFDC2626),
          backgroundColor: const Color(0xFFFEF2F2),
          points: [
            'Ejaculatory dysfunction affects ~90% of men with SCI',
            'Emission (T11-L2 sympathetic): sperm/seminal fluid delivered to posterior urethra',
            'Ejaculation (S2-S4 somatic): rhythmic contraction of bulbocavernosus and ischiocavernosus muscles',
            'Most men with complete UMN injuries cannot ejaculate with intercourse',
            'Semen quality is poor: decreased motility, increased abnormal morphology, low volume',
            'Causes of poor semen quality: stasis, elevated scrotal temperature, recurrent UTI, epididymal obstruction, abnormal seminal plasma',
            'Anejaculation is the primary barrier to fertility in SCI males',
          ],
        ),
        TableBlock(
          title: 'Sperm Retrieval Techniques',
          columns: ['Technique', 'Method', 'Success Rate', 'Best For'],
          rows: [
            ['Penile vibratory stimulation (PVS)', 'High-amplitude vibrator applied to frenulum/glans', '~60-70% (UMN lesions)', 'First-line for UMN lesions (intact reflex arc). Cannot use in LMN.'],
            ['Electroejaculation (EEJ)', 'Rectal probe delivers electrical stimulation to seminal vesicles/prostate', '~90% (UMN and LMN)', 'Second-line; when PVS fails; works in both UMN and LMN'],
            ['Surgical sperm retrieval', 'TESE, MESA, microsurgical aspiration', '~95%+ for retrieval', 'Last resort when PVS and EEJ fail; requires IVF/ICSI'],
          ],
        ),
        PearlBlock(
          'Board Pearl: PVS vs EEJ',
          'Penile vibratory stimulation (PVS) is first-line for sperm retrieval because it is non-invasive, can be performed at home, and produces better quality semen than EEJ. However, PVS requires an intact ejaculatory reflex arc (UMN lesion with intact S2-S4). EEJ works in both UMN and LMN lesions but requires anesthesia in patients with sensation (incomplete injuries) and produces retrograde ejaculation requiring bladder harvest. Monitor for AD during both procedures in patients T6 and above.',
        ),
        BulletCardBlock(
          title: 'Assisted Reproduction Options',
          themeColor: const Color(0xFF059669),
          backgroundColor: const Color(0xFFECFDF5),
          points: [
            'Intrauterine insemination (IUI): when semen quality is adequate; least invasive',
            'In vitro fertilization (IVF): when IUI fails or semen quality is poor',
            'Intracytoplasmic sperm injection (ICSI): requires only a single viable sperm; highest success rate with poor semen quality',
            'Success rates have improved dramatically with ICSI technology',
            'Sperm cryopreservation: store retrieved sperm for future use',
            'Pre-procedure counseling for both partners is essential',
          ],
        ),
        BulletCardBlock(
          title: 'Improving Semen Quality',
          themeColor: const Color(0xFF6366F1),
          backgroundColor: const Color(0xFFEEF2FF),
          points: [
            'Regular ejaculation (PVS program) may improve motility over time',
            'Treatment of UTIs and genital infections',
            'Avoid overheating of testes: avoid prolonged sitting on hot cushions, hot baths',
            'Minimize anticholinergic medications (can affect seminal emission)',
            'Optimize general health and nutrition',
            'Refer to reproductive endocrinologist/urologist specializing in SCI fertility',
          ],
        ),
        PearlBlock(
          'Board Pearl: Female vs Male Fertility',
          'Female fertility is generally PRESERVED after SCI. Menses typically return within 6-12 months, and ovulation continues normally. Women can conceive naturally and carry pregnancies to term with appropriate monitoring. In contrast, male fertility is significantly impaired (~90% anejaculation, poor semen quality) and usually requires assisted reproductive techniques.',
        ),
      ],
    ),
  ],
);
