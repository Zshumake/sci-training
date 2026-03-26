import 'package:flutter_test/flutter_test.dart';
import 'package:sci_training/core/isncsci/isncsci_algorithm.dart';
import 'package:sci_training/data/isncsci_training_cases.dart';

void main() {
  group('ISNCSCI Training Cases - Integration Tests', () {
    final allCases = ISNCSCITrainingCases.allCases;

    test('all 30 training cases are present', () {
      expect(allCases.length, 30);
    });

    for (final tc in allCases) {
      test('${tc.id}: "${tc.title}" produces a valid classification', () {
        final result = calculateISNCSCI(tc.exam);

        // The algorithm should return a valid result with classification.
        expect(result.classification.asiaImpairmentScale, isNotEmpty,
            reason: '${tc.id} should have an AIS grade');
        expect(result.classification.neurologicalLevelOfInjury, isNotEmpty,
            reason: '${tc.id} should have an NLI');

        // AIS must be one of the valid grades (possibly with * or comma-separated).
        final ais = result.classification.asiaImpairmentScale;
        expect(
          ais.contains(RegExp(r'[ABCDE]')),
          isTrue,
          reason: '${tc.id}: AIS "$ais" should contain a valid grade letter',
        );
      });
    }

    // -----------------------------------------------------------------------
    // Specific assertions for known cases
    // -----------------------------------------------------------------------

    group('AIS A complete injury cases', () {
      test('basic-01 (Complete C5 Tetraplegia) should be AIS A', () {
        final tc = allCases.firstWhere((c) => c.id == 'basic-01');
        final result = calculateISNCSCI(tc.exam);
        expect(result.classification.asiaImpairmentScale, contains('A'));
        expect(result.classification.injuryComplete, contains('C'));
      });

      test('basic-02 (Complete C6 Tetraplegia) should be AIS A', () {
        final tc = allCases.firstWhere((c) => c.id == 'basic-02');
        final result = calculateISNCSCI(tc.exam);
        expect(result.classification.asiaImpairmentScale, contains('A'));
      });

      test('basic-03 (Complete T6 Paraplegia) should be AIS A', () {
        final tc = allCases.firstWhere((c) => c.id == 'basic-03');
        final result = calculateISNCSCI(tc.exam);
        expect(result.classification.asiaImpairmentScale, contains('A'));
      });

      test('basic-04 (Complete T10 Paraplegia) should be AIS A', () {
        final tc = allCases.firstWhere((c) => c.id == 'basic-04');
        final result = calculateISNCSCI(tc.exam);
        expect(result.classification.asiaImpairmentScale, contains('A'));
      });

      test('basic-05 (Complete L1 Paraplegia) should be AIS A', () {
        final tc = allCases.firstWhere((c) => c.id == 'basic-05');
        final result = calculateISNCSCI(tc.exam);
        expect(result.classification.asiaImpairmentScale, contains('A'));
      });
    });

    group('Incomplete injury cases', () {
      test('basic-06 (Sensory Incomplete T8) should be AIS B', () {
        final tc = allCases.firstWhere((c) => c.id == 'basic-06');
        final result = calculateISNCSCI(tc.exam);
        expect(result.classification.asiaImpairmentScale, contains('B'));
      });

      test('basic-07 (Motor Incomplete C7) should be AIS C', () {
        final tc = allCases.firstWhere((c) => c.id == 'basic-07');
        final result = calculateISNCSCI(tc.exam);
        expect(result.classification.asiaImpairmentScale, contains('C'));
      });

      test('basic-08 (Motor Incomplete T12) should be AIS D', () {
        final tc = allCases.firstWhere((c) => c.id == 'basic-08');
        final result = calculateISNCSCI(tc.exam);
        expect(result.classification.asiaImpairmentScale, contains('D'));
      });

      test('basic-10 (Motor Incomplete L2) should be AIS D', () {
        final tc = allCases.firstWhere((c) => c.id == 'basic-10');
        final result = calculateISNCSCI(tc.exam);
        expect(result.classification.asiaImpairmentScale, contains('D'));
      });
    });

    group('Totals are valid', () {
      test('all cases have numeric or ND totals', () {
        for (final tc in allCases) {
          final result = calculateISNCSCI(tc.exam);
          final t = result.totals;

          for (final total in [
            t.upperExtremity,
            t.lowerExtremity,
            t.lightTouch,
            t.pinPrick,
          ]) {
            expect(
              total == 'ND' || int.tryParse(total) != null,
              isTrue,
              reason:
                  '${tc.id}: total "$total" should be numeric or "ND"',
            );
          }
        }
      });
    });
  });
}
