/*
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sukoon/Pages/classes/caregiver.dart';

class CaregiverApi {
  Future<List<Caregiver>> getAllCaregiver() async {
    try {
      const String url = 'https://infinite-wave-71025-404d3d4feff8.herokuapp.com/api/addCaregiver';
      var response = await http.get(Uri.parse(url));
      List<Caregiver> cargiver = (json.decode(response.body))
          .map<Caregiver>((json) => Caregiver.fromJason(json))
          .toList();

          return cargiver;
    } catch (e) {
      rethrow;
    }
  }
}
*/