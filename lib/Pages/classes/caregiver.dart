import 'dart:math';
import 'package:sukoon/widgets.dart';
import "package:http/http.dart" as http;
import 'dart:convert' as convert;
import 'dart:convert';

class Caregiver {
  int? caregiverID;
  int? doctorID;
  String? Fname;
  String? Lname;
  String? gender;
  String? role; // need spicific class
  String? phone;
  String? email;
  String? pass;
  List<dynamic>? patinetData;
  bool? isLoginData;

  Creagiver() {}

  Caregiver(
      {this.caregiverID,
      this.doctorID,
      this.Fname,
      this.Lname,
      this.gender,
      this.role,
      this.phone,
      this.email,
      this.pass,
      this.patinetData,
      this.isLoginData = false});

  int get getId => caregiverID!;
  int? get getDoctorId => doctorID;
  String get getFname => Fname!;
  String get getLname => Lname!;
  String get getGender => gender!;
  String get getRole => role!;
  String get getPhone => phone!;
  String get getEmail => email!;
  String get getPass => pass!;
  List<dynamic> get getPatientList => patinetData!;
  bool get getIslogindata => isLoginData!;

  // Setter for name
  set setId(int? value) {
    caregiverID = value!;
  }

  set setDoctorId(int? value) {
    doctorID = value!;
  }

  set setFname(String? value) {
    Fname = value!;
  }

  set setLname(String? value) {
    Lname = value!;
  }

  set setGender(String? value) {
    gender = value!;
  }

  set setRole(String? value) {
    role = value!;
  }

  set setPhone(String? value) {
    phone = value!;
  }

  set setEmail(String? value) {
    email = value!;
  }

  set setPass(String? value) {
    pass = value!;
  }

  set setPatintList(List<dynamic>? value) {
    patinetData = value!;
  }

  set setIslogindata(bool? value) {
    isLoginData = value!;
  }

  /// -------------------------------- API

  factory Caregiver.fromJason(Map<String, dynamic> json) {
    return Caregiver(
      caregiverID: json['caregiverID'],
      doctorID: json['doctor_ID'],
      Fname: json['Fname'],
      Lname: json['Lname'],
      gender: json['Gender'],
      phone: json['PhoneNum'],
      email: json['Email'],
      pass: json['Password'],
    );
  }

  Map<String, dynamic> toJason() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['caregiverID'] = caregiverID;
    data['doctor_ID'] = 0;
    data['Fname'] = Fname;
    data['Lname'] = Lname;
    data['Gender'] = gender;
    data['PhoneNum'] = phone;
    data['Email'] = email;
    data['Password'] = pass;
    return data;
  }

// ----------------  function

  int generateCaregiverId() {
    // Generate a random number with up to 5 digits
    int randomSuffix = Random().nextInt(99999);

    // Pad the random number to ensure a total length of 6 digits
    int userId = int.parse('1${randomSuffix.toString().padLeft(5, '0')}');
    return userId;
  }

  Future<int> generateUniqueCaregiverId() async {
    while (true) {
      int newId = generateCaregiverId(); // Generate a new ID

      // Check if the generated ID already exists in the database
      bool isUnique = await checkIfIdIsUniqueC(newId);
      if (isUnique) {
        return newId; // Return the unique ID
      }
    }
  }






Map<String, dynamic> toJson() {
    return {
      'Fname': Fname,
      'Lname': Lname,
      'Gender': gender,
      'PhoneNum': phone,
      'Email': email,
      'Password': pass,
      'doctor_ID': doctorID, // Pass doctor ID if available
    };
  }









Future<void> createCaregiver(Caregiver caregiver) async {
  final apiUrl = 'https://infinite-wave-71025-404d3d4feff8.herokuapp.com/api/addCaregiver';
  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode(caregiver.toJson());

  final response = await http.post(Uri.parse(apiUrl), headers: headers, body: body);

  if (response.statusCode == 200) {
    print('Caregiver created successfully');
  } else {
    print('Failed to create caregiver: ${response.body}');
    throw Exception('Failed to create caregiver');
  }
}



  Future<bool> authenticate() async {
    String urlC =
        "https://infinite-wave-71025-404d3d4feff8.herokuapp.com/api/listCaregiver";
    http.Response responseC = await http.get(Uri.parse(urlC));
    List datacare = convert.json.decode(responseC.body);
    for (var item in datacare) {
      if (item['Email'] == this.getEmail && item['Password'] == this.getPass) {
        return true;
      }
    }

    return false;
  }



}