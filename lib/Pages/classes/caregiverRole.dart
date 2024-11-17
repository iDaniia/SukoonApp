import 'package:sukoon/Pages/classes/caregiver.dart';
import 'package:sukoon/Pages/classes/patient.dart';

class CaregiverRole{
late Caregiver? caregiver;
late Patient? patient;
String? caregiverRole;


  CaregiverRole(
      {this.caregiver,
      this.patient,
      this.caregiverRole,
     
});

  Caregiver get careiverData => caregiver!;
  Patient get patientData => patient!;
  String get Role => caregiverRole!;






}