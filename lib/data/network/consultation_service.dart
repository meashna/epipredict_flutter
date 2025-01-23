// import 'dart:convert';
// import 'package:dio/dio.dart';
// import '../models/consultationResponse.dart';
// import '../../constants/api_constants.dart';

// class ConsultationService {
//   final Dio _dio = Dio(); // Use Dio instance correctly

//   // Fetch consultations by patient ID
//   Future<List<Consultation>?> getConsultationsByPatientId(
//       String patientId) async {
//     try {
//       final url = ApiConstants.patientConsultationsEndpoint(patientId);
//       final response = await _dio.get(url);

//       if (response.statusCode == 200) {
//         // Convert the JSON data into Consultation objects
//         List<dynamic> data = response.data;
//         return data.map((json) => Consultation.fromJson(json)).toList();
//       } else {
//         print('Failed to fetch consultations: ${response.statusCode}');
//       }
//     } on DioError catch (e) {
//       print('Failed to fetch consultations: ${e.response?.data}');
//     }
//     return null; // Return null if the request fails
//   }
// }
