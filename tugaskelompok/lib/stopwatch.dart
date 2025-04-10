import 'package:flutter/material.dart';
import 'dart:async';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  Stopwatch stopwatch = Stopwatch();
  late Timer timer;

  void startTimer() {
    timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Stopwatch")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text((stopwatch.elapsed.inSeconds).toString(),
                style: TextStyle(fontSize: 48)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      stopwatch.start();
                      startTimer();
                    },
                    child: Text("Start")),
                SizedBox(width: 10),
                ElevatedButton(
                    onPressed: () => stopwatch.stop(), child: Text("Stop")),
                SizedBox(width: 10),
                ElevatedButton(
                    onPressed: () {
                      stopwatch.reset();
                      setState(() {});
                      stopwatch.stop();
                    },
                    child: Text("Reset")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
