// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:staff/providers/intern_provider.dart';
// import 'package:staff/screens/InitialScreen.dart';
// import 'package:staff/screens/InternHomeScreen.dart';
// import 'package:staff/screens/ViewAllPatients.dart';
// import 'package:staff/screens/information_hub_screen.dart';
// import '../models/intern.dart'; 

// class InternProfileScreen extends StatefulWidget {
//   const InternProfileScreen({super.key});

//   @override
//   State<InternProfileScreen> createState() => _InternProfileScreenState();
// }

// class _InternProfileScreenState extends State<InternProfileScreen> {
//   late Future<void> _fetchInternDetails;

//   @override
//   void initState() {
//     super.initState();
//     // Fetch intern details when the screen initializes
//     final internProvider = Provider.of<InternProvider>(context, listen: false);
//     _fetchInternDetails = internProvider.fetchIntern(internProvider.intern!.id);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final internProvider = Provider.of<InternProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Intern Profile"),
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
//         child: FutureBuilder(
//           future: _fetchInternDetails,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text("Error: ${snapshot.error}"));
//             } else {
//               Intern intern = internProvider.intern!;
//               return Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Name: ${intern.name}",
//                       style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 8),
//                     Text("Email: ${intern.email}"),
//                     Text("Username: ${intern.username}"),
//                     Text("Contact: ${intern.contact}"),
//                     Text("NIC: ${intern.nic}"),
//                     Text("Role: ${intern.role ?? 'N/A'}"),
//                     const SizedBox(height: 16),
//                     Text("Member Since: ${intern.createdAt ?? 'N/A'}"),
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
import 'package:staff/providers/intern_provider.dart';
import 'package:staff/screens/InitialScreen.dart';
import 'package:staff/screens/InternHomeScreen.dart';
import 'package:staff/screens/ViewAllPatients.dart';
import 'package:staff/screens/information_hub_screen.dart';
import '../models/intern.dart';

class InternProfileScreen extends StatefulWidget {
  const InternProfileScreen({super.key});

  @override
  State<InternProfileScreen> createState() => _InternProfileScreenState();
}

class _InternProfileScreenState extends State<InternProfileScreen> {
  late Future<void> _fetchInternDetails;

  @override
  void initState() {
    super.initState();
    // Fetch intern details when the screen initializes
    final internProvider = Provider.of<InternProvider>(context, listen: false);
    _fetchInternDetails = internProvider.fetchIntern(internProvider.intern!.id);
  }

  @override
  Widget build(BuildContext context) {
    final internProvider = Provider.of<InternProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Intern Profile"),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: _buildDrawer(context),
      body: SafeArea(
        child: FutureBuilder(
          future: _fetchInternDetails,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else {
              Intern intern = internProvider.intern!;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildProfileHeader(intern),
                      const SizedBox(height: 20),
                      // Profile Card
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
                              _buildProfileDetail("Email", intern.email, Icons.email),
                              const Divider(),
                              _buildProfileDetail("Username", intern.username, Icons.person),
                              const Divider(),
                              _buildProfileDetail("Contact", intern.contact, Icons.phone),
                              const Divider(),
                              _buildProfileDetail("NIC", intern.nic, Icons.credit_card),
                              const Divider(),
                              _buildProfileDetail("Role", intern.role ?? 'N/A', Icons.work),
                              const Divider(),
                              _buildProfileDetail(
                                "Member Since", 
                                intern.createdAt?.toString() ?? 'N/A', 
                                Icons.calendar_today,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32, 
                              vertical: 12,
                            ),
                            backgroundColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () async {
                            await context.read<InternProvider>().logoutIntern(context);
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => InitialScreen()),
                            );
                          },
                          icon: const Icon(Icons.logout),
                          label: const Text('Logout'),
                        ),
                      ),
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => const InternHomescreen()));
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.person,
            text: 'Profile',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const InternProfileScreen()));
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.list,
            text: 'Patients',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ViewAllPatients()));
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.document_scanner,
            text: 'Information Hub',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const InformationHubScreen()));
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.logout,
            text: 'Logout',
            onTap: () async {
              await context.read<InternProvider>().logoutIntern(context);
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
  Widget _buildDrawerItem(BuildContext context, {required IconData icon, required String text, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        text,
        style: const TextStyle(fontSize: 23),
      ),
      onTap: onTap,
    );
  }

  // Profile header with avatar
  Widget _buildProfileHeader(Intern intern) {
    return Row(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: const AssetImage('assets/default_profile.png'),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              intern.name,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              intern.role ?? 'N/A',
              style: const TextStyle(fontSize: 18, color: Colors.black54),
            ),
          ],
        ),
      ],
    );
  }

  // Profile detail row with icon
  Widget _buildProfileDetail(String label, String value, IconData icon) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(fontSize: 16, color: Colors.black54),
      ),
    );
  }
}
