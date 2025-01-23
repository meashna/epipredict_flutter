// lib/data/models/prediction_dashboard_response.dart

class PredictionDashboardResponse {
  final String message;
  final List<PredictionModel> predictions;

  PredictionDashboardResponse({
    required this.message,
    required this.predictions,
  });

  factory PredictionDashboardResponse.fromJson(Map<String, dynamic> json) {
    return PredictionDashboardResponse(
      message: json['message'] ?? '',
      predictions: (json['predictions'] as List<dynamic>?)
              ?.map((e) => PredictionModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'predictions': predictions.map((e) => e.toJson()).toList(),
    };
  }
}

class PredictionModel {
  final String id;
  final PatientModel patient;
  final DoctorModel doctor;
  final ConsultationModel consultation;
  final String predictedDisease;
  final DateTime predictionDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  PredictionModel({
    required this.id,
    required this.patient,
    required this.doctor,
    required this.consultation,
    required this.predictedDisease,
    required this.predictionDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PredictionModel.fromJson(Map<String, dynamic> json) {
    return PredictionModel(
      id: json['_id'] ?? '',
      patient: json['patientId'] != null
          ? PatientModel.fromJson(json['patientId'])
          : PatientModel(id: '', patientName: ''),
      doctor: json['doctorId'] != null
          ? DoctorModel.fromJson(json['doctorId'])
          : DoctorModel(id: '', username: ''),
      consultation: json['consultationId'] != null
          ? ConsultationModel.fromJson(json['consultationId'])
          : ConsultationModel(
              id: '',
              patientId: '',
              doctorId: '',
              symptoms: '',
              diagnosis: '',
              prescription: '',
              consultationDate: DateTime.now(),
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
      predictedDisease: json['predictedDisease'] ?? 'Unknown Disease',
      predictionDate: json['predictionDate'] != null
          ? DateTime.parse(json['predictionDate'])
          : DateTime.now(),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'patientId': patient.toJson(),
      'doctorId': doctor.toJson(),
      'consultationId': consultation.toJson(),
      'predictedDisease': predictedDisease,
      'predictionDate': predictionDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class PatientModel {
  final String id;
  final String patientName;

  PatientModel({
    required this.id,
    required this.patientName,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['_id'] ?? '',
      patientName: json['patientName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'patientName': patientName,
    };
  }
}

class DoctorModel {
  final String id;
  final String username;

  DoctorModel({
    required this.id,
    required this.username,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['_id'] ?? '',
      username: json['username'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'username': username,
    };
  }
}

class ConsultationModel {
  final String id;
  final String patientId;
  final String doctorId;
  final String symptoms;
  final String diagnosis;
  final String prescription;
  final DateTime consultationDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  ConsultationModel({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.symptoms,
    required this.diagnosis,
    required this.prescription,
    required this.consultationDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ConsultationModel.fromJson(Map<String, dynamic> json) {
    return ConsultationModel(
      id: json['_id'] ?? '',
      patientId: json['patientId'] ?? '',
      doctorId: json['doctorId'] ?? '',
      symptoms: json['symptoms'] ?? '',
      diagnosis: json['diagnosis'] ?? '',
      prescription: json['prescription'] ?? '',
      consultationDate: json['consultationDate'] != null
          ? DateTime.parse(json['consultationDate'])
          : DateTime.now(),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'patientId': patientId,
      'doctorId': doctorId,
      'symptoms': symptoms,
      'diagnosis': diagnosis,
      'prescription': prescription,
      'consultationDate': consultationDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
