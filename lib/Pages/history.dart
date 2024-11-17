import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sukoon/Const/constant.dart';
import 'package:sukoon/Pages/settings.dart';
import 'package:sukoon/widgets.dart';
import 'package:http/http.dart' as http;
//import 'dart:convert' as convert;
import 'package:intl/intl.dart';

class History extends StatefulWidget {
  const History({super.key, required this.listOfObject});
  final List<dynamic>? listOfObject;

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<dynamic> _data = [];


  Future<List<dynamic>> getData() async {
    var response = await http.get(Uri.parse(
        "https://infinite-wave-71025-404d3d4feff8.herokuapp.com/api/searchSession/${widget.listOfObject![1]['patientID']}"));
        //216558
    // ${widget.listOfObject![1]['patientID']}

    if (response.statusCode == 200) {
      List<dynamic> parsedData = jsonDecode(response.body);
      parsedData.sort((a, b) => DateTime.parse(b['Timestamp']).compareTo(DateTime.parse(a['Timestamp'])));
      return parsedData;
    } else {
      print("Failed fetch data");
      return []; // Return an empty list if there's an error
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> HistoryData = [];

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 236,
            decoration: const BoxDecoration(color: Color(darkBlue), boxShadow: [
              BoxShadow(
                color: Color(darkerGray),
                blurRadius: 5,
                spreadRadius: 2,
                offset: Offset(0, 2),
              )
            ]),
            child:  Column(
              children: [
                SizedBox(
                  height: 70,
                ),
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
                    SizedBox(
                      width: 80,
                    ),
                    Text(
                      "History",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          
          //--------------------------------------- start

          SizedBox(height: 20),
          FutureBuilder(
            future: getData(),
            builder:
                (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.data!.isEmpty) {
                return Text('No data available');
              } else {
                // Initialize variables to keep track of the current month
                String currentMonth = '';
                bool isFirstCardInMonth = true;

                // Your ListView.builder
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, i) {
                    List<String> DateVsTime =
                        dateandtime(snapshot.data![i]['Timestamp']);
                    String month = DateVsTime[0].substring(3, 6);

                    // Check if the current card is the first card of the month
                    if (currentMonth != month) {
                      currentMonth = month;
                      isFirstCardInMonth = true;
                    } else {
                      isFirstCardInMonth = false;
                    }

                    // Display the month name only for the first card of each month
                    return Column(
                      children: [
                        if (isFirstCardInMonth)
                          Text("________  ${month}  ________",
                              style: TextStyle(
                                  color: Color(darkerGray), fontSize: 20)),
                        historyCard(
                          Eresult: snapshot.data![i]['Result'] + " emotion",
                          date: DateVsTime[0],
                          time: DateVsTime[1],
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

List<String> dateandtime(String inputString) {
  // Parse the input string to create a DateTime object
  DateTime dateTime = DateTime.parse(inputString);

  // Format the DateTime object as "MMM dd yyyy" for date and "hh:mm a" for time
  String formattedDate = DateFormat("dd MMM yyyy").format(dateTime);
  String formattedTime = DateFormat("hh:mm a").format(dateTime);

  return [formattedDate, formattedTime];
}

