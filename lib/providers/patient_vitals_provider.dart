import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:staff/models/patientVitals.dart';
import '../services/api_service.dart';

class PatientVitalProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<PatientVitals> _vitals = [];

  List<PatientVitals> get vitals => _vitals;

  // Add new patient vitals
  Future<void> addPatientVital({
    required double weight,
    required double temperature,
    required String bloodPressure,
    required int heartRate,
    required int respiratoryRate,
    required int oxygenLevel,
    required String patientId,
    required DateTime date,
  }) async {
    try {
      // Retrieve the logged-in intern ID from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // String? internId = prefs.getString('_id'); // Get the Intern ID

      // if (internId == null) {
      //   throw Exception("Intern ID not found in SharedPreferences");
      // }
      String? doctorId = prefs.getString('_id');

      if (doctorId == null) {
        throw Exception("Doctor ID not found in SharedPreferences");
      }


      // Call the ApiService to add the patient vitals
      await _apiService.addVital(
        weight: weight,
        temperature: temperature,
        bloodPressure: bloodPressure,
        heartRate: heartRate,
        respiratoryRate: respiratoryRate,
        oxygenLevel: oxygenLevel,
        examinedBy: doctorId,
        patientId: patientId,
        date: date.toIso8601String(), // Format the date properly
      );

      notifyListeners(); // Notify listeners after successful operation
    } catch (error) {
      throw Exception('Error adding patient vitals: $error');
    }
  }

  // Fetch all patient vitals for a given patient
  Future<void> getAllVitals(String patientId) async {
    try {
      _vitals = await _apiService.getAllVitals(patientId);
      notifyListeners(); // Notify listeners when vitals are fetched
    } catch (error) {
      throw Exception('Error fetching patient vitals: $error');
    }
  }

  // Fetch a specific patient vital record by ID
  Future<PatientVitals?> getVitalById(String id) async {
    try {
      return await _apiService.getVitalById(id);
    } catch (error) {
      throw Exception('Error fetching patient vital by ID: $error');
    }
  }
}
