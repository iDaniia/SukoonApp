import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sukoon/Pages/eidtProfilePage.dart';

 bool isNegativeEmotionActive = true; // Add this line
//a9ceea0e-3556-4a5e-8030-5e7ce4102577

class Settings extends StatefulWidget {
  const Settings({Key? key, this.listOfObject}) : super(key: key);
  final List<dynamic>? listOfObject;
  @override
  _SettingsState createState() => _SettingsState();
}


class _SettingsState extends State<Settings> {
  bool isSwitched = true;
 
  bool isRecommendationActive = false; // Add this line

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 41, 46, 145),
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_circle_left_outlined,
            color: Color.fromARGB(255, 232, 230, 236),
          ),
        ),
        title: Center(
          child: Text(
            "Settings",
            style: TextStyle(
              fontSize: 29,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            // Image and user info
            Column(
              children: [
                SizedBox(height: 15),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/profileImage.png"),
                          ),
                          border: Border.all(
                            width: 4,
                            color: Colors.grey,
                          ),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    Text(
                      "Name: ${widget.listOfObject![0]['Fname']} ${widget.listOfObject![0]['Lname']}",
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "ID : ${widget.listOfObject![0]['caregiverID']}",
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 5),
            // Account section
            Row(
              children: [
                SizedBox(width: 15),
                Icon(Icons.person, color: Color.fromARGB(255, 41, 46, 145)),
                SizedBox(width: 5),
                Text(
                  "Account",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(height: 5),
            Divider(
              height: 15,
              thickness: 2,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditProfilePage(
                            listOfObject: widget.listOfObject,
                          )),
                );
              },
              child: Row(
                children: [
                  SizedBox(width: 30),
                  Text(
                    "Edit profile",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(height: 5),
            // Notification section
            Row(
              children: [
                SizedBox(width: 15),
                Icon(Icons.notification_add_outlined,
                    color: Color.fromARGB(255, 41, 46, 145)),
                SizedBox(width: 5),
                Text(
                  "Notification",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(height: 5),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(height: 5),
            notificationOptionRow("Negative Emotion", isNegativeEmotionActive,
                (bool val) {
              setState(() {
                isNegativeEmotionActive = val;
                //print("isNegativeEmotionActive >>>> ${isNegativeEmotionActive}");
                // You can add code here to save the state if needed
              });
            }),
/*
            notificationOptionRow("Recommendation", isRecommendationActive,
                (bool val) {
              setState(() {
                isRecommendationActive = val;
                // You can add code here to save the state if needed
              });
            }),
            */
            SizedBox(height: 5),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(height: 5),
            // Help and Support section
            Row(
              children: [
                SizedBox(width: 15),
                Icon(Icons.headset_mic_rounded,
                    color: Color.fromARGB(255, 41, 46, 145)),
                SizedBox(width: 5),
                Text(
                  "Help and Support",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(height: 5),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(height: 5),
            // Ask section
            Row(
              children: [
                SizedBox(width: 30),
                Text(
                  "Ask",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                ),
                SizedBox(width: 15),
              ],
            ),
            SizedBox(height: 5),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(height: 5),
            // About section
            Row(
              children: [
                SizedBox(width: 15),
                Icon(Icons.contact_support_outlined,
                    color: Color.fromARGB(255, 41, 46, 145)),
                SizedBox(width: 12),
                Text(
                  "About",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(height: 5),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(height: 5),
            // Our Sukoon section
            Row(
              children: [
                SizedBox(width: 30),
                Text(
                  "Our Sukoon",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                ),
                SizedBox(width: 15),
              ],
            ),
            SizedBox(height: 5),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(height: 5),
            // Logout section
            GestureDetector(
              onTap: () {
                logout(context);
              },
              child: Row(
                children: [
                  SizedBox(width: 15),
                  Icon(Icons.logout, color: Color.fromARGB(255, 41, 46, 145)),
                  SizedBox(width: 12),
                  Text(
                    "Logout",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Divider(
              height: 15,
              thickness: 2,
            ),
          ],
        ),
      ),
    );
  }

  Row notificationOptionRow(
      String title, bool isActive, Function(bool) onChanged) {
    return Row(
      children: [
        SizedBox(width: 5),
        Text(
          title,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey),
        ),
        Spacer(),
        Transform.scale(
          scale: 0.5,
          child: CupertinoSwitch(
            value: isActive,
            onChanged: onChanged,
            activeColor: Color.fromARGB(255, 41, 46, 145),
          ),
        )
      ],
    );
  }

  void logout(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
