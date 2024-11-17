import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:sukoon/Const/constant.dart';
import 'package:sukoon/Pages/classes/noti.dart';
import 'package:sukoon/Pages/deviceInstr.dart';
import 'package:sukoon/Pages/timeeeeer.dart';
import 'package:sukoon/Pages/settings.dart';
import 'package:sukoon/widgets.dart';
import 'package:get/get.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class EEG_Session extends StatefulWidget {
  const EEG_Session({super.key, this.listOfObject});
  final List<dynamic>? listOfObject;

  @override
  State<EEG_Session> createState() => _EEG_SessionState();
}

class _EEG_SessionState extends State<EEG_Session> {
  @override
  void initState() {
    super.initState();
    //Noti.initialize(flutterLocalNotificationsPlugin);
  }

  Future<String> fetchDataFromServer() async {
    try {
      var response = await http.get(Uri.parse(
          "https://infinite-wave-71025-404d3d4feff8.herokuapp.com/api/listSession"));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);

        // Sort the response by timestamp in descending order
        responseBody
            .sort((a, b) => b['Timestamp'].compareTo(a['Timestamp']) as int);

        // Take the first entry as the latest result
        var latestResult = responseBody.isNotEmpty ? responseBody[0] : null;

        if (latestResult != null) {
          String result =latestResult['Result'];
          // "NEGATIVE";
          //
          return result;
        } else {
          return "No data available";
        }
      } else {
        throw Exception(
            'Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error getting data: $e');
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(darkBlue),),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            height: 236,
            decoration: const BoxDecoration(
              color: Color(darkBlue),
              boxShadow: [
                BoxShadow(
                  color: Color(darkerGray),
                  blurRadius: 5,
                  spreadRadius: 2,
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: Column(
              children: [
                SizedBox(height: 70),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Settings(
                              listOfObject: widget.listOfObject,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Icon(
                            Icons.settings_outlined,
                            color: Color(lightBlue1),
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      "Emotion Recognition",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "5 ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "rounds",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(width: 40),
                    Text(
                      "10 ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "min each",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(height: 10),
              Image(image: AssetImage("assest/images/giphy.gif")),
              /*
              ElevatedButton(
                onPressed: () {
                  Noti.showNotification();
                },
                child: Text("click"),
              ),
              */
              wideGrayBotton(
                label: "Instrection Device",
                page: DeviceInstr(),
              ),
              SizedBox(height: 15),
              wideGrayBotton(
                label: "EEG Session",
                 weindow: () => _showModalBottomSheet(context),
              ),
              SizedBox(height: 15),
            ],
          ),
        ],
      ),
    );
  }
void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AdvancedCustomAlert();
      },
    );
  }

void _showModalBottomSheet(BuildContext context) {
  _showResultModal(context);
}

void _showResultModal(BuildContext context) async {
  bool timerFinished = false;
  late Future<String> futureResult;

  void onTimerFinish() {
    setState(() {
      timerFinished = true;
      alertNegativeEmotion();
      futureResult = fetchDataFromServer(); // Fetch the latest result when the timer finishes
    });
  }

  futureResult = fetchDataFromServer(); // Initial fetch

  showModalBottomSheet(
    backgroundColor: Color(lightGray),
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        height: 500,
        child: Column(
          children: [
            SizedBox(height: 30),
            Timer1(
              onTimerFinish: onTimerFinish,
              listOfObject: widget.listOfObject,
            ),
            SizedBox(height: 10),
            FutureBuilder<String>(
              future: futureResult,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (timerFinished) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.receipt_long_outlined,
                          color: Color(darkBlue),
                          size: 50,
                        ),
                        Text(
                          "Result: ${snapshot.data}",
                          style: TextStyle(color: Color(darkBlue), fontSize: 30),
                        ),
                      ],
                    );
                  } else{
                    return CircularProgressIndicator();
                  }
                }
                return Container(); // Return an empty container when data is not yet available or timer is not finished
              },
            )
          ],
        ),
      );
    },
  );
}

  //---------------------------------------------------------------------------------
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width - 20,
                color: const Color.fromARGB(186, 255, 254, 255),
                child: const Column(
                  children: <Widget>[
                    // SizedBox( height: 65, child: Image( image: AssetImage('assest/images/logo.png'),),),
                    SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.notifications_active , color: Color(darkBlue),),
                        SizedBox(width: 5,),
                        Text(
                          'Negative Emotion',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 5,),
                    Text(
                      '\nResult of EEG session is Negative',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Future<void> alertNegativeEmotion() async {
    final response1 = await http.get(Uri.parse(
        'https://infinite-wave-71025-404d3d4feff8.herokuapp.com/api/listSession'));
    if (response1.statusCode == 200) {
      final List<dynamic> dataList = jsonDecode(response1.body);

      if (dataList[dataList.length - 1]["Result"] == "NEGATIVE" &&
          isNegativeEmotionActive) {
            //_showMyDialog();
            Noti.showNotification();
            }

    }
  }
}

class TimerController extends GetxController {
  Timer? _timer;
  int remainingSeconds = 1;
  final time = '00.00'.obs;

  @override
  void onReady() {
    _startTimer(900);
    super.onReady();
  }

  @override
  void onClose() {
    if (_timer != null) {
      _timer!.cancel();
    }

    super.onClose();
  }

  void _startTimer(int seconds) {
    const duration = Duration(seconds: 1);
    remainingSeconds = seconds;
    _timer = Timer.periodic(duration, (timer) {
      if (remainingSeconds == 0) {
        timer.cancel();
      } else {
        int minutes = remainingSeconds ~/ 60;
        int seconds = (remainingSeconds % 60);
        time.value = minutes.toString().padLeft(2, "0") +
            ":" +
            seconds.toString().padLeft(2, "0");
        remainingSeconds--;
      }
    });
  }
}


