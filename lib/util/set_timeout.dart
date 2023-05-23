import 'dart:async';

Timer setTimeout(int seconds, void Function() handleTimeout) =>
  Timer(Duration(seconds: seconds), handleTimeout);

Timer setRepeatingTimeout(int seconds, void Function(Timer) handleTimeout) => 
  Timer.periodic(Duration(seconds: seconds), handleTimeout);