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

/// Neurological levels for each modality and side.
///
/// Each field is a comma-separated string of level(s), possibly with
/// '*' suffix indicating variability. E.g., "C5", "C5,C6*", "INT".
class NeurologicalLevels {
  /// Sensory level on the right side.
  final String sensoryRight;

  /// Sensory level on the left side.
  final String sensoryLeft;

  /// Motor level on the right side.
  final String motorRight;

  /// Motor level on the left side.
  final String motorLeft;

  const NeurologicalLevels({
    required this.sensoryRight,
    required this.sensoryLeft,
    required this.motorRight,
    required this.motorLeft,
  });

  @override
  String toString() =>
      'NeurologicalLevels(sR: $sensoryRight, sL: $sensoryLeft, '
      'mR: $motorRight, mL: $motorLeft)';
}

/// Zone of Partial Preservation for each modality and side.
///
/// Applicable only for AIS A injuries. 'NA' when not applicable.
class ZoneOfPartialPreservation {
  final String sensoryRight;
  final String sensoryLeft;
  final String motorRight;
  final String motorLeft;

  const ZoneOfPartialPreservation({
    required this.sensoryRight,
    required this.sensoryLeft,
    required this.motorRight,
    required this.motorLeft,
  });

  @override
  String toString() =>
      'ZPP(sR: $sensoryRight, sL: $sensoryLeft, '
      'mR: $motorRight, mL: $motorLeft)';
}

/// Injury completeness classification.
///
/// Possible values: 'C', 'I', 'C,I', 'I*', 'C*,I', 'C*,I*'
typedef InjuryComplete = String;

/// Totals for one side of the body.
class SideTotals {
  /// Upper-extremity motor total (C5-T1), or 'ND' if not determinable.
  final String upperExtremity;

  /// Lower-extremity motor total (L2-S1), or 'ND' if not determinable.
  final String lowerExtremity;

  /// Light touch sensory total (C2-S4_5), or 'ND' if not determinable.
  final String lightTouch;

  /// Pin prick sensory total (C2-S4_5), or 'ND' if not determinable.
  final String pinPrick;

  /// Total motor score for this side, or 'ND' if not determinable.
  final String motor;

  const SideTotals({
    required this.upperExtremity,
    required this.lowerExtremity,
    required this.lightTouch,
    required this.pinPrick,
    required this.motor,
  });

  @override
  String toString() =>
      'SideTotals(UE: $upperExtremity, LE: $lowerExtremity, '
      'LT: $lightTouch, PP: $pinPrick, Motor: $motor)';
}

/// Combined totals for both sides.
class Totals {
  final SideTotals left;
  final SideTotals right;

  /// Total upper-extremity motor (left + right), or 'ND'.
  final String upperExtremity;

  /// Total lower-extremity motor (left + right), or 'ND'.
  final String lowerExtremity;

  /// Total light touch sensory (left + right), or 'ND'.
  final String lightTouch;

  /// Total pin prick sensory (left + right), or 'ND'.
  final String pinPrick;

  const Totals({
    required this.left,
    required this.right,
    required this.upperExtremity,
    required this.lowerExtremity,
    required this.lightTouch,
    required this.pinPrick,
  });

  @override
  String toString() =>
      'Totals(UE: $upperExtremity, LE: $lowerExtremity, '
      'LT: $lightTouch, PP: $pinPrick)';
}

/// The full classification result from the ISNCSCI algorithm.
class Classification {
  final NeurologicalLevels neurologicalLevels;

  /// Neurological Level of Injury (NLI). Comma-separated if variable.
  final String neurologicalLevelOfInjury;

  /// Injury completeness: 'C', 'I', 'C,I', 'I*', 'C*,I', 'C*,I*'.
  final InjuryComplete injuryComplete;

  /// ASIA Impairment Scale: 'A', 'B', 'C', 'D', 'E', or with '*' suffix,
  /// or comma-separated when multiple apply.
  final String asiaImpairmentScale;

  final ZoneOfPartialPreservation zoneOfPartialPreservation;

  const Classification({
    required this.neurologicalLevels,
    required this.neurologicalLevelOfInjury,
    required this.injuryComplete,
    required this.asiaImpairmentScale,
    required this.zoneOfPartialPreservation,
  });

  @override
  String toString() =>
      'Classification(NLI: $neurologicalLevelOfInjury, '
      'AIS: $asiaImpairmentScale, Complete: $injuryComplete)';
}

/// The complete result of running the ISNCSCI algorithm.
class ISNCSCIResult {
  final Classification classification;
  final Totals totals;

  const ISNCSCIResult({
    required this.classification,
    required this.totals,
  });
}
