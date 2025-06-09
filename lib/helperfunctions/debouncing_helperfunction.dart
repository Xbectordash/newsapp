import 'dart:async';

/// Debounce utility to delay function execution.
///
/// Useful for limiting frequent calls (e.g., during typing).
class Debounce {
  /// Delay duration before executing the callback.
  final Duration delay;

  Timer? _timer;

  /// Creates a [Debounce] with the given [delay].
  Debounce(this.delay);

  /// Calls [callback] after [delay]; resets if called again before time.
  void call(void Function() callback) {
    _timer?.cancel();
    _timer = Timer(delay, callback);
  }

  /// Cancels the active timer, if any.
  void dispose() {
    _timer?.cancel();
  }
}
