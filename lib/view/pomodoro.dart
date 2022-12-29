import 'dart:async';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminder_pomodoro/helpers/theme.dart';

class Pomodoro extends StatefulWidget {
  const Pomodoro(
      {Key? key,
      required this.breakTime,
      required this.workTime,
      required this.workSessions})
      : super(key: key);
  final String breakTime;
  final String workTime;
  final String workSessions;

  @override
  State<Pomodoro> createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  bool _isRunning = false;
  Duration _time = const Duration(minutes: 60);
  Duration _break = const Duration(minutes: 10);
  int _timeInt = 60;
  int _counter = 1;
  int _sessionCount = 4;
  int _timerCount = 0;
  int _currMax = 60;
  Timer? _timer;

  //Functions
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() async {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _time = _time - const Duration(seconds: 1);
        if (_time.inSeconds <= 0) {
          if (_timerCount % 2 == 1) {
            _time = Duration(minutes: _timeInt);
            _currMax = _timeInt;
            _timerCount++;
          } else {
            _time = _break;
            _currMax = _break.inMinutes;
            _counter++;
            _timerCount++;
          }
          if (_counter > _sessionCount) {
            AnimatedSnackBar(
              builder: ((context) {
                return Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.greenAccent,
                  height: 65,
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.check_circle_outline,
                            size: 30,
                          ),
                          SizedBox(width: 20),
                          Text(
                            'Session Completed!',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'Arial',
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(
                              width:
                                  50), // Add some horizontal spacing to align the text with the first message
                          Text(
                            'You logged ${_sessionCount * _timeInt} minutes.',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Arial',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ).show(context);
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.pop(context);
          }

          _stopTimer();
          _isRunning = false;
        }
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  void _resetTimer() {
    setState(() {
      if (_isRunning) {
        _stopTimer();
      }
      _time = const Duration(minutes: 60);
      if (_timerCount % 2 == 1) {
        _time = Duration(minutes: _break.inMinutes);
      } else {
        _time = Duration(minutes: _timeInt);
      }
      _isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final int minutes = _time.inMinutes;
    final int seconds = _time.inSeconds % 60;
    String timerState = "Break";
    if (_timerCount % 2 == 0) {
      timerState = '$_counter / $_sessionCount';
    }
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _customAppBar(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  width: 300,
                  height: 300,
                  child: CircularProgressIndicator(
                    color: Colors.greenAccent,
                    backgroundColor: Colors.black,
                    value: _time.inSeconds /
                        (_currMax *
                            60), // calculates the progress as a value between 0 and 1
                    strokeWidth: 2,
                  ),
                ),
                Positioned(
                  top: 100,
                  left: 70,
                  child: Text(
                    '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                    style: const TextStyle(
                      fontSize: 60,
                      color: Colors.greenAccent,
                      fontFamily: 'Arial',
                    ),
                  ),
                ),
                Positioned(
                  bottom: 100,
                  left: 130,
                  child: Text(
                    timerState,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.greenAccent,
                      fontFamily: 'Arial',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_isRunning) {
              _stopTimer();
            } else {
              _startTimer();
            }
            _isRunning = !_isRunning;
          });
        },
        shape: const CircleBorder(),
        backgroundColor: Colors.black,
        mini: false,
        child: _isRunning
            ? const Icon(Icons.pause, color: Colors.greenAccent)
            : const Icon(Icons.play_arrow, color: Colors.greenAccent),
      ),
    );
  }

  AppBar _customAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      title: Text(
        'POMODORO',
        style: titleStyle,
      ),
      actions: [
        IconButton(
          padding: const EdgeInsets.only(right: 20.0),
          icon: const Icon(Icons.settings, color: Colors.greenAccent, size: 30),
          onPressed: () {
            setState(() {
              _resetTimer();
            });
          },
        ),
      ],
    );
  }
}
