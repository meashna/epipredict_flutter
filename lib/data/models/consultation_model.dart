class Consultation {
  final String id;
  final String patientId;
  final String doctorId;
  final List<String> symptoms; // Fix typo here
  final String diagnosis;
  final String prescription;
  final String consultationDate;

  Consultation({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.symptoms, // Fix typo here
    required this.diagnosis,
    required this.prescription,
    required this.consultationDate,
  });

  factory Consultation.fromJson(Map<String, dynamic> json) {
    return Consultation(
      id: json['_id'],
      patientId: json['patientId'],
      doctorId: json['doctorId'],
      symptoms: List<String>.from(json['symptoms']), // Fix typo here
      diagnosis: json['diagnosis'],
      prescription: json['prescription'],
      consultationDate: DateTime.parse(json['consultationDate']).toString(),
    );
  }

  @override
  String toString() {
    return 'Consultation(id: $id, patientId: $patientId, doctorId: $doctorId, '
        'symptoms: $symptoms, diagnosis: $diagnosis, prescription: $prescription, '
        'consultationDate: $consultationDate)';
  }
}
