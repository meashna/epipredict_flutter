// lib/src/data/models/add_patient.dart
class AddPatient {
  String doctorId;
  String patientName;
  String gender;
  int age;
  double height;
  double weight;
  String contactInfo;

  AddPatient({
    required this.doctorId,
    required this.patientName,
    required this.gender,
    required this.age,
    required this.height,
    required this.weight,
    required this.contactInfo,
  });

  factory AddPatient.fromJson(Map<String, dynamic> json) {
    return AddPatient(
      doctorId: json['doctorId'],
      patientName: json['patientName'],
      gender: json['gender'],
      age: json['age'],
      height: json['height'].toDouble(),
      weight: json['weight'].toDouble(),
      contactInfo: json['contactInfo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'doctorId': doctorId,
      'patientName': patientName,
      'gender': gender,
      'age': age,
      'height': height,
      'weight': weight,
      'contactInfo': contactInfo,
    };
  }
}
