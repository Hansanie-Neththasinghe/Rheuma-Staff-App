// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/patient_vitals_provider.dart'; // Import your PatientVitalProvider

// class ViewAllVitalsScreen extends StatefulWidget {
//   final String patientId; // Patient ID to filter records

//   const ViewAllVitalsScreen({super.key, required this.patientId});

//   @override
//   State<ViewAllVitalsScreen> createState() => _ViewAllVitalsScreenState();
// }

// class _ViewAllVitalsScreenState extends State<ViewAllVitalsScreen> {
//   bool _isLoading = true; // Loading state

//   @override
//   void initState() {
//     super.initState();
//     // Fetch vitals for the specific patient
//     final patientVitalProvider = Provider.of<PatientVitalProvider>(context, listen: false);
//     patientVitalProvider.getAllVitals(widget.patientId).then((_) {
//       setState(() {
//         _isLoading = false; // Set loading to false after data is fetched
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final vitals = Provider.of<PatientVitalProvider>(context).vitals; // Get vitals from provider

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Patient Vitals'),
//       ),
//       body: SafeArea(
//         child: _isLoading
//             ? const Center(child: CircularProgressIndicator()) // Show loading indicator
//             : vitals.isEmpty
//                 ? const Center(child: Text('No vitals found.')) // Handle empty records
//                 : ListView.builder(
//                     itemCount: vitals.length,
//                     itemBuilder: (context, index) {
//                       return Card(
//                         margin: const EdgeInsets.all(16.0),
//                         elevation: 4,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               // Display the Date
//                               Text(
//                                 "Date: ${vitals[index].date.toLocal()}".split(' ')[0],
//                                 style: const TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(height: 8),
//                               // Display the Time
//                               Text(
//                                 "Time: ${vitals[index].time}",
//                                 style: const TextStyle(fontSize: 16),
//                               ),
//                               const Divider(), // Divider to separate sections
//                               // Display the Weight
//                               Text(
//                                 "Weight: ${vitals[index].weight} kg",
//                                 style: const TextStyle(fontSize: 16),
//                               ),
//                               const SizedBox(height: 8),
//                               // Display the Temperature
//                               Text(
//                                 "Temperature: ${vitals[index].temperature} °C",
//                                 style: const TextStyle(fontSize: 16),
//                               ),
//                               const SizedBox(height: 8),
//                               // Display the Blood Pressure
//                               Text(
//                                 "Blood Pressure: ${vitals[index].bloodPressure}",
//                                 style: const TextStyle(fontSize: 16),
//                               ),
//                               const SizedBox(height: 8),
//                               // Display the Heart Rate
//                               Text(
//                                 "Heart Rate: ${vitals[index].heartRate} bpm",
//                                 style: const TextStyle(fontSize: 16),
//                               ),
//                               const SizedBox(height: 8),
//                               // Display the Respiratory Rate
//                               Text(
//                                 "Respiratory Rate: ${vitals[index].respiratoryRate} breaths/min",
//                                 style: const TextStyle(fontSize: 16),
//                               ),
//                               const SizedBox(height: 8),
//                               // Display the Oxygen Level
//                               Text(
//                                 "Oxygen Level: ${vitals[index].oxygenLevel} %",
//                                 style: const TextStyle(fontSize: 16),
//                               ),
//                               const SizedBox(height: 8),
//                               //Display the Examined By (Doctor/Intern)
//                               Text(
//                                 "Examined By: ${vitals[index].examinedBy.name}",
//                                 style: const TextStyle(fontSize: 16),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/patient_vitals_provider.dart'; // Import your PatientVitalProvider

class ViewAllVitalsScreen extends StatefulWidget {
  final String patientId; // Patient ID to filter records

  const ViewAllVitalsScreen({super.key, required this.patientId});

  @override
  State<ViewAllVitalsScreen> createState() => _ViewAllVitalsScreenState();
}

class _ViewAllVitalsScreenState extends State<ViewAllVitalsScreen> {
  bool _isLoading = true; // Loading state

  @override
  void initState() {
    super.initState();
    // Fetch vitals for the specific patient
    final patientVitalProvider =
        Provider.of<PatientVitalProvider>(context, listen: false);
    patientVitalProvider.getAllVitals(widget.patientId).then((_) {
      setState(() {
        // Sort the vitals in descending order by date
        patientVitalProvider.vitals.sort((a, b) => b.date.compareTo(a.date));
        _isLoading = false; // Set loading to false after data is fetched
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final vitals =
        Provider.of<PatientVitalProvider>(context).vitals; // Get vitals from provider

    return Scaffold(
      backgroundColor: const Color(0xFFDAFDF9), // Set background color to DAFDF9
      appBar: AppBar(
        title: const Text('Patient Vitals'),
        backgroundColor: Colors.blueAccent, // Blue color for app bar
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator()) // Show loading indicator
            : vitals.isEmpty
                ? const Center(child: Text('No vitals found.')) // Handle empty records
                : ListView.builder(
                    itemCount: vitals.length,
                    itemBuilder: (context, index) {
                      // Format the date for display
                      String formattedDate =
                          "${vitals[index].date.toLocal()}".split(' ')[0];
                      return Card(
                        margin: const EdgeInsets.all(16.0),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Display the Date with Blue font
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_today,
                                    color: Colors.blueAccent,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Date: $formattedDate",
                                    style: const TextStyle(
                                      fontSize: 20, // Increased font size
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueAccent, // Blue font color
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              // Display the Time with Blue font
                              Row(
                                children: [
                                  const Icon(
                                    Icons.access_time,
                                    color: Colors.blueAccent,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Time: ${vitals[index].time}",
                                    style: const TextStyle(
                                      fontSize: 20, // Increased font size
                                      color: Colors.blueAccent, // Blue font color
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(), // Divider to separate sections
                              const SizedBox(height: 8),
                              // Display the Weight
                              Row(
                                children: [
                                  const Icon(
                                    Icons.monitor_weight,
                                    color: Colors.blueAccent,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Weight: ${vitals[index].weight} kg",
                                    style: const TextStyle(
                                      fontSize: 18, // Increased font size
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              // Display the Temperature
                              Row(
                                children: [
                                  const Icon(
                                    Icons.thermostat,
                                    color: Colors.blueAccent,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Temperature: ${vitals[index].temperature} °C",
                                    style: const TextStyle(
                                      fontSize: 18, // Increased font size
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              // Display the Blood Pressure
                              Row(
                                children: [
                                  const Icon(
                                    Icons.favorite,
                                    color: Colors.blueAccent,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Blood Pressure: ${vitals[index].bloodPressure}",
                                    style: const TextStyle(
                                      fontSize: 18, // Increased font size
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              // Display the Heart Rate
                              Row(
                                children: [
                                  const Icon(
                                    Icons.favorite_border,
                                    color: Colors.blueAccent,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Heart Rate: ${vitals[index].heartRate} bpm",
                                    style: const TextStyle(
                                      fontSize: 18, // Increased font size
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              // Display the Respiratory Rate
                              Row(
                                children: [
                                  const Icon(
                                    Icons.air,
                                    color: Colors.blueAccent,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Respiratory Rate: ${vitals[index].respiratoryRate} breaths/min",
                                    style: const TextStyle(
                                      fontSize: 18, // Increased font size
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              // Display the Oxygen Level
                              Row(
                                children: [
                                  const Icon(
                                    Icons.local_fire_department,
                                    color: Colors.blueAccent,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Oxygen Level: ${vitals[index].oxygenLevel} %",
                                    style: const TextStyle(
                                      fontSize: 18, // Increased font size
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              //Display the Examined By (Doctor/Intern)
                              Row(
                                children: [
                                  const Icon(
                                    Icons.person,
                                    color: Colors.blueAccent,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Examined By: ${vitals[index].examinedBy.name}",
                                    style: const TextStyle(
                                      fontSize: 18, // Increased font size
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/patient_vitals_provider.dart'; // Import your PatientVitalProvider

// class ViewAllVitalsScreen extends StatefulWidget {
//   final String patientId; // Patient ID to filter records

//   const ViewAllVitalsScreen({super.key, required this.patientId});

//   @override
//   State<ViewAllVitalsScreen> createState() => _ViewAllVitalsScreenState();
// }

// class _ViewAllVitalsScreenState extends State<ViewAllVitalsScreen> {
//   bool _isLoading = true; // Loading state

//   @override
//   void initState() {
//     super.initState();
//     // Fetch vitals for the specific patient
//     final patientVitalProvider = Provider.of<PatientVitalProvider>(context, listen: false);
//     patientVitalProvider.getAllVitals(widget.patientId).then((_) {
//       setState(() {
//         // Sort the vitals in descending order by date
//         patientVitalProvider.vitals.sort((a, b) => b.date.compareTo(a.date));
//         _isLoading = false; // Set loading to false after data is fetched
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final vitals = Provider.of<PatientVitalProvider>(context).vitals; // Get vitals from provider

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Patient Vitals'),
//       ),
   
//       body: SafeArea(
//         child: _isLoading
//             ? const Center(child: CircularProgressIndicator()) // Show loading indicator
//             : vitals.isEmpty
//                 ? const Center(child: Text('No vitals found.')) // Handle empty records
//                 : ListView.builder(
//                     itemCount: vitals.length,
//                     itemBuilder: (context, index) {

//                       // Format the date for display
//                     String formattedDate = "${vitals[index].date.toLocal()}".split(' ')[0];
//                       return Card(
//                         margin: const EdgeInsets.all(16.0),
//                         elevation: 4,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               // Display the Date
//                               Text(
//                                 "Date: $formattedDate",
//                                 style: const TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(height: 8),
//                               // Display the Time
//                               Text(
//                                 "Time: ${vitals[index].time}",
//                                 style: const TextStyle(fontSize: 16),
//                               ),
//                               const Divider(), // Divider to separate sections
//                               // Display the Weight
//                               Text(
//                                 "Weight: ${vitals[index].weight} kg",
//                                 style: const TextStyle(fontSize: 16),
//                               ),
//                               const SizedBox(height: 8),
//                               // Display the Temperature
//                               Text(
//                                 "Temperature: ${vitals[index].temperature} °C",
//                                 style: const TextStyle(fontSize: 16),
//                               ),
//                               const SizedBox(height: 8),
//                               // Display the Blood Pressure
//                               Text(
//                                 "Blood Pressure: ${vitals[index].bloodPressure}",
//                                 style: const TextStyle(fontSize: 16),
//                               ),
//                               const SizedBox(height: 8),
//                               // Display the Heart Rate
//                               Text(
//                                 "Heart Rate: ${vitals[index].heartRate} bpm",
//                                 style: const TextStyle(fontSize: 16),
//                               ),
//                               const SizedBox(height: 8),
//                               // Display the Respiratory Rate
//                               Text(
//                                 "Respiratory Rate: ${vitals[index].respiratoryRate} breaths/min",
//                                 style: const TextStyle(fontSize: 16),
//                               ),
//                               const SizedBox(height: 8),
//                               // Display the Oxygen Level
//                               Text(
//                                 "Oxygen Level: ${vitals[index].oxygenLevel} %",
//                                 style: const TextStyle(fontSize: 16),
//                               ),
//                               const SizedBox(height: 8),
//                               //Display the Examined By (Doctor/Intern)
//                               Text(
//                                 "Examined By: ${vitals[index].examinedBy.name}",
//                                 style: const TextStyle(fontSize: 16),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//       ),
//     );
//   }
// }

