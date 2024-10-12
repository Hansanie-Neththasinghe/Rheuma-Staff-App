// // import 'package:flutter/material.dart';

// // class InternLoginScreen extends StatelessWidget {
// //   const InternLoginScreen ({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return const Scaffold(
// //       body: SafeArea(
// //           child: Text("Intern login Screen"),
// //           ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/intern_provider.dart'; // Assuming you have InternProvider
// import '../screens/InternHomeScreen.dart'; // Assuming there's a home screen for interns
// import '../screens/InitialScreen.dart'; // Assuming the forgot password/registration is handled here

// class InternLoginScreen extends StatefulWidget {
//   const InternLoginScreen({super.key});

//   @override
//   _InternLoginScreenState createState() => _InternLoginScreenState();
// }

// class _InternLoginScreenState extends State<InternLoginScreen> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Intern Login')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: emailController,
//               decoration: const InputDecoration(labelText: 'Email'),
//             ),
//             TextField(
//               controller: passwordController,
//               decoration: const InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 final email = emailController.text;
//                 final password = passwordController.text;

//                 try {
//                   // Call the login method for interns and get internId from the response
//                   final internId = await context
//                       .read<InternProvider>()
//                       .loginIntern(email, password);

//                   // Fetch intern details using the internId
//                   await context.read<InternProvider>().fetchIntern(internId);

//                   // If mounted, navigate to InternHomeScreen
//                   if (mounted) {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(builder: (_) =>const InternHomescreen()),
//                     );
//                   }
//                 } catch (error) {
//                   if (mounted) {
//                     // Show error message if login fails
//                     showDialog(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                         title: const Text('Login Failed'),
//                         content: const Text('Please check your credentials.'),
//                         actions: <Widget>[
//                           TextButton(
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: const Text('OK'),
//                           )
//                         ],
//                       ),
//                     );
//                   }
//                 }
//               },
//               child: const Text('Login'),
//             ),
//             TextButton(
//               onPressed: () {
//                 // Navigate to the Forgot Password/InitialScreen
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (_) => InitialScreen()),
//                 );
//               },
//               child: const Text('Forgot Password'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/intern_provider.dart';
import '../screens/InternHomeScreen.dart';

class InternLoginScreen extends StatefulWidget {
  const InternLoginScreen({super.key});

  @override
  _InternLoginScreenState createState() => _InternLoginScreenState();
}

class _InternLoginScreenState extends State<InternLoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDAFDF9), // Background color
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Intern Login',
              style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontFamily: 'Serif',
              ),
            ),
            const SizedBox(height: 50),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'email',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'password',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                final email = emailController.text;
                final password = passwordController.text;

                try {
                  // Call the login method for interns and get internId from the response
                  final internId = await context
                      .read<InternProvider>()
                      .loginIntern(email, password);

                  // Fetch intern details using the internId
                  await context.read<InternProvider>().fetchIntern(internId);

                  // If mounted, navigate to InternHomeScreen
                  if (mounted) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const InternHomescreen()),
                    );
                  }
                } catch (error) {
                  if (mounted) {
                    // Show error message if login fails
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Login Failed'),
                        content: const Text('Please check your credentials.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          )
                        ],
                      ),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D597C), // Dark blue button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 80, vertical: 16), // Button size
              ),
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            // TextButton(
            //   onPressed: () {
            //     // Navigate to the Forgot Password/InitialScreen
            //     Navigator.pushReplacement(
            //       context,
            //       MaterialPageRoute(builder: (_) => InitialScreen()),
            //     );
            //   },
            //   child: const Text(
            //     '',
            //     style: TextStyle(
            //       fontSize: 16,
            //       color: Color(0xFF0D597C),
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
