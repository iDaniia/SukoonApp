import 'package:flutter/material.dart';
import 'package:sukoon/Const/constant.dart';
import 'package:sukoon/Pages/caregiverInfo.dart';
import 'package:sukoon/Pages/classes/caregiver.dart';
import 'package:sukoon/Pages/signIn.dart';
import 'package:sukoon/widgets.dart';
import "package:fluttertoast/fluttertoast.dart";
import "package:http/http.dart"as http;
import 'dart:convert' as convert;


class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}


class _SignUpState extends State<SignUp>  {
  final _FnameController = TextEditingController();
  final _LnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmpassController = TextEditingController();

  final formkey = GlobalKey<FormState>();
  bool isVisible = true;
  //List data =  await getData();
  
  Future<List> getData( )async{
  String url = "https://infinite-wave-71025-404d3d4feff8.herokuapp.com/api/listCaregiver";
  http.Response response = await http.get(Uri.parse(url));
  return convert.json.decode(response.body);
}

void addData() async{
  String url = 'https://infinite-wave-71025-404d3d4feff8.herokuapp.com/api/add';
  http.post(Uri.parse(url), body: {
    'Fname': "9999",
    "Lname" :"1010"
  }).then((value) {
    print("Response status: ${value.statusCode}");
    print("Response body: ${value.body}");

  } );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
        child: Form(
          key: formkey,
          child: ListView(
            children: [
              const SizedBox(height: 20),
              const UpperBarTitle(
                title: "Sign Up",
                space: 90,
              ),
              const SizedBox(
                height: 50,
              ),
              Image.asset(
                logo,
                width: 224,
                height: 89,
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
                height: 45,
              ),
              // ---------- First name
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "First name is required";
                    } else if (value.length < 3) {
                      return "should be greater than 3 charachter";
                    }
                  },
                  decoration: const InputDecoration(
                    prefixIcon:
                        Icon(Icons.person, color: Color(darkerGray), size: 32),
                    filled: true,
                    fillColor: Color(lightGray),
                    hintText: "F-name",
                    hintStyle: TextStyle(
                      color: Color(darkerGray),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(darkGray),
                        style: BorderStyle.solid,
                        width: 3.0,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(darkBlue), width: 2.0),
                    ),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _FnameController,
                ),
              ),
              // ---------- Last name
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Last name is required";
                    } else if (value.length < 3) {
                      return "should be greater than 3 charachter";
                    }
                  },
                  decoration: const InputDecoration(
                    prefixIcon:
                        Icon(Icons.person, color: Color(darkerGray), size: 32),
                    filled: true,
                    fillColor: Color(lightGray),
                    hintText: "L-name",
                    hintStyle: TextStyle(
                      color: Color(darkerGray),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(darkGray),
                        style: BorderStyle.solid,
                        width: 3.0,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(darkBlue), width: 2.0),
                    ),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _LnameController,
                ),
              ),
              // ---------- Email
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email is required";
                    } else if (!validateEmail(value)) {
                      return "Please Enter valid Email";
                    }
                  },
                  decoration: const InputDecoration(
                    prefixIcon:
                        Icon(Icons.email, color: Color(darkerGray), size: 32),
                    filled: true,
                    fillColor: Color(lightGray),
                    hintText: "Email",
                    hintStyle: TextStyle(
                      color: Color(darkerGray),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(darkGray),
                        style: BorderStyle.solid,
                        width: 3.0,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(darkBlue), width: 2.0),
                    ),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _emailController,
                ),
              ),
              // ---------- password
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "password is required";
                    } else if (value.length < 8) {
                      return "should be greater or equal than 8 charachter";
                    }
                  },
                  obscureText: isVisible,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        icon: Icon(isVisible
                            ? Icons.visibility
                            : Icons.visibility_off)),
                    prefixIcon:
                        Icon(Icons.lock, color: Color(darkerGray), size: 32),
                    filled: true,
                    fillColor: Color(lightGray),
                    hintText: "passwprd",
                    hintStyle: TextStyle(
                      color: Color(darkerGray),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(darkGray),
                        style: BorderStyle.solid,
                        width: 3.0,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(darkBlue), width: 2.0),
                    ),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _passController,
                ),
              ),
              // ---------- confirm password
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "confirm password is required";
                    } else if (value.length < 8) {
                      return "should be greater or equal than 8 charachter";
                    } else if (_confirmpassController.text !=
                        _passController.text) {
                      return "Not match as password field";
                    }
                  },
                  obscureText: isVisible,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        icon: Icon(isVisible
                            ? Icons.visibility
                            : Icons.visibility_off)),
                    prefixIcon:
                        Icon(Icons.lock, color: Color(darkerGray), size: 32),
                    filled: true,
                    fillColor: Color(lightGray),
                    hintText: "Confirm password",
                    hintStyle: TextStyle(
                      color: Color(darkerGray),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(darkGray),
                        style: BorderStyle.solid,
                        width: 3.0,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(darkBlue), width: 2.0),
                    ),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _confirmpassController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(287, 45),
                        alignment: Alignment.center,
                        backgroundColor: Color(darkBlue),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        // check if email is existing in system befor button to next in
                        if (await checkEmailExisting(_emailController.text)) {
                          /*
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                               content: Text('Email already exists. Please use a different email.'),
                                      ),
                                    );
                           */
                          Fluttertoast.showToast(
                            msg: "This email is existed in SUKOON",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 2,
                            backgroundColor: Color(lightBlue1),
                            textColor: Colors.white,
                            fontSize: 15,
                          );
                        } else {
                          //  sign p method here
                          Caregiver caregiver = Caregiver(
                              Fname: _FnameController.text,
                              Lname: _LnameController.text,
                              email: _emailController.text,
                              pass: _passController.text);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CaregiverInfo(
                                        caregiver: caregiver,
                                      )));
                        }
                      }
                      // ------------------------------------------------------------------- Update caegiver information
                    },
                    child: const Text(
                      "Next",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    )),
              ),

               subscriberQues(
                quesion: 'Have an account?',
                buttonPage: 'Sign In',
                page: SignIn(),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
