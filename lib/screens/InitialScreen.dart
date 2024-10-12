import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../screens/DoctorLoginScreen.dart';
import '../screens/InternLoginScreen.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Upper section for doctors
            Expanded(
              child: Container(
                width: double.infinity, // Takes the full width of the screen
                color: const Color.fromARGB(255, 186, 228, 247), // Light color for the top section
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/intern.png', // Replace with your doctor image path
                      height: 100,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to DoctorLogin screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DoctorLoginScreen()),
                        );
                      },
                      child: const Text('For Doctors'),
                    ),
                  ],
                ),
              ),
            ),
            // Lower section for interns
            Expanded(
              child: Container(
                width: double.infinity, // Takes the full width of the screen
                color: const Color.fromARGB(255, 204, 245, 157), // Light color for the bottom section
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/intern.png', // Replace with your intern image path
                      height: 100,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to InternLogin screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  InternLoginScreen()),
                        );
                      },
                      child: const Text('For Interns'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

