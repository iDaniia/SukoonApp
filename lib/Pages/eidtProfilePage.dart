import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sukoon/Const/constant.dart';
import 'package:sukoon/widgets.dart';

class EditProfilePage extends StatefulWidget {
  final List<dynamic>? listOfObject;

  const EditProfilePage({Key? key, this.listOfObject}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _caregiverID = TextEditingController();
  TextEditingController _doctor_ID = TextEditingController();
  TextEditingController _Gender = TextEditingController();
  TextEditingController _PhoneNumController = TextEditingController();
  TextEditingController _confirmpassController = TextEditingController();

  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    populateData();
  }

  void populateData() {
    // Populate the text fields with data from listOfObject
    if (widget.listOfObject != null && widget.listOfObject!.isNotEmpty) {
      final Map<String, dynamic> caregiverData = widget.listOfObject?[0];
      _firstNameController.text = caregiverData['Fname'] ?? '';
      _lastNameController.text = caregiverData['Lname'] ?? '';
      _emailController.text = caregiverData['Email'] ?? '';
      _passwordController.text = caregiverData['Password'] ?? '';
      _caregiverID.text = caregiverData['caregiverID'].toString() ?? '';
      _doctor_ID.text = caregiverData['doctor_ID'].toString() ?? '';
      _Gender.text = caregiverData['Gender'] ?? '';
      _PhoneNumController.text = caregiverData['PhoneNum'] ?? '';
      _confirmpassController.text = caregiverData['Password'] ?? '';
    }
  }

  Future<bool> updateCaregiver(Map<String, String> data) async {
    try {
      var response = await http.put(
        Uri.parse(
            'https://infinite-wave-71025-404d3d4feff8.herokuapp.com/api/updateCaregiverData'),
        body: data,
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error updating caregiver: $e');
      return false;
    }
  }

  Future<void> saveChanges() async {
    String newPassword = _passwordController.text;
    String newEmail = _emailController.text;
    String newFname = _firstNameController.text;
    String newLname = _lastNameController.text;
    String newPhonNum = _PhoneNumController.text;

    Map<String, String> caregiverData = {
      'caregiverID': _caregiverID.text,
      'Password': newPassword,
      'Fname': newFname,
      'Lname': newLname,
      'Email': newEmail,
      'PhoneNum': newPhonNum,
    };

    bool success = await updateCaregiver(caregiverData);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile updated successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update profile. Please try again later.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
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
            "Edit Profile",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
// ---------- First name
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 30, top: 10, bottom: 10),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "First name is required";
                  } else if (value.length < 3) {
                    return "should be greater than 3 charachter";
                  }
                },
                decoration: const InputDecoration(
                  label: Text('First Name'),
                  prefixIcon:
                      Icon(Icons.person, color: Color(darkerGray), size: 32),
                  filled: false,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(darkGray),
                      style: BorderStyle.solid,
                      width: 3.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(darkBlue), width: 2.0),
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _firstNameController,
              ),
            ),
            // ---------- Last name
            Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 30, top: 10, bottom: 10),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Last name is required";
                  } else if (value.length < 3) {
                    return "should be greater than 3 charachter";
                  }
                },
                decoration: const InputDecoration(
                  label: Text('Last Name'),
                  prefixIcon:
                      Icon(Icons.person, color: Color(darkerGray), size: 32),
                  filled: false,
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(darkGray),
                      style: BorderStyle.solid,
                      width: 3.0,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(darkBlue), width: 2.0),
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _lastNameController,
              ),
            ),
            // Email
            Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 30, top: 10, bottom: 10),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email is required";
                  } else if (!validateEmail(value)) {
                    return "Please enter a valid Email";
                  }
                },
                decoration: const InputDecoration(
                  label: Text('Email'),
                  prefixIcon:
                      Icon(Icons.email, color: Color(darkerGray), size: 32),
                  filled: false,
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(darkGray),
                      style: BorderStyle.solid,
                      width: 3.0,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(darkBlue), width: 2.0),
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _emailController,
              ),
            ),
// Phone Number

            Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 30, top: 10, bottom: 10),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Phone number is required";
                  } else if (!validatePhone(_PhoneNumController.text)!) {
                    return "Please Enter valid phone number";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.phone, // Set keyboard type to phone
                decoration: InputDecoration(
                  labelText: 'Phone number',
                  prefixIcon:
                      Icon(Icons.phone, color: Color(darkerGray), size: 32),
                  filled: false,
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(darkGray),
                      style: BorderStyle.solid,
                      width: 3.0,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(darkBlue), width: 2.0),
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _PhoneNumController,
              ),
            ),

            // Password
            Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 30, top: 10, bottom: 10),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password is required";
                  } else if (value.length < 8) {
                    return "should be greater or equal than 8 characters";
                  }
                },
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  label: Text('Password'),
                  prefixIcon:
                      Icon(Icons.lock, color: Color(darkerGray), size: 32),
                  filled: false,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(darkGray),
                      style: BorderStyle.solid,
                      width: 3.0,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(darkBlue), width: 2.0),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _passwordController,
              ),
            ),
// Confirm Password field
            Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 30, top: 10, bottom: 10),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Confirm password is required";
                  } else if (value.length < 8) {
                    return " should be greater or equal than 8 characters";
                  } else if (value != _passwordController.text) {
                    return "Passwords do not match";
                  }
                },
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  prefixIcon:
                      Icon(Icons.lock, color: Color(darkerGray), size: 32),
                  filled: false,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(darkGray),
                      style: BorderStyle.solid,
                      width: 3.0,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(darkBlue), width: 2.0),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _confirmpassController,
              ),
            ),

            SizedBox(height: 20),
            SizedBox(width: 30),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 45),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(width: 30),
                ElevatedButton(
                  onPressed: saveChanges,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color.fromARGB(255, 41, 46, 145),
                    padding: EdgeInsets.symmetric(horizontal: 45),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  child: Text(
                    "SAVE",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool? validatePhone(String? phone) {
    RegExp phoneRegExp = RegExp(r'^05\d{8}$');
    return phoneRegExp.hasMatch(phone ?? '');
  }
}
