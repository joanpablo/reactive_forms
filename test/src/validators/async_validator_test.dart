import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  group('AsyncValidator Test', () {
    test('Async validator is executed after debounce time', () {
      fakeAsync((async) {
        final control = FormControl<String>(
          asyncValidators: [
            Validators.delegateAsync(
              (control) =>
                  Future.delayed(const Duration(milliseconds: 100), () => null),
              debounceTime: 200,
            ),
          ],
        );

        control.value = 'some value';

        // Elapse the debounce time
        async.elapse(const Duration(milliseconds: 200));
        expect(
          control.pending,
          true,
          reason: 'Control should be pending after debounce',
        );

        // Elapse the validator delay
        async.elapse(const Duration(milliseconds: 100));
        expect(
          control.pending,
          false,
          reason: 'Control should not be pending after validation',
        );
        expect(control.valid, true);
      });
    });

    test('Async validator returns error on failure', () {
      fakeAsync((async) {
        final control = FormControl<String>(
          asyncValidators: [
            Validators.delegateAsync(
              (control) => Future.delayed(
                const Duration(milliseconds: 100),
                () => {'unique': true},
              ),
              debounceTime: 200,
            ),
          ],
        );

        control.value = 'some value';

        async.elapse(const Duration(milliseconds: 200));
        expect(control.pending, true);

        async.elapse(const Duration(milliseconds: 100));
        expect(control.pending, false);
        expect(control.hasError('unique'), true);
      });
    });

    test(
      'DebouncedAsyncValidator is executed after its custom debounce time',
      () {
        fakeAsync((async) {
          final control = FormControl<String>(
            asyncValidators: [
              Validators.debounced(
                Validators.delegateAsync(
                  (control) => Future.delayed(
                    const Duration(milliseconds: 100),
                    () => null,
                  ),
                ),
                500, // Custom debounce time
              ),
            ],
          );

          control.value = 'some value';

          // Elapse global debounce time, but not custom debounce time
          async.elapse(const Duration(milliseconds: 200));
          expect(
            control.pending,
            true,
            reason: 'Control should be pending after global debounce',
          );

          // Elapse custom debounce time
          async.elapse(
            const Duration(milliseconds: 300),
          ); // 200 (global) + 300 = 500 (custom)
          expect(
            control.pending,
            true,
            reason: 'Control should still be pending after custom debounce',
          );

          // Elapse validator delay
          async.elapse(const Duration(milliseconds: 100));
          expect(
            control.pending,
            false,
            reason: 'Control should not be pending after validation',
          );
          expect(control.valid, true);
        });
      },
    );

    test(
      'DebouncedAsyncValidator with custom debounce time returns error on failure',
      () {
        fakeAsync((async) {
          final control = FormControl<String>(
            asyncValidators: [
              Validators.debounced(
                Validators.delegateAsync(
                  (control) => Future.delayed(
                    const Duration(milliseconds: 100),
                    () => {'custom_error': true},
                  ),
                ),
                500, // Custom debounce time
              ),
            ],
          );

          control.value = 'some value';

          async.elapse(const Duration(milliseconds: 500));
          expect(control.pending, true);

          async.elapse(const Duration(milliseconds: 100));
          expect(control.pending, false);
          expect(control.hasError('custom_error'), true);
        });
      },
    );

    test(
      'Multiple value changes within debounce period trigger validation only once',
      () {
        fakeAsync((async) {
          var validationCount = 0;
          final control = FormControl<String>(
            asyncValidators: [
              Validators.delegateAsync(
                (control) =>
                    Future.delayed(const Duration(milliseconds: 100), () {
                      validationCount++;
                      return null;
                    }),
                debounceTime: 200,
              ),
            ],
          );

          control.value = 'value1';
          async.elapse(const Duration(milliseconds: 50));
          control.value = 'value2';
          async.elapse(const Duration(milliseconds: 50));
          control.value = 'value3';
          async.elapse(const Duration(milliseconds: 50));

          // Elapse debounce time
          async.elapse(const Duration(milliseconds: 200));
          expect(control.pending, true);

          // Elapse validator delay
          async.elapse(const Duration(milliseconds: 100));
          expect(control.pending, false);
          expect(validationCount, 1);
        });
      },
    );

    test(
      'Multiple value changes with DebouncedAsyncValidator trigger validation only once',
      () {
        fakeAsync((async) {
          var validationCount = 0;
          final control = FormControl<String>(
            asyncValidators: [
              Validators.debounced(
                Validators.delegateAsync(
                  (control) =>
                      Future.delayed(const Duration(milliseconds: 100), () {
                        validationCount++;
                        return null;
                      }),
                ),
                500, // Custom debounce time
              ),
            ],
          );

          control.value = 'value1';
          async.elapse(const Duration(milliseconds: 100));
          control.value = 'value2';
          async.elapse(const Duration(milliseconds: 100));
          control.value = 'value3';

          // Elapse custom debounce time
          async.elapse(const Duration(milliseconds: 500));
          expect(control.pending, true, reason: 'Control should be pending');

          // Elapse validator delay
          async.elapse(const Duration(milliseconds: 100));
          expect(
            control.pending,
            false,
            reason: 'Control should not be pending',
          );
          expect(
            validationCount,
            1,
            reason: 'Validation should be triggered once',
          );
        });
      },
    );

    test('delegateAsync with debounceTime 0 executes immediately', () {
      fakeAsync((async) {
        var validationCount = 0;
        final control = FormControl<String>(
          // ignore: deprecated_member_use_from_same_package
          asyncValidatorsDebounceTime: 0,
          asyncValidators: [
            Validators.delegateAsync(
              (control) =>
                  Future.delayed(const Duration(milliseconds: 100), () {
                    validationCount++;
                    return null;
                  }),
              debounceTime: 0,
            ),
          ],
        );

        control.value = 'some value';

        // Validator should execute immediately, so control should be pending
        expect(
          control.pending,
          true,
          reason: 'Control should be pending immediately',
        );

        // Elapse validator delay
        async.elapse(const Duration(milliseconds: 100));
        expect(
          control.pending,
          false,
          reason: 'Control should not be pending after validation',
        );
        expect(control.valid, true);
        expect(validationCount, 1);
      });
    });

    test(
      'delegateAsync with debounceTime 0 returns error on failure immediately',
      () {
        fakeAsync((async) {
          final control = FormControl<String>(
            // ignore: deprecated_member_use_from_same_package
            asyncValidatorsDebounceTime: 0,
            asyncValidators: [
              Validators.delegateAsync(
                (control) => Future.delayed(
                  const Duration(milliseconds: 100),
                  () => {'error_immediate': true},
                ),
                debounceTime: 0,
              ),
            ],
          );

          control.value = 'some value';

          // Validator should execute immediately, so control should be pending
          expect(
            control.pending,
            true,
            reason: 'Control should be pending immediately',
          );

          // Elapse validator delay
          async.elapse(const Duration(milliseconds: 100));
          expect(
            control.pending,
            false,
            reason: 'Control should not be pending after validation',
          );
          expect(control.hasError('error_immediate'), true);
        });
      },
    );

    test(
      'DebouncedAsyncValidator throws AssertionError if debounce time is negative',
      () {
        expect(
          () => DebouncedAsyncValidator(
            Validators.delegateAsync((control) async => null),
            -1,
          ),
          throwsAssertionError,
        );
      },
    );
  });
}
