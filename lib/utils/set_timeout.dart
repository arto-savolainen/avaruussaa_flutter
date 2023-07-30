import 'dart:async';

setTimeout(int seconds, void Function() handleTimeout) =>
  Timer(Duration(seconds: seconds), handleTimeout);

setRepeatingTimeout(int seconds, void Function(Timer) handleTimeout) => 
  Timer.periodic(Duration(seconds: seconds), handleTimeout);