import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Timer1 extends StatefulWidget {
  final VoidCallback onTimerFinish;
  final List<dynamic>? listOfObject;

  const Timer1({Key? key, required this.onTimerFinish, this.listOfObject}) : super(key: key);

  @override
  State<Timer1> createState() => _Timer1State();
}

class _Timer1State extends State<Timer1> {
  static const maxSecond = 30;
  int second = maxSecond;
  Timer? time;
  bool isPaused = false;

  void resetTimer() => setState(() {
        second = maxSecond;
      });

  void startTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }
    time = Timer.periodic(Duration(seconds: 1), (_) {
      if (second > 0) {
        setState(() {
          second--;
        });
      } else {
        stopTimer(reset: false);
        widget.onTimerFinish();
      }
    });
  }

  void stopTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }
    setState(() {
      time?.cancel();
      isPaused = false;
    });
  }

  void pauseTimer() {
    setState(() {
      time?.cancel();
      isPaused = true;
    });
  }

  void resumeTimer() {
    startTimer(reset: false);
  }

  void showResult() {
    // Code to show the result
  }

  @override
  Widget build(BuildContext context) {
    final isRunning = time == null ? false : time!.isActive;
    final isCompleted = second == 0 || second == maxSecond;

    return GestureDetector(
      onTap: () {
        if (!isRunning) {
          startTimer();
          if (widget.listOfObject != null && widget.listOfObject!.length > 1) {
            _startEEGProcessing(widget.listOfObject![1]['patientID']);
          }
        } else if (isPaused) {
          resumeTimer();
        } else {
          pauseTimer();
        }
      },
      child: Center(
        child: Column(
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: 1 - second / maxSecond,
                    strokeWidth: 12,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                  ),
                  BuiltTime(),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            isRunning || !isCompleted
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (isPaused) {
                              resumeTimer();
                            } else {
                              pauseTimer();
                            }
                          },
                          child: Text(isPaused ? "Resume" : "Pause"),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: stopTimer,
                          child: Text("Cancel"),
                        ),
                      ),
                    ],
                  )
                : ElevatedButton(
                    onPressed: () {
                      startTimer(reset: true);
                      if (widget.listOfObject != null && widget.listOfObject!.length > 1) {
                        _startEEGProcessing(widget.listOfObject![1]['patientID']);
                      }
                    },
                    child: Text(
                      "Start",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(287, 45),
                      alignment: Alignment.center,
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget BuiltTime() {
    return Center(
      child: Text(
        "$second",
        style: TextStyle(color: Colors.blue, fontSize: 80),
      ),
    );
  }
}



void _startEEGProcessing(int patientID) async {
  try {
    print("patientID >>>>>>>>>>> $patientID");
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/start_eeg_processing'),
      body: jsonEncode({'patientID': patientID}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Handle successful response
      print("EEG processing started successfully");

      // Start a 30-second timer to stop EEG processing
      Timer(const Duration(seconds: 20), () {
        _stopEEGProcessing();
      });
    } else {
      // Handle other status codes (e.g., display error message)
      print("Failed to start EEG processing: ${response.statusCode}");
    }
  } catch (error) {
    // Handle network error (e.g., display network error message)
    print("Error starting EEG processing: $error");
  }
}

void _stopEEGProcessing() async {
  try {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/stop_eeg_processing'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Handle successful response
      print("EEG processing stopped successfully");
    } else {
      // Handle other status codes (e.g., display error message)
      print("Failed to stop EEG processing: ${response.statusCode}");
    }
  } catch (error) {
    // Handle network error (e.g., display network error message)
    print("Error stopping EEG processing: $error");
  }
}


