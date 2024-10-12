// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:staff/screens/CreateAppointment.dart';
// import 'package:staff/screens/DoctorProfileScreen.dart';
// import 'package:staff/screens/InitialScreen.dart';
// import 'package:staff/screens/ViewAllPatients.dart';
// import '../providers/doctor_provider.dart'; // Import DoctorProvider
// import '../providers/appointment_provider.dart'; // Import AppointmentProvider
// import '../screens/PatientDetailsScreen.dart'; // Import the PatientDetailsScreen

// class DoctorHomeScreen extends StatefulWidget {
//   const DoctorHomeScreen({Key? key}) : super(key: key);

//   @override
//   _DoctorHomeScreenState createState() => _DoctorHomeScreenState();
// }

// class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
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
//     final doctorProvider = Provider.of<DoctorProvider>(context); // Get the DoctorProvider

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
//           )
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
//               leading: const Icon(Icons.person),
//               title: const Text(
//                 'Dashboard',
//                 style: TextStyle(fontSize: 23),
//               ),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const DoctorHomeScreen()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.logout),
//               title: const Text(
//                 'Profile',
//                 style: TextStyle(fontSize: 23),
//               ),
//               onTap: ()  {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const DoctorProfileScreen()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.logout),
//               title: const Text(
//                 'Patients',
//                 style: TextStyle(fontSize: 23),
//               ),
//               onTap: ()  {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const ViewAllPatients()),
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
//                 await context
//                     .read<DoctorProvider>()
//                     .logoutDoctor(context); // Use logout function
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
//               Consumer<DoctorProvider>(builder: (context, provider, child) {
//                 String doctorName = provider.doctor?.username ?? 'Doctor';
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Welcome back, $doctorName',
//                       style: const TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text('Date: ${_getCurrentDate()}'),
//                     Text('Time: ${_getCurrentTime()}'),
//                   ],
//                 );
//               }),

//               const SizedBox(height: 16),

//               // Patient List for Today with Scheduled Appointments
//               Text(
//                 'Patients with Appointments for Today',
//                 style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

//                   // Display the list of patients with today's appointments
//                   return ListView.builder(
//                     itemCount: provider.patientsWithAppointments!.length,
//                     itemBuilder: (context, index) {
//                       final patient = provider.patientsWithAppointments![index];
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
import 'package:staff/screens/DoctorProfileScreen.dart';
import 'package:staff/screens/InitialScreen.dart';
import 'package:staff/screens/ViewAllPatients.dart';
import 'package:staff/screens/information_hub_screen.dart';
import '../providers/doctor_provider.dart'; 
import '../providers/appointment_provider.dart'; 
import '../screens/PatientDetailsScreen.dart'; 

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({Key? key}) : super(key: key);

  @override
  _DoctorHomeScreenState createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchPatientsWithAppointments();
  }

  Future<void> fetchPatientsWithAppointments() async {
    final appointmentProvider = Provider.of<AppointmentProvider>(context, listen: false);
    await appointmentProvider.fetchPatientsWithAppointmentsForToday();
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
            onPressed: fetchPatientsWithAppointments,
          ),
        ],
      ),
      drawer: _buildDrawer(context),  // Refactored into a method for clarity
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section
              Consumer<DoctorProvider>(builder: (context, provider, child) {
                String doctorName = provider.doctor?.username ?? 'Doctor';
                return _buildWelcomeCard(doctorName, appointmentProvider.patientsWithAppointments?.length ?? 0);
              }),

              const SizedBox(height: 16),

              // Search Bar
              _buildSearchBar(),

              const SizedBox(height: 16),

              // Patient List for Today with Scheduled Appointments
              _buildSectionTitle("Today's Appointments"),
              const SizedBox(height: 8),

              Expanded(
                child: Consumer<AppointmentProvider>(builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (provider.patientsWithAppointments == null || provider.patientsWithAppointments!.isEmpty) {
                    return const Center(child: Text('No patients with scheduled appointments for today'));
                  }

                  final filteredPatients = provider.patientsWithAppointments!
                      .where((patient) => patient.name!.toLowerCase().contains(searchQuery))
                      .toList();

                  if (filteredPatients.isEmpty) {
                    return const Center(child: Text('No matching patients found'));
                  }

                  return ListView.builder(
                    itemCount: filteredPatients.length,
                    itemBuilder: (context, index) {
                      final patient = filteredPatients[index];
                      return _buildPatientCard(patient);
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

  // Drawer method for navigation
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueAccent,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildDrawerItem(context, Icons.dashboard, 'Dashboard', const DoctorHomeScreen()),
          _buildDrawerItem(context, Icons.person, 'Profile', const DoctorProfileScreen()),
          _buildDrawerItem(context, Icons.list, 'Patients', const ViewAllPatients()),
          _buildDrawerItem(context, Icons.document_scanner, 'Information Hub', const InformationHubScreen()),
          _buildDrawerItem(context, Icons.logout, 'Logout', InitialScreen(), logout: true),
        ],
      ),
    );
  }

  // Drawer item builder
  Widget _buildDrawerItem(BuildContext context, IconData icon, String title, Widget destination, {bool logout = false}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: const TextStyle(fontSize: 20),
      ),
      onTap: () async {
        if (logout) {
          await context.read<DoctorProvider>().logoutDoctor(context);
        }
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => destination),
        );
      },
    );
  }

  // Welcome card with doctor name and appointment count
  Widget _buildWelcomeCard(String doctorName, int totalAppointments) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome back,',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            Text(
              doctorName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueAccent),
            ),
            const SizedBox(height: 10),
            Text(
              'Date: ${_getCurrentDate()}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            Text(
              'Time: ${_getCurrentTime()}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Text(
              'Total Appointments: $totalAppointments',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  // Search bar
  Widget _buildSearchBar() {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Search patients',
        border: OutlineInputBorder(),
        suffixIcon: Icon(Icons.search),
      ),
      onChanged: (query) {
        setState(() {
          searchQuery = query.toLowerCase();
        });
      },
    );
  }

  // Section title
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueAccent),
    );
  }

  // Patient card for each appointment
  Widget _buildPatientCard(patient) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.person, color: Colors.white),
        ),
        title: Text(patient.name ?? 'No Name'),
        subtitle: Text('ID: ${patient.medicalId}'),
        trailing: ElevatedButton(
          onPressed: () {
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
            backgroundColor: Colors.blueAccent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('View'),
        ),
      ),
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

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// // import 'package:staff/screens/CreateAppointment.dart';
// import 'package:staff/screens/DoctorProfileScreen.dart';
// import 'package:staff/screens/InitialScreen.dart';
// import 'package:staff/screens/ViewAllPatients.dart';
// import 'package:staff/screens/information_hub_screen.dart';
// import '../providers/doctor_provider.dart'; // Import DoctorProvider
// import '../providers/appointment_provider.dart'; // Import AppointmentProvider
// import '../screens/PatientDetailsScreen.dart'; // Import the PatientDetailsScreen

// class DoctorHomeScreen extends StatefulWidget {
//   const DoctorHomeScreen({Key? key}) : super(key: key);

//   @override
//   _DoctorHomeScreenState createState() => _DoctorHomeScreenState();
// }

// class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
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
//     // final doctorProvider = Provider.of<DoctorProvider>(context); // Get the DoctorProvider

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
//               leading: const Icon(Icons.person),
//               title: const Text(
//                 'Dashboard',
//                 style: TextStyle(fontSize: 23),
//               ),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const DoctorHomeScreen()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.logout),
//               title: const Text(
//                 'Profile',
//                 style: TextStyle(fontSize: 23),
//               ),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const DoctorProfileScreen()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.logout),
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
//               leading: const Icon(Icons.logout),
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
//                 await context.read<DoctorProvider>().logoutDoctor(context); // Use logout function
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
//               Consumer<DoctorProvider>(builder: (context, provider, child) {
//                 String doctorName = provider.doctor?.username ?? 'Doctor';
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Welcome back, $doctorName',
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
//               Text(
//                 'Patients with Appointments for Today',
//                 style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
