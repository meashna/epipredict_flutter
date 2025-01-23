// import 'dart:convert';

// class ConsultationResponse {
//   final String message;
//   final Consultation consultation;
//   final Prediction? prediction; // Made nullable

//   ConsultationResponse({
//     required this.message,
//     required this.consultation,
//     this.prediction,
//   });

//   factory ConsultationResponse.fromJson(Map<String, dynamic> json) {
//     return ConsultationResponse(
//       message: json['message'],
//       consultation: Consultation.fromJson(json['consultation']),
//       prediction: json['prediction'] != null
//           ? Prediction.fromJson(json['prediction'])
//           : null,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'message': message,
//       'consultation': consultation.toJson(),
//       if (prediction != null) 'prediction': prediction!.toJson(),
//     };
//   }
// }

// // lib/data/models/consultationResponse.dart

// class Consultation {
//   Consultation({
//     required this.id,
//     required this.patientId,
//     required this.doctorId,
//     required this.symptoms,
//     required this.diagnosis,
//     required this.prescription,
//     required this.consultationDate,
//     this.createdAt, // Made nullable
//     this.updatedAt, // Made nullable
//   });

//   factory Consultation.fromJson(Map<String, dynamic> json) {
//     List<String> symptomsList = [];

//     if (json['symptoms'] is List) {
//       symptomsList = List<String>.from(json['symptoms']);
//     } else if (json['symptoms'] is String) {
//       symptomsList = [json['symptoms']];
//     }

//     return Consultation(
//       id: json['_id'] ?? '', // Provide default value if null
//       patientId: json['patientId'] ?? '',
//       doctorId: json['doctorId'] ?? '',
//       symptoms: symptomsList,
//       diagnosis: json['diagnosis'] ?? '',
//       prescription: json['prescription'] ?? '',
//       consultationDate: json['consultationDate'] != null
//           ? DateTime.parse(json['consultationDate'])
//           : DateTime.now(), // Provide default value if null
//       createdAt: json['createdAt'] != null
//           ? DateTime.parse(json['createdAt'])
//           : null, // Handle null
//       updatedAt: json['updatedAt'] != null
//           ? DateTime.parse(json['updatedAt'])
//           : null, // Handle null
//     );
//   }

//   final String id;
//   final String patientId;
//   final String doctorId;
//   final List<String> symptoms;
//   final String diagnosis;
//   final String prescription;
//   final DateTime consultationDate;
//   final DateTime? createdAt; // Nullable
//   final DateTime? updatedAt; // Nullable

//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'patientId': patientId,
//       'doctorId': doctorId,
//       'symptoms': symptoms,
//       'diagnosis': diagnosis,
//       'prescription': prescription,
//       'consultationDate': consultationDate.toIso8601String(),
//       'createdAt': createdAt?.toIso8601String(),
//       'updatedAt': updatedAt?.toIso8601String(),
//     };
//   }
// }

// // class Consultation {
// //   Consultation({
// //     required this.id,
// //     required this.patientId,
// //     required this.doctorId,
// //     required this.symptoms,
// //     required this.diagnosis,
// //     required this.prescription,
// //     required this.consultationDate,
// //     this.createdAt,
// //     required this.updatedAt,
// //   });

// //   factory Consultation.fromJson(Map<String, dynamic> json) {
// //     List<String> symptomsList = [];

// //     if (json['symptoms'] is List) {
// //       symptomsList = List<String>.from(json['symptoms']);
// //     } else if (json['symptoms'] is String) {
// //       symptomsList = [json['symptoms']];
// //     }

// //     return Consultation(
// //       id: json['_id'],
// //       patientId: json['patientId'],
// //       doctorId: json['doctorId'],
// //       symptoms: symptomsList,
// //       diagnosis: json['diagnosis'],
// //       prescription: json['prescription'],
// //       consultationDate: DateTime.parse(json['consultationDate']),
// //       createdAt: DateTime.parse(json['createdAt']),
// //       updatedAt: DateTime.parse(json['updatedAt']),
// //     );
// //   }

// //   final String id;
// //   final String patientId;
// //   final String doctorId;
// //   final List<String> symptoms; // Changed to List<String>
// //   final String diagnosis;
// //   final String prescription;
// //   final DateTime consultationDate;
// //   final DateTime createdAt;
// //   final DateTime updatedAt;

// //   Map<String, dynamic> toJson() {
// //     return {
// //       '_id': id,
// //       'patientId': patientId,
// //       'doctorId': doctorId,
// //       'symptoms': symptoms,
// //       'diagnosis': diagnosis,
// //       'prescription': prescription,
// //       'consultationDate': consultationDate.toIso8601String(),
// //       'createdAt': createdAt.toIso8601String(),
// //       'updatedAt': updatedAt.toIso8601String(),
// //     };
// //   }
// // }

// class Prediction {
//   Prediction({
//     required this.id,
//     required this.patientId,
//     required this.doctorId,
//     required this.consultationId,
//     required this.predictedDisease,
//     required this.predictionDate,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory Prediction.fromJson(Map<String, dynamic> json) {
//     return Prediction(
//       id: json['_id'],
//       patientId: json['patientId'],
//       doctorId: json['doctorId'],
//       consultationId: json['consultationId'],
//       predictedDisease: json['predictedDisease'],
//       predictionDate: DateTime.parse(json['predictionDate']),
//       createdAt: DateTime.parse(json['createdAt']),
//       updatedAt: DateTime.parse(json['updatedAt']),
//     );
//   }

//   final String id;
//   final String patientId;
//   final String doctorId;
//   final String consultationId;
//   final String predictedDisease;
//   final DateTime predictionDate;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'patientId': patientId,
//       'doctorId': doctorId,
//       'consultationId': consultationId,
//       'predictedDisease': predictedDisease,
//       'predictionDate': predictionDate.toIso8601String(),
//       'createdAt': createdAt.toIso8601String(),
//       'updatedAt': updatedAt.toIso8601String(),
//     };
//   }
// }
// File: lib/data/models/consultationResponse.dart
import 'dart:convert';

class ConsultationResponse {
  final String message;
  final Consultation consultation;
  final Prediction? prediction; // optional, if included in the response

  ConsultationResponse({
    required this.message,
    required this.consultation,
    this.prediction,
  });

  factory ConsultationResponse.fromJson(Map<String, dynamic> json) {
    return ConsultationResponse(
      message: json['message'] ?? '',
      consultation: Consultation.fromJson(json['consultation'] ?? {}),
      prediction: json['prediction'] != null
          ? Prediction.fromJson(json['prediction'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'consultation': consultation.toJson(),
      if (prediction != null) 'prediction': prediction!.toJson(),
    };
  }
}

class Consultation {
  final String id;
  final String patientId; // We'll store just the string _id
  final String doctorId; // We'll store just the string _id
  final List<String> symptoms;
  final String diagnosis;
  final String prescription;
  final DateTime consultationDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Consultation({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.symptoms,
    required this.diagnosis,
    required this.prescription,
    required this.consultationDate,
    this.createdAt,
    this.updatedAt,
  });

  factory Consultation.fromJson(Map<String, dynamic> json) {
    // 1) Safely parse `patientId`
    String extractedPatientId = '';
    if (json['patientId'] is Map) {
      // e.g. "patientId": { "_id": "6702b49f0107c63a92ced53f", ... }
      extractedPatientId = json['patientId']['_id'] ?? '';
    } else if (json['patientId'] is String) {
      // e.g. "patientId": "6702b49f0107c63a92ced53f"
      extractedPatientId = json['patientId'];
    }

    // 2) Safely parse `doctorId`
    String extractedDoctorId = '';
    if (json['doctorId'] is Map) {
      extractedDoctorId = json['doctorId']['_id'] ?? '';
    } else if (json['doctorId'] is String) {
      extractedDoctorId = json['doctorId'];
    }

    // 3) Safely parse `symptoms`
    List<String> symptomsList = [];
    if (json['symptoms'] is List) {
      symptomsList = List<String>.from(json['symptoms']);
    } else if (json['symptoms'] is String) {
      // if the server sometimes returns a single string
      symptomsList = [json['symptoms']];
    }

    // 4) Construct the object
    return Consultation(
      id: json['_id'] ?? '',
      patientId: extractedPatientId,
      doctorId: extractedDoctorId,
      symptoms: symptomsList,
      diagnosis: json['diagnosis'] ?? '',
      prescription: json['prescription'] ?? '',
      consultationDate: json['consultationDate'] != null
          ? DateTime.parse(json['consultationDate'])
          : DateTime.now(),
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
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
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}

class Prediction {
  Prediction({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.consultationId,
    required this.predictedDisease,
    required this.predictionDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) {
    // For Prediction, your API also returns nested objects for patientId / doctorId,
    // but if you only want the _id, do the same approach or a separate model.
    // For brevity, let's assume it's just storing the raw fields if they are strings.
    // Otherwise, you can do the same "extractedPatientId" approach.

    String extractedPatientId = '';
    if (json['patientId'] is Map) {
      extractedPatientId = json['patientId']['_id'] ?? '';
    } else if (json['patientId'] is String) {
      extractedPatientId = json['patientId'];
    }

    String extractedDoctorId = '';
    if (json['doctorId'] is Map) {
      extractedDoctorId = json['doctorId']['_id'] ?? '';
    } else if (json['doctorId'] is String) {
      extractedDoctorId = json['doctorId'];
    }

    // For consultationId, we can do the same or keep it as a string
    String extractedConsultationId = '';
    if (json['consultationId'] is Map) {
      extractedConsultationId = json['consultationId']['_id'] ?? '';
    } else if (json['consultationId'] is String) {
      extractedConsultationId = json['consultationId'];
    }

    return Prediction(
      id: json['_id'] ?? '',
      patientId: extractedPatientId,
      doctorId: extractedDoctorId,
      consultationId: extractedConsultationId,
      predictedDisease: json['predictedDisease'] ?? '',
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

  final String id;
  final String patientId;
  final String doctorId;
  final String consultationId;
  final String predictedDisease;
  final DateTime predictionDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'patientId': patientId,
      'doctorId': doctorId,
      'consultationId': consultationId,
      'predictedDisease': predictedDisease,
      'predictionDate': predictionDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
