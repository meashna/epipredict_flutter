import '../models/patientList_model.dart';
import '../network/patientList.dart';

class PatientListRepository {
  final PatientListService _patientListService = PatientListService();

  // Fetch all patients from the API and convert them to a list of PatientList models
  Future<List<PatientList>?> getPatientList() async {
    final data = await _patientListService.fetchPatientList();

    if (data != null) {
      // Convert the list of JSON objects to a list of PatientList models
      return data.map((json) => PatientList.fromJson(json)).toList();
    }

    return null; // Return null if data fetch fails
  }
}
