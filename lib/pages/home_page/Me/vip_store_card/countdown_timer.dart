import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:youmi/global_vm.dart';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({
    super.key,
  });

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  late int _secondsRemaining; // 设定初始倒计时时间（例如 1小时1分钟1秒）
  late GlobalVm _globalVm;
  @override
  void initState() {
    super.initState();
    _globalVm = Provider.of<GlobalVm>(context, listen: false);
    _secondsRemaining = DateTime.now().millisecondsSinceEpoch ~/ 1000 -
        (_globalVm.meUserinfo?.firstActTime ?? 0);
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  String _formatTime(int seconds) {
    int hours = (seconds ~/ 3600);
    int minutes = (seconds % 3600) ~/ 60;
    int secondsLeft = seconds % 60;

    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secondsLeft.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text("Limited Time "),
      Text(
        _formatTime(_secondsRemaining), // 格式化倒计时
        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
      )
    ]);
  }
}
