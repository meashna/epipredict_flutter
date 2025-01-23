// // lib/ui/screens/patient_details_screen.dart

// import 'package:flutter/material.dart';
// import '../../data/models/patient_list.dart';
// import '../../data/models/consultationResponse.dart';
// import '../../data/repositories/user_repository_impl.dart';
// import '../../data/models/apis/UIResponse.dart';
// import './addConsultationScreen.dart';
// import './consultation_details_screen.dart';

// class PatientDetailsScreen extends StatefulWidget {
//   final PatientList patient;

//   const PatientDetailsScreen({
//     Key? key,
//     required this.patient,
//   }) : super(key: key);

//   @override
//   _PatientDetailsScreenState createState() => _PatientDetailsScreenState();
// }

// class _PatientDetailsScreenState extends State<PatientDetailsScreen> {
//   // Use the repository instead of ConsultationService
//   final UserRepositoryImpl _userRepository = UserRepositoryImpl();

//   List<Consultation>? _consultations;
//   bool _isLoading = true;
//   String? _error;

//   @override
//   void initState() {
//     super.initState();
//     _fetchConsultations();
//   }

//   Future<void> _fetchConsultations() async {
//     setState(() {
//       _isLoading = true;
//       _error = null;
//     });

//     // Use the repository's method
//     final UIResponse<List<Consultation>> response =
//         await _userRepository.getPatientConsultations(widget.patient.id);

//     if (!mounted) return;

//     if (response.isSuccess && response.data != null) {
//       setState(() {
//         _consultations = response.data; // List<Consultation>
//         _isLoading = false;
//       });
//     } else {
//       setState(() {
//         _error = response.error ?? 'Error fetching consultations';
//         _isLoading = false;
//       });
//     }
//   }

//   Future<void> _addNewConsultation() async {
//     final result = await Navigator.push<bool>(
//       context,
//       MaterialPageRoute(
//         builder: (context) => AddConsultationScreen(
//           patientId: widget.patient.id,
//           doctorId: widget.patient.doctorId,
//         ),
//       ),
//     );

//     if (result == true) {
//       // Refresh the list after adding a new consultation
//       _fetchConsultations();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.patient.patientName),
//         backgroundColor: Colors.teal,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: ElevatedButton.icon(
//               onPressed: _addNewConsultation,
//               icon: const Icon(Icons.add),
//               label: const Text('New Consultation'),
//               style: ElevatedButton.styleFrom(
//                 foregroundColor: Colors.white,
//                 backgroundColor: Colors.teal.shade700,
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: RefreshIndicator(
//         onRefresh: _fetchConsultations,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildPatientInfoCard(),
//               const SizedBox(height: 20),
//               Text(
//                 'Consultations',
//                 style: Theme.of(context)
//                     .textTheme
//                     .titleLarge!
//                     .copyWith(color: Colors.teal, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 10),
//               Expanded(
//                 child: _buildConsultationsList(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPatientInfoCard() {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Patient Information',
//               style: Theme.of(context)
//                   .textTheme
//                   .titleLarge!
//                   .copyWith(fontWeight: FontWeight.bold),
//             ),
//             const Divider(),
//             Text(
//               'Name: ${widget.patient.patientName}',
//               style: Theme.of(context).textTheme.bodyLarge,
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Gender: ${widget.patient.gender}',
//               style: Theme.of(context).textTheme.bodyLarge,
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Age: ${widget.patient.age}',
//               style: Theme.of(context).textTheme.bodyLarge,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildConsultationsList() {
//     if (_isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     if (_error != null) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Error: $_error'),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _fetchConsultations,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.teal,
//               ),
//               child: const Text('Retry'),
//             ),
//           ],
//         ),
//       );
//     }

//     if (_consultations == null || _consultations!.isEmpty) {
//       return const Center(child: Text('No consultations found'));
//     }

//     return ListView.builder(
//       itemCount: _consultations!.length,
//       itemBuilder: (context, index) {
//         final consultation = _consultations![index];
//         return Card(
//           elevation: 3,
//           margin: const EdgeInsets.symmetric(vertical: 8),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//           child: ListTile(
//             contentPadding: const EdgeInsets.all(16),
//             title: Text('Consultation ${index + 1}'),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Date: ${consultation.consultationDate}'),
//                 Text('Diagnosis: ${consultation.diagnosis}'),
//               ],
//             ),
//             trailing: const Icon(Icons.arrow_forward_ios, color: Colors.teal),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ConsultationDetailsScreen(
//                     consultation: consultation,
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../../data/models/patient_list.dart';
import '../../data/models/consultationResponse.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../data/models/apis/UIResponse.dart';
import './addConsultationScreen.dart';
import './consultation_details_screen.dart';

class PatientDetailsScreen extends StatefulWidget {
  final PatientList patient;

  const PatientDetailsScreen({
    Key? key,
    required this.patient,
  }) : super(key: key);

  @override
  State<PatientDetailsScreen> createState() => _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends State<PatientDetailsScreen> {
  final UserRepositoryImpl _userRepository = UserRepositoryImpl();

  List<Consultation>? _consultations;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchConsultations();
  }

  Future<void> _fetchConsultations() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final UIResponse<List<Consultation>> response =
        await _userRepository.getPatientConsultations(widget.patient.id);

    if (!mounted) return;

    if (response.isSuccess && response.data != null) {
      setState(() {
        _consultations = response.data;
        _isLoading = false;
      });
    } else {
      setState(() {
        _error = response.error ?? 'Error fetching consultations';
        _isLoading = false;
      });
    }
  }

  Future<void> _addNewConsultation() async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => AddConsultationScreen(
          patientId: widget.patient.id,
          doctorId: widget.patient.doctorId,
        ),
      ),
    );

    if (result == true) {
      // Refresh the list after adding a new consultation
      _fetchConsultations();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // A slight gradient behind the body
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: _fetchConsultations,
            child: Column(
              children: [
                // AppBar area
                _buildHeader(context),
                // Body
                Expanded(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildPatientInfoCard(context),
                          const SizedBox(height: 16),
                          _buildConsultationHeader(context),
                          const SizedBox(height: 8),
                          _buildConsultationList(context),
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

  /// A custom header instead of a default AppBar
  Widget _buildHeader(BuildContext context) {
    return Container(
      color: Colors.teal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Back button
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          // Title
          Expanded(
            child: Text(
              widget.patient.patientName,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // New Consultation button
          // ElevatedButton.icon(
          //   onPressed: _addNewConsultation,
          //   icon: const Icon(Icons.add),
          //   label: const Text('New'),
          //   style: ElevatedButton.styleFrom(
          //     foregroundColor: Colors.white,
          //     backgroundColor: Colors.teal.shade700,
          //     elevation: 0,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //   ),
          // ),
          SizedBox(
            child: ElevatedButton(
              onPressed: _addNewConsultation,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, // Ensures icon is white
                backgroundColor: Colors.teal.shade700,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Icon(Icons.add, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPatientInfoCard(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Patient Information',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            const Divider(),
            const SizedBox(height: 4),
            Text(
              'Name: ${widget.patient.patientName}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 6),
            Text(
              'Gender: ${widget.patient.gender}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 6),
            Text(
              'Age: ${widget.patient.age}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConsultationHeader(BuildContext context) {
    // Show how many consultations
    final count = _consultations?.length ?? 0;
    return Row(
      children: [
        Text(
          'Consultations',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.teal,
                fontWeight: FontWeight.bold,
              ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Total: $count',
            style: const TextStyle(color: Colors.black87, fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildConsultationList(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              'Error: $_error',
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _fetchConsultations,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }
    if (_consultations == null || _consultations!.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(child: Text('No consultations found')),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _consultations!.length,
      itemBuilder: (context, index) {
        final consultation = _consultations![index];
        return _buildConsultationCard(context, consultation, index);
      },
    );
  }

  Widget _buildConsultationCard(
      BuildContext context, Consultation consultation, int index) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: const Icon(Icons.medical_services, color: Colors.teal),
        title: Text('Consultation ${index + 1}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              'Date: ${consultation.consultationDate}',
              style: const TextStyle(fontSize: 14),
            ),
            Text(
              'Diagnosis: ${consultation.diagnosis}',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.teal),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ConsultationDetailsScreen(
                consultation: consultation,
              ),
            ),
          );
        },
      ),
    );
  }
}
