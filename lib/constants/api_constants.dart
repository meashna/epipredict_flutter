// // lib/src/constants/api_constants.dart
// class ApiConstants {
//   static const String baseUrl = "https://epipredict-api.vercel.app";
//   // "http://192.168.136.192:3000"; // Replace with your Node.js API base URL
//   static const String loginEndpoint = "$baseUrl/login";
//   static const String registerEndpoint = "$baseUrl/register";
//   static const String patientListEndpoint = "$baseUrl/patients/all";
//   static const String addPatientEndpoint = "$baseUrl/patients/register";
//   //static const String addConsultationEndpoint = "$baseUrl/consultations/create";
//   static String patientConsultationsEndpoint(String patientId) =>
//       "$baseUrl/patients/$patientId/consultations";

//   static String createConsultation = '$baseUrl/consultations/create';
// }
// lib/src/constants/api_constants.dart

class ApiConstants {
  // 192.168.216.192
  static const String baseUrl = "http://192.168.69.192:3000";
  // static const String baseUrl = "https://epipredict-api.vercel.app"; 192.168.176.192
  // Replace with your Node.js API base URL if different, e.g., "http://192.168.150.213:3000"

  static const String loginEndpoint = "$baseUrl/login";
  static const String registerEndpoint = "$baseUrl/register";
  static const String patientListEndpoint = "$baseUrl/patients/all";
  static const String addPatientEndpoint = "$baseUrl/patients/register";
  static const String createConsultationEndpoint =
      "$baseUrl/consultations/create";

  static String patientConsultationsEndpoint(String patientId) =>
      "$baseUrl/patients/$patientId/consultations";

  static String fetchPredictionsEndpoint = '$baseUrl/api/predictions';

  ///http://localhost:3000/api/predictions
}
