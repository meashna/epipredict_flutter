class PatientList {
  final String id;
  final String doctorId;
  final String patientName;
  final String gender;
  final int age;
  final int height;
  final int weight;
  final String contactInfo;
  final DateTime createdAt;

  PatientList({
    required this.id,
    required this.doctorId,
    required this.patientName,
    required this.gender,
    required this.age,
    required this.height,
    required this.weight,
    required this.contactInfo,
    required this.createdAt,
  });

  factory PatientList.fromJson(Map<String, dynamic> json) {
    return PatientList(
      id: json['_id'],
      doctorId: json['doctorId'],
      patientName: json['patientName'],
      gender: json['gender'],
      age: json['age'],
      height: json['height'],
      weight: json['weight'],
      contactInfo: json['contactInfo'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'doctorId': doctorId,
      'patientName': patientName,
      'gender': gender,
      'age': age,
      'height': height,
      'weight': weight,
      'contactInfo': contactInfo,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
