// ///media/B/epipredict_flutter/lib/data/repositories/user_repository_impl.dart

// import 'dart:convert';
// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:logger/logger.dart';
// // import 'package:Epipredict/data/network/ApiEndpoints.dart';
// import '../models/consultationRequestBody.dart';
// import '../models/consultationResponse.dart';
// import '../models/apis/UIResponse.dart';
// import '../../constants/api_constants.dart';
// import './user_repository.dart';

// class UserRepositoryImpl implements UserRepository {
//   final Logger _logger = Logger();
//   final Dio _dio = Dio();
// //for - creating consultation
//   @override
//   Future<UIResponse<ConsultationResponse>> createConsultation({
//     required ConsultationRequestBody request,
//   }) async {
//     try {
//       // Convert the ConsultationRequestBody object to JSON
//       final payload = request.toJson();

//       final response = await _dio.post(
//         ApiConstants().createConsultation,
//         data: jsonEncode(payload),
//         options: Options(
//           headers: {
//             HttpHeaders.contentTypeHeader: 'application/json',
//           },
//         ),
//       );

//       _logger.i("Create Consultation Response Status: ${response.statusCode}");
//       _logger
//           .d("Create Consultation Response Body: ${jsonEncode(response.data)}");

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         // Parse the response into the ConsultationResponse model
//         final consultationResponse =
//             ConsultationResponse.fromJson(response.data);
//         return UIResponse.completed(consultationResponse);
//       } else {
//         final errorMessage = response.data["error"] ?? "Unknown server error.";
//         _logger.e("Server responded with error: $errorMessage");
//         return UIResponse.error(errorMessage);
//       }
//     } on DioException catch (error) {
//       _logger.e("DioException in createConsultation: ${error.message}");
//       return UIResponse.error(handleDioError(error));
//     } catch (e, stackTrace) {
//       _logger.e("Unexpected exception in createConsultation: $e");
//       return UIResponse.error("An unexpected error occurred: $e");
//     }
//   }

// //for add patiinet
//   @override
//   Future<Map<String, dynamic>?> addPatient(AddPatient patient) async {
//     try {
//       _logger.i('Attempting to add patient');
//       final response = await _dio.post(
//         ApiConstants.addPatientEndpoint,
//         data: patient.toJson(),
//         options: Options(headers: {'Content-Type': 'application/json'}),
//       );

//       if (response.statusCode == 201) {
//         _logger.i(
//             'Patient added successfully, Response received: ${response.data}');
//         return response.data;
//       } else {
//         _logger.e(
//             'Adding patient failed with status code: ${response.statusCode}');
//       }
//     } on DioException catch (e) {
//       _logger.e('Add patient error: ${e.message}');
//       _logger.e('Error response: ${e.response?.data}');
//     }
//     return null;
//   }

// //for auth
//   Future<Map<String, dynamic>?> login(String username, String password) async {
//     try {
//       _logger.i('Attempting login for user: $username'); // Log login attempt
//       final response = await _dio.post(
//         ApiConstants.loginEndpoint,
//         data: {
//           'username': username,
//           'password': password,
//         },
//         options: Options(headers: {'Content-Type': 'application/json'}),
//       );

//       if (response.statusCode == 200) {
//         _logger.i(
//             'Login successful, Response received: ${response.data}'); // Log successful response
//         return response.data; // Return the response data (token, userId, etc.)
//       } else {
//         _logger.e('Login failed with status code: ${response.statusCode}');
//       }
//     } on DioException catch (e) {
//       _logger.e('Login error: ${e.message}'); // Log error message
//       _logger.e(
//           'Error response: ${e.response?.data}'); // Log the API error response
//     }
//     return null; // Return null if login fails
//   }

//   // Register function using Dio new
//   Future<Map<String, dynamic>?> register(
//       String username, String password) async {
//     try {
//       _logger.i(
//           'Attempting registration for user: $username'); // Log registration attempt
//       final response = await _dio.post(
//         ApiConstants.registerEndpoint,
//         data: {
//           'username': username,
//           'password': password,
//         },
//         options: Options(headers: {'Content-Type': 'application/json'}),
//       );

//       if (response.statusCode == 201) {
//         _logger.i(
//             'Registration successful, Response received: ${response.data}'); // Log successful response
//         return response.data; // Return response data
//       } else {
//         _logger
//             .e('Registration failed with status code: ${response.statusCode}');
//       }
//     } on DioException catch (e) {
//       _logger.e('Registration error: ${e.message}'); // Log error message
//       _logger.e(
//           'Error response: ${e.response?.data}'); // Log the API error response
//     }
//     return null; // Return null if registration fails
//   }

//   //for patinet list
//   Future<List<dynamic>?> fetchPatientList() async {
//     try {
//       final response = await _dio.get(ApiConstants.patientListEndpoint);

//       if (response.statusCode == 200) {
//         return response.data; // Return the data as a List
//       }
//     } on DioException catch (e) {
//       print('Failed to fetch patient list: ${e.response?.data}');
//     }
//     return null; // Return null if the request fails
//   }
// }

//   String handleDioError(DioException error) {
//     if (error.response != null) {
//       return error.response?.data['message'] ?? 'An error occurred';
//     }
//     return error.message ?? 'Unknown error';
//   }
// }
// lib/data/repositories/user_repository_impl.dart

// import 'dart:convert';
// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:logger/logger.dart';
// import '../../constants/api_constants.dart';
// import '../models/add_patient.dart';
// import '../models/consultationRequestBody.dart';
// import '../models/consultationResponse.dart';
// import '../models/patient_list.dart';
// import '../models/user_model.dart';
// import '../models/apis/UIResponse.dart';
// import './user_repository.dart';

// class UserRepositoryImpl implements UserRepository {
//   final Logger _logger = Logger();
//   final Dio _dio = Dio();

//   // Constructor to set up Dio with base options if needed
//   UserRepositoryImpl() {
//     _dio.options.baseUrl = ApiConstants.baseUrl;
//     _dio.options.headers[HttpHeaders.contentTypeHeader] = 'application/json';
//     // Add interceptors if necessary, e.g., for adding auth tokens
//   }

//   // 1. Creating a Consultation
//   @override
//   Future<UIResponse<ConsultationResponse>> createConsultation({
//     required ConsultationRequestBody request,
//   }) async {
//     try {
//       _logger.i('Creating consultation with payload: ${request.toJson()}');

//       final response = await _dio.post(
//         ApiConstants.createConsultation,
//         data: jsonEncode(request.toJson()),
//       );

//       _logger.i("Create Consultation Response Status: ${response.statusCode}");
//       _logger
//           .d("Create Consultation Response Body: ${jsonEncode(response.data)}");

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         // Parse the response into the ConsultationResponse model
//         final consultationResponse =
//             ConsultationResponse.fromJson(response.data);
//         return UIResponse.completed(consultationResponse);
//       } else {
//         final errorMessage = response.data["error"] ?? "Unknown server error.";
//         _logger.e("Server responded with error: $errorMessage");
//         return UIResponse.error(errorMessage);
//       }
//     } on DioException catch (error) {
//       _logger.e("DioException in createConsultation: ${error.message}");
//       final errorMessage = handleDioError(error);
//       return UIResponse.error(errorMessage);
//     } catch (e, stackTrace) {
//       _logger.e(
//           "Unexpected exception in createConsultation: $e", e, stackTrace);
//       return UIResponse.error("An unexpected error occurred: $e");
//     }
//   }

//   // 2. Adding a Patient
//   @override
//   Future<UIResponse<bool>> addPatient(AddPatient patient) async {
//     try {
//       _logger.i('Attempting to add patient: ${patient.toJson()}');

//       final response = await _dio.post(
//         ApiConstants.addPatientEndpoint,
//         data: jsonEncode(patient.toJson()),
//       );

//       _logger.i("Add Patient Response Status: ${response.statusCode}");
//       _logger.d("Add Patient Response Body: ${jsonEncode(response.data)}");

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         _logger.i('Patient added successfully.');
//         return UIResponse.completed(true);
//       } else {
//         final errorMessage = response.data["error"] ?? "Unknown server error.";
//         _logger.e("Adding patient failed with error: $errorMessage");
//         return UIResponse.error(errorMessage);
//       }
//     } on DioException catch (e) {
//       _logger.e('Add patient DioException: ${e.message}');
//       final errorMessage = handleDioError(e);
//       return UIResponse.error(errorMessage);
//     } catch (e, stackTrace) {
//       _logger.e('Unexpected exception in addPatient: $e', e, stackTrace);
//       return UIResponse.error("An unexpected error occurred: $e");
//     }
//   }

//   // 3. User Login
//   @override
//   Future<UIResponse<User>> login(String username, String password) async {
//     try {
//       _logger.i('Attempting login for user: $username');

//       final response = await _dio.post(
//         ApiConstants.loginEndpoint,
//         data: jsonEncode({
//           'username': username,
//           'password': password,
//         }),
//       );

//       _logger.i("Login Response Status: ${response.statusCode}");
//       _logger.d("Login Response Body: ${jsonEncode(response.data)}");

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final user = User.fromJson(response.data);
//         _logger.i('Login successful for user: $username');
//         return UIResponse.completed(user);
//       } else {
//         final errorMessage = response.data["error"] ?? "Login failed.";
//         _logger.e("Login failed with error: $errorMessage");
//         return UIResponse.error(errorMessage);
//       }
//     } on DioException catch (e) {
//       _logger.e('Login DioException: ${e.message}');
//       final errorMessage = handleDioError(e);
//       return UIResponse.error(errorMessage);
//     } catch (e, stackTrace) {
//       _logger.e('Unexpected exception in login: $e', e, stackTrace);
//       return UIResponse.error("An unexpected error occurred: $e");
//     }
//   }

//   // 4. User Registration
//   @override
//   Future<UIResponse<User>> register(String username, String password) async {
//     try {
//       _logger.i('Attempting registration for user: $username');

//       final response = await _dio.post(
//         ApiConstants.registerEndpoint,
//         data: jsonEncode({
//           'username': username,
//           'password': password,
//         }),
//       );

//       _logger.i("Register Response Status: ${response.statusCode}");
//       _logger.d("Register Response Body: ${jsonEncode(response.data)}");

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final user = User.fromJson(response.data);
//         _logger.i('Registration successful for user: $username');
//         return UIResponse.completed(user);
//       } else {
//         final errorMessage = response.data["error"] ?? "Registration failed.";
//         _logger.e("Registration failed with error: $errorMessage");
//         return UIResponse.error(errorMessage);
//       }
//     } on DioException catch (e) {
//       _logger.e('Registration DioException: ${e.message}');
//       final errorMessage = handleDioError(e);
//       return UIResponse.error(errorMessage);
//     } catch (e, stackTrace) {
//       _logger.e('Unexpected exception in register: $e', e, stackTrace);
//       return UIResponse.error("An unexpected error occurred: $e");
//     }
//   }

//   // 5. Fetching Patient List
//   @override
//   Future<UIResponse<List<PatientList>>> fetchPatientList() async {
//     try {
//       _logger.i('Fetching patient list');

//       final response = await _dio.get(
//         ApiConstants.patientListEndpoint,
//       );

//       _logger.i("Fetch Patient List Response Status: ${response.statusCode}");
//       _logger
//           .d("Fetch Patient List Response Body: ${jsonEncode(response.data)}");

//       if (response.statusCode == 200) {
//         List<dynamic> data = response.data;
//         List<PatientList> patients =
//             data.map((json) => PatientList.fromJson(json)).toList();
//         _logger.i('Fetched ${patients.length} patients successfully.');
//         return UIResponse.completed(patients);
//       } else {
//         final errorMessage =
//             response.data["error"] ?? "Failed to fetch patient list.";
//         _logger.e("Fetching patient list failed with error: $errorMessage");
//         return UIResponse.error(errorMessage);
//       }
//     } on DioException catch (e) {
//       _logger.e('Fetch patient list DioException: ${e.message}');
//       final errorMessage = handleDioError(e);
//       return UIResponse.error(errorMessage);
//     } catch (e, stackTrace) {
//       _logger.e('Unexpected exception in fetchPatientList: $e', e, stackTrace);
//       return UIResponse.error("An unexpected error occurred: $e");
//     }
//   }

//   @override
//   Future<UIResponse<List<Consultation>>> getPatientConsultations(
//       String patientId) async {
//     try {
//       _logger.i('Fetching consultations for patient ID: $patientId');

//       final response = await _dio.get(
//         '${ApiConstants.patientConsultationsEndpoint}/$patientId/consultations',
//       );

//       _logger.i(
//           "Fetch Patient Consultations Response Status: ${response.statusCode}");
//       _logger.d(
//           "Fetch Patient Consultations Response Body: ${jsonEncode(response.data)}");

//       if (response.statusCode == 200) {
//         List<dynamic> data = response.data;
//         List<Consultation> consultations =
//             data.map((json) => Consultation.fromJson(json)).toList();
//         _logger
//             .i('Fetched ${consultations.length} consultations successfully.');
//         return UIResponse.completed(consultations);
//       } else {
//         final errorMessage =
//             response.data["error"] ?? "Failed to fetch consultations.";
//         _logger.e("Fetching consultations failed with error: $errorMessage");
//         return UIResponse.error(errorMessage);
//       }
//     } on DioException catch (e) {
//       _logger.e('Fetch consultations DioException: ${e.message}');
//       final errorMessage = handleDioError(e);
//       return UIResponse.error(errorMessage);
//     } catch (e, stackTrace) {
//       _logger.e(
//           'Unexpected exception in getPatientConsultations: $e', e, stackTrace);
//       return UIResponse.error("An unexpected error occurred: $e");
//     }
//   }

//   // Helper method to handle Dio errors
//   String handleDioError(DioException error) {
//     if (error.response != null) {
//       // Extract error message from response data
//       if (error.response?.data is Map<String, dynamic>) {
//         return error.response?.data['message'] ?? 'An error occurred';
//       } else if (error.response?.data is String) {
//         return error.response?.data ?? 'An error occurred';
//       }
//     }
//     return error.message ?? 'Unknown error';
//   }
// }
// lib/src/repositories/user_repository_impl.dart
// lib/src/repositories/user_repository_impl.dart

import 'dart:convert'; // Added to resolve jsonEncode error
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../../constants/api_constants.dart';
import '../models/add_patient.dart';
// import '../models/consultation.dart'; // Ensure this import exists
import '../models/consultationRequestBody.dart';
import '../models/consultationResponse.dart';
import '../models/patient_list.dart';
import '../models/user_model.dart';
import '../models/apis/UIResponse.dart';
import './user_repository.dart';
import '../models/prediction_dashboard_response.dart';

class UserRepositoryImpl implements UserRepository {
  final Logger _logger = Logger();
  final Dio _dio;

  // Constructor to set up Dio with base options
  UserRepositoryImpl({Dio? dio}) : _dio = dio ?? Dio() {
    _dio.options.baseUrl = ApiConstants.baseUrl;
    _dio.options.headers[HttpHeaders.contentTypeHeader] = 'application/json';
  }

  // 1. Creating a Consultation
  @override
  Future<UIResponse<ConsultationResponse>> createConsultation({
    required ConsultationRequestBody request,
  }) async {
    try {
      _logger.i('Creating consultation with payload: ${request.toJson()}');

      final response = await _dio.post(
        ApiConstants.createConsultationEndpoint, // Correct endpoint
        data: request.toJson(), // Pass Map directly; Dio handles JSON encoding
      );

      _logger.i("Create Consultation Response Status: ${response.statusCode}");
      _logger
          .d("Create Consultation Response Body: ${jsonEncode(response.data)}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Parse the response into the ConsultationResponse model
        final consultationResponse =
            ConsultationResponse.fromJson(response.data);
        return UIResponse.completed(consultationResponse);
      } else {
        final errorMessage = response.data["error"] ?? "Unknown server error.";
        _logger.e("Server responded with error: $errorMessage");
        return UIResponse.error(errorMessage);
      }
    } on DioException catch (error) {
      _logger.e("DioException in createConsultation: ${error.message}");
      final errorMessage = handleDioError(error);
      return UIResponse.error(errorMessage);
    } catch (e, stackTrace) {
      _logger.e(
          "Unexpected exception in createConsultation: $e", e, stackTrace);
      return UIResponse.error("An unexpected error occurred: $e");
    }
  }

  // 2. Adding a Patient
  @override
  Future<UIResponse<bool>> addPatient(AddPatient patient) async {
    try {
      _logger.i('Attempting to add patient: ${patient.toJson()}');

      final response = await _dio.post(
        ApiConstants.addPatientEndpoint,
        data: patient.toJson(), // Pass Map directly
      );

      _logger.i("Add Patient Response Status: ${response.statusCode}");
      _logger.d("Add Patient Response Body: ${jsonEncode(response.data)}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        _logger.i('Patient added successfully.');
        return UIResponse.completed(true);
      } else {
        final errorMessage = response.data["error"] ?? "Unknown server error.";
        _logger.e("Adding patient failed with error: $errorMessage");
        return UIResponse.error(errorMessage);
      }
    } on DioException catch (e) {
      _logger.e('Add patient DioException: ${e.message}');
      final errorMessage = handleDioError(e);
      return UIResponse.error(errorMessage);
    } catch (e, stackTrace) {
      _logger.e('Unexpected exception in addPatient: $e', e, stackTrace);
      return UIResponse.error("An unexpected error occurred: $e");
    }
  }

  // 3. User Login
  @override
  Future<UIResponse<User>> login(String username, String password) async {
    try {
      _logger.i('Attempting login for user: $username');

      final response = await _dio.post(
        ApiConstants.loginEndpoint,
        data: {
          'username': username,
          'password': password,
        }, // Pass Map directly
      );

      _logger.i("Login Response Status: ${response.statusCode}");
      _logger.d("Login Response Body: ${jsonEncode(response.data)}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final user = User.fromJson(response.data);
        _logger.i('Login successful for user: $username');
        return UIResponse.completed(user);
      } else {
        final errorMessage = response.data["error"] ?? "Login failed.";
        _logger.e("Login failed with error: $errorMessage");
        return UIResponse.error(errorMessage);
      }
    } on DioException catch (e) {
      _logger.e('Login DioException: ${e.message}');
      final errorMessage = handleDioError(e);
      return UIResponse.error(errorMessage);
    } catch (e, stackTrace) {
      _logger.e('Unexpected exception in login: $e', e, stackTrace);
      return UIResponse.error("An unexpected error occurred: $e");
    }
  }

  // 4. User Registration
  @override
  Future<UIResponse<User>> register(String username, String password) async {
    try {
      _logger.i('Attempting registration for user: $username');

      final response = await _dio.post(
        ApiConstants.registerEndpoint,
        data: {
          'username': username,
          'password': password,
        }, // Pass Map directly
      );

      _logger.i("Register Response Status: ${response.statusCode}");
      _logger.d("Register Response Body: ${jsonEncode(response.data)}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final user = User.fromJson(response.data);
        _logger.i('Registration successful for user: $username');
        return UIResponse.completed(user);
      } else {
        final errorMessage = response.data["error"] ?? "Registration failed.";
        _logger.e("Registration failed with error: $errorMessage");
        return UIResponse.error(errorMessage);
      }
    } on DioException catch (e) {
      _logger.e('Registration DioException: ${e.message}');
      final errorMessage = handleDioError(e);
      return UIResponse.error(errorMessage);
    } catch (e, stackTrace) {
      _logger.e('Unexpected exception in register: $e', e, stackTrace);
      return UIResponse.error("An unexpected error occurred: $e");
    }
  }

  // 5. Fetching Patient List
  @override
  Future<UIResponse<List<PatientList>>> fetchPatientList() async {
    try {
      _logger.i('Fetching patient list');

      final response = await _dio.get(
        ApiConstants.patientListEndpoint,
      );

      _logger.i("Fetch Patient List Response Status: ${response.statusCode}");
      _logger
          .d("Fetch Patient List Response Body: ${jsonEncode(response.data)}");

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        List<PatientList> patients =
            data.map((json) => PatientList.fromJson(json)).toList();
        _logger.i('Fetched ${patients.length} patients successfully.');
        return UIResponse.completed(patients);
      } else {
        final errorMessage =
            response.data["error"] ?? "Failed to fetch patient list.";
        _logger.e("Fetching patient list failed with error: $errorMessage");
        return UIResponse.error(errorMessage);
      }
    } on DioException catch (e) {
      _logger.e('Fetch patient list DioException: ${e.message}');
      final errorMessage = handleDioError(e);
      return UIResponse.error(errorMessage);
    } catch (e, stackTrace) {
      _logger.e('Unexpected exception in fetchPatientList: $e', e, stackTrace);
      return UIResponse.error("An unexpected error occurred: $e");
    }
  }

  // 6. Fetching Consultations for a Patient
  @override
  Future<UIResponse<List<Consultation>>> getPatientConsultations(
      String patientId) async {
    try {
      _logger.i('Fetching consultations for patient ID: $patientId');

      final response = await _dio.get(
        ApiConstants.patientConsultationsEndpoint(
            patientId), // Corrected endpoint usage
      );

      _logger.i(
          "Fetch Patient Consultations Response Status: ${response.statusCode}");
      _logger.d(
          "Fetch Patient Consultations Response Body: ${jsonEncode(response.data)}");

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        List<Consultation> consultations =
            data.map((json) => Consultation.fromJson(json)).toList();
        _logger
            .i('Fetched ${consultations.length} consultations successfully.');
        return UIResponse.completed(consultations);
      } else {
        final errorMessage =
            response.data["error"] ?? "Failed to fetch consultations.";
        _logger.e("Fetching consultations failed with error: $errorMessage");
        return UIResponse.error(errorMessage);
      }
    } on DioException catch (e) {
      _logger.e('Fetch consultations DioException: ${e.message}');
      final errorMessage = handleDioError(e);
      return UIResponse.error(errorMessage);
    } catch (e, stackTrace) {
      _logger.e(
          'Unexpected exception in getPatientConsultations: $e', e, stackTrace);
      return UIResponse.error("An unexpected error occurred: $e");
    }
  }

  @override
  Future<UIResponse<List<PredictionModel>>> fetchPredictions() async {
    try {
      final response = await _dio.get(ApiConstants.fetchPredictionsEndpoint);
      if (response.statusCode == 200) {
        final data = PredictionDashboardResponse.fromJson(response.data);
        return UIResponse.completed(data.predictions);
      } else {
        return UIResponse.error("Failed to fetch predictions");
      }
    } catch (e) {
      return UIResponse.error("An error occurred: $e");
    }
  }

  // 6. Fetching Predictions
  // @override
  // Future<UIResponse<List<PredictionModel>>> fetchPredictions() async {
  //   try {
  //     _logger.i('Fetching predictions');

  //     final response = await _dio.get(
  //       ApiConstants.fetchPredictionsEndpoint, // Define this endpoint
  //     );

  //     _logger.i("Fetch Predictions Response Status: ${response.statusCode}");
  //     _logger
  //         .d("Fetch Predictions Response Body: ${jsonEncode(response.data)}");

  //     if (response.statusCode == 200) {
  //       // Assuming the backend returns a structure matching PredictionDashboardResponse
  //       final dashboardResponse =
  //           PredictionDashboardResponse.fromJson(response.data);
  //       _logger.i(
  //           'Fetched ${dashboardResponse.predictions.length} predictions successfully.');
  //       return UIResponse.completed(dashboardResponse.predictions);
  //     } else {
  //       final errorMessage =
  //           response.data["message"] ?? "Failed to fetch predictions.";
  //       _logger.e("Fetching predictions failed with error: $errorMessage");
  //       return UIResponse.error(errorMessage);
  //     }
  //   } on DioException catch (e) {
  //     _logger.e('Fetch predictions DioException: ${e.message}');
  //     final errorMessage = handleDioError(e);
  //     return UIResponse.error(errorMessage);
  //   } catch (e, stackTrace) {
  //     _logger.e('Unexpected exception in fetchPredictions: $e', e, stackTrace);
  //     return UIResponse.error("An unexpected error occurred: $e");
  //   }
  // }

  // Helper method to handle Dio errors
  String handleDioError(DioException error) {
    if (error.response != null) {
      // Extract error message from response data
      if (error.response?.data is Map<String, dynamic>) {
        //return error.response?['message'] ?? 'An error occurred';
      } else if (error.response?.data is String) {
        return error.response?.data ?? 'An error occurred';
      }
    }
    return error.message ?? 'Unknown error';
  }
}
