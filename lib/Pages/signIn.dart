import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sukoon/Const/constant.dart';
import 'package:sukoon/Pages/showScreens.dart';
import 'package:sukoon/Pages/signUp.dart';
import 'package:sukoon/bloc/authentication_bloc.dart';
import 'package:sukoon/widgets.dart';
import "package:http/http.dart" as http;


class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  bool isVisible = true;

  bool isLoginTrue = false;
  List<dynamic> listOfObject = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is ErrorState) {
            Fluttertoast.showToast(
              msg: state.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 2,
              backgroundColor: Color(lightBlue1),
              textColor: Colors.white,
              fontSize: 15,
            );
          } else if (state is LoginedState) {
            
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyScreen(
                          listOfObject: state.listOfObject,
                        )));
          }
        },
        child:

            SafeArea(
                child: Center(
          child: Form(
            key: formkey,
            child: ListView(
              children: [
                const SizedBox(height: 20),
                const UpperBarTitle(
                  title: "Sign In",
                  space: 90,
                ),
                const SizedBox(
                  height: 100,
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
                      } else {
                        return null;
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
                      } else {
                        return null;
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
                      hintText: "password",
                      hintStyle: const TextStyle(
                        color: Color(darkerGray),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 4.0),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(darkGray),
                          style: BorderStyle.solid,
                          width: 3.0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(darkBlue), width: 2.0),
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _passController,
                  ),
                ),

                Builder(builder: (context) {
                  return Padding(
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
                            BlocProvider.of<AuthenticationBloc>(context).add(
                                LoginEvent(
                                    email: _emailController.text,
                                    password: _passController.text));
                            //LoginPage();
                            //login();
                          }
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        )),
                  );
                }),
                const subscriberQues(
                  quesion: 'Don\'t have an account?',
                  buttonPage: 'Sign Up',
                  page: SignUp(),
                ),
              ],
            ),
          ),
        )),
        // },), // for Builder
      ),
    );
  }
}

