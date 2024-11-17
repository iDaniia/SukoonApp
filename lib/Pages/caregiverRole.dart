import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class CaregiverPatientRole {
  Map<String, dynamic>? caregiver;
  Map<String, dynamic>? patient;
  String? role;
  String? email;

  CaregiverPatientRole({
    this.caregiver,
    this.patient,
    this.role,
  });

  CaregiverPatientRole.withEmail({
    this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'caregiver': caregiver,
      'patient': patient,
      'role': role,
    };
  }
}

Future<http.Response> createCaregiverPatientWithRole(CaregiverPatientRole data) async {
  final apiUrl = 'https://infinite-wave-71025-404d3d4feff8.herokuapp.com/api/createRoles';
  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode(data.toJson());

  final response = await http.post(Uri.parse(apiUrl), headers: headers, body: body);

  if (response.statusCode == 200) {
    print('Caregiver, patient, and role created successfully');
  } else {
    print('Failed to create caregiver, patient, and role: ${response.body}');
    throw Exception('Failed to create caregiver, patient, and role');
  }

  return response;
}

Future<List<Map<String, dynamic>>> retriveDataRolesubjects(String email) async {
  // get caregiver ID  from the emial
  int caregiverID = 0;
  int patientID = 0;
  Map<String, dynamic> caregiverData;
  Map<String, dynamic> patientData;
  List<Map<String, dynamic>> listOfObject = [];

  try {
    // Make GET request to API endpoint
    var responseCaregiver = await http.get(Uri.parse(
        'https://infinite-wave-71025-404d3d4feff8.herokuapp.com/api/listCaregiver'));

    // Check if the request was successful (status code 200)
    if (responseCaregiver.statusCode == 200) {
      // Parse the JSON response
      List caregiverList = convert.json.decode(responseCaregiver.body);
      // Access and process the data as needed
      // For example, if the API returns a list of items
   for (var item in caregiverList) {
  // Process each item
  if (item.containsKey('caregiverID') && item['Email'] == email) {
    caregiverID = item['caregiverID'];
    listOfObject.add(item);
    print(item); // retrieve all the data of the caregiver and set
  }
}

    } else {
      // Handle error if the request was not successful
      print(
          'Failed to fetch caregiver ID data. Status code: ${responseCaregiver.statusCode}');
    }
  } catch (e) {
    // Handle any exceptions that occur during the request
    print('Error fetching caregiver ID data: $e');
  }
  //--------------------------------------------------------------------------------- >>>>

  // search caregiver ID in the  role table
  try {
    // Make GET request to API endpoint
    var responseRole = await http.get(Uri.parse(
        'https://infinite-wave-71025-404d3d4feff8.herokuapp.com/api/listRole'));

    // Check if the request was successful (status code 200)
    if (responseRole.statusCode == 200) {
      // Parse the JSON response
      List roleList = convert.json.decode(responseRole.body);

      // Access and process the data as needed
      // For example, if the API returns a list of items
      for (var item in roleList) {
        // Process each item
        if (item['caregiver_ID'] == caregiverID) {
          patientID = item['patient_ID']; // get patient ID from role table

          print(item); // retrive all the data of the caregiver and set
        }
      }
    } else {
      // Handle error if the request was not successful
      print(
          'Failed to fetch caregiver ID data. Status code: ${responseRole.statusCode}');
    }
  } catch (e) {
    // Handle any exceptions that occur during the request
    print('Error fetching caregiver ID data: $e');
  }

  //----------------------------------------------------------------------------- >>>>>

  //retrive all patient data
  try {
    var responsePatient = await http.get(Uri.parse(
        'https://infinite-wave-71025-404d3d4feff8.herokuapp.com/api/listPatient'));

    // Check if the request was successful (status code 200)
    if (responsePatient.statusCode == 200) {
      // Parse the JSON response
      List patientList = convert.json.decode(responsePatient.body);

      // Access and process the data as needed
      // For example, if the API returns a list of items
      for (var item in patientList) {
        // Process each item
        if (item['patientID'] == patientID) {
          patientData = item;
          listOfObject.add(item);
          print(item); // retrive all the data of the caregiver and set
        }
      }
    } else {
      // Handle error if the request was not successful
      print(
          'Failed to fetch patient ID data. Status code: ${responsePatient.statusCode}');
    }
  } catch (e) {
    // Handle any exceptions that occur during the request
    print('Error fetching patient ID data: $e');
  }
  return listOfObject;
}
