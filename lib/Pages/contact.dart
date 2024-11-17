import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:sukoon/Const/constant.dart';
import 'package:sukoon/Pages/api_services.dart';
import 'package:sukoon/Pages/settings.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key, this.listOfObject});
  final List<dynamic>? listOfObject;

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  void initState() {
    super.initState();
  }

  List<dynamic> recomendations = [];
  bool isContentTooLong = true;
  int counChar = 100;
  int RecomendationLength = 190;
  String Recomendation =
      "klsjds kjskdjksjd kjsdkjsd skdjksjds dn ifeifed ojjf ldjf ojflkfmfb kjfkjd ljdlfjjf kjfkjdfndfndkfdf knfkndnf kdfkdf df,dnfkfkf kfmdfmd fd'd;adoif hfkdf, kkdmdc adldfaskjfsad";

  Future<List<dynamic>> faetchRecomendation() async {
    try {
      // Make GET request to API endpoint
      var responseContact = await http.get(Uri.parse(
          'https://infinite-wave-71025-404d3d4feff8.herokuapp.com/api/searchContactMessage/${widget.listOfObject![0]["caregiverID"]}'));

      // Check if the request was successful (status code 200)
      if (responseContact.statusCode == 200) {
        // Parse the JSON response
        return recomendations = convert.json.decode(responseContact.body);
      } else {
        // Handle error if the request was not successful
        print(
            'Failed to fetch recomendations of. Status code: ${responseContact.statusCode}');
        return [];
      }
    } catch (e) {
      // Handle any exceptions that occur during the request
      print('Error fetching recomendations data: $e');
      return [];
    }
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
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
                  const SizedBox(
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
                        "Contact",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        Container(
                          // ---------------- Image
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            color: Color(darkGray),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.person_2_rounded,
                            color: Color(darkBlue),
                            size: 50,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        widget.listOfObject![0]['doctor_ID'] != null
                            ? Text(
                                "Dr. ${widget.listOfObject![2]['Fname']} ${widget.listOfObject![2]['Lname']}\n${widget.listOfObject![2]['specialization']}",
                                style: TextStyle(
                                    color: Color(darkerGray), fontSize: 18),
                              )
                            : const Text(
                                "PLEASE! Choose Doctor \nfrom Doctor List",
                                style:
                                    TextStyle(color: Colors.yellow, fontSize: 12),
                              ),
                      ],
                    ),
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
              future: faetchRecomendation(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.data!.isEmpty) {
                  return Text('No data available');
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        List<String> DateVsTime =
                            dateandtime(snapshot.data![index]['TimeStamp']);
                        Recomendation = snapshot.data![index]['message'] ?? '';                      
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 35, bottom: 10, top: 10, right: 35),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.date_range_rounded,
                                      color: Color(darkBlue),
                                      size: 30,
                                    ),
                                    Text(
                                      DateVsTime[0],
                                      style: TextStyle(
                                          color: Color(darkBlue), fontSize: 18),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.timelapse_rounded,
                                      color: Color(darkBlue),
                                      size: 30,
                                    ),
                                    Text(
                                      DateVsTime[1],
                                      style: TextStyle(
                                          color: Color(darkBlue), fontSize: 18),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                if (Recomendation.length > counChar)
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        Recomendation.substring(0, counChar),
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                backgroundColor: Color(lightGray),
                                                content: SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        Recomendation,
                                                        style: TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                      // Add additional information here
                                                    ],
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context); // Close the dialog
                                                    },
                                                    child: Text("Close"),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: Text(
                                          "Read More",
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      ),
                                    ],
                                  )
                                else
                                  Text(Recomendation,
                                      style: TextStyle(fontSize: 12)),
                                if (recomendations.length - 1 != index) Divider(),
                                if ((recomendations.length - 1) == index)
                                  Container(
                                    height: 200,
                                  ),
                              ],
                            ),
                          );
                        
                      });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  List<String> dateandtime(String inputString) {
    // Parse the input string to create a DateTime object
    
    DateTime dateTime = DateTime.parse(inputString);

    // Format the DateTime object as "MMM dd yyyy" for date and "hh:mm a" for time
    String formattedDate = DateFormat("dd MMM yyyy").format(dateTime);
    String formattedTime = DateFormat("hh:mm a").format(dateTime);

    return [formattedDate, formattedTime];
  }
}
