
import 'package:flutter/material.dart';
import 'package:sukoon/Const/constant.dart';
import 'package:sukoon/Pages/EEG_Session.dart';
import 'package:sukoon/Pages/contact.dart';
import 'package:sukoon/Pages/history.dart';
import 'package:sukoon/Pages/home.dart';
import 'package:sukoon/Pages/api_services.dart';

class MyScreen extends StatefulWidget {
  const MyScreen({super.key, this.listOfObject});
  final List<dynamic>? listOfObject;
  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  int currentIndex = 0;
  late List screens;
  
  void initState() {
    super.initState();
    fetchDctor(widget.listOfObject);

    // Initialize screens after the widget is fully initialized
    screens = [
      Home(listOfObject: widget.listOfObject),
      EEG_Session(listOfObject: widget.listOfObject),
      History(listOfObject: widget.listOfObject),
      ContactPage(listOfObject: widget.listOfObject),
      //ContactScreen(listOfObject: widget.listOfObject,),
      //ContactPage(),
      //RealContactPage(listOfObject: widget.listOfObject,),
    ];
  }

  @override
  //final double bottomNavBarHeight = kBottomNavigationBarHeight;

  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: screens.elementAt(currentIndex),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
          child: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              mouseCursor: SystemMouseCursors.click,
              selectedItemColor: Color(lightBlue1),
              unselectedItemColor: Color(lightGray),
              selectedIconTheme: IconThemeData(size: 32),
              unselectedIconTheme: IconThemeData(size: 23),
              currentIndex: currentIndex,
              onTap: (index) => setState(() {
                    currentIndex = index;
                  }),
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    backgroundColor: Color(darkBlue),
                    // activeIcon:
                    label: ''),
                BottomNavigationBarItem(
                    icon: Icon(Icons.waves_rounded),
                    backgroundColor: Color(darkBlue),
                    // activeIcon:
                    label: ''),
                BottomNavigationBarItem(
                    icon: Icon(Icons.history),
                    backgroundColor: Color(darkBlue),
                    // activeIcon:
                    label: ''),
                BottomNavigationBarItem(
                    icon: Icon(Icons.chat_outlined),
                    backgroundColor: Color(darkBlue),
                    // activeIcon:
                    label: ''),
              ]),
        ),
      ),
    );
  }
}
