// import 'dart:convert';

// class ConsultationRequestBody {
//   ConsultationRequestBody({
//     required this.patientId,
//     required this.doctorId,
//     required this.symptoms,
//     required this.diagnosis,
//     required this.prescription,
//   });

//   final String patientId;
//   final String doctorId;
//   final List<String> symptoms;
//   final String diagnosis;
//   final String prescription;

//   factory ConsultationRequestBody.fromJson(Map<String, dynamic> json) {
//     return ConsultationRequestBody(
//       patientId: json['patientId'],
//       doctorId: json['doctorId'],
//       symptoms: List<String>.from(json['symptoms']),
//       diagnosis: json['diagnosis'],
//       prescription: json['prescription'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'patientId': patientId,
//       'doctorId': doctorId,
//       'symptoms': symptoms,
//       'diagnosis': diagnosis,
//       'prescription': prescription,
//     };
//   }
// }
// File: lib/data/models/consultationRequestBody.dart

class ConsultationRequestBody {
  ConsultationRequestBody({
    required this.patientId,
    required this.doctorId,
    required this.symptoms,
    required this.diagnosis,
    required this.prescription,
  });

  final String patientId;
  final String doctorId;
  final List<String> symptoms;
  final String diagnosis;
  final String prescription;

  factory ConsultationRequestBody.fromJson(Map<String, dynamic> json) {
    return ConsultationRequestBody(
      patientId: json['patientId'],
      doctorId: json['doctorId'],
      symptoms: List<String>.from(json['symptoms']),
      diagnosis: json['diagnosis'],
      prescription: json['prescription'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patientId': patientId,
      'doctorId': doctorId,
      'symptoms': symptoms,
      'diagnosis': diagnosis,
      'prescription': prescription,
    };
  }
}
