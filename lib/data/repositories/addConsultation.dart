import '../models/addConsultation.dart';
import '../network/addConsultation_service.dart';

class AddConsultationRepository {
  final AddConsultationService _addConsultationService =
      AddConsultationService();

  Future<AddConsultation?> addConsultation(AddConsultation consultation) async {
    final response =
        await _addConsultationService.addConsultation(consultation);

    if (response != null &&
        response['message'] == "Consultation created successfully") {
      return AddConsultation.fromJson(response['consultation']);
    }
    return null;
  }
}
