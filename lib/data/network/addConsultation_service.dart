import 'package:dio/dio.dart';
import '../../constants/api_constants.dart';
import 'package:logger/logger.dart';
import '../models/addConsultation.dart';

class AddConsultationService {
  final Dio _dio = Dio();
  final Logger _logger = Logger();

  Future<Map<String, dynamic>?> addConsultation(
      AddConsultation consultation) async {
    try {
      _logger.i('Attempting to add patient consultation');
      final response = await _dio.post(
        ApiConstants.addConsultationEndpoint,
        data: consultation.toJson(),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 201) {
        _logger.i(
            'Patient consultation added successfully, Response received: ${response.data}');
        return response.data;
      } else {
        _logger.e(
            'Adding patient consultation failed with status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      _logger.e('Add patient consultation error: ${e.message}');
      _logger.e('Error response: ${e.response?.data}');
    }
    return null;
  }
}
