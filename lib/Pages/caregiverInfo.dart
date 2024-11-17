import 'package:flutter/material.dart';
import 'package:sukoon/Const/constant.dart';
import 'package:sukoon/Pages/classes/caregiver.dart';
import 'package:sukoon/Pages/patientInfo.dart';
import 'package:sukoon/widgets.dart';

class CaregiverInfo extends StatefulWidget {
  final Caregiver caregiver;
  const CaregiverInfo({super.key, required this.caregiver});
  @override
  State<CaregiverInfo> createState() => _CaregiverInfoState();
}

class _CaregiverInfoState extends State<CaregiverInfo> {
  final TextEditingController _RoleController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  bool? validatePhone(String? phone) {
    RegExp phoneRegExp = RegExp(r'^05\d{8}$');
    return phoneRegExp.hasMatch(phone ?? '');
  }

  @override
  void dispose() {
    _genderController.dispose(); // Dispose of _genderController
    super.dispose();
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
                title: "Caregiver Information",
                space: 15,
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
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
              const SizedBox(height: 10),
               Text(
                'Hello ${widget.caregiver.Fname}',
                style: TextStyle(
                  color: Color(darkerGray2),
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              //--------------------------------------1
              const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    Icon(
                      Icons.call_outlined,
                      color: Color(darkBlue),
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Phone Number",
                      style: TextStyle(color: Color(darkBlue), fontSize: 20),
                    ),
                  ]),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Phone number is required";
                    } else if (!validatePhone(_phoneController.text)!) {
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
                  controller: _phoneController,
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
                  style: TextStyle(
                      color: Colors
                          .black), // Change the color of the dropdown button text to black
                  decoration: InputDecoration(
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
                  onChanged: (value) {
                    setState(() {
                      _genderController.text =
                          value!; // Update _genderController value
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Gender is required";
                    }
                    return null;
                  },
                  items: <String>['Female', 'Male'] // List of gender options
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
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
                      Icons.link_outlined,
                      color: Color(darkBlue),
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Role",
                      style: TextStyle(color: Color(darkBlue), fontSize: 20),
                    ),
                  ]),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Role is required";
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
                  controller: _RoleController,
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
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        // ------------------------------------------------------------------- Update caegiver information
                        widget.caregiver.phone = _phoneController.text;
                        widget.caregiver.role = _RoleController.text;
                        widget.caregiver.gender = _genderController.text;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PatientInfo(
                                      caregiver: widget.caregiver,
                                    )));
                      }
                    },
                    child: const Text(
                      "Next",
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
