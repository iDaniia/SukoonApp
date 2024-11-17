import 'package:flutter/material.dart';
import 'package:sukoon/Const/constant.dart';
import 'package:sukoon/Pages/SignIn.dart';
import 'package:sukoon/Pages/signUp.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

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
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                //------------Sign In >>
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(110, 36),
                        alignment: Alignment.center,
                        backgroundColor: Color(lightBlue2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignIn()));
                    },
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(darkBlue),
                      ),
                    )),
                //----------Spase >>
                SizedBox(width: 20),

                //------------Sign Up >>
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(110, 36),
                        alignment: Alignment.center,
                        backgroundColor: Color(darkBlue),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUp()));
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    )),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
