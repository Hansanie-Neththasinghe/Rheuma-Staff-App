import 'package:flutter/material.dart';
import '../models/patient.dart';
import '../services/api_service.dart';

class PatientProvider with ChangeNotifier {
  Patient? _patient;
  final ApiService _apiService = ApiService();

  Patient? get patient => _patient;
  List<Patient>? _patients; // A list to hold fetched patient details
  List<Patient>? get patients => _patients; // Getter for patients


  // Fetch a single patient by ID
  Future<void> fetchPatient(String patientId) async {
    try {
      _patient = await _apiService.fetchPatientDetails(patientId);
      notifyListeners();
    } catch (error) {
      print('Failed to fetch patient details: $error');
    }
  }

  //Fetch all patients
  Future<void> fetchAllPatients() async {
    try {
      _patients = await _apiService.fetchAllPatients(); // Fetch all patients from the API
      notifyListeners(); // Notify listeners to update UI
    } catch (error) {
      print('Failed to fetch patients: $error');
    }
  }


  //Get Patient With medical id
  Future<void> fetchPatientByMedicalId(String medicalId) async {
  try {
    _patient = await _apiService.fetchPatientByMedicalId(medicalId); // Use fetchPatientByMedicalId
    notifyListeners(); // Notify listeners to update the UI
  } catch (error) {
    print('Failed to fetch patient by medicalId: $error');
  }
}


}