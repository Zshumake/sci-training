// Copyright 2024 Praxis-ISNCSCI Contributors
// Ported from https://github.com/praxis-isncsci/algorithm (TypeScript)
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/// All sensory levels in rostral-to-caudal order, including C1.
/// C1 is included as the starting reference point but has no exam values.
const List<String> sensoryLevels = [
  'C1',
  'C2',
  'C3',
  'C4',
  'C5',
  'C6',
  'C7',
  'C8',
  'T1',
  'T2',
  'T3',
  'T4',
  'T5',
  'T6',
  'T7',
  'T8',
  'T9',
  'T10',
  'T11',
  'T12',
  'L1',
  'L2',
  'L3',
  'L4',
  'L5',
  'S1',
  'S2',
  'S3',
  'S4_5',
];

/// The 10 key motor levels (myotomes) assessed in ISNCSCI.
const List<String> motorLevels = [
  'C5',
  'C6',
  'C7',
  'C8',
  'T1',
  'L2',
  'L3',
  'L4',
  'L5',
  'S1',
];

/// Upper-extremity motor levels (cervical myotomes).
const List<String> upperMotorLevels = ['C5', 'C6', 'C7', 'C8', 'T1'];

/// Lower-extremity motor levels (lumbosacral myotomes).
const List<String> lowerMotorLevels = ['L2', 'L3', 'L4', 'L5', 'S1'];

/// Mapping from motor level to the key muscle tested at that level.
const Map<String, String> motorLevelToMuscle = {
  'C5': 'Elbow flexors (Biceps, Brachialis)',
  'C6': 'Wrist extensors (Extensor carpi radialis longus/brevis)',
  'C7': 'Elbow extensors (Triceps)',
  'C8': 'Finger flexors (FDP to middle finger)',
  'T1': 'Small finger abductors (Abductor digiti minimi)',
  'L2': 'Hip flexors (Iliopsoas)',
  'L3': 'Knee extensors (Quadriceps)',
  'L4': 'Ankle dorsiflexors (Tibialis anterior)',
  'L5': 'Long toe extensors (Extensor hallucis longus)',
  'S1': 'Ankle plantar flexors (Gastrocnemius, Soleus)',
};

/// Sensory levels that have exam values (C2-S4_5, excludes C1).
const List<String> sensoryExamLevels = [
  'C2',
  'C3',
  'C4',
  'C5',
  'C6',
  'C7',
  'C8',
  'T1',
  'T2',
  'T3',
  'T4',
  'T5',
  'T6',
  'T7',
  'T8',
  'T9',
  'T10',
  'T11',
  'T12',
  'L1',
  'L2',
  'L3',
  'L4',
  'L5',
  'S1',
  'S2',
  'S3',
  'S4_5',
];

/// The "not determinable" string used in totals when NT values are present.
const String notDeterminable = 'ND';

/// Valid motor muscle values for exam input.
const List<String> validMotorValues = [
  '0',
  '1',
  '2',
  '3',
  '4',
  '5',
  '0*',
  '1*',
  '2*',
  '3*',
  '4*',
  '0**',
  '1**',
  '2**',
  '3**',
  '4**',
  'NT',
  'NT*',
  'NT**',
];

/// Valid sensory point values for exam input.
const List<String> validSensoryValues = [
  '0',
  '1',
  '2',
  '0*',
  '1*',
  '0**',
  '1**',
  'NT',
  'NT*',
  'NT**',
];

/// Values that indicate sensory function can be absent.
const List<String> canBeAbsentSensoryValues = ['0', 'NT', '0*', 'NT*'];

/// Values that indicate normal sensory function (including double-star
/// variants which represent "consider normal").
const List<String> normalSensoryValues = ['2', 'NT**', '0**', '1**'];

/// NT-like values that produce ND in totals calculations.
const List<String> ntValues = ['NT', 'NT*', 'NT**'];
