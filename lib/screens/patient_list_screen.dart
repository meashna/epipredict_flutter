// // lib/ui/screens/patient_list_screen.dart

// import 'package:Epipredict/screens/dashboard_screen.dart';
// import 'package:flutter/material.dart';
// import 'patient_details_screen.dart';
// import '../data/repositories/user_repository_impl.dart';
// import '../data/models/patient_list.dart';
// import 'addPatient_screen.dart';
// import 'loginpage.dart';
// import '../data/models/apis/UIResponse.dart';
// import './dashboard_screen.dart';

// class PatientListScreen extends StatefulWidget {
//   final String userId;
//   const PatientListScreen({Key? key, required this.userId}) : super(key: key);

//   @override
//   _PatientListScreenState createState() => _PatientListScreenState();
// }

// class _PatientListScreenState extends State<PatientListScreen> {
//   final UserRepositoryImpl _repository = UserRepositoryImpl();
//   List<PatientList>? _patients;
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _fetchPatients();
//   }

//   Future<void> _fetchPatients() async {
//     setState(() {
//       _isLoading = true;
//     });
//     try {
//       final UIResponse<List<PatientList>> response =
//           await _repository.fetchPatientList();
//       if (response.isSuccess && response.data != null) {
//         setState(() {
//           _patients = response.data;
//           _isLoading = false;
//         });
//       } else if (response.error != null) {
//         setState(() {
//           _isLoading = false;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error fetching patients: ${response.error}')),
//         );
//       }
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error fetching patients: ${e.toString()}')),
//       );
//     }
//   }

//   // Navigation functions
//   void _navigateToHome() {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//           builder: (context) => PatientListScreen(userId: widget.userId)),
//     );
//   }

//   void _navigateToDashboard() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//           builder: (context) => DashboardScreen(userId: widget.userId)),
//     );
//   }

//   void _navigateToAddPatient() async {
//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(
//           builder: (context) => AddPatientScreen(userId: widget.userId)),
//     );

//     if (result == true) {
//       await _fetchPatients(); // Refresh the patient list
//     }
//   }

//   void _exitApp() {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => const LoginScreen()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Patient List'),
//         centerTitle: true,
//         backgroundColor: Colors.teal,
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : _patients == null || _patients!.isEmpty
//               ? const Center(child: Text('No patients found.'))
//               : GridView.builder(
//                   padding: const EdgeInsets.all(8.0),
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2, // Changed to 2 for better UI
//                     mainAxisSpacing: 8.0,
//                     crossAxisSpacing: 8.0,
//                     childAspectRatio: 0.8,
//                   ),
//                   itemCount: _patients?.length ?? 0,
//                   itemBuilder: (context, index) {
//                     final patient = _patients![index];

//                     return GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 PatientDetailsScreen(patient: patient),
//                           ),
//                         );
//                       },
//                       child: Card(
//                         elevation: 3,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               const Icon(
//                                 Icons.person,
//                                 size: 60,
//                                 color: Colors.teal,
//                               ),
//                               const SizedBox(height: 8),
//                               Text(
//                                 patient.patientName,
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.black87,
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 '${patient.age} years',
//                                 style: const TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.black54,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),

//       // Bottom Navigation Bar
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Colors.teal,
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.white70,
//         type: BottomNavigationBarType.fixed,
//         onTap: (index) {
//           switch (index) {
//             case 0:
//               _navigateToHome();
//               break;
//             case 1:
//               _navigateToDashboard();
//               break;
//             case 2:
//               _navigateToAddPatient();
//               break;
//             case 3:
//               _exitApp();
//               break;
//           }
//         },
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.dashboard),
//             label: 'Dashboard',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.add),
//             label: 'Add Patient',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.exit_to_app),
//             label: 'Exit',
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../data/repositories/user_repository_impl.dart';
import '../data/models/patient_list.dart';
import 'patient_details_screen.dart';
import 'addPatient_screen.dart';
import 'loginpage.dart';
import './dashboard_screen.dart';
import '../data/models/apis/UIResponse.dart';

class PatientListScreen extends StatefulWidget {
  final String userId;

  const PatientListScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<PatientListScreen> createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  final UserRepositoryImpl _repository = UserRepositoryImpl();
  final Logger _logger = Logger();

  List<PatientList>? _allPatients; // Full list
  List<PatientList>? _filteredPatients; // Filtered by search
  bool _isLoading = true;
  String _searchQuery = ''; // Current search text

  @override
  void initState() {
    super.initState();
    _fetchPatients();
  }

  Future<void> _fetchPatients() async {
    setState(() => _isLoading = true);

    try {
      final UIResponse<List<PatientList>> response =
          await _repository.fetchPatientList();

      if (response.isSuccess && response.data != null) {
        setState(() {
          _allPatients = response.data;
          _filteredPatients = _allPatients; // Initially show all
          _isLoading = false;
        });
      } else {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching patients: ${response.error}')),
        );
      }
    } catch (e, stackTrace) {
      _logger.e('Error fetching patients: $e', e, stackTrace);
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching patients: $e')),
      );
    }
  }

  // Filter patients by name
  void _filterPatients(String query) {
    if (_allPatients == null) return;
    if (query.isEmpty) {
      // If search is cleared, show all
      setState(() {
        _searchQuery = '';
        _filteredPatients = _allPatients;
      });
    } else {
      setState(() {
        _searchQuery = query.toLowerCase();
        _filteredPatients = _allPatients!
            .where((patient) =>
                patient.patientName.toLowerCase().contains(_searchQuery))
            .toList();
      });
    }
  }

  // Navigation
  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => PatientListScreen(userId: widget.userId)),
    );
  }

  void _navigateToDashboard() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DashboardScreen(userId: widget.userId)),
    );
  }

  void _navigateToAddPatient() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddPatientScreen(userId: widget.userId)),
    );
    if (result == true) {
      await _fetchPatients();
    }
  }

  // void _exitApp() {
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(builder: (context) => const LoginScreen()),
  //   );
  // }
  void _exitApp() async {
    // 1) Show dialog
    bool? confirmExit = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Exit'),
          content: const Text('Are you sure you want to log out and exit?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false), // Cancel
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true), // Confirm
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );

    // 2) If user confirmed, navigate to Login screen
    if (confirmExit == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Patient List',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20, // Adjust font size if desired
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),

      body: Column(
        children: [
          // --- Search Bar ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextField(
              onChanged: _filterPatients,
              decoration: InputDecoration(
                hintText: 'Search patients...',
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.teal),
                ),
              ),
            ),
          ),
          // --- Body ---
          Expanded(
            child: _buildBody(),
          ),
        ],
      ),
      // Bottom Nav
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.teal,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          switch (index) {
            case 0:
              _navigateToHome();
              break;
            case 1:
              _navigateToDashboard();
              break;
            case 2:
              _navigateToAddPatient();
              break;
            case 3:
              _exitApp();
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Patient',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app),
            label: 'Exit',
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_filteredPatients == null || _filteredPatients!.isEmpty) {
      return const Center(
        child: Text(
          'No matching patients found.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 columns
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 0.8,
      ),
      itemCount: _filteredPatients?.length ?? 0,
      itemBuilder: (context, index) {
        final patient = _filteredPatients![index];
        return GestureDetector(
          onTap: () {
            // Navigate to patient details
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PatientDetailsScreen(patient: patient),
              ),
            );
          },
          child: _buildPatientCard(patient),
        );
      },
    );
  }

  Widget _buildPatientCard(PatientList patient) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.person,
              size: 60,
              color: Colors.teal,
            ),
            const SizedBox(height: 8),
            Text(
              patient.patientName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              '${patient.age} years',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            // Optional: Add more info here if needed
          ],
        ),
      ),
    );
  }
}
