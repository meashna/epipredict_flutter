import 'package:flutter/material.dart';
import '../data/models/consultationRequestBody.dart';
import '../data/models/consultationResponse.dart';
import '../data/repositories/user_repository_impl.dart';
import '../../data/models/apis/UIResponse.dart';

class AddConsultationScreen extends StatefulWidget {
  final String patientId;
  final String doctorId;

  const AddConsultationScreen({
    Key? key,
    required this.patientId,
    required this.doctorId,
  }) : super(key: key);

  @override
  State<AddConsultationScreen> createState() => _AddConsultationScreenState();
}

class _AddConsultationScreenState extends State<AddConsultationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _diagnosisController = TextEditingController();
  final _prescriptionController = TextEditingController();
  final UserRepositoryImpl _repository = UserRepositoryImpl();
  bool _isLoading = false;

  // Full list of possible symptoms
  final List<String> _symptomsList = [
    'High fever',
    'Severe headache',
    'Pain behind the eyes',
    'Muscle and joint pain',
    'Skin rash',
    'Nausea and vomiting',
    'Fatigue',
    'Mild bleeding',
    'Abdominal pain',
    'Redness in palms and soles',
    'Cyclical fever with chills and sweating',
    'Muscle pain',
    'Diarrhea',
    'Jaundice',
    'Confusion or altered mental state',
    'Sudden onset of fever',
    'Debilitating joint pain',
    'Rash',
    'Mild headache',
    'Swelling in joints',
    'Muscle tenderness',
    'Eschar',
    'Chills',
    'Lymph node swelling',
    'Dry cough',
    'Hearing loss',
    'Stiff neck',
    'Seizures',
    'Altered mental status',
    'Vomiting',
    'Tremors',
    'Paralysis or muscle weakness',
    'Speech difficulties',
    'Sensitivity to light',
    'Sudden fever',
    'Convulsions',
    'Confusion',
    'Coma',
    'Muscle weakness',
    'Difficulty swallowing',
    'Hallucinations',
    'Loss of appetite',
    'Respiratory distress',
    'Fever',
    'Neurological symptoms',
    'Swollen lymph nodes',
    'Eye pain',
    'Joint stiffness',
    'High fever with chills',
    'Bleeding tendencies',
    'Pain in the abdomen',
    'Low blood pressure',
    'Back pain',
    'Brain inflammation',
    'Drowsiness',
    'Muscle aches',
    'Double vision',
    'Weakness or paralysis',
    'Rapid breathing',
    'Persistent cough',
    'Sore throat',
    'Body aches',
    'Runny or congested nose',
    'Shortness of breath',
    'Chest pain',
    'Puffy cheeks',
    'Swollen jaw',
    'Pain while chewing or swallowing',
    'Headache',
    'Swelling in other glands',
    'Hearing loss (rare)',
    'Disease (indicates corresponding disease or "None")',
  ];

  // Start with an empty filtered list (so we don't show them all initially)
  List<String> _filteredSymptoms = [];
  // The user's selected symptoms
  List<String> _selectedSymptoms = [];

  @override
  void initState() {
    super.initState();
    // We'll keep the symptom list hidden until the user starts typing
  }

  // ================== UI BUILD ===================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Gradient background
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
                // Custom header with a close button
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Add Consultation',
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
                // Main card for the form
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _buildSearchableSymptoms(),
                          const SizedBox(height: 16),
                          _buildSelectedSymptomsView(),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: _diagnosisController,
                            label: 'Diagnosis',
                            maxLines: 2,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter a diagnosis';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: _prescriptionController,
                            label: 'Prescription',
                            maxLines: 3,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter a prescription';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
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

  // ================== SEARCHABLE SYMPTOMS ===================
  Widget _buildSearchableSymptoms() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Search Symptoms',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: 'Type to search symptoms...',
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            prefixIcon: const Icon(Icons.search),
          ),
          onChanged: (value) {
            setState(() {
              if (value.trim().isEmpty) {
                // If user clears text => no suggestions
                _filteredSymptoms = [];
              } else {
                _filteredSymptoms = _symptomsList
                    .where((symptom) =>
                        symptom.toLowerCase().contains(value.toLowerCase()))
                    .toList();
              }
            });
          },
        ),
        const SizedBox(height: 8),
        // Show the suggestion chips only if we have filtered items
        if (_filteredSymptoms.isNotEmpty)
          Wrap(
            spacing: 8.0,
            children: _filteredSymptoms.map((symptom) {
              final isSelected = _selectedSymptoms.contains(symptom);
              return ChoiceChip(
                label: Text(symptom),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected && !isSelected) {
                      _selectedSymptoms.add(symptom);
                    }
                  });
                },
              );
            }).toList(),
          ),
      ],
    );
  }

  // ================== SELECTED SYMPTOMS ===================
  Widget _buildSelectedSymptomsView() {
    if (_selectedSymptoms.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Selected Symptoms',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          children: _selectedSymptoms.map((symptom) {
            return Chip(
              label: Text(symptom),
              deleteIcon: const Icon(Icons.close),
              onDeleted: () {
                setState(() {
                  _selectedSymptoms.remove(symptom);
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  // ================== TEXT FIELD ===================
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hintText,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  // ================== SUBMIT BUTTON ===================
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
  //             'Add Consultation',
  //             style: TextStyle(fontSize: 16),
  //           ),
  //   );
  // }
  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity, // Full-width button
      child: ElevatedButton(
        onPressed: _isLoading ? null : _submitForm,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, // Ensures text/icon color is white
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
                'Add Consultation',
                style: TextStyle(
                  fontSize: 16,
                  // color: Colors.white, // Not strictly needed if foregroundColor is set
                ),
              ),
      ),
    );
  }

  // ================== SUBMIT LOGIC ===================
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedSymptoms.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select at least one symptom')),
        );
        return;
      }

      setState(() => _isLoading = true);

      try {
        final request = ConsultationRequestBody(
          patientId: widget.patientId,
          doctorId: widget.doctorId,
          symptoms: _selectedSymptoms,
          diagnosis: _diagnosisController.text.trim(),
          prescription: _prescriptionController.text.trim(),
        );

        final response = await _repository.createConsultation(request: request);

        if (!mounted) return;

        if (response.isSuccess && response.data != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Consultation added successfully!')),
          );
          Navigator.pop(context, true);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(response.error ?? 'Failed to add consultation')),
          );
        }
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _diagnosisController.dispose();
    _prescriptionController.dispose();
    super.dispose();
  }
}
