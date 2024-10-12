// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/doctor_provider.dart'; // Ensure this is the correct path to your DoctorProvider
// import '../models/doctor.dart'; // Ensure this is the correct path to your Doctor model

// class DoctorProfileScreen extends StatefulWidget {
//   const DoctorProfileScreen({super.key});

//   @override
//   State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
// }

// class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
//   late Future<void> _fetchDoctorDetails;

//   @override
//   void initState() {
//     super.initState();
//     // Fetch doctor details when the screen initializes
//     final doctorProvider = Provider.of<DoctorProvider>(context, listen: false);
//     _fetchDoctorDetails = doctorProvider.fetchDoctor(doctorProvider.doctor!.id);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final doctorProvider = Provider.of<DoctorProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Doctor Profile"),
//       ),
//       body: SafeArea(
//         child: FutureBuilder(
//           future: _fetchDoctorDetails,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text("Error: ${snapshot.error}"));
//             } else {
//               // Assuming the doctor details are fetched correctly from the provider
//               Doctor doctor = doctorProvider.doctor!;
//               return Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Name: ${doctor.name}",
//                       style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 8),
//                     Text("Email: ${doctor.email}"),
//                     Text("Username: ${doctor.username}"),
//                     Text("Contact: ${doctor.contact}"),
//                     Text("NIC: ${doctor.nic}"),
//                     Text("Doctor ID: ${doctor.docId}"),
//                     Text("Role: ${doctor.role}"),
//                     const SizedBox(height: 16),
//                     Text("Member Since: ${doctor.createdAt}"),
//                     const SizedBox(height: 16),
                    
//                     // Add more details here if needed, e.g., appointments, medicalRecords, etc.
//                     const Text(
//                       "Appointments:",
//                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     doctor.appointments!.isEmpty
//                         ? const Text("No appointments available")
//                         : Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: doctor.appointments!
//                                 .map((appointment) => Text(appointment))
//                                 .toList(),
//                           ),
//                     const SizedBox(height: 16),
//                   ],
//                 ),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staff/screens/DoctorHomeScreen.dart';
import 'package:staff/screens/InitialScreen.dart';
import 'package:staff/screens/ViewAllPatients.dart';
import 'package:staff/screens/information_hub_screen.dart';
import '../providers/doctor_provider.dart'; // Import DoctorProvider
import '../models/doctor.dart'; // Import Doctor model

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({super.key});

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  late Future<void> _fetchDoctorDetails;

  @override
  void initState() {
    super.initState();
    // Fetch doctor details when the screen initializes
    final doctorProvider = Provider.of<DoctorProvider>(context, listen: false);
    _fetchDoctorDetails = doctorProvider.fetchDoctor(doctorProvider.doctor!.id);
  }

  @override
  Widget build(BuildContext context) {
    final doctorProvider = Provider.of<DoctorProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Doctor Profile"),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: _buildDrawer(context),
      body: SafeArea(
        child: FutureBuilder(
          future: _fetchDoctorDetails,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else {
              // Assuming the doctor details are fetched correctly from the provider
              Doctor doctor = doctorProvider.doctor!;

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildProfileCard(doctor),
                      const SizedBox(height: 20),
                      // _buildSectionTitle("Appointments"),
                      // const SizedBox(height: 10),
                    ],
                  ),
                ),
              );
            }
          },
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
          _buildDrawerItem(
            context,
            icon: Icons.dashboard,
            text: 'Dashboard',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DoctorHomeScreen()),
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
                MaterialPageRoute(builder: (context) => const DoctorProfileScreen()),
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
              await context.read<DoctorProvider>().logoutDoctor(context); // Use logout function
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
        style: const TextStyle(fontSize: 20),
      ),
      onTap: onTap,
    );
  }

  // Profile Section
  Widget _buildProfileCard(Doctor doctor) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blueAccent,
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            _buildProfileRow("Name", doctor.name),
            _buildProfileRow("Email", doctor.email),
            _buildProfileRow("Username", doctor.username),
            _buildProfileRow("Contact", doctor.contact),
            _buildProfileRow("NIC", doctor.nic),
            _buildProfileRow("Doctor ID", doctor.docId),
            _buildProfileRow("Role", doctor.role ?? 'N/A'),
            _buildProfileRow("Member Since", doctor.createdAt?.toString() ?? 'N/A'),
          ],
        ),
      ),
    );
  }

  // Build profile row for displaying doctor information
  Widget _buildProfileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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

  // Section title with styling
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueAccent),
    );
  }

  // Appointments section with cards
  // Widget _buildAppointmentSection(Doctor doctor) {
  //   if (doctor.appointments!.isEmpty) {
  //     return const Text("No appointments available");
  //   }

  //   return Column(
  //     children: doctor.appointments!.map((appointment) {
  //       return Card(
  //         elevation: 3,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //         child: ListTile(
  //           leading: Icon(Icons.calendar_today, color: Colors.blueAccent),
  //           title: Text(appointment),
  //           subtitle: const Text("Appointment details go here"),
  //         ),
  //       );
  //     }).toList(),
  //   );
  // }
}


// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:staff/screens/DoctorHomeScreen.dart';
// import 'package:staff/screens/InitialScreen.dart';
// import 'package:staff/screens/ViewAllPatients.dart';
// import 'package:staff/screens/information_hub_screen.dart';
// import '../providers/doctor_provider.dart'; // Ensure this is the correct path to your DoctorProvider
// import '../models/doctor.dart'; // Ensure this is the correct path to your Doctor model

// class DoctorProfileScreen extends StatefulWidget {
//   const DoctorProfileScreen({super.key});

//   @override
//   State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
// }

// class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
//   late Future<void> _fetchDoctorDetails;

//   @override
//   void initState() {
//     super.initState();
//     // Fetch doctor details when the screen initializes
//     final doctorProvider = Provider.of<DoctorProvider>(context, listen: false);
//     _fetchDoctorDetails = doctorProvider.fetchDoctor(doctorProvider.doctor!.id);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final doctorProvider = Provider.of<DoctorProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Doctor Profile"),
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
//                   MaterialPageRoute(builder: (context) => const DoctorHomeScreen()),
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
//                   MaterialPageRoute(builder: (context) => const DoctorProfileScreen()),
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
//         child: FutureBuilder(
//           future: _fetchDoctorDetails,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text("Error: ${snapshot.error}"));
//             } else {
//               // Assuming the doctor details are fetched correctly from the provider
//               Doctor doctor = doctorProvider.doctor!;

//               // Debugging logs
//               print('NIC: ${doctor.nic}, Contact: ${doctor.contact}, Role: ${doctor.role}');

//               return Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Name: ${doctor.name}",
//                       style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 8),
//                     Text("Email: ${doctor.email}"),
//                     Text("Username: ${doctor.username}"),
//                     Text("Contact: ${doctor.contact}"),
//                     Text("NIC: ${doctor.nic}"),
//                     Text("Doctor ID: ${doctor.docId}"),
//                     Text("Role: ${doctor.role ?? 'N/A'}"),
//                     const SizedBox(height: 16),
//                     Text("Member Since: ${doctor.createdAt ?? 'N/A'}"),
//                     const SizedBox(height: 16),
                    
//                     // Add more details here if needed, e.g., appointments, medicalRecords, etc.
//                     const Text(
//                       "Appointments:",
//                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     doctor.appointments!.isEmpty
//                         ? const Text("No appointments available")
//                         : Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: doctor.appointments!
//                                 .map((appointment) => Text(appointment))
//                                 .toList(),
//                           ),
//                     const SizedBox(height: 16),
//                   ],
//                 ),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
