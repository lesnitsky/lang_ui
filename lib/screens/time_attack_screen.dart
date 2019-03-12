import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';

class TimeAttackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TimeAttackContent();
  }
}

class TimeAttackContent extends StatefulWidget {
  @override
  _TimeAttackContentState createState() => _TimeAttackContentState();
}

class _TimeAttackContentState extends State<TimeAttackContent> {
  List<String> words = [];

  static int duration = 30;

  int points = 0;
  int seconds = duration;
  bool isStarted = false;
  int correct;
  String word;

  List<int> options = [];

  Random random = new Random();

  _nextWord([int answer]) {
    if (answer == correct && answer != null) {
      points++;
    } else if (correct != null) {
      points -= 2;
    }

    correct = random.nextInt(words.length);

    word = words[correct].split(',')[0];

    options = [
      correct,
      random.nextInt(words.length),
      random.nextInt(words.length),
    ];

    options.shuffle();
  }

  _start() {
    setState(() {
      isStarted = true;
      seconds = duration;
      points = 0;
      _nextWord();
    });

    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        seconds--;

        if (seconds == 0) {
          timer.cancel();
          isStarted = false;

          correct = null;
          word = null;
          options = [];
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Time attack')),
      floatingActionButton: isStarted
          ? null
          : FloatingActionButton(
              child: Icon(Icons.play_arrow),
              onPressed: _start,
            ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: CircularProgressIndicator(
                        value: 1 - (duration - seconds) / duration,
                      ),
                    ),
                    Text(
                      seconds.toString(),
                      style: TextStyle(color: Colors.blue, fontSize: 30),
                    ),
                  ],
                ),
                Text(
                  points.toString(),
                  style: TextStyle(fontSize: 30.0),
                )
              ],
            ),
            word != null
                ? Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 30,
                            ),
                            child: Text(
                              word,
                              style: TextStyle(fontSize: 30.0),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _nextWord(options[0]);
                                  });
                                },
                                child: Card(
                                    child: Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text(
                                    words[options[0]].split(',')[1],
                                    style: TextStyle(fontSize: 20),
                                  ),
                                )),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _nextWord(options[1]);
                                  });
                                },
                                child: Card(
                                    child: Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text(
                                    words[options[1]].split(',')[1],
                                    style: TextStyle(fontSize: 20),
                                  ),
                                )),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _nextWord(options[2]);
                                  });
                                },
                                child: Card(
                                  child: Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Text(
                                      words[options[2]].split(',')[1],
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : null,
          ].where((o) => o != null).toList(),
        ),
      ),
    );
  }
}
