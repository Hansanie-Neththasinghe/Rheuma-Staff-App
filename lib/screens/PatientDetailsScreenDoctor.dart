import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staff/providers/doctor_provider.dart';
// import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'package:staff/screens/AddMedicalRecord.dart';
import 'package:staff/screens/DoctorHomeScreen.dart';
import 'package:staff/screens/DoctorProfileScreen.dart';
import 'package:staff/screens/InitialScreen.dart';
import 'package:staff/screens/ViewAllMedicalRecords.dart';
import 'package:staff/screens/ViewAllPatients.dart';
import 'package:staff/screens/information_hub_screen.dart';
import '../providers/patient_provider.dart';
import '../screens/AddVitalsScreen.dart';
import '../screens/ViewAllVitalsScreen.dart';

class PatientDetailsScreenDoctor extends StatefulWidget {
  final String name;
  final String medicalId;
  final String additionalInfo; // Optional

  const PatientDetailsScreenDoctor({
    super.key,
    required this.name,
    required this.medicalId,
    this.additionalInfo = '',
  });

  @override
  State<PatientDetailsScreenDoctor> createState() => _PatientDetailsScreenDoctorState();
}

class _PatientDetailsScreenDoctorState extends State<PatientDetailsScreenDoctor> {
  Future<void>? _patientFuture;
// Store the doctor ID

  @override
  void initState() {
    super.initState();
    _patientFuture = Provider.of<PatientProvider>(context, listen: false)
        .fetchPatientByMedicalId(widget.medicalId);
    _getDoctorId();
  }

  Future<void> _getDoctorId() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
// Ensure this key matches the one used during login
    });
  }

  @override
  Widget build(BuildContext context) {
    final patientProvider = Provider.of<PatientProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Details'),
        centerTitle: true, // Center the title for a clean look
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text(
                'Dashboard',
                style: TextStyle(fontSize: 23),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DoctorHomeScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text(
                'Profile',
                style: TextStyle(fontSize: 23),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DoctorProfileScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text(
                'Patients',
                style: TextStyle(fontSize: 23),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ViewAllPatients()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.document_scanner),
              title: const Text(
                'Information Hub',
                style: TextStyle(fontSize: 23),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const InformationHubScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text(
                'Logout',
                style: TextStyle(fontSize: 23),
              ),
              onTap: () async {
                await context.read<DoctorProvider>().logoutDoctor(context); // Use logout function
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => InitialScreen()),
                );
              },
            ),
          ],
        ),
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
                  Text(
                    patient.name ?? 'Unknown',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildPatientDetail('Medical ID', patient.medicalId),
                  _buildPatientDetail('Email', patient.email),
                  _buildPatientDetail('Age', patient.age?.toString() ?? 'N/A'),
                  _buildPatientDetail('Blood Type', patient.bloodType ?? 'Unknown'),
                  _buildPatientDetail('Rheumatic Type', patient.rheumaticType ?? 'N/A'),
                  _buildPatientDetail('Contact Number', patient.contactNumber ?? 'N/A'),
                  _buildPatientDetail('Member Since', patient.createdAt?.toString() ?? 'N/A'),
                  
                  const Divider(height: 32, thickness: 1, color: Colors.grey),

                  _buildButtonRow(context, 'Add New Record', 'View All Records', 
                    () => _navigateTo(context, AddMedicalRecord(patientId: patient.id)), 
                    () => _navigateTo(context, ViewAllMedicalRecords(patientId: patient.id))
                  ),
                  
                  const SizedBox(height: 16),
                  _buildButtonRow(context, 'Add Vitals', 'View All Vitals', 
                    () => _navigateTo(context, AddVitalsScreen(patientId: patient.id)), 
                    () => _navigateTo(context, ViewAllVitalsScreen(patientId: patient.id))
                  ),
                  
                  const SizedBox(height: 24),
                  // Center(
                  //   child: ElevatedButton.icon(
                  //     style: ElevatedButton.styleFrom(
                  //       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  //       backgroundColor: Colors.blueAccent,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(8),
                  //       ),
                  //     ),
                  //     onPressed: () => _navigateTo(context, CreateAppointmentPage(patientId: patient.id)),
                  //     icon: const Icon(Icons.calendar_today),
                  //     label: const Text('Create Appointment'),
                  //   ),
                  // ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPatientDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonRow(BuildContext context, String label1, String label2, 
      VoidCallback onPressed1, VoidCallback onPressed2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildActionButton(context, label1, onPressed1),
        _buildActionButton(context, label2, onPressed2),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        backgroundColor: Colors.lightBlueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(label, style: const TextStyle(fontSize: 14)),
    );
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
  }
}
