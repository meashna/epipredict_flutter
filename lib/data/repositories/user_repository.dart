// ///media/B/epipredict_flutter/lib/data/repositories/user_repository.dart

// import 'dart:io';
// import 'package:Epipredict/data/models/consultationRequestBody.dart';

// import '../models/consultationResponse.dart';
// import '../models/apis/UIResponse.dart';

// abstract class UserRepository {
//   Future<UIResponse<ConsultationResponse>> createConsultation({
//     required ConsultationRequestBody request,
//   });
// }
// lib/data/repositories/user_repository.dart

// lib/src/repositories/user_repository.dart

import '../models/add_patient.dart';
import '../models/consultationRequestBody.dart';
import '../models/consultationResponse.dart';
import '../models/patient_list.dart';
import '../models/user_model.dart';
import '../models/apis/UIResponse.dart';
import '../models/prediction_dashboard_response.dart';

abstract class UserRepository {
  // Consultation
  Future<UIResponse<ConsultationResponse>> createConsultation({
    required ConsultationRequestBody request,
  });

  // Patient
  Future<UIResponse<bool>> addPatient(AddPatient patient);

  // Authentication
  Future<UIResponse<User>> login(String username, String password);

  Future<UIResponse<User>> register(String username, String password);

  // Fetch Patient List
  Future<UIResponse<List<PatientList>>> fetchPatientList();

  // Fetch Consultations for a Patient
  Future<UIResponse<List<Consultation>>> getPatientConsultations(
      String patientId);

  Future<UIResponse<List<PredictionModel>>> fetchPredictions();
}
