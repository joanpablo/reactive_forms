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

    // Regression tests for https://github.com/joanpablo/reactive_forms/issues/504
    //
    // When a control is disposed while an async validator is still in flight,
    // the validator's `onDone` callback used to fire after `_statusChanges`
    // was already closed, throwing
    // `StateError: Cannot add new events after calling close`.
    group('Dispose during in-flight async validation', () {
      test('FormControl disposed mid-flight does not throw', () {
        fakeAsync((async) {
          final control = FormControl<String>(
            asyncValidators: [
              Validators.delegateAsync(
                (control) =>
                    Future.delayed(const Duration(milliseconds: 100), () => null),
              ),
            ],
          );

          control.value = 'some value';
          expect(control.pending, true);

          // Dispose part-way through the debounce window so the timer
          // outlives the subscription's cancellation.
          async.elapse(const Duration(milliseconds: 100));
          control.dispose();

          // Advance past the global debounce (250ms) plus the validator's
          // delay so the orphaned future resolves and the stream completes.
          async.elapse(const Duration(milliseconds: 500));
        });
      });

      test(
        'FormControl disposed mid-flight does not throw when validator returns errors',
        () {
          fakeAsync((async) {
            final control = FormControl<String>(
              asyncValidators: [
                Validators.delegateAsync(
                  (control) => Future.delayed(
                    const Duration(milliseconds: 100),
                    () => {'unique': true},
                  ),
                ),
              ],
            );

            control.value = 'some value';
            async.elapse(const Duration(milliseconds: 100));
            control.dispose();

            // Without the guard, onDone would call setErrors → _statusChanges.add
            // on a closed controller and throw StateError.
            async.elapse(const Duration(milliseconds: 500));
          });
        },
      );

      test('FormControl disposed during debounce window does not throw', () {
        fakeAsync((async) {
          final control = FormControl<String>(
            asyncValidators: [
              Validators.delegateAsync(
                (control) =>
                    Future.delayed(const Duration(milliseconds: 100), () => null),
                debounceTime: 500,
              ),
            ],
          );

          control.value = 'some value';

          // Dispose while still inside the debounce window — the timer is
          // armed but the validator hasn't started yet.
          async.elapse(const Duration(milliseconds: 100));
          control.dispose();

          // Advance well past debounce + validator delay.
          async.elapse(const Duration(milliseconds: 1000));
        });
      });

      test(
        'FormGroup disposed while a child async validator is in flight does not throw',
        () {
          fakeAsync((async) {
            final form = FormGroup({
              'name': FormControl<String>(
                asyncValidators: [
                  Validators.delegateAsync(
                    (control) => Future.delayed(
                      const Duration(milliseconds: 100),
                      () => {'taken': true},
                    ),
                  ),
                ],
              ),
            });

            form.control('name').value = 'some value';
            expect(form.pending, true);

            // Disposing the parent cascades dispose() to children.
            async.elapse(const Duration(milliseconds: 100));
            form.dispose();

            async.elapse(const Duration(milliseconds: 500));
          });
        },
      );

      test(
        'FormControl disposed with multiple in-flight async validators does not throw',
        () {
          fakeAsync((async) {
            final control = FormControl<String>(
              asyncValidators: [
                Validators.delegateAsync(
                  (control) => Future.delayed(
                    const Duration(milliseconds: 100),
                    () => null,
                  ),
                ),
                Validators.delegateAsync(
                  (control) => Future.delayed(
                    const Duration(milliseconds: 200),
                    () => {'other': true},
                  ),
                ),
                Validators.debounced(
                  Validators.delegateAsync(
                    (control) => Future.delayed(
                      const Duration(milliseconds: 150),
                      () => null,
                    ),
                  ),
                  300,
                ),
              ],
            );

            control.value = 'some value';
            async.elapse(const Duration(milliseconds: 100));
            control.dispose();

            async.elapse(const Duration(milliseconds: 1000));
          });
        },
      );

      test('Dispose cancels the pending debounce timer', () {
        fakeAsync((async) {
          final control = FormControl<String>(
            asyncValidators: [
              Validators.delegateAsync(
                (control) =>
                    Future.delayed(const Duration(milliseconds: 100), () => null),
              ),
            ],
          );

          control.value = 'x';
          expect(
            async.pendingTimers,
            isNotEmpty,
            reason:
                'A debounce timer should be scheduled after a value change',
          );

          control.dispose();

          expect(
            async.pendingTimers,
            isEmpty,
            reason:
                'Dispose should cancel the pending debounce timer so it cannot '
                'fire the validator after the streams have been closed',
          );
        });
      });
    });

    // Regression test for the underlying race that caused the use-after-free
    // crash in issue #504. The bug: `_cancelExistingSubscription` was async and
    // awaited `subscription.cancel()`; the suspension point allowed
    // `_runAsyncValidators` to assign a fresh subscription before the
    // continuation set `_asyncValidationSubscription = null`, orphaning it.
    // Because the orphan was never cancelled on a subsequent value change, its
    // stale result could overwrite the latest validator's result.
    group('Async validator subscription cancellation', () {
      test('Stale async validator result does not overwrite latest', () {
        fakeAsync((async) {
          // Validator behaviour is value-dependent. The captured value is
          // fixed at validator-invocation time so the closure stays
          // consistent even if the control's value changes afterwards.
          //   'bad'  → slow (200ms), returns {'invalid': true}
          //   'good' → fast (50ms),  returns no error
          //
          // If the 'bad' subscription is correctly cancelled when the value
          // becomes 'good', the stale error never reaches the control. With
          // the orphan race, the 'bad' subscription survives, fires onDone
          // after 'good' has already settled, and re-injects the stale error
          // into the control's error map.
          final control = FormControl<String>(
            // ignore: deprecated_member_use_from_same_package
            asyncValidatorsDebounceTime: 0,
            asyncValidators: [
              Validators.delegateAsync((c) {
                final captured = c.value;
                return Future.delayed(
                  Duration(milliseconds: captured == 'bad' ? 200 : 50),
                  () => captured == 'bad' ? {'invalid': true} : null,
                );
              }),
            ],
          );

          control.value = 'bad';
          async.elapse(const Duration(milliseconds: 50));
          control.value = 'good';
          async.elapse(const Duration(milliseconds: 300));

          expect(
            control.hasError('invalid'),
            false,
            reason:
                'A stale validator result for "bad" must not survive after '
                'the value has been changed to "good"',
          );
        });
      });
    });
  });
}
