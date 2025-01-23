import 'package:flutter/material.dart';
import '../../data/models/add_patient.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../data/models/apis/UIResponse.dart';

class AddPatientScreen extends StatefulWidget {
  final String userId;
  const AddPatientScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<AddPatientScreen> createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _contactInfoController = TextEditingController();
  String? _selectedGender;

  bool _isLoading = false;

  final UserRepositoryImpl _repository = UserRepositoryImpl();

  // ------------------------------------------
  // Submit Logic
  // ------------------------------------------
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final patient = AddPatient(
        doctorId: widget.userId,
        patientName: _nameController.text.trim(),
        gender: _selectedGender ?? '',
        age: int.parse(_ageController.text),
        height: double.parse(_heightController.text),
        weight: double.parse(_weightController.text),
        contactInfo: _contactInfoController.text.trim(),
      );

      setState(() => _isLoading = true);

      try {
        final UIResponse<bool> response = await _repository.addPatient(patient);

        if (!mounted) return;
        if (response.isSuccess && response.data == true) {
          // Successfully added patient
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Patient added successfully!')),
          );
          Navigator.pop(context, true);
        } else {
          // Some error from server
          final message = response.error ?? 'Error adding patient';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        }
      } catch (e) {
        // Unexpected exceptions
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding patient: $e')),
        );
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  // ------------------------------------------
  // Build
  // ------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Gradient background for a modern look
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
                // Custom Header
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Add Patient',
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

                // The main card that holds the form
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _buildTextField(
                            controller: _nameController,
                            label: 'Patient Name',
                            validator: (value) => value?.isEmpty ?? true
                                ? 'Please enter patient name'
                                : null,
                          ),
                          _buildGenderDropdown(),
                          _buildTextField(
                            controller: _ageController,
                            label: 'Age',
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Please enter age';
                              }
                              if (int.tryParse(value!) == null) {
                                return 'Please enter a valid age';
                              }
                              return null;
                            },
                          ),
                          _buildTextField(
                            controller: _heightController,
                            label: 'Height (cm)',
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Please enter height';
                              }
                              if (double.tryParse(value!) == null) {
                                return 'Please enter a valid height';
                              }
                              return null;
                            },
                          ),
                          _buildTextField(
                            controller: _weightController,
                            label: 'Weight (kg)',
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Please enter weight';
                              }
                              if (double.tryParse(value!) == null) {
                                return 'Please enter a valid weight';
                              }
                              return null;
                            },
                          ),
                          _buildTextField(
                            controller: _contactInfoController,
                            label: 'Contact Info',
                            validator: (value) => value?.isEmpty ?? true
                                ? 'Please enter contact info'
                                : null,
                          ),
                          const SizedBox(height: 20),
                          _buildSubmitButton(),
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

  // ------------------------------------------
  // Widgets
  // ------------------------------------------
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Widget _buildGenderDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: _selectedGender,
        items: ['Male', 'Female', 'Other']
            .map(
              (gender) => DropdownMenuItem(
                value: gender,
                child: Text(gender),
              ),
            )
            .toList(),
        onChanged: (value) => setState(() => _selectedGender = value),
        decoration: InputDecoration(
          labelText: 'Gender',
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        validator: (value) => value == null ? 'Please select a gender' : null,
      ),
    );
  }

  // Widget _buildSubmitButton() {
  //   return ElevatedButton(
  //     onPressed: _isLoading ? null : _submitForm,
  //     style: ElevatedButton.styleFrom(
  //       backgroundColor: Colors.teal,
  //       padding: const EdgeInsets.symmetric(vertical: 16),
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //     ),
  //     child: _isLoading
  //         ? const CircularProgressIndicator(
  //             valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
  //           )
  //         : const Text(
  //             'Add Patient',
  //             style: TextStyle(fontSize: 16),
  //           ),
  //   );
  // }
  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity, // Makes the button take full available width
      child: ElevatedButton(
        onPressed: _isLoading ? null : _submitForm,
        style: ElevatedButton.styleFrom(
          // Use foregroundColor for text color in newer Flutter versions
          foregroundColor: Colors.white,
          backgroundColor: Colors.teal,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: _isLoading
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : const Text(
                'Add Patient',
                style: TextStyle(fontSize: 16),
              ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _contactInfoController.dispose();
    super.dispose();
  }
}
