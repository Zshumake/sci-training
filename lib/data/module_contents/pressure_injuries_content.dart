import 'package:flutter/material.dart';
import '../models/topic_content_model.dart';

final TopicData pressureInjuriesContent = TopicData(
  id: 'pressure-injuries',
  title: 'Pressure Injuries',
  tabs: [
    TopicTab(
      title: 'NPUAP Staging',
      blocks: [
        HeaderBlock('Pressure Injury Staging System'),
        TextBlock(
          'Pressure injuries (formerly pressure ulcers or decubitus ulcers) are localized damage to the skin and/or underlying tissue, usually over a bony prominence, resulting from sustained pressure or pressure in combination with shear. The NPUAP/EPUAP staging system is the standard classification.',
          isIntro: true,
        ),
        ScaleBlock(
          scaleName: 'NPUAP Pressure Injury Staging',
          description: 'The National Pressure Ulcer Advisory Panel (NPUAP, now NPIAP) staging system classifies pressure injuries by depth of tissue involvement.',
          columns: ['Stage', 'Description'],
          rows: [
            ['Stage 1', 'Intact skin with non-blanchable erythema. Skin may be warmer, cooler, firmer, softer, or more painful compared to adjacent tissue. May be difficult to detect in darkly pigmented skin.'],
            ['Stage 2', 'Partial-thickness skin loss involving epidermis and/or dermis. Presents as a shallow open ulcer with a red-pink wound bed WITHOUT slough. May also present as an intact or ruptured serum-filled blister.'],
            ['Stage 3', 'Full-thickness skin loss. Subcutaneous fat may be visible, but bone, tendon, and muscle are NOT exposed. Slough may be present but does not obscure depth. May include undermining and tunneling.'],
            ['Stage 4', 'Full-thickness tissue loss with exposed bone, tendon, cartilage, or muscle. Slough or eschar may be present. Often includes undermining and tunneling. Osteomyelitis risk is high.'],
            ['Unstageable', 'Full-thickness tissue loss with wound bed obscured by slough (yellow, tan, gray, green, or brown) and/or eschar (tan, brown, or black). True depth cannot be determined until slough/eschar is removed. Cannot stage until debrided.'],
            ['DTPI', 'Deep Tissue Pressure Injury: intact or non-intact skin with localized area of persistent non-blanchable deep red, maroon, or purple discoloration, or epidermal separation revealing a dark wound bed or blood-filled blister. Evolves rapidly. May be preceded by tissue that is painful, firm, mushy, boggy, warmer, or cooler than adjacent tissue.'],
          ],
          boardPearl: 'Stage 1 = intact skin with non-blanchable erythema. Stage 2 = partial thickness (epidermis/dermis). Stage 3 = full thickness through subcutaneous fat. Stage 4 = exposed bone/muscle/tendon. Unstageable = cannot see the bottom (slough/eschar obscures). DTPI = deep purple/maroon discoloration suggesting deep tissue damage underneath.',
        ),
        PearlBlock(
          'Board Pearl: Staging Rules',
          'Pressure injuries are staged FORWARD only (a healing Stage 4 is documented as "healing Stage 4," NOT downstaged to Stage 3 or 2). Reverse staging is incorrect because the tissue that fills in is granulation tissue, not true replacement of lost anatomic structures. Also: pressure injuries on mucous membranes (e.g., nasal bridge from O2 tubing) are documented as "mucosal membrane pressure injury" and are NOT staged.',
        ),
      ],
    ),
    TopicTab(
      title: 'Risk Factors',
      blocks: [
        HeaderBlock('Risk Factors & Common Locations'),
        TextBlock(
          'SCI patients are at lifelong elevated risk for pressure injuries due to impaired sensation, immobility, moisture exposure, and autonomic dysfunction. Understanding risk factors and common locations is essential for prevention.',
          isIntro: true,
        ),
        BulletCardBlock(
          title: 'Intrinsic Risk Factors',
          themeColor: const Color(0xFFDC2626),
          backgroundColor: const Color(0xFFFEF2F2),
          points: [
            'Impaired sensation: cannot feel sustained pressure',
            'Immobility/paralysis: cannot reposition independently',
            'Autonomic dysfunction: impaired local blood flow regulation',
            'Moisture: incontinence (bladder and bowel) leads to maceration',
            'Malnutrition: protein/calorie deficiency impairs tissue integrity and healing',
            'Anemia: reduced oxygen delivery to tissues',
            'Spasticity: can create shearing forces; or low tone allows tissue compression',
            'Age: skin becomes thinner and less elastic',
            'Smoking: vasoconstriction reduces tissue perfusion',
            'Diabetes: microangiopathy, neuropathy, impaired healing',
            'Depression: may reduce self-care motivation and adherence',
          ],
        ),
        BulletCardBlock(
          title: 'Extrinsic Risk Factors',
          themeColor: const Color(0xFFEA580C),
          backgroundColor: const Color(0xFFFFF7ED),
          points: [
            'Pressure: sustained pressure exceeding capillary closing pressure (~32 mmHg)',
            'Shear: displacement of skin over underlying tissue (sliding in bed/chair)',
            'Friction: skin rubbing against surfaces (during transfers)',
            'Moisture: urinary/fecal incontinence, perspiration',
            'Poor support surfaces: inadequate wheelchair cushion or mattress',
            'Medications: steroids impair healing, sedatives reduce repositioning',
          ],
        ),
        TableBlock(
          title: 'Common Pressure Injury Locations by Position',
          columns: ['Position', 'Location', 'Notes'],
          rows: [
            ['Sitting (wheelchair)', 'Ischial tuberosities', 'Most common PI location in SCI wheelchair users'],
            ['Supine', 'Sacrum/coccyx', 'Most common location overall in hospitalized patients'],
            ['Supine', 'Heels', 'Second most common supine location; float heels with pillows'],
            ['Supine', 'Occiput', 'Especially in cervical SCI patients on backboards/halo'],
            ['Side-lying', 'Greater trochanter', 'Avoid 90-degree side-lying; use 30-degree tilt'],
            ['Side-lying', 'Lateral malleolus', 'Use pillow between ankles'],
            ['Prone', 'Anterior iliac spines, knees, toes', 'Less common position in SCI'],
            ['Seated (wheelchair)', 'Scapulae', 'From wheelchair backrest pressure'],
            ['Any', 'Medical device-related', 'Cervical collar, halo pins, O2 tubing, catheter tubing'],
          ],
        ),
        PearlBlock(
          'Board Pearl: Location by Position',
          'The most common PI location for a wheelchair user with SCI is the ischial tuberosities (from sitting). The most common location for a supine hospitalized patient is the sacrum. The most common location in side-lying is the greater trochanter. This is one of the most frequently tested concepts on boards.',
        ),
        ScaleBlock(
          scaleName: 'Braden Scale',
          description: 'The most widely used pressure injury risk assessment tool. Scores range from 6-23; lower scores indicate higher risk.',
          columns: ['Subscale', 'Range', 'What It Measures'],
          rows: [
            ['Sensory Perception', '1-4', 'Ability to respond to pressure-related discomfort'],
            ['Moisture', '1-4', 'Degree of skin exposure to moisture'],
            ['Activity', '1-4', 'Degree of physical activity (bedfast, chairfast, walks)'],
            ['Mobility', '1-4', 'Ability to change and control body position'],
            ['Nutrition', '1-4', 'Usual food intake pattern'],
            ['Friction & Shear', '1-3', 'Degree of friction and shear during movement'],
          ],
          boardPearl: 'Braden Scale total score ranges from 6-23. Risk levels: <=9 = very high risk, 10-12 = high risk, 13-14 = moderate risk, 15-18 = mild risk, >=19 = no risk. Most SCI patients score in the high or very high risk categories. The Braden Scale has 6 subscales with most scored 1-4 (friction/shear is 1-3).',
        ),
      ],
    ),
    TopicTab(
      title: 'Prevention & Management',
      blocks: [
        HeaderBlock('Prevention & Treatment'),
        TextBlock(
          'Prevention is the cornerstone of pressure injury management in SCI. Once a pressure injury develops, treatment is prolonged, costly, and may require surgery. A comprehensive prevention program is essential for all SCI patients.',
          isIntro: true,
        ),
        BulletCardBlock(
          title: 'Prevention Strategies',
          themeColor: const Color(0xFF059669),
          backgroundColor: const Color(0xFFECFDF5),
          points: [
            'Pressure relief: wheelchair pushups or lateral leans every 15-30 minutes (minimum 15-30 seconds duration)',
            'Repositioning in bed every 2 hours; use 30-degree lateral tilt (not 90-degree side-lying)',
            'Pressure-redistributing support surfaces: specialty mattresses (foam, air, gel) and wheelchair cushions',
            'Skin inspection: daily full-body skin check using a mirror for areas the patient cannot see',
            'Moisture management: continence care, moisture barrier creams',
            'Nutrition optimization: adequate protein (1.2-1.5 g/kg/day), calories, vitamins C and A, zinc',
            'Prealbumin >15 mg/dL indicates adequate protein status for healing (better marker than albumin)',
            'Seating assessment: proper wheelchair fit, cushion selection (pressure mapping)',
            'Education: patient and caregiver training on prevention strategies',
          ],
        ),
        TableBlock(
          title: 'Support Surface Selection',
          columns: ['Type', 'Examples', 'Indication'],
          rows: [
            ['Group 1: Static', 'Foam, gel, water, air overlays', 'Prevention; Stage 1-2 if patient can reposition'],
            ['Group 2: Dynamic', 'Alternating pressure, low-air-loss', 'Stage 2-3; cannot reposition independently'],
            ['Group 3: Air-fluidized', 'Clinitron bed', 'Stage 3-4; post-flap surgery; multiple turning surfaces involved'],
            ['Wheelchair cushions', 'Foam, gel, air (ROHO), honeycomb', 'All wheelchair users; individualized based on pressure mapping'],
          ],
        ),
        PearlBlock(
          'Board Pearl: Pressure Relief Timing',
          'Wheelchair pressure relief should be performed every 15-30 minutes for 15-30 seconds (pushup) or 1-2 minutes (lateral lean/forward lean). The key concept: tissue ischemia from sustained pressure is time-dependent. Capillary closing pressure is approximately 32 mmHg, and tissue begins to experience damage after approximately 2 hours of sustained pressure.',
        ),
        BulletCardBlock(
          title: 'Wound Care Principles',
          themeColor: const Color(0xFF3B82F6),
          backgroundColor: const Color(0xFFEFF6FF),
          points: [
            'Offload pressure completely from the wound area',
            'Debridement: sharp, enzymatic (collagenase), autolytic (moisture-retentive dressings), mechanical, or biological (maggots)',
            'Moist wound healing: maintain appropriate moisture balance (not too wet, not too dry)',
            'Wound cleansing: normal saline irrigation; avoid cytotoxic agents (hydrogen peroxide, povidone-iodine on open wounds)',
            'Dressing selection: based on wound characteristics (depth, drainage, infection status)',
            'Infection control: topical antimicrobials for bioburden; systemic antibiotics for cellulitis, osteomyelitis',
            'Nutritional support: high protein diet, vitamin C (250-500 mg BID), zinc (220 mg daily)',
            'Monitor for osteomyelitis: especially Stage 4 wounds with exposed bone (MRI is gold standard)',
          ],
        ),
        BulletCardBlock(
          title: 'Surgical Management',
          themeColor: const Color(0xFF7C3AED),
          backgroundColor: const Color(0xFFF5F3FF),
          points: [
            'Indicated for Stage 3-4 wounds that fail conservative management',
            'Musculocutaneous or fasciocutaneous flap procedures',
            'Ischial PI: gluteus maximus flap, posterior thigh flap, gracilis flap',
            'Sacral PI: gluteus maximus flap, superior gluteal artery perforator flap',
            'Trochanteric PI: tensor fasciae latae (TFL) flap, vastus lateralis flap',
            'Pre-operative optimization: nutrition, infection control, spasm management',
            'Post-operative: strict bed rest on air-fluidized bed for 4-6 weeks',
            'Progressive sitting program after surgical healing',
            'Recurrence rate: 25-60% (prevention remains critical)',
          ],
        ),
        PearlBlock(
          'Board Pearl: Flap Recurrence',
          'Pressure injury recurrence after surgical flap repair is distressingly high (25-60%). This emphasizes that surgery addresses the wound but NOT the underlying risk factors (immobility, insensitivity, moisture). Lifetime pressure injury prevention adherence is critical. Patient education, proper support surfaces, and regular skin checks must continue indefinitely.',
        ),
      ],
    ),
  ],
);
