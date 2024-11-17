import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sukoon/Const/constant.dart';
import 'package:sukoon/Pages/api_services.dart';
import 'package:sukoon/Pages/contact.dart';

class SpecialistList extends StatefulWidget {
  const SpecialistList({Key? key, this.listOfObject}) : super(key: key);
  final List<dynamic>? listOfObject;

  @override
  State<SpecialistList> createState() => _SpecialistListState();
}

class _SpecialistListState extends State<SpecialistList> {
  late Future<List<dynamic>> _fetchDataFuture;

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = fetchData();

  }

  Future<void> updateDoctorID(int id, List<dynamic>? list) async {
    String apiUrl =
        'https://infinite-wave-71025-404d3d4feff8.herokuapp.com/api/updateDoctorCaregiver';
    String apiUr2 =
        'https://infinite-wave-71025-404d3d4feff8.herokuapp.com/api/updateDoctorPatient';
    Map<String, dynamic> requestBody1 = {
      'caregiverID': list![0]['caregiverID'],
      'doctor_id': id,
    };
    String jsonBody1 = jsonEncode(requestBody1);

    Map<String, dynamic> requestBody2 = {
      'patientID': list[1]['patientID'],
      'doctor_ID': id,
    };
    String jsonBody2 = jsonEncode(requestBody2);

// ------------------------ for caregiver
    try {
      http
          .put(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonBody1,
      )
          .then((response) {
        if (response.statusCode == 200) {
          print('Caregiver\'s doctor updated successfully.');
          widget.listOfObject![0]['doctor_ID'] = id;
        } else {
          print(
              'Failed to update caregiver\'s doctor. Status code: ${response.statusCode}');
        }
      }).catchError((error) {
        print('Error updating caregiver\'s doctor: $error');
      });
    } catch (e) {
      print('Error updating caregiver\'s doctor: $e');
    }

    // -------------------------- for patient

    try {
      http
          .put(
        Uri.parse(apiUr2),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonBody2,
      )
          .then((response) {
        if (response.statusCode == 200) {
          print('Patient\'s doctor updated successfully.');
          widget.listOfObject![1]['doctor_ID'] = id;
        } else {
          print(
              'Failed to update patient\'s doctor. Status code: ${response.statusCode}');
        }
      }).catchError((error) {
        print('Error updating patient\'s doctor: $error');
      });
    } catch (e) {
      print('Error updating patient\'s doctor: $e');
    }
  }

  Future<List<dynamic>> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://infinite-wave-71025-404d3d4feff8.herokuapp.com/api/listDoctor'));

    if (response.statusCode == 200) {
      List<dynamic> parsedData = jsonDecode(response.body);
      if (widget.listOfObject != null && widget.listOfObject!.isNotEmpty) {
        if (widget.listOfObject![0]['doctor_ID'] == null) {
          parsedData.sort(
              (a, b) => a['specialization'].compareTo(b['specialization']));
          return parsedData;
        } else {
          List<dynamic> filteredData = [];
          for (var item in parsedData) {
            if (item['doctorID'] == widget.listOfObject![0]['doctor_ID']) {
              filteredData.add(item);
              setState(() {
                fetchDctor(widget.listOfObject);
              });
            }
          }
          return filteredData;
        }
      } else {
        throw Exception('Null Information');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
            child: const Column(
              children: [
                SizedBox(height: 70),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Icon(
                          Icons.settings_outlined,
                          color: Color(lightBlue1),
                          size: 30,
                        ),
                      ),
                    ),
                    SizedBox(width: 80),
                    Text(
                      "Specialist",
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
          const SizedBox(height: 20),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: _fetchDataFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<dynamic> data = snapshot.data!;
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 152,
                        width: 298,
                        decoration: const BoxDecoration(
                          color: Color(darkGray),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Color(darkerGray),
                              blurRadius: 5,
                              spreadRadius: 2,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Row(
                          children: [
                            Container(
                              height: 90,
                              width: 103,
                              margin: const EdgeInsets.only(
                                top: 20,
                                bottom: 20,
                                left: 20,
                                right: 10,
                              ),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Color(lightGray),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(darkerGray2),
                                    blurRadius: 3,
                                    spreadRadius: 1,
                                    offset: Offset(-1, 2),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.person_2_rounded,
                                color: Color(darkBlue),
                                size: 80,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${data[index]['Fname']} ${data[index]['Lname']}\n${data[index]['specialization']}",
                                    style: const TextStyle(
                                      color: Color(darkerGray),
                                      fontSize: 18,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              // Navigate to the new page here
                                              int ID = data[index]['doctorID'];
                                              if (widget.listOfObject![0]
                                                      ['doctor_ID'] ==
                                                  null) {
                                                //-----------------------<<>>
                                                await updateDoctorID(
                                                      ID, widget.listOfObject);
                                                  await fetchDctor(widget.listOfObject);
                                                
                                              } else {
                                                await fetchDctor(widget.listOfObject);

                                              }
                                              if (widget.listOfObject![0]['doctor_ID'] != null) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ContactPage(
                                                      listOfObject:
                                                          widget.listOfObject,
                                                    ),
                                                  ),
                                                );
                                              }else{
                                                const Center(child: CircularProgressIndicator());
                                                
                                              }
                                            },
                                            child: Icon(
                                              Icons.chat_outlined,
                                              color: Color(darkBlue),
                                              size: 20,
                                            ),

                                            
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}