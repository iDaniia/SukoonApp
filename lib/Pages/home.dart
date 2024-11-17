import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sukoon/Const/constant.dart';
import 'package:sukoon/Pages/EEG_Session.dart';
import 'package:sukoon/Pages/Specialist.dart';
import 'package:sukoon/widgets.dart';
import "package:http/http.dart" as http;
class Home extends StatelessWidget {
  const Home({super.key, this.listOfObject});
  final List<dynamic>? listOfObject;
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          // becuse I need to put the object ID card on bottom
          height: 430,
          //color: Colors.amber,
          child: Stack(
            children: [
              Padding(
                // the background of behined th ID card === brain waves
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  height: 390,
                  margin: const EdgeInsets.only(left: 5, right: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(darkBlue),
                    image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assest/images/waves.jpg")),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5,
                        spreadRadius: .5,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                // ------------------  >> patient's ID card item
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 160,
                  margin:
                      const EdgeInsets.only(left: 30, right: 30, bottom: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color(darkGray),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.white,
                        blurRadius: 5,
                        spreadRadius: .8,
                        offset: Offset(-2, -1),
                      ),
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 6,
                        spreadRadius: .8,
                        offset: Offset(1, 2),
                      ),
                    ],
                  ),
                  child: Container(
                    padding:
                        const EdgeInsets.only(top: 10, left: 15, right: 10),
                    child: Row(
                      children: [
                        Container(
                          // ---------------- Image
                          width: 70,
                          height: 70,
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
                            size: 60,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        if (listOfObject != null && listOfObject!.isNotEmpty)
                          Expanded(
                            child: Text(
                                "name: ${listOfObject![1]['Fname']} ${listOfObject![1]['Lname']}\nID:${listOfObject![1]['patientID']}\nAge:${listOfObject![1]['Age']}",
                                style: TextStyle(
                                    color: Color(darkBlue), fontSize: 18)),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
         Padding(
          padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
          child: wideBlueBotton(label: "Start EEG Session", page: EEG_Session(listOfObject: listOfObject,)),
        ),
        // ------------------------ spicilist | Doctor List
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "Specialist",
            style: TextStyle(
                color: Color(darkBlue),
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              // ----------- first
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                height: 110,
                width: 140,
                decoration: BoxDecoration(
                  color: Color(darkGray),
                  border: Border.all(
                    color: const Color(darkerGray),
                    width: 1,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(darkerGray),
                      blurRadius: 5,
                      spreadRadius: 2,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: const Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Column(
                    children: [
                      Icon(
                        Icons.psychology_rounded,
                        color: Color(darkBlue),
                        size: 65,
                      ),
                      Text(
                        "Psychiatrist",
                        style: TextStyle(
                            color: Color(darkBlue),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              // ---------------- second
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                height: 110,
                width: 140,
                decoration: BoxDecoration(
                  color: Color(darkGray),
                  border: Border.all(
                    color: const Color(darkerGray),
                    width: 1,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(darkerGray),
                      blurRadius: 5,
                      spreadRadius: 2,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: const Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Column(
                    children: [
                      Icon(
                        Icons.psychology,
                        color: Color(darkBlue),
                        size: 65,
                      ),
                      Text(
                        "Neurologist",
                        style: TextStyle(
                            color: Color(darkBlue),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                height: 110,
                width: 140,
                decoration: BoxDecoration(
                  color: Color(darkGray),
                  border: Border.all(
                    color: const Color(darkBlue),
                    width: 3,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(darkerGray),
                      blurRadius: 5,
                      spreadRadius: 2,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: TextButton(
                  // -------------------------
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SpecialistList(
                                  listOfObject: listOfObject,
                                )));
                  },
                  child: Text(
                    "view all",
                    style: TextStyle(
                        color: Color(darkBlue),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(null)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
Future<void> getAllInfo(String email , List<dynamic> listOfObject) async {
  final response1 = await http.get(Uri.parse(
      'https://infinite-wave-71025-404d3d4feff8.herokuapp.com/api/searchEmailCaregiver/${email}'));
  if (response1.statusCode == 200) {
  }
}