// import '../models/addPatient.dart';
// import '../network/addPatient_service.dart';

// class AddPatientRepository {
//   final AddPatientService _addPatientService = AddPatientService();

//   Future<AddPatient?> addPatient(AddPatient patient) async {
//     final response = await _addPatientService.addPatient(patient);

//     if (response != null &&
//         response['message'] == "Patient registered successfully") {
//       return AddPatient.fromJson(response['patient']);
//     }
//     return null;
//   }
// }
