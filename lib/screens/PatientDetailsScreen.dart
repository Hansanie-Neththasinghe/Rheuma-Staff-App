// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:staff/screens/AddMedicalRecord.dart';
// import 'package:staff/screens/ViewAllMedicalRecords.dart';
// import 'package:staff/screens/CreateAppointment.dart';
// import '../providers/patient_provider.dart';
// import '../screens/AddVitalsScreen.dart';
// import '../screens/ViewAllVitalsScreen.dart';

// class PatientDetailsScreen extends StatefulWidget {
//   final String name;
//   final String medicalId;
//   final String additionalInfo; // Optional

//   const PatientDetailsScreen({
//     super.key,
//     required this.name,
//     required this.medicalId,
//     this.additionalInfo = '',
//   });

//   @override
//   State<PatientDetailsScreen> createState() => _PatientDetailsScreenState();
// }

// class _PatientDetailsScreenState extends State<PatientDetailsScreen> {
//   Future<void>? _patientFuture;
// // Store the doctor ID

//   @override
//   void initState() {
//     super.initState();
//     _patientFuture = Provider.of<PatientProvider>(context, listen: false)
//         .fetchPatientByMedicalId(widget.medicalId);
//     _getDoctorId();
//   }

//   Future<void> _getDoctorId() async {
//     // SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
// // Ensure this key matches the one used during login
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final patientProvider = Provider.of<PatientProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Patient Details'),
//         centerTitle: true, // Center the title for a clean look
//       ),
      
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: FutureBuilder(
//           future: _patientFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}'));
//             }

//             final patient = patientProvider.patient;

//             if (patient == null) {
//               return const Center(
//                 child: Text('No patient data found', style: TextStyle(fontSize: 18)),
//               );
//             }

//             return SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     patient.name ?? 'Unknown',
//                     style: const TextStyle(
//                       fontSize: 26,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   _buildPatientDetail('Medical ID', patient.medicalId),
//                   _buildPatientDetail('Email', patient.email),
//                   _buildPatientDetail('Age', patient.age?.toString() ?? 'N/A'),
//                   _buildPatientDetail('Blood Type', patient.bloodType ?? 'Unknown'),
//                   _buildPatientDetail('Rheumatic Type', patient.rheumaticType ?? 'N/A'),
//                   _buildPatientDetail('Contact Number', patient.contactNumber ?? 'N/A'),
//                   _buildPatientDetail('Member Since', patient.createdAt?.toString() ?? 'N/A'),
                  
//                   const Divider(height: 32, thickness: 1, color: Colors.grey),

//                   _buildButtonRow(context, 'Add New Record', 'View All Records', 
//                     () => _navigateTo(context, AddMedicalRecord(patientId: patient.id)), 
//                     () => _navigateTo(context, ViewAllMedicalRecords(patientId: patient.id))
//                   ),
                  
//                   const SizedBox(height: 16),
//                   _buildButtonRow(context, 'Add Vitals', 'View All Vitals', 
//                     () => _navigateTo(context, AddVitalsScreen(patientId: patient.id)), 
//                     () => _navigateTo(context, ViewAllVitalsScreen(patientId: patient.id))
//                   ),
                  
//                   const SizedBox(height: 24),
//                   Center(
//                     child: ElevatedButton.icon(
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                         backgroundColor: Colors.blueAccent,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       onPressed: () => _navigateTo(context, CreateAppointmentPage(patientId: patient.id)),
//                       icon: const Icon(Icons.calendar_today),
//                       label: const Text('Create Appointment'),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildPatientDetail(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         children: [
//           Text(
//             '$label: ',
//             style: const TextStyle(
//               fontWeight: FontWeight.w600,
//               fontSize: 16,
//               color: Colors.black87,
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: const TextStyle(fontSize: 16, color: Colors.black54),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildButtonRow(BuildContext context, String label1, String label2, 
//       VoidCallback onPressed1, VoidCallback onPressed2) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         _buildActionButton(context, label1, onPressed1),
//         _buildActionButton(context, label2, onPressed2),
//       ],
//     );
//   }

//   Widget _buildActionButton(BuildContext context, String label, VoidCallback onPressed) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//         backgroundColor: Colors.lightBlueAccent,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//       ),
//       child: Text(label, style: const TextStyle(fontSize: 14)),
//     );
//   }

//   void _navigateTo(BuildContext context, Widget screen) {
//     Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/patient_provider.dart'; // Adjust import as necessary
import '../screens/AddMedicalRecord.dart';
import '../screens/ViewAllMedicalRecords.dart';
import '../screens/AddVitalsScreen.dart';
import '../screens/ViewAllVitalsScreen.dart';
import '../screens/CreateAppointment.dart';

class PatientDetailsScreen extends StatefulWidget {
  final String name;
  final String medicalId;
  final String additionalInfo; // Optional

  const PatientDetailsScreen({
    super.key,
    required this.name,
    required this.medicalId,
    this.additionalInfo = '',
  });

  @override
  State<PatientDetailsScreen> createState() => _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends State<PatientDetailsScreen> {
  Future<void>? _patientFuture;

  @override
  void initState() {
    super.initState();
    _patientFuture = Provider.of<PatientProvider>(context, listen: false)
        .fetchPatientByMedicalId(widget.medicalId);
  }

  @override
  Widget build(BuildContext context) {
    final patientProvider = Provider.of<PatientProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Details'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true, // Center the title for a clean look
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: _patientFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final patient = patientProvider.patient;

            if (patient == null) {
              return const Center(
                child: Text('No patient data found', style: TextStyle(fontSize: 18)),
              );
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Patient Profile Card
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildPatientHeader(patient),
                          const SizedBox(height: 16),
                          _buildPatientDetail('Medical ID', patient.medicalId, Icons.perm_identity),
                          _buildPatientDetail('Email', patient.email, Icons.email),
                          _buildPatientDetail('Age', patient.age?.toString() ?? 'N/A', Icons.cake),
                          _buildPatientDetail('Blood Type', patient.bloodType ?? 'Unknown', Icons.bloodtype),
                          _buildPatientDetail('Rheumatic Type', patient.rheumaticType ?? 'N/A', Icons.spa),
                          _buildPatientDetail('Contact Number', patient.contactNumber ?? 'N/A', Icons.phone),
                          _buildPatientDetail('Member Since', patient.createdAt?.toString() ?? 'N/A', Icons.calendar_today),
                        ],
                      ),
                    ),
                  ),
                  const Divider(height: 32, thickness: 1, color: Colors.grey),

                  // Button Row 1: Add New Record & View All Records
                  _buildButtonRow(context, 'Add New Record', 'View All Records',
                      () => _navigateTo(context, AddMedicalRecord(patientId: patient.id)),
                      () => _navigateTo(context, ViewAllMedicalRecords(patientId: patient.id))),

                  const SizedBox(height: 16),
                  // Button Row 2: Add Vitals & View All Vitals
                  _buildButtonRow(context, 'Add Vitals', 'View All Vitals',
                      () => _navigateTo(context, AddVitalsScreen(patientId: patient.id)),
                      () => _navigateTo(context, ViewAllVitalsScreen(patientId: patient.id))),

                  const SizedBox(height: 24),
                  // Create Appointment Button
                  Center(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => _navigateTo(context, CreateAppointmentPage(patientId: patient.id)),
                      icon: const Icon(Icons.calendar_today),
                      label: const Text('Create Appointment'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPatientHeader(patient) {
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: const AssetImage('assets/default_profile.png'),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              patient.name ?? 'Unknown',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Medical ID: ${patient.medicalId}',
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPatientDetail(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '$label: $value',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonRow(BuildContext context, String label1, String label2, VoidCallback onPressed1, VoidCallback onPressed2) {
    return Column(
      children: [
        _buildFullWidthButton(context, label1, onPressed1),
        const SizedBox(height: 10),
        _buildFullWidthButton(context, label2, onPressed2),
      ],
    );
  }

  Widget _buildFullWidthButton(BuildContext context, String label, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          backgroundColor: Colors.lightBlueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(label, style: const TextStyle(fontSize: 16)),
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
  }
}
