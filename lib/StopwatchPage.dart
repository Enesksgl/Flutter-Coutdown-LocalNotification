import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

class StopwatchPage extends StatefulWidget {
  @override
  _StopwatchPageState createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  CountDownController _controller = CountDownController();
  int dakika;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Stopwatch")),
      body: Container(
        child: Column(
          children: <Widget>[
            TextFormField(
              onChanged: (dk) {
                dakika = 60 * int.parse(dk);

                _controller.restart(duration: dakika);
                _controller.pause();
                setState(() {});
              },
            ),
            Center(
              child: coutdownwidget(dakika, context, _controller),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: ButtonBar(
                  children: <Widget>[
                    RaisedButton(
                      child: Text("Başlat"),
                      onPressed: () {
                        _controller.resume();
                      },
                    ),
                    RaisedButton(
                      child: Text("Durdur"),
                      onPressed: () {
                        _controller.pause();
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget coutdownwidget(
    int dk, BuildContext context, CountDownController _controller) {
  return CircularCountDownTimer(
    // Countdown duration in Seconds
    duration: (dk == null) ? 0 : dk,

    // Controller to control (i.e Pause, Resume, Restart) the Countdown
    controller: _controller,

    // Width of the Countdown Widget
    width: MediaQuery.of(context).size.width / 3,

    // Height of the Countdown Widget
    height: MediaQuery.of(context).size.height / 3,

    // Default Color for Countdown Timer
    color: Colors.white,

    // Filling Color for Countdown Timer
    fillColor: Colors.red,

    // Background Color for Countdown Widget
    backgroundColor: null,

    // Border Thickness of the Countdown Circle
    strokeWidth: 5.0,

    // Begin and end contours with a flat edge and no extension
    strokeCap: StrokeCap.butt,

    // Text Style for Countdown Text
    textStyle: TextStyle(
        fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.bold),

    // true for reverse countdown (max to 0), false for forward countdown (0 to max)
    isReverse: true,

    // true for reverse animation, false for forward animation
    isReverseAnimation: false,

    // Optional [bool] to hide the [Text] in this widget.
    isTimerTextShown: true,

    // Function which will execute when the Countdown Ends
    onComplete: () {
      // Here, do whatever you want
      print('Countdown Ended');
    },
  );
}

/*floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            setState(() {
              if (_isPause) {
                _isPause = false;
                _controller.resume();
              } else {
                _isPause = true;
                _controller.pause();
              }
            });
          },
          icon: Icon(_isPause ? Icons.play_arrow : Icons.pause),
          label: Text(_isPause ? "Resume" : "Pause")),
);*/
