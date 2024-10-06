import 'package:flutter/material.dart';
import '../data/models/consultation_model.dart';

class ConsultationDetailsScreen extends StatelessWidget {
  final Consultation consultation;

  const ConsultationDetailsScreen({Key? key, required this.consultation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultation Details'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Date', consultation.consultationDate),
            const SizedBox(height: 12),
            _buildDetailRow(
              'Symptoms',
              consultation.symptoms.isNotEmpty
                  ? consultation.symptoms.join(", ")
                  : 'Not provided',
            ),
            const SizedBox(height: 12),
            _buildDetailRow('Diagnosis', consultation.diagnosis),
            const SizedBox(height: 12),
            _buildDetailRow('Prescription', consultation.prescription),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          content,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
