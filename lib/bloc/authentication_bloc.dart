import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import "package:http/http.dart" as http;
import 'package:sukoon/Pages/caregiverRole.dart';
import 'dart:convert' as convert;
import 'package:sukoon/Pages/classes/caregiver.dart';
import 'package:sukoon/Pages/classes/patient.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(LodingState()) {
    on<AuthenticationEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LodingState());
        Caregiver caregiver =
            Caregiver(email: event.email, pass: event.password);
        print(event.email);
        print(event.password);
        bool result = await caregiver.authenticate();
        if (result) {
          // return patient then add object in list
          //CaregiverPatientRole data =   CaregiverPatientRole.withEmail(email: event.email);
          List<Map<String, dynamic>> listOfObject = await retriveDataRolesubjects(event.email);
          //Patient patient = await getPatientData(caregiver);
          //print(patient.getId);
          emit(LoginedState(listOfObject: listOfObject));
        } else {
          emit(ErrorState(message: "Email or password is not correct"));
        }
      }
    });
  }
}

Future<Patient> getPatientData(Caregiver caregiver) async {
  Patient patient = Patient.withDetails();

  http.Response responseCare = await http.get(Uri.parse(
      'https://infinite-wave-71025-404d3d4feff8.herokuapp.com/api/listCaregiver'));
  List list = convert.json.decode(responseCare.body);
  for (var item in list) {
    if (item['Email'] == caregiver.getEmail) {
      caregiver.setId = item['caregiverID'];
      print(caregiver.getId);
      caregiver.doctorID = item['doctor_ID'];
      print('ok //// 1 ');
      print('item[doctor_ID] -->${item['doctor_ID']}');
    }
  }

  http.Response response = await http.get(Uri.parse(
      'https://infinite-wave-71025-404d3d4feff8.herokuapp.com/api/listRole'));
  List data = convert.json.decode(response.body);
  int patientID = 0;
  for (var item in data) {
    if (item['caregiver_ID'] == caregiver.getId) {
      print('ok cargiver  >>>');
      patientID = item['patient_ID'];
    }
  }

  if (patientID != 0) {
    http.Response response = await http.get(Uri.parse(
        'https://infinite-wave-71025-404d3d4feff8.herokuapp.com/api/listPatient'));
    List data = convert.json.decode(response.body);
    for (var item in data) {
      if (item['patientID'] == patientID) {
        print('ok patient >>>');
        patient.setId = patientID;
        patient.setFname = item['Fname'];
        patient.setLname = item['Lname'];
        patient.setGender = item['Gender'];
        patient.setBirhDate = DateTime.parse(item['birthdate']);
        patient.setAge = item['Age'];
        patient.setState = item['patientState'];
      }
    }
  }

  return patient;
}
