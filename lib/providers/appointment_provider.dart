// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../services/api_service.dart';
// import '../models/appointment.dart';

// class AppointmentProvider with ChangeNotifier {

//   Appointment? _appointment;
//   final ApiService _apiService = ApiService();
  
//   Appointment? get appointment => _appointment;

// Future<void> createAppointment({
//     required DateTime date,
//     required String time,
//     DateTime? nextAppDateTime,
//     DateTime? lastAppDateTime,
//     required String roomNo,
//     required String consultantId,
//     required String status,
//     required String patientId,
//     required List<String> patientVitals,
//     required List<String> medicalRecords,
//   }) async {
//     try {

//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? doctorId = prefs.getString('_id');

//       if (doctorId == null) {
//         throw Exception("Doctor ID not found in SharedPreferences");
//       }
//       await _apiService.addAppointment(
//         date: date,
//         time: time,
//         nextAppDateTime: nextAppDateTime,
//         lastAppDateTime: lastAppDateTime,
//         roomNo: roomNo,
//         consultantId: consultantId,
//         status: status,
//         patientId: patientId,
//         patientVitals: patientVitals,
//         medicalRecords: medicalRecords,
//       );
      
    
//       notifyListeners(); 
//     } catch (error) {
      
//       throw Exception('Error adding appointment: $error');
//     }
//   }

// }












import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:staff/models/patient.dart';
import '../services/api_service.dart';
import '../models/appointment.dart';

class AppointmentProvider with ChangeNotifier {
  Appointment? _appointment;
  final ApiService _apiService = ApiService();
  bool _isLoading = false;

   List<Appointment> _appointments = [];
  List<Appointment> get appointments => _appointments;
  

  Appointment? get appointment => _appointment;
  bool get isLoading => _isLoading;

  List<Patient>? _patientsWithAppointments; // Store patients with appointments
  List<Patient>? get patientsWithAppointments => _patientsWithAppointments; // Getter for patients



  Future<void> createAppointment(BuildContext context, {
    required DateTime date,
    required String time,
    DateTime? nextAppDateTime,
    DateTime? lastAppDateTime,
    required String roomNo,
    required String status,
    required String patientId,
    // required List<String> patientVitals,
    // required List<String> medicalRecords,
    // required String consultant,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? doctorId = prefs.getString('_id');
      
      // Retrieve consultant ID from SharedPreferences
      if (doctorId == null) {
        throw Exception("Doctor ID not found in SharedPreferences");
      }

      await _apiService.addAppointment(
        date: date,
        time: time,
        nextAppDateTime: nextAppDateTime,
        lastAppDateTime: lastAppDateTime,
        roomNo: roomNo,
        consultant: doctorId, // Use the doctorId as the consultant ID
        status: status,
        patientId: patientId,
        // patientVitals: patientVitals,
        // medicalRecords: medicalRecords,
      );

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      throw Exception('Error adding appointment: $error');
    }
  }

 

  // Method to fetch the last appointment by patient ID
  Future<void> fetchLastAppointmentByPatientId(String patientId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final fetchedAppointment = await _apiService.getLastAppointmentByPatientId(patientId);
      _appointment = fetchedAppointment;
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      throw Exception('Error fetching last appointment: $error');
    }
  }

  // Method to fetch the last scheduled appointment by patient ID
  Future<void> fetchLastScheduledAppointmentByPatientId(String patientId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final fetchedAppointment = await _apiService.getLastScheduledAppointmentByPatientId(patientId);
      _appointment = fetchedAppointment;
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      throw Exception('Error fetching last scheduled appointment: $error');
    }
  }

  // Method to fetch all scheduled appointments for today
  Future<void> fetchAppointmentsForToday() async {
    _isLoading = true;
    notifyListeners();

    try {
      final fetchedAppointments = await _apiService.getAppointmentsForTodayWithScheduledStatus();
      _appointments = fetchedAppointments;
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      throw Exception("Error fetching today's scheduled appointments: $error");
    }
  }


Future<void> fetchPatientsWithAppointmentsForToday() async {
    _isLoading = true;
    notifyListeners();

    try {
      _patientsWithAppointments = await _apiService.getPatientsWithAppointmentsForToday();
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      throw Exception('Error fetching patients with appointments: $error');
    }
  }





}


















// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../services/api_service.dart';
// import '../models/appointment.dart';

// class AppointmentProvider with ChangeNotifier {
//   Appointment? _appointment;
//   final ApiService _apiService = ApiService();
//   bool _isLoading = false;

//   Appointment? get appointment => _appointment;
//   bool get isLoading => _isLoading;

//   Future<void> createAppointment(BuildContext context, {
//     required DateTime date,
//     required String time,
//     DateTime? nextAppDateTime,
//     DateTime? lastAppDateTime,
//     required String roomNo,
//     required String consultantId,
//     required String status,
//     required String patientId,
//     required List<String> patientVitals,
//     required List<String> medicalRecords,
//   }) async {
//     _isLoading = true;
//     notifyListeners();

//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? doctorId = prefs.getString('_id');

//       if (doctorId == null) {
//         throw Exception("Doctor ID not found in SharedPreferences");
//       }

//       await _apiService.addAppointment(
//         date: date,
//         time: time,
//         nextAppDateTime: nextAppDateTime,
//         lastAppDateTime: lastAppDateTime,
//         roomNo: roomNo,
//         consultantId: consultantId,
//         status: status,
//         patientId: patientId,
//         patientVitals: patientVitals,
//         medicalRecords: medicalRecords,
//       );

//       _isLoading = false;
//       notifyListeners();
//     } catch (error) {
//       _isLoading = false;
//       notifyListeners();
//       throw Exception('Error adding appointment: $error');
//     }
//   }
// }
