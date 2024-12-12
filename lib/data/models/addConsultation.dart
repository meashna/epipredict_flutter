// lib/src/data/models/add_consultation.dart
class AddConsultation {
  String patientId;
  String doctorId;
  List<String> symptoms;
  String diagnosis;
  String prescription;
//comment
  AddConsultation({
    required this.patientId,
    required this.doctorId,
    required this.symptoms,
    required this.diagnosis,
    required this.prescription,
  });

  factory AddConsultation.fromJson(Map<String, dynamic> json) {
    return AddConsultation(
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
