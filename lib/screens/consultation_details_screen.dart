// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import '../data/models/consultationResponse.dart';

// class ConsultationDetailsScreen extends StatelessWidget {
//   final Consultation consultation;

//   const ConsultationDetailsScreen({
//     Key? key,
//     required this.consultation,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Format the consultation date
//     final formattedDate =
//         DateFormat('yyyy-MM-dd – HH:mm').format(consultation.consultationDate);

//     // Join the symptoms into a single comma-separated string
//     final symptomsString = consultation.symptoms.isNotEmpty
//         ? consultation.symptoms.join(', ')
//         : 'Not provided';

//     return Scaffold(
//       // Optional gradient background behind the entire screen
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.teal, Colors.white],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 // Custom app bar (row with back button and title)
//                 Row(
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.arrow_back, color: Colors.white),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       child: Text(
//                         'Consultation Details',
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 // The actual card containing the consultation info
//                 Card(
//                   elevation: 4,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         _buildDetailRow(
//                           'Date',
//                           formattedDate,
//                         ),
//                         const SizedBox(height: 12),
//                         _buildDetailRow(
//                           'Symptoms',
//                           symptomsString,
//                         ),
//                         const SizedBox(height: 12),
//                         _buildDetailRow(
//                           'Diagnosis',
//                           consultation.diagnosis,
//                         ),
//                         const SizedBox(height: 12),
//                         _buildDetailRow(
//                           'Prescription',
//                           consultation.prescription,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   /// A helper widget to render a title and value in a vertical layout
//   Widget _buildDetailRow(String title, String content) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(
//             fontSize: 17,
//             fontWeight: FontWeight.bold,
//             color: Colors.teal,
//           ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           content,
//           style: const TextStyle(
//             fontSize: 15,
//             color: Colors.black87,
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/models/consultationResponse.dart';

class ConsultationDetailsScreen extends StatelessWidget {
  final Consultation consultation;

  const ConsultationDetailsScreen({
    Key? key,
    required this.consultation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Format the consultation date
    final formattedDate =
        DateFormat('yyyy-MM-dd – HH:mm').format(consultation.consultationDate);

    // Join the symptoms into a single comma-separated string
    final symptomsString = consultation.symptoms.isNotEmpty
        ? consultation.symptoms.join(', ')
        : 'Not provided';

    return Scaffold(
      // Optional gradient background behind the entire screen
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Custom app bar (row with back button and title)
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Consultation Details',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // The actual card containing the consultation info,
                // wrapped in a SizedBox to make it full-width
                SizedBox(
                  width: double.infinity, // <<-- Full width
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDetailRow('Date', formattedDate),
                          const SizedBox(height: 12),
                          _buildDetailRow('Symptoms', symptomsString),
                          const SizedBox(height: 12),
                          _buildDetailRow(
                            'Diagnosis',
                            consultation.diagnosis,
                          ),
                          const SizedBox(height: 12),
                          _buildDetailRow(
                            'Prescription',
                            consultation.prescription,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// A helper widget to render a title and value in a vertical layout
  Widget _buildDetailRow(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          content,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
