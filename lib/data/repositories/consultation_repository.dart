import '../network/consultation_service.dart';
import '../models/consultation_model.dart';

class ConsultationRepository {
  final ConsultationService _consultationService = ConsultationService();

  // Fetch consultations by patient ID
  Future<List<Consultation>?> getConsultationsByPatientId(
      String patientId) async {
    final data =
        await _consultationService.getConsultationsByPatientId(patientId);

    if (data != null) {
      // Return the list of Consultation objects
      return data;
    }

    return null; // Return null if data fetch fails
  }
}
