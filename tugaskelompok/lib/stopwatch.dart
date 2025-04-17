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
  bool isTimerActive = false;
  List<String> laps = [];

  @override
  void initState() {
    super.initState();
    timer = Timer(Duration.zero, () {});
  }

  void startTimer() {
    timer = Timer.periodic(Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
    isTimerActive = true;
  }

  void stopTimer() {
    timer.cancel();
    isTimerActive = false;
  }

  String formatTime() {
    var millis = stopwatch.elapsedMilliseconds;
    String minutes = ((millis ~/ 60000) % 60).toString().padLeft(2, '0');
    String seconds = ((millis ~/ 1000) % 60).toString().padLeft(2, '0');
    String milliseconds = ((millis % 1000) ~/ 10).toString().padLeft(2, '0');
    return "$minutes:$seconds:$milliseconds";
  }

  void addLap() {
    if (stopwatch.isRunning) {
      setState(() {
        laps.insert(0, formatTime());
      });
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.blue[700]),
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Stopwatch',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[700],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'Catat waktu dengan tepat',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              SizedBox(height: 40),
              
              // Stopwatch Clock Display
              Center(
                child: Container(
                  width: 280,
                  height: 280,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.2),
                      width: 2,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Clock face background
                      Container(
                        width: 260,
                        height: 260,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.blue.shade100,
                            width: 4,
                          ),
                        ),
                      ),
                      
                      // Center circle
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue[700],
                        ),
                      ),
                      
                      // Second hand
                      Transform.rotate(
                        angle: stopwatch.elapsedMilliseconds * 0.00628, // 2PI/1000 * 1000
                        child: Container(
                          height: 220,
                          width: 2,
                          alignment: Alignment.topCenter,
                          child: Container(
                            height: 110,
                            width: 2,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      
                      // Digital time display
                      Positioned(
                        bottom: 70,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            formatTime(),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 20),
              
              // Control buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildControlButton(
                    icon: Icons.refresh,
                    label: "Reset",
                    color: Colors.grey[700]!,
                    onPressed: () {
                      stopwatch.reset();
                      setState(() {
                        laps.clear();
                      });
                    },
                  ),
                  _buildControlButton(
                    icon: stopwatch.isRunning ? Icons.pause : Icons.play_arrow,
                    label: stopwatch.isRunning ? "Pause" : "Start",
                    color: stopwatch.isRunning ? Colors.orange : Colors.green,
                    onPressed: () {
                      if (stopwatch.isRunning) {
                        stopwatch.stop();
                        stopTimer();
                      } else {
                        stopwatch.start();
                        startTimer();
                      }
                      setState(() {});
                    },
                  ),
                  _buildControlButton(
                    icon: Icons.flag,
                    label: "Lap",
                    color: Colors.blue[700]!,
                    onPressed: addLap,
                  ),
                ],
              ),
              
              SizedBox(height: 20),
              
              // Lap times
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: laps.isEmpty
                    ? Center(
                        child: Text(
                          "Tekan tombol Lap untuk mencatat waktu",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.all(8),
                        itemCount: laps.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 4),
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Lap ${laps.length - index}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue[700],
                                  ),
                                ),
                                Text(
                                  laps[index],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            shape: CircleBorder(),
            child: InkWell(
              customBorder: CircleBorder(),
              onTap: onPressed,
              child: Center(
                child: Icon(
                  icon,
                  size: 32,
                  color: color,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: (8)),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
