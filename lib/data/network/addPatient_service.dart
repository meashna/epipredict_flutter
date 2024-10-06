import 'package:dio/dio.dart';
import '../../constants/api_constants.dart';
import 'package:logger/logger.dart';
import '../models/addPatient.dart';

class AddPatientService {
  final Dio _dio = Dio();
  final Logger _logger = Logger();

  Future<Map<String, dynamic>?> addPatient(AddPatient patient) async {
    try {
      _logger.i('Attempting to add patient');
      final response = await _dio.post(
        ApiConstants.addPatientEndpoint,
        data: patient.toJson(),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 201) {
        _logger.i(
            'Patient added successfully, Response received: ${response.data}');
        return response.data;
      } else {
        _logger.e(
            'Adding patient failed with status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      _logger.e('Add patient error: ${e.message}');
      _logger.e('Error response: ${e.response?.data}');
    }
    return null;
  }
}
