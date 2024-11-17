import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:sukoon/Const/constant.dart';
import 'package:sukoon/Pages/caregiverRole.dart';
import 'package:sukoon/Pages/classes/caregiver.dart';
import 'package:sukoon/Pages/classes/patient.dart';
import 'package:sukoon/Pages/showScreens.dart';
import 'package:sukoon/widgets.dart';

class PatientInfo extends StatefulWidget {
  const PatientInfo({super.key, required this.caregiver});
  final Caregiver caregiver; // ------- HEAR CAREGIVER INFORMATION

  @override
  State<PatientInfo> createState() => _PatientInfoState();
}

class _PatientInfoState extends State<PatientInfo> {
  final TextEditingController _FnameController = TextEditingController();
  final TextEditingController _LnameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _HealthController = TextEditingController();
  String? _selectedPatientState;

  @override
  void dispose() {
    _genderController.dispose(); // Dispose of _genderController
    super.dispose();
  }

  final formkey = GlobalKey<FormState>();
  late List<dynamic> objects;
  @override
  void initState() {
    super.initState();
    objects = [widget.caregiver];
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
                title: "Patient Information",
                space: 15,
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                // Image
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                    color: Color(darkGray), shape: BoxShape.circle),
                child: const Icon(
                  Icons.person_2_rounded,
                  color: Color(darkBlue),
                  size: 80,
                ),
              ),
              const SizedBox(height: 40),
              //--------------------------------------1
              const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    Icon(
                      Icons.person_2_outlined,
                      color: Color(darkBlue),
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Patient F-name",
                      style: TextStyle(color: Color(darkBlue), fontSize: 20),
                    ),
                  ]),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "First name is required";
                    } else if (value.length < 3) {
                      return "Please Enter valid phone number";
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(lightGray),
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
              const SizedBox(height: 18),
              //-----------------------------------------
              const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    Icon(
                      Icons.person_2_outlined,
                      color: Color(darkBlue),
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Patient L-name",
                      style: TextStyle(color: Color(darkBlue), fontSize: 20),
                    ),
                  ]),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Last name is required";
                    } else if (value.length < 3) {
                      return "Please Enter valid phone number";
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(lightGray),
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
              const SizedBox(height: 18),
              //----------------------------------------2
              const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    Icon(
                      Icons.male_outlined,
                      color: Color(darkBlue),
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Gender",
                      style: TextStyle(color: Color(darkBlue), fontSize: 20),
                    ),
                  ]),

              Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                child: DropdownButtonFormField<String>(
                  style: const TextStyle(
                      color: Colors
                          .black), // Change the color of the dropdown button text to black
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(lightGray),
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
                  dropdownColor: Color(lightGray),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  value: _genderController.text.isNotEmpty
                      ? _genderController.text
                      : null, // Use null if _genderController is empty to prevent assertion error
                  onChanged: (newValue) {
                    setState(() {
                      _genderController.text =
                          newValue!; // Update _genderController value
                    });
                  },
                  items: <String>['Female', 'Male'] // List of gender options
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                            color: Colors
                                .black), // Change the color of the dropdown menu text to black
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 18),
              //----------------------------------------------3
              const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    Icon(
                      Icons.calendar_month_outlined,
                      color: Color(darkBlue),
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Birth Date",
                      style: TextStyle(color: Color(darkBlue), fontSize: 20),
                    ),
                  ]),

              Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Birthdate is required";
                    } else {
                      return null;
                    }
                  },
                  controller: _dateController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(lightGray),
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
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      firstDate: DateTime(1970),
                      lastDate: DateTime(2023),
                    );
                    if (pickedDate != null) {
                      // Format the pickedDate to remove the time portion
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      setState(() {
                        _dateController.text = formattedDate;
                      });
                    }
                  },
                ),
              ),
              //----------------------------------------------4
              const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    Icon(
                      Icons.health_and_safety_outlined,
                      color: Color(darkBlue),
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Health Condition",
                      style: TextStyle(color: Color(darkBlue), fontSize: 20),
                    ),
                  ]),

              Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                child: DropdownButtonFormField<String>(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Health condition is required";
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(lightGray),
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
                  dropdownColor: Color(lightGray),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  
                  value: _selectedPatientState,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedPatientState = newValue!;
                      _HealthController.text = newValue;
                    });
                  },
                  items: <String>[
                    'Autism',
                    'ADHD',
                    'Depression'
                  ] // List of patient states
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
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
                        // ----------------- Add patient information
                        Patient patient = Patient.withDetails(
                            Fname: _FnameController.text,
                            Lname: _LnameController.text,
                            gender: _genderController.text,
                            patientState: _HealthController.text,
                            birthDate: _dateController.text.isEmpty
                                ? null
                                : DateFormat('yyyy-MM-dd').parse(_dateController
                                    .text) // ERROR The argument type 'TextEditingController' can't be assigned to the parameter type 'DateTime?'.
                            );
                        // add patient object
                        objects.add(patient);

                        ///----------- HERE we make role and create caregiver and patient in DB
                        final caregiverData = {
                          //  'doctor_ID': "",
                          'Fname': objects[0].getFname,
                          'Lname': objects[0].getLname,
                          'Gender': objects[0].getGender,
                          'PhoneNum': objects[0].getPhone,
                          'Email': objects[0].getEmail,
                          'Password': objects[0].getPass,
                        };

                        objects[1].age =
                            objects[1].calculateAge(objects[1].getBirthDate);

                        final patientData = {
                          'Fname': objects[1].getFname,
                          'Lname': objects[1].getLname,
                          "Gender": objects[1].getGender,
                          'birthdate': (objects[1].getBirthDate).toString(),
                          'Age': (objects[1].getAge).toString(),
                          'patientState': objects[1].getState,
                          'DrugType': "",
                          'DrugAmmount': "",
                          'doctor_ID': ""
                        };

                        final caregiverPatientRole = CaregiverPatientRole(
                          caregiver: caregiverData,
                          patient: patientData,
                          role: objects[0].getRole,
                        );

                        try {
                          final response = await createCaregiverPatientWithRole(
                              caregiverPatientRole);

                          if (response.statusCode == 200) {
                            Fluttertoast.showToast(
                              msg: "Successful registration",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 3,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 15,
                            );
                          }
                        } catch (e) {
                          Fluttertoast.showToast(
                            msg: "Failed registration",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 2,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 15,
                          );
                          print('Error: $e');
                        }

                        //------------------------------------------------------------------------------
                        //String? signUp = await cubit.signUp(objects);
                        //print("---------  sign up to chat ----- ${signUp}");
                        List<Map<String, dynamic>> listOfObject =
                            await retriveDataRolesubjects(objects[0].getEmail);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyScreen(
                                      listOfObject: listOfObject,
                                    )));
                      }
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    )),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
