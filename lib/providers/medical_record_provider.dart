// // medical_record_provider.dart

// import 'package:flutter/material.dart';
// import '../services/api_service.dart';
// // import '../models/medical_record.dart';

// class MedicalRecordProvider with ChangeNotifier {
//   final ApiService _apiService = ApiService();

//   Future<void> addMedicalRecord(
//     String photo,
//     String generatedBy,
//     String patientId,
//     DateTime date,
//   ) async {
//     await _apiService.addMedicalRecord(photo, generatedBy, patientId, date);
//     notifyListeners(); // Notify listeners if needed
//   }
// }


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/medical_record.dart';
import '../services/api_service.dart';

class MedicalRecordProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<MedicalRecord> _records = [];

  List<MedicalRecord> get records => _records;

  // Add a new medical record
  Future<void> addMedicalRecord(
    String description,
    String duration,
    List<String> medicines,
    String patientId,
    DateTime date,
  ) async {
    try {
      // Retrieve the logged-in doctor ID from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? doctorId = prefs.getString('_id');

      if (doctorId == null) {
        throw Exception("Doctor ID not found in SharedPreferences");
      }

      // Call the ApiService to add the record
      await _apiService.addRecord(
        description: description,
        duration: duration,
        medicines: medicines,
        date: date.toIso8601String(), // Convert the date to a proper format
        generatedBy: doctorId,
        patientId: patientId,
      );

      notifyListeners(); // Notify listeners after successful operation
    } catch (error) {
      // Handle the error and rethrow it
      throw Exception('Error adding medical record: $error');
    }
  }

  // Fetch all medical records
  Future<void> getAllRecords(String patientId) async {
    try {
      _records = await _apiService.getAllRecords(patientId);
      notifyListeners(); // Notify listeners when records are fetched
    } catch (error) {
      throw Exception('Error fetching medical records: $error');
    }
  }

  // Fetch a specific medical record by ID
  Future<MedicalRecord?> getRecordById(String id) async {
    try {
      return await _apiService.getRecordById(id);
    } catch (error) {
      throw Exception('Error fetching medical record by ID: $error');
    }
  }
}


// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:staff/models/doctor.dart';
// import '../models/medical_record.dart';
// import '../services/api_service.dart';
// import '../providers/doctor_provider.dart';


// class MedicalRecordProvider with ChangeNotifier {
//   final ApiService _apiService = ApiService();

//    Doctor? _doctor;
//   Doctor? get doctor => _doctor;

//   Future<void> addMedicalRecord(String photoUrl, String _id, String patientId, DateTime date) async {

//     SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.getString('_id');
      
//     final record = MedicalRecord(
//       id: '', //id: _doctor!.id, 
//       photo: photoUrl,
//       date: date,
//       generatedBy: _id,
//       patientId: patientId,
//     );

//     await _apiService.addMedicalRecord(record);
//     notifyListeners();
//   }
// }
