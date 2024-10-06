import 'package:dio/dio.dart';
import '../../constants/api_constants.dart';

class PatientListService {
  final Dio _dio = Dio();

  // Method to fetch all patients
  Future<List<dynamic>?> fetchPatientList() async {
    try {
      final response = await _dio.get(ApiConstants.patientListEndpoint);

      if (response.statusCode == 200) {
        return response.data; // Return the data as a List
      }
    } on DioException catch (e) {
      print('Failed to fetch patient list: ${e.response?.data}');
    }
    return null; // Return null if the request fails
  }
}
