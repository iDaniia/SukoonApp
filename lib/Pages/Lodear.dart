import 'package:flutter/material.dart';
import 'package:sukoon/Const/constant.dart';
import 'package:sukoon/Pages/getStarted.dart';
import 'package:sukoon/widgets.dart';

class LoaderPage extends StatelessWidget {
  const LoaderPage({super.key});
    static const routeName = "loader";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 280,
              ),
              Image.asset(
                logo,
                width: 307,
                height: 122,
              ),
              const SizedBox(height: 10),
              const Text(
                'Sukoon',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Color(darkBlue),
                  letterSpacing: 25,
                  shadows: [
                    Shadow(
                      color: Color.fromARGB(255, 136, 134, 134),
                      offset: Offset(2, 1),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 120,
              ),
              const wideBlueBotton(label: "Get Start", page: GetStarted(),),
            ],
          ),
        ),
      ),
    );
  }
}





/*

bool isHovered = false;

Container(
  decoration: BoxDecoration(
    border: isHovered ? Border.all(color: Colors.blue, width: 2) : null,
    borderRadius: BorderRadius.circular(10),
  ),
  child: GestureDetector(
    onTap: () {
      // Handle button tap
    },
    onHover: (PointerHoverEvent event) {
      setState(() {
        isHovered = event.kind == PointerDeviceKind.mouse;
      });
    },
    child: AnimatedContainer(
      duration: Duration(milliseconds: 200),
      transform: isHovered ? Matrix4.identity()..scale(1.1) : Matrix4.identity(),
      child: ElevatedButton(
        onPressed: () {
          // Handle button press
        },
        child: Text("Button"),
      ),
    ),
  ),
)

*/