
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;



Future<void> fetchDctor(List<dynamic>? listOfObject) async {
  try {
    // Make GET request to API endpoint
    var responseDoctor = await http.get(Uri.parse(
        'https://infinite-wave-71025-404d3d4feff8.herokuapp.com/api/listDoctor'));

    // Check if the request was successful (status code 200)
    if (responseDoctor.statusCode == 200) {
      // Parse the JSON response
      List caregiverList = convert.json.decode(responseDoctor.body);
      // Access and process the data as needed
      // For example, if the API returns a list of items
      for (var item in caregiverList) {
        //print(item.runtimeType); // Process each item
       // print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-----------");
        if (item['doctorID'] == listOfObject![0]['doctor_ID']) {
          listOfObject.add(item);
          //print(" >>>>>> ----------- >>>>>> ${listOfObject[2]}"); // retrieve all the data of the caregiver and set
        }
      }
    } else {
      // Handle error if the request was not successful
      print(
          'Failed to fetch caregiver ID data. Status code: ${responseDoctor.statusCode}');
    }
  } catch (e) {
    // Handle any exceptions that occur during the request
    print('Error fetching caregiver ID data: $e');
  }
}