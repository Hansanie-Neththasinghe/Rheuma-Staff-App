// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/patient_provider.dart'; // Adjust the import based on your folder structure
// import '../screens/PatientDetailsScreen.dart'; // Adjust the import for the PatientDetailsScreen

// class ViewAllPatients extends StatefulWidget {
//   const ViewAllPatients({super.key});

//   @override
//   State<ViewAllPatients> createState() => _ViewAllPatientsState();
// }

// class _ViewAllPatientsState extends State<ViewAllPatients> {
//   String searchQuery = '';

//   @override
//   void initState() {
//     super.initState();
//     // Fetch all patients when the widget is initialized
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final patientProvider = Provider.of<PatientProvider>(context, listen: false);
//       patientProvider.fetchAllPatients();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final patientProvider = Provider.of<PatientProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('All Patients'),
//       ),
     
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Search Bar
//               TextField(
//                 decoration: const InputDecoration(
//                   labelText: 'Search patients',
//                   border: OutlineInputBorder(),
//                   suffixIcon: Icon(Icons.search),
//                 ),
//                 onChanged: (query) {
//                   setState(() {
//                     searchQuery = query.toLowerCase(); // Update search query
//                   });
//                 },
//               ),

//               const SizedBox(height: 16),

//               // Patient List
//               Expanded(
//                 child: Consumer<PatientProvider>(
//                   builder: (context, provider, child) {
//                     if (provider.patients == null) {
//                       return const Center(child: CircularProgressIndicator());
//                     }

//                     // Filter patients based on the search query
//                     final filteredPatients = provider.patients!.where((patient) {
//                       return patient.name!.toLowerCase().contains(searchQuery);
//                     }).toList();

//                     if (filteredPatients.isEmpty) {
//                       return const Center(child: Text('No patients found'));
//                     }

//                     // Display the list of patients
//                     return ListView.builder(
//                       itemCount: filteredPatients.length,
//                       itemBuilder: (context, index) {
//                         final patient = filteredPatients[index];
//                         return ListTile(
//                           title: Text(patient.name ?? 'No Name'),
//                           subtitle: Text('ID: ${patient.medicalId}'),
//                           trailing: ElevatedButton(
//                             onPressed: () {
//                               // Navigate to the PatientDetailsScreen with patient data
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (_) => PatientDetailsScreen(
//                                     name: patient.name ?? 'No Name',
//                                     medicalId: patient.medicalId,
//                                     // Pass additional patient information as needed
//                                   ),
//                                 ),
//                               );
//                             },
//                             child: const Text('View'),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/patient_provider.dart'; // Adjust the import based on your folder structure
import '../screens/PatientDetailsScreen.dart'; // Adjust the import for the PatientDetailsScreen

class ViewAllPatients extends StatefulWidget {
  const ViewAllPatients({super.key});

  @override
  State<ViewAllPatients> createState() => _ViewAllPatientsState();
}

class _ViewAllPatientsState extends State<ViewAllPatients> {
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Fetch all patients when the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final patientProvider = Provider.of<PatientProvider>(context, listen: false);
      patientProvider.fetchAllPatients();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Patients'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              TextField(
                decoration: InputDecoration(
                  labelText: 'Search patients',
                  labelStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  suffixIcon: Icon(Icons.search, color: Colors.blueAccent),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                onChanged: (query) {
                  setState(() {
                    searchQuery = query.toLowerCase(); // Update search query
                  });
                },
              ),
              const SizedBox(height: 16),

              // Patient List
              Expanded(
                child: Consumer<PatientProvider>(
                  builder: (context, provider, child) {
                    if (provider.patients == null) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    // Filter patients based on the search query
                    final filteredPatients = provider.patients!.where((patient) {
                      return patient.name!.toLowerCase().contains(searchQuery);
                    }).toList();

                    if (filteredPatients.isEmpty) {
                      return const Center(child: Text('No patients found', style: TextStyle(fontSize: 18)));
                    }

                    // Display the list of patients in a Card layout
                    return ListView.builder(
                      itemCount: filteredPatients.length,
                      itemBuilder: (context, index) {
                        final patient = filteredPatients[index];
                        return Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16.0),
                            leading: CircleAvatar(
                              backgroundColor: Colors.blueAccent,
                              child: const Icon(Icons.person, color: Colors.white),
                            ),
                            title: Text(
                              patient.name ?? 'No Name',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text('ID: ${patient.medicalId}', style: const TextStyle(color: Colors.grey)),
                            trailing: ElevatedButton(
                              onPressed: () {
                                // Navigate to the PatientDetailsScreen with patient data
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => PatientDetailsScreen(
                                      name: patient.name ?? 'No Name',
                                      medicalId: patient.medicalId,
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                                backgroundColor: Colors.blueAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text('View', style: TextStyle(fontSize: 16)),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/patient_provider.dart'; // Adjust the import based on your folder structure
// import '../screens/PatientDetailsScreen.dart'; // Adjust the import for the PatientDetailsScreen

// class ViewAllPatients extends StatefulWidget {
//   const ViewAllPatients({super.key});

//   @override
//   State<ViewAllPatients> createState() => _ViewAllPatientsState();
// }

// class _ViewAllPatientsState extends State<ViewAllPatients> {
//   String searchQuery = '';

//   @override
//   void initState() {
//     super.initState();
//     // Fetch all patients when the widget is initialized
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final patientProvider = Provider.of<PatientProvider>(context, listen: false);
//       patientProvider.fetchAllPatients();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('All Patients'),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Search Bar
//               TextField(
//                 decoration: const InputDecoration(
//                   labelText: 'Search patients',
//                   border: OutlineInputBorder(),
//                   suffixIcon: Icon(Icons.search),
//                 ),
//                 onChanged: (query) {
//                   setState(() {
//                     searchQuery = query.toLowerCase(); // Update search query
//                   });
//                 },
//               ),
//               const SizedBox(height: 16),

//               // Patient List with proper error handling
//               Expanded(
//                 child: Consumer<PatientProvider>(
//                   builder: (context, provider, child) {
//                     // Handle loading state
//                     if (provider.patients == null) {
//                       return const Center(child: CircularProgressIndicator());
//                     }

//                     // Handle the case where the patient list is empty
//                     if (provider.patients!.isEmpty) {
//                       return const Center(
//                         child: Text(
//                           'No patients found',
//                           style: TextStyle(fontSize: 18),
//                         ),
//                       );
//                     }

//                     // Filter patients based on the search query
//                     final filteredPatients = provider.patients!.where((patient) {
//                       return patient.name!.toLowerCase().contains(searchQuery);
//                     }).toList();

//                     // Handle the case where the filtered list is empty
//                     if (filteredPatients.isEmpty && searchQuery.isNotEmpty) {
//                       return const Center(
//                         child: Text(
//                           'No matching patients found',
//                           style: TextStyle(fontSize: 18),
//                         ),
//                       );
//                     }

//                     // Display the list of patients in scrollable view
//                     return SingleChildScrollView(
//                       child: Column(
//                         children: filteredPatients.map((patient) {
//                           return Card(
//                             elevation: 4,
//                             margin: const EdgeInsets.symmetric(vertical: 10),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(16.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       CircleAvatar(
//                                         radius: 30,
//                                         backgroundColor: Colors.blueAccent,
//                                         child: Text(
//                                           patient.name![0].toUpperCase(),
//                                           style: const TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 24,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ),
//                                       const SizedBox(width: 16),
//                                       Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             patient.name ?? 'No Name',
//                                             style: const TextStyle(
//                                               fontSize: 18,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                           const SizedBox(height: 5),
//                                           Text(
//                                             'ID: ${patient.medicalId}',
//                                             style: const TextStyle(
//                                               fontSize: 14,
//                                               color: Colors.grey,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 16),
//                                   Align(
//                                     alignment: Alignment.centerRight,
//                                     child: ElevatedButton(
//                                       onPressed: () {
//                                         // Navigate to the PatientDetailsScreen with patient data
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (_) => PatientDetailsScreen(
//                                               name: patient.name ?? 'No Name',
//                                               medicalId: patient.medicalId,
//                                             ),
//                                           ),
//                                         );
//                                       },
//                                       style: ElevatedButton.styleFrom(
//                                         backgroundColor: Colors.blueAccent,
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.circular(10),
//                                         ),
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 20, vertical: 12),
//                                       ),
//                                       child: const Text(
//                                         'View',
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         }).toList(),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
