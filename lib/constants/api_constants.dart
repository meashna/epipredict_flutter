// lib/src/constants/api_constants.dart
class ApiConstants {
  static const String baseUrl =
      "http://192.168.136.192:3000"; // Replace with your Node.js API base URL
  static const String loginEndpoint = "$baseUrl/login";
  static const String registerEndpoint = "$baseUrl/register";
  static const String patientListEndpoint = "$baseUrl/patients/all";
  static const String addPatientEndpoint = "$baseUrl/patients/register";
  static const String addConsultationEndpoint = "$baseUrl/consultations/create";
  static String patientConsultationsEndpoint(String patientId) =>
      "$baseUrl/patients/$patientId/consultations";
}
