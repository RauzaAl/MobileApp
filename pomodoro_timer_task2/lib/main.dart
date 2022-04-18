import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum Status {
  studyTime,
  breakTime,
  none,
}

class _MyHomePageState extends State<MyHomePage> {
  static int studyMinutes = 25;
  static int studySeconds = 0;
  static int breakMinutes = 5;
  static int breakSeconds = 0;
  Status current = Status.none;
  int _seconds = studySeconds;
  int _minutes = studyMinutes;
  Timer? _timer;
  var f = NumberFormat("00");

  void _stopTimer() {
    if (_timer != null) {
      current = Status.none;
      _timer?.cancel();
      _seconds = studySeconds;
      _minutes = studyMinutes;
    }
  }

  void _startTimer(){
    if (_timer != null){
      _stopTimer();
    }
    current = Status.studyTime;
    _minutes = studyMinutes;
    _seconds = studySeconds;
    // if (_minutes > 0){
    //   _seconds = _minutes * 60;
    // }
    // if (_seconds > 60){
    //   _minutes = (_seconds/60).floor();
    //   _seconds = _seconds - (_minutes * 60);
    // }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0){
          _seconds--;
        }
        else {
          if (_minutes > 0){
            _seconds = 59;
            _minutes--;
          }
          else {
            if (current == Status.studyTime){
              current = Status.breakTime;
              _minutes = breakMinutes;
              _seconds = breakSeconds;
            }
            else {
              current = Status.studyTime;
              _minutes = studyMinutes;
              _seconds = studySeconds;
            }
          }
        }
      });
    });
  }

  String _statusText() {
    switch (current) {
      case Status.studyTime:
        return "Study time";
      case Status.breakTime:
        return "Break time";
      case Status.none:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${f.format(_minutes)} : ${f.format(_seconds)}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
              _statusText(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                  onPressed: (){
                    setState(() {
                      _stopTimer();
                    });
                  },
                color: Colors.black,
                shape: CircleBorder(
                  side: BorderSide(color: Colors.orange)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Text(
                    "Stop",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                )
                ),
              ),
              RaisedButton(
                onPressed: (){
                   _startTimer();
                },
                color: Colors.orange,
                shape: CircleBorder(
                    side: BorderSide(color: Colors.orange)
                ),
                child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Text(
                      "Start",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    )
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

