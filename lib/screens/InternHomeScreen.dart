// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:staff/screens/InternProfileScreen.dart';
// import 'package:staff/screens/InitialScreen.dart';
// import 'package:staff/screens/ViewAllPatients.dart';
// import 'package:staff/screens/information_hub_screen.dart';
// import '../providers/intern_provider.dart'; // Import InternProvider
// import '../providers/appointment_provider.dart'; // Import AppointmentProvider
// import '../screens/PatientDetailsScreen.dart'; // Import the PatientDetailsScreen

// class InternHomescreen extends StatefulWidget {
//   const InternHomescreen({super.key});

//   @override
//   _InternHomescreenState createState() => _InternHomescreenState();
// }

// class _InternHomescreenState extends State<InternHomescreen> {
//   String searchQuery = ''; // Variable to hold search query

//   @override
//   void initState() {
//     super.initState();
//     fetchPatientsWithAppointments(); // Fetch patients with appointments for today
//   }

//   Future<void> fetchPatientsWithAppointments() async {
//     final appointmentProvider = Provider.of<AppointmentProvider>(context, listen: false);
//     await appointmentProvider.fetchPatientsWithAppointmentsForToday(); // Fetch patients with today's scheduled appointments
//   }

//   @override
//   Widget build(BuildContext context) {
//     final appointmentProvider = Provider.of<AppointmentProvider>(context);
//     // final internProvider = Provider.of<InternProvider>(context); // Get the DoctorProvider

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Dashboard'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: () {
//               // Manually trigger a refresh of patients
//               fetchPatientsWithAppointments();
//             },
//           ),
//         ],
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             const DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//               ),
//               child: Text(
//                 'Menu',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 40,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.dashboard),
//               title: const Text(
//                 'Dashboard',
//                 style: TextStyle(fontSize: 23),
//               ),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const InternHomescreen()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.person),
//               title: const Text(
//                 'Profile',
//                 style: TextStyle(fontSize: 23),
//               ),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const InternProfileScreen()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.list),
//               title: const Text(
//                 'Patients',
//                 style: TextStyle(fontSize: 23),
//               ),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const ViewAllPatients()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.document_scanner),
//               title: const Text(
//                 'Information Hub',
//                 style: TextStyle(fontSize: 23),
//               ),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const InformationHubScreen()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.logout),
//               title: const Text(
//                 'Logout',
//                 style: TextStyle(fontSize: 23),
//               ),
//               onTap: () async {
//                 await context.read<InternProvider>().logoutIntern(context); // Use logout function
//                 Navigator.of(context).pushReplacement(
//                   MaterialPageRoute(builder: (context) => InitialScreen()),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Welcome Section with Doctor's Name
//               Consumer<InternProvider>(builder: (context, provider, child) {
//                 String internName = provider.intern!.name;
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Welcome back, $internName',
//                       style: const TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text('Date: ${_getCurrentDate()}'),
//                     Text('Time: ${_getCurrentTime()}'),

//                     // Display Total Number of Appointments
//                     Text(
//                       'Total Appointments: ${appointmentProvider.patientsWithAppointments?.length ?? 0}',
//                       style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 );
//               }),

//               const SizedBox(height: 16),

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

//               // Patient List for Today with Scheduled Appointments
//               const Text(
//                 "Today's Appointments",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 8),

//               Expanded(
//                 child: Consumer<AppointmentProvider>(builder: (context, provider, child) {
//                   if (provider.isLoading) {
//                     return const Center(child: CircularProgressIndicator());
//                   }

//                   if (provider.patientsWithAppointments == null || provider.patientsWithAppointments!.isEmpty) {
//                     return const Center(child: Text('No patients with scheduled appointments for today'));
//                   }

//                   // Display the list of patients with today's appointments filtered by search query
//                   final filteredPatients = provider.patientsWithAppointments!.where((patient) {
//                     return patient.name!.toLowerCase().contains(searchQuery);
//                   }).toList();

//                   if (filteredPatients.isEmpty) {
//                     return const Center(child: Text('No matching patients found'));
//                   }

//                   return ListView.builder(
//                     itemCount: filteredPatients.length,
//                     itemBuilder: (context, index) {
//                       final patient = filteredPatients[index];
//                       return ListTile(
//                         title: Text(patient.name ?? 'No Name'),
//                         subtitle: Text('ID: ${patient.medicalId}'),
//                         trailing: ElevatedButton(
//                           onPressed: () {
//                             // Navigate to the PatientDetailsScreen with patient data
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (_) => PatientDetailsScreen(
//                                   name: patient.name ?? 'No Name',
//                                   medicalId: patient.medicalId,
//                                   // Pass additional patient information as needed
//                                 ),
//                               ),
//                             );
//                           },
//                           child: const Text('View'),
//                         ),
//                       );
//                     },
//                   );
//                 }),
//               ),

//               // Special Notices Section
//               const Padding(
//                 padding: EdgeInsets.symmetric(vertical: 16.0),
//                 child: Text(
//                   'Special Notices',
//                   style: TextStyle(
//                     color: Colors.redAccent,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),

//               // Add more widgets or sections as needed
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Utility function to get the current date
//   String _getCurrentDate() {
//     final now = DateTime.now();
//     return '${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}';
//   }

//   // Utility function to get the current time
//   String _getCurrentTime() {
//     final now = DateTime.now();
//     return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
//   }
// }



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staff/screens/InternProfileScreen.dart';
import 'package:staff/screens/InitialScreen.dart';
import 'package:staff/screens/ViewAllPatients.dart';
import 'package:staff/screens/information_hub_screen.dart';
import '../providers/intern_provider.dart'; // Import InternProvider
import '../providers/appointment_provider.dart'; // Import AppointmentProvider
import '../screens/PatientDetailsScreen.dart'; // Import the PatientDetailsScreen

class InternHomescreen extends StatefulWidget {
  const InternHomescreen({super.key});

  @override
  _InternHomescreenState createState() => _InternHomescreenState();
}

class _InternHomescreenState extends State<InternHomescreen> {
  String searchQuery = ''; // Variable to hold search query

  @override
  void initState() {
    super.initState();
    fetchPatientsWithAppointments(); // Fetch patients with appointments for today
  }

  Future<void> fetchPatientsWithAppointments() async {
    final appointmentProvider =
        Provider.of<AppointmentProvider>(context, listen: false);
    await appointmentProvider
        .fetchPatientsWithAppointmentsForToday(); // Fetch patients with today's scheduled appointments
  }

  @override
  Widget build(BuildContext context) {
    final appointmentProvider = Provider.of<AppointmentProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Manually trigger a refresh of patients
              fetchPatientsWithAppointments();
            },
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section with Doctor's Name
              Consumer<InternProvider>(builder: (context, provider, child) {
                String internName = provider.intern!.name;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back, $internName',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, color: Colors.blueAccent),
                        const SizedBox(width: 5),
                        Text(
                          'Date: ${_getCurrentDate()}',
                          style: const TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.access_time, color: Colors.blueAccent),
                        const SizedBox(width: 5),
                        Text(
                          'Time: ${_getCurrentTime()}',
                          style: const TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Display Total Number of Appointments
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.assignment, color: Colors.blueAccent),
                          const SizedBox(width: 8),
                          Text(
                            'Total Appointments: ${appointmentProvider.patientsWithAppointments?.length ?? 0}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),

              const SizedBox(height: 16),

              // Search Bar
              TextField(
                decoration: InputDecoration(
                  labelText: 'Search patients',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  suffixIcon: const Icon(Icons.search),
                ),
                onChanged: (query) {
                  setState(() {
                    searchQuery = query.toLowerCase(); // Update search query
                  });
                },
              ),

              const SizedBox(height: 16),

              // Patient List for Today with Scheduled Appointments
              const Text(
                "Today's Appointments",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              Expanded(
                child: Consumer<AppointmentProvider>(
                    builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (provider.patientsWithAppointments == null ||
                      provider.patientsWithAppointments!.isEmpty) {
                    return const Center(
                        child:
                            Text('No patients with scheduled appointments'));
                  }

                  // Display the list of patients with today's appointments filtered by search query
                  final filteredPatients =
                      provider.patientsWithAppointments!.where((patient) {
                    return patient.name!.toLowerCase().contains(searchQuery);
                  }).toList();

                  if (filteredPatients.isEmpty) {
                    return const Center(child: Text('No matching patients found'));
                  }

                  return ListView.builder(
                    itemCount: filteredPatients.length,
                    itemBuilder: (context, index) {
                      final patient = filteredPatients[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            child: Text(
                              patient.name![0],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(patient.name ?? 'No Name'),
                          subtitle: Text('ID: ${patient.medicalId}'),
                          trailing: ElevatedButton(
                            onPressed: () {
                              // Navigate to the PatientDetailsScreen with patient data
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PatientDetailsScreen(
                                    name: patient.name ?? 'No Name',
                                    medicalId: patient.medicalId,
                                    // Pass additional patient information as needed
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                            ),
                            child: const Text('View'),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),

              // Special Notices Section
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Special Notices',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Drawer for navigation
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
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
          _buildDrawerItem(
            context,
            icon: Icons.dashboard,
            text: 'Dashboard',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const InternHomescreen()),
              );
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.person,
            text: 'Profile',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const InternProfileScreen()),
              );
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.list,
            text: 'Patients',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ViewAllPatients()),
              );
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.document_scanner,
            text: 'Information Hub',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const InformationHubScreen()),
              );
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.logout,
            text: 'Logout',
            onTap: () async {
              await context.read<InternProvider>().logoutIntern(context); // Use logout function
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => InitialScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  // Drawer Item Builder
  Widget _buildDrawerItem(BuildContext context,
      {required IconData icon, required String text, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        text,
        style: const TextStyle(fontSize: 23),
      ),
      onTap: onTap,
    );
  }

  // Utility function to get the current date
  String _getCurrentDate() {
    final now = DateTime.now();
    return '${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}';
  }

  // Utility function to get the current time
  String _getCurrentTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }
}
