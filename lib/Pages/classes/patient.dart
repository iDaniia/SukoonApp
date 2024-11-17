import 'dart:math';

import 'package:sukoon/widgets.dart';

class Patient {
  int? PatientID;
  int? doctor_ID;
  String? Fname;
  String? Lname;
  String? gender;
  String? typeOfDrug; //
  int? amountOfDrug; //
  DateTime? birthDate;
  int? age;
  String? patientState;
  List<dynamic>? EEG_Session;

  Patient() {}

  Patient.withDetails(
      {this.PatientID,
      this.Fname,
      this.doctor_ID,
      this.Lname,
      this.gender,
      this.typeOfDrug,
      this.amountOfDrug,
      this.age,
      this.birthDate,
      this.patientState,
      this.EEG_Session});

  int? get getId => PatientID;
  int get getDoctorID => doctor_ID!;
  String get getFname => Fname!;
  String get getLname => Lname!;
  String get getGender => gender!;
  String get getKindOfDrug => typeOfDrug!;
  int get getNumofDrug => amountOfDrug!;
  DateTime get getBirthDate => birthDate!;
  int get getAge => age!;
  String get getState => patientState!;
  List<dynamic> get getEegSessions => EEG_Session!;

  // Setter for name
  set setId(int? value) {
    PatientID = value!;
  }
  set setDoctorId(int? value) {
    doctor_ID = value!;
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

  set setKindOfDrug(String? value) {
    typeOfDrug = value!;
  }

  set setNumOfDug(int? value) {
    amountOfDrug = value!;
  }

  set setBirhDate(DateTime? value) {
    birthDate = value!;
  }

  set setAge(int? value) {
    age = value!;
  }

  set setState(String? value) {
    patientState = value!;
  }

  set setEegSessions(List<dynamic>? value) {
    EEG_Session = value!;
  }

  int generatePatientId() {
    // Generate a random number with up to 5 digits
    int randomSuffix = Random().nextInt(99999);

    // Pad the random number to ensure a total length of 6 digits
    int userId = int.parse('2${randomSuffix.toString().padLeft(5, '0')}');
    return userId;
  }

  
  Future<int> generateUniqueCaregiverId() async {
    while (true) {
      int newId = generatePatientId(); // Generate a new ID

      // Check if the generated ID already exists in the database
      bool isUnique = await checkIfIdIsUniqueP(newId);
      if (isUnique) {
        return newId; // Return the unique ID
      }
    }
  }


  int calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();

    int age = currentDate.year - birthDate.year;

    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      age--;
    }

    return age;
  }
}
