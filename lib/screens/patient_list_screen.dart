import 'package:Epipredict/screens/dashboardScreen.dart';
import 'package:flutter/material.dart';
import 'patient_details_screen.dart';
import '../data/repositories/patientList_repository.dart';
import '../data/models/patientList_model.dart';
import 'addPatient_screen.dart';
import 'package:Epipredict/screens/loginpage.dart';

class PatientListScreen extends StatefulWidget {
  final String userId;
  PatientListScreen({required this.userId});

  @override
  _PatientListScreenState createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  final PatientListRepository _repository = PatientListRepository();
  List<PatientList>? _patients;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPatients();
  }

  Future<void> _fetchPatients() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final patients = await _repository.getPatientList();
      setState(() {
        _patients = patients;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching patients: ${e.toString()}')),
      );
    }
  }

  // Navigation functions
  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => PatientListScreen(userId: widget.userId)),
    );
  }

  void _navigateToDashboard() {
    Navigator.pushReplacement(
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
      await _fetchPatients(); // Refresh the patient list
    }
  }

  void _exitApp() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient List'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 0.7,
              ),
              itemCount: _patients?.length ?? 0,
              itemBuilder: (context, index) {
                final patient = _patients![index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PatientDetailsScreen(patient: patient),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.folder,
                            size: 40,
                            color: Colors.teal,
                          ),
                          SizedBox(height: 8),
                          Text(
                            patient.patientName,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

      // Bottom Navigation Bar
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
        items: [
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
}
