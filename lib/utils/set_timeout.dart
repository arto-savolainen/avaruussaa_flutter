import 'dart:async';

// Helper functions for setting timers.

/// Starts a timer which calls [handleTimeout] after [seconds] seconds have elapsed.
/// Returns a reference to the timer.
Timer setTimeout(int seconds, void Function() handleTimeout) =>
  Timer(Duration(seconds: seconds), handleTimeout);

/// Starts a repeating timer which calls [handleTimeout] after [seconds] seconds have
/// elapsed. [handleTimeout] will be called repeatedly at [seconds] second intervals
/// until the timer is cancelled. Returns a reference to the timer.
Timer setRepeatingTimeout(int seconds, void Function(Timer) handleTimeout) => 
  Timer.periodic(Duration(seconds: seconds), handleTimeout);