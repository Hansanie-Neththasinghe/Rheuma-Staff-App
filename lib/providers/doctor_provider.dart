// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../models/doctor.dart';
// import '../services/api_service.dart';

// class DoctorProvider with ChangeNotifier{

//   Doctor? _doctor;
//   final ApiService _apiService = ApiService();

//   Doctor? get doctor => _doctor;

// //Login doctor
//   Future<String> login(String email, String password) async {
//     try {
//       final response = await _apiService.loginDoctor(email, password);

//       // Ensure that we check for '_id' instead of 'patientId'
//       final docId = response['id'] ?? response['_id'];

//       if (docId == null) {
//         throw Exception('No docId returned in the login response');
//       }

//       notifyListeners();
//       return docId;
//     } catch (error) {
//       print("Login error: $error");
//       throw error;
//     }
//   }

// Future<void> fetchPatient(String patientId) async {
//     try {
//       _patient = await _apiService.fetchPatientDetails(patientId);
//       notifyListeners();
//     } catch (error) {
//       print('Failed to fetch patient details: $error');
//     }
//   }



// }


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/doctor.dart';
import '../services/api_service.dart';
// import '../models/patient.dart'; // Import the patient model

class DoctorProvider with ChangeNotifier {
  Doctor? _doctor;
  final ApiService _apiService = ApiService();
  // List<Patient>? _patients; // A list to hold fetched patient details
  // Patient? _patient;
  Doctor? get doctor => _doctor;
  // List<Patient>? get patients => _patients; // Getter for patients

  // Login doctor
  Future<String> loginDoctor(String email, String password) async {
    try {
      final response = await _apiService.loginDoctor(email, password);

      // Ensure that we check for '_id' instead of 'patientId'
      final docId = response['id'] ?? response['_id'];

      _doctor = Doctor.fromJson(response);

      
      if (docId == null) {
        throw Exception('No docId returned in the login response');
      }

      notifyListeners();
      return docId;
    } catch (error) {
      print("Login error: $error");
      throw error;
    }
  }

Future<void> fetchDoctor(String docId) async {
    try {
      _doctor = await _apiService.fetchDoctorDetails(docId);
      notifyListeners();
    } catch (error) {
      print('Failed to fetch doctor details: $error');
    }
  }

Future<void> logoutDoctor(BuildContext context) async {
    try {
      // Clear the saved token from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');

      // Clear the patient data locally
      _doctor = null;
      notifyListeners();

      // Redirect to the login page
      Navigator.of(context).pushReplacementNamed('/initial');
    } catch (error) {
      print('Error logging out doctor: $error');
    }
  }
  
}
