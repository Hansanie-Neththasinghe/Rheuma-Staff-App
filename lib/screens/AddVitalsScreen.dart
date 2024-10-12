// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../providers/patient_vitals_provider.dart'; // Import your PatientVitalProvider
// // import 'package:intl/intl.dart'; // For date formatting

// class AddVitalsScreen extends StatefulWidget {
//   final String patientId; // Receive the patientId

//   const AddVitalsScreen({Key? key, required this.patientId}) : super(key: key);

//   @override
//   State<AddVitalsScreen> createState() => _AddVitalsScreenState();
// }

// class _AddVitalsScreenState extends State<AddVitalsScreen> {
//   final _formKey = GlobalKey<FormState>();

//   // Controllers for the vitals form fields
//   final TextEditingController _weightController = TextEditingController();
//   final TextEditingController _temperatureController = TextEditingController();
//   final TextEditingController _bloodPressureController = TextEditingController();
//   final TextEditingController _heartRateController = TextEditingController();
//   final TextEditingController _respiratoryRateController = TextEditingController();
//   final TextEditingController _oxygenLevelController = TextEditingController();

//   // Function to submit the form and add vitals
//   Future<void> _submitForm() async {
//     if (_formKey.currentState!.validate()) {
//       try {
//         // Retrieve the logged-in doctor ID from SharedPreferences
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? doctorId = prefs.getString('_id');

//       if (doctorId == null) {
//         throw Exception("Doctor ID not found in SharedPreferences");
//       }
//         // Get the provider and add vitals
//         await Provider.of<PatientVitalProvider>(context, listen: false)
//             .addPatientVital(
//           weight: double.parse(_weightController.text),
//           temperature: double.parse(_temperatureController.text),
//           bloodPressure: _bloodPressureController.text,
//           heartRate: int.parse(_heartRateController.text),
//           respiratoryRate: int.parse(_respiratoryRateController.text),
//           oxygenLevel: int.parse(_oxygenLevelController.text),
//           patientId: widget.patientId,
//           date: DateTime.now(), // Set the current date and time
//           // examinedBy: doctorId,
//         );
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Vitals added successfully')),
//         );
//         Navigator.pop(context); // Navigate back after submission
//       } catch (error) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error adding vitals: $error')),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Add Patient Vitals"),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   TextFormField(
//                     controller: _weightController,
//                     decoration: const InputDecoration(labelText: 'Weight (kg)'),
//                     keyboardType: TextInputType.number,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter weight';
//                       }
//                       return null;
//                     },
//                   ),
//                   TextFormField(
//                     controller: _temperatureController,
//                     decoration:
//                         const InputDecoration(labelText: 'Temperature (°C)'),
//                     keyboardType: TextInputType.number,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter temperature';
//                       }
//                       return null;
//                     },
//                   ),
//                   TextFormField(
//                     controller: _bloodPressureController,
//                     decoration: const InputDecoration(labelText: 'Blood Pressure'),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter blood pressure';
//                       }
//                       return null;
//                     },
//                   ),
//                   TextFormField(
//                     controller: _heartRateController,
//                     decoration: const InputDecoration(labelText: 'Heart Rate'),
//                     keyboardType: TextInputType.number,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter heart rate';
//                       }
//                       return null;
//                     },
//                   ),
//                   TextFormField(
//                     controller: _respiratoryRateController,
//                     decoration:
//                         const InputDecoration(labelText: 'Respiratory Rate'),
//                     keyboardType: TextInputType.number,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter respiratory rate';
//                       }
//                       return null;
//                     },
//                   ),
//                   TextFormField(
//                     controller: _oxygenLevelController,
//                     decoration:
//                         const InputDecoration(labelText: 'Oxygen Level (%)'),
//                     keyboardType: TextInputType.number,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter oxygen level';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: _submitForm,
//                     child: const Text('Submit'),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _weightController.dispose();
//     _temperatureController.dispose();
//     _bloodPressureController.dispose();
//     _heartRateController.dispose();
//     _respiratoryRateController.dispose();
//     _oxygenLevelController.dispose();
//     super.dispose();
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/patient_vitals_provider.dart';

class AddVitalsScreen extends StatefulWidget {
  final String patientId; 

  const AddVitalsScreen({Key? key, required this.patientId}) : super(key: key);

  @override
  State<AddVitalsScreen> createState() => _AddVitalsScreenState();
}

class _AddVitalsScreenState extends State<AddVitalsScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for the vitals form fields
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _temperatureController = TextEditingController();
  final TextEditingController _bloodPressureController = TextEditingController();
  final TextEditingController _heartRateController = TextEditingController();
  final TextEditingController _respiratoryRateController = TextEditingController();
  final TextEditingController _oxygenLevelController = TextEditingController();

  // Function to submit the form and add vitals
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? doctorId = prefs.getString('_id');

        if (doctorId == null) {
          throw Exception("Doctor ID not found in SharedPreferences");
        }

        await Provider.of<PatientVitalProvider>(context, listen: false).addPatientVital(
          weight: double.parse(_weightController.text),
          temperature: double.parse(_temperatureController.text),
          bloodPressure: _bloodPressureController.text,
          heartRate: int.parse(_heartRateController.text),
          respiratoryRate: int.parse(_respiratoryRateController.text),
          oxygenLevel: int.parse(_oxygenLevelController.text),
          patientId: widget.patientId,
          date: DateTime.now(), 
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Vitals added successfully')),
        );
        Navigator.pop(context); 
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding vitals: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Patient Vitals", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                _buildInputCard(
                  controller: _weightController,
                  label: 'Weight (kg)',
                  keyboardType: TextInputType.number,
                  icon: Icons.monitor_weight_outlined,
                ),
                const SizedBox(height: 16),
                _buildInputCard(
                  controller: _temperatureController,
                  label: 'Temperature (°C)',
                  keyboardType: TextInputType.number,
                  icon: Icons.thermostat_outlined,
                ),
                const SizedBox(height: 16),
                _buildInputCard(
                  controller: _bloodPressureController,
                  label: 'Blood Pressure',
                  keyboardType: TextInputType.text,
                  icon: Icons.favorite_border_outlined,
                ),
                const SizedBox(height: 16),
                _buildInputCard(
                  controller: _heartRateController,
                  label: 'Heart Rate',
                  keyboardType: TextInputType.number,
                  icon: Icons.favorite_outline,
                ),
                const SizedBox(height: 16),
                _buildInputCard(
                  controller: _respiratoryRateController,
                  label: 'Respiratory Rate',
                  keyboardType: TextInputType.number,
                  icon: Icons.air_outlined,
                ),
                const SizedBox(height: 16),
                _buildInputCard(
                  controller: _oxygenLevelController,
                  label: 'Oxygen Level (%)',
                  keyboardType: TextInputType.number,
                  icon: Icons.local_fire_department_outlined,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Custom input field in card style
  Widget _buildInputCard({
    required TextEditingController controller,
    required String label,
    required TextInputType keyboardType,
    required IconData icon,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon, color: Colors.blueAccent),
            border: InputBorder.none,
          ),
          keyboardType: keyboardType,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $label';
            }
            return null;
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _weightController.dispose();
    _temperatureController.dispose();
    _bloodPressureController.dispose();
    _heartRateController.dispose();
    _respiratoryRateController.dispose();
    _oxygenLevelController.dispose();
    super.dispose();
  }
}
