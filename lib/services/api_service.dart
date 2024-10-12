import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:staff/models/appointment.dart';
import 'package:staff/models/doctor.dart';
import 'package:staff/models/info_hub.dart';
import 'package:staff/models/intern.dart';
import 'package:staff/models/medical_record.dart';
import 'package:staff/models/patientVitals.dart';
// import '../models/doctor.dart';
import '../models/patient.dart';
// import '../models/intern.dart';


class ApiService {
  // final String baseUrl = 'http://192.168.8.120:3001/api';
  final String baseUrl = 'https://rheuma-bakend-git-main-hansanis-projects.vercel.app/api';

  //Login a doctor
  Future<Map<String, dynamic>> loginDoctor(
    String email, String password) async {
  final response = await http.post(
    Uri.parse('$baseUrl/doctors/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: jsonEncode(<String, String>{'email': email, 'password': password}),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', data['token']); // Save token locally
    prefs.setString('_id', data['_id']);
    return data; // Return the entire response body
  } else {
    throw Exception('Failed to login: ${response.statusCode}');
  }
}





//Logout doctor
Future<void> logoutDoctor() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Remove the stored token
  bool result = await prefs.remove('token');

  if (result) {
    print("Token removed successfully. Doctor logged out.");
  } else {
    throw Exception("Failed to remove token.");
  }
}

//Fetch doctor details
// Future<Doctor> fetchDoctorDetails(String id) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('token');

//     final response = await http.get(
//       Uri.parse('$baseUrl/doctors/$id'),
//       headers: {'Authorization': 'Bearer $token'},
//     );

//     if (response.statusCode == 200) {
//       return Doctor.fromJson(jsonDecode(response.body)['doctor']);
//     } else {
//       throw Exception('Failed to load doctor details');
//     }
//   }


Future<Doctor> fetchDoctorDetails(String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  final response = await http.get(
    Uri.parse('$baseUrl/doctors/$id'),
    headers: {'Authorization': 'Bearer $token'},
  );

  if (response.statusCode == 200) {
    // return Doctor.fromJson(jsonDecode(response.body)['doctor']);
    return Doctor.fromJson(jsonDecode(response.body));
  } else {
    // Log the error response for debugging
    print('Error fetching doctor details: ${response.statusCode} - ${response.body}');
    throw Exception('Failed to load doctor details');
  }
}


// =======================
// MEDICAL INTERN RELATED
// =======================


//Login Intern
Future<Map<String, dynamic>> loginIntern(
    String email, String password) async {
  final response = await http.post(
    Uri.parse('$baseUrl/interns/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: jsonEncode(<String, String>{'email': email, 'password': password}),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', data['token']); // Save token locally
    // prefs.setString('_id', data['_id']);
    return data; // Return the entire response body
  } else {
    throw Exception('Failed to login: ${response.statusCode}');
  }
}

//Fetch intern details
Future<Intern> fetchInternDetails(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    
    final response = await http.get(
      Uri.parse('$baseUrl/interns/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return Intern.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load intern details');
    }
  }

//Logout intern
Future<void> logoutIntern() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Remove the stored token
  bool result = await prefs.remove('token');

  if (result) {
    print("Token removed successfully. Intern logged out.");
  } else {
    throw Exception("Failed to remove token.");
  }
}


// =======================
// PATIENT RELATED
// =======================


//Fetch patient details
 Future<Patient> fetchPatientDetails(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('$baseUrl/patients/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return Patient.fromJson(jsonDecode(response.body)['patient']);
    } else {
      throw Exception('Failed to load patient details');
    }
  }

// Fetch all patients
Future<List<Patient>> fetchAllPatients() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  final response = await http.get(
    Uri.parse('$baseUrl/patients/all'), // Assuming this is the endpoint for fetching all patients
    headers: {'Authorization': 'Bearer $token'},
  );

  if (response.statusCode == 200) {
    // Parse the response body to get the list of patients
    List<dynamic> patientsJson = jsonDecode(response.body)['patients'];
    
    // Map the JSON data to a list of Patient objects
    List<Patient> patients = patientsJson.map((json) => Patient.fromJson(json)).toList();

    return patients;
  } else {
    throw Exception('Failed to load patients');
  }
}

//Get patient by medical id
Future<Patient> fetchPatientByMedicalId(String medicalId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  final response = await http.get(
    Uri.parse('$baseUrl/patients/medicalId/$medicalId'), // Using medicalId in the URL
    headers: {'Authorization': 'Bearer $token'},
  );

  if (response.statusCode == 200) {
    return Patient.fromJson(jsonDecode(response.body)['patient']);
  } else {
    throw Exception('Failed to load patient by medicalId');
  }
}


// =======================
// MEDICAL RECORD RELATED
// =======================

// Method to get all medical records
  // Future<List<MedicalRecord>> getAllRecordsold() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString('token');

  //   final url = Uri.parse('$baseUrl/medicalRecords/get-all-records');
  //   try {
  //     final response = await http.get(
  //       url,
  //       headers: {'Authorization': 'Bearer $token'}, // Include the token in the headers
  //     );

  //     if (response.statusCode == 200) {
  //       List<dynamic> data = jsonDecode(response.body);
  //       return data.map((record) => MedicalRecord.fromJson(record)).toList();
  //     } else {
  //       throw Exception('Failed to load medical records');
  //     }
  //   } catch (error) {
  //     rethrow;
  //   }
  // }

  Future<List<MedicalRecord>> getAllRecords(String patientId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  // Update the URL to include the patientId
  final url = Uri.parse('$baseUrl/medicalRecords/get-all-records/$patientId'); // Use the patientId in the URL
  try {
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'}, // Include the token in the headers
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((record) => MedicalRecord.fromJson(record)).toList();
    } else {
      throw Exception('Failed to load medical records');
    }
  } catch (error) {
    rethrow;
  }
}


  // Method to get a specific medical record by ID
  Future<MedicalRecord> getRecordById(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final url = Uri.parse('$baseUrl/medicalRecords/get-record/$id');
    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'}, // Include the token in the headers
      );

      if (response.statusCode == 200) {
        return MedicalRecord.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Record not found');
      }
    } catch (error) {
      rethrow;
    }
  }

  // Method to add a new medical record
  Future<void> addRecord({
    required String description,
    required String duration,
    required List<String> medicines,
    required String date,
    required String generatedBy,
    required String patientId,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final url = Uri.parse('$baseUrl/medicalRecords/add-record');
    
    final body = jsonEncode({
      'description': description,
      'duration': duration,
      'medicines': medicines,
      'date': date,
      'generatedBy': generatedBy,
      'patient': patientId,
    });

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Include the token in the headers
        },
        body: body,
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to add medical record');
      }
    } catch (error) {
      rethrow;
    }
  }

//Add medical record
// Future<void> addMedicalRecord(MedicalRecord record) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('token');

//     final response = await http.post(
//       Uri.parse('$baseUrl/medicalRecords/add'), // Adjust the endpoint as needed
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode({
//         'photo': record.photo,
//         'date': record.date.toIso8601String(),
//         'generatedBy': record.generatedBy,
//         'patient': record.patientId,
//       }),
//     );

//     if (response.statusCode != 201) {
//       throw Exception('Failed to add medical record: ${response.body}');
//     }
//   }


// Future<MedicalRecord> addMedicalRecord(
//     String photo,
//     String generatedBy,
//     String patientId,
//     DateTime date,
//   ) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/medical-records'), // Update with your endpoint
//       headers: {
//         'Content-Type': 'application/json',
//         // Include authorization headers if necessary
//       },
//       body: jsonEncode({
//         'photo': photo,
//         'generatedBy': generatedBy,
//         'patient': patientId,
//         'date': date.toIso8601String(), // Convert date to ISO format
//       }),
//     );

//     if (response.statusCode == 201) {
//       return MedicalRecord.fromJson(jsonDecode(response.body)['data']);
//     } else {
//       throw Exception('Failed to add medical record');
//     }
//   }


// =======================
// PATIENT VITAL RELATED
// =======================

//Add vital
// Future<void> addVital({
//     required String description,
//     required String duration,
//     required List<String> medicines,
//     required String date,
//     required String generatedBy,
//     required String patientId,
//   }) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('token');

//     final url = Uri.parse('$baseUrl/medicalRecords/add-record');
    
//     final body = jsonEncode({
//       'description': description,
//       'duration': duration,
//       'medicines': medicines,
//       'date': date,
//       'generatedBy': generatedBy,
//       'patient': patientId,
//     });

//     try {
//       final response = await http.post(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token', // Include the token in the headers
//         },
//         body: body,
//       );

//       if (response.statusCode != 201) {
//         throw Exception('Failed to add medical record');
//       }
//     } catch (error) {
//       rethrow;
//     }
//   }

// Method to add a new patient vital
Future<void> addVital({
  required double weight,
  required double temperature,
  required String bloodPressure,
  required int heartRate,
  required int respiratoryRate,
  required int oxygenLevel,
  required String examinedBy, // Intern ID
  required String patientId,
  required String date, // Patient ID
}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  final url = Uri.parse('$baseUrl/vitals/addVitals');

  final body = jsonEncode({
    'weight': weight,
    'temperature': temperature,
    'bloodPressure': bloodPressure,
    'heartRate': heartRate,
    'respiratoryRate': respiratoryRate,
    'oxygenLevel': oxygenLevel,
    'examinedBy': examinedBy,
    'patient': patientId,
  });

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: body,
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add patient vital');
    }
  } catch (error) {
    rethrow;
  }
}


// Method to get all vitals for a specific patient by patientId
Future<List<PatientVitals>> getAllVitals(String patientId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  final url = Uri.parse('$baseUrl/vitals/getAllVitals/$patientId');
  try {
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((vital) => PatientVitals.fromJson(vital)).toList();
    } else {
      throw Exception('Failed to load vitals');
    }
  } catch (error) {
    rethrow;
  }
}

// Method to get a specific patient vital by vital ID
Future<PatientVitals> getVitalById(String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  final url = Uri.parse('$baseUrl/vitals/get-vital/$id');
  try {
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return PatientVitals.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Vital record not found');
    }
  } catch (error) {
    rethrow;
  }
}




// =======================
// APPOINTMENT RELATED
// =======================

Future<void> addAppointment({
    required DateTime date,
    required String time,
    DateTime? nextAppDateTime,
    DateTime? lastAppDateTime,
    required String roomNo,
    required String consultant,
    required String status,
    required String patientId,
    // required List<String> patientVitals,
    // required List<String> medicalRecords,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final url = Uri.parse('$baseUrl/appointments/add');


    final body = jsonEncode({
      'date': date.toIso8601String(),
      'time': time,
      'nextAppDateTime': nextAppDateTime?.toIso8601String(),
      'lastAppDateTime': lastAppDateTime?.toIso8601String(),
      'roomNo': roomNo,
      'consultant': consultant,
      'status': status,
      'patientId': patientId,
      // 'patientVitals': patientVitals,
      // 'medicalRecords': medicalRecords,
    });

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to create appointment');
      }
    } catch (error) {
      rethrow;
    }
  }

//Fetch the last appointment for a patient by patient ID
Future<Appointment?> getLastAppointmentByPatientId(String patientId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  final url = Uri.parse('$baseUrl/appointments/get-last/:patientId');

  try {
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Appointment.fromJson(data['appointment']);
    } else {
      throw Exception('Failed to fetch last appointment');
    }
  } catch (error) {
    rethrow;
  }
}

//Fetch the last scheduled appointment for a patient by patient ID
Future<Appointment?> getLastScheduledAppointmentByPatientId(String patientId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  final url = Uri.parse('$baseUrl/appointments/get-last-scheduled/:patientId');

  try {
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Appointment.fromJson(data['appointment']);
    } else {
      throw Exception('Failed to fetch last scheduled appointment');
    }
  } catch (error) {
    rethrow;
  }
}

//Fetch all appointments for today with "Scheduled" status
Future<List<Appointment>> getAppointmentsForTodayWithScheduledStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  final url = Uri.parse('$baseUrl/appointments/get-all-today');

  try {
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<dynamic> appointmentsJson = data['appointments'];
      return appointmentsJson.map((json) => Appointment.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch today\'s scheduled appointments');
    }
  } catch (error) {
    rethrow;
  }
}

//Fetch all patients who has appointments for today with "Scheduled" status
Future<List<Patient>> getPatientsWithAppointmentsForToday() async {
    // Get the saved token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    // Define the API endpoint URL
    final url = Uri.parse('$baseUrl/appointments/get-all-today/patients');

    try {
      // Make the HTTP GET request
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Attach the token in the request
        },
      );

      // Check if the response was successful
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        // Extract the patient list from the response
        List<dynamic> patientsJson = data['patients'];
        
        // Map the JSON to the Patient model and return the list of patients
        return patientsJson.map((json) => Patient.fromJson(json)).toList();
      } else {
        // Handle the error response
        throw Exception('Failed to fetch today\'s scheduled patients');
      }
    } catch (error) {
      // Rethrow any caught errors for further handling
      rethrow;
    }
  }




// =======================
// INFO HUB RELATED
// =======================

// ========================
  // Corrct Infor Hub api s
  // ========================

  // Fetch all info articles
  Future<List<InfoHub>> getAllInfoArticles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('$baseUrl/infoHub/all'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> articlesJson =
          jsonDecode(response.body)['data']; // Access 'data' field
      // List<dynamic> articlesJson = jsonDecode(response.body)['articles'];
      return articlesJson.map((json) => InfoHub.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch info articles');
    }
  }

  // Fetch an info article by ID
  Future<InfoHub> getInfoArticleById(String articleId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('$baseUrl/infoHub/$articleId'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return InfoHub.fromJson(jsonDecode(response.body)['data']);
    } else {
      throw Exception('Failed to fetch info article');
    }
  }

  // Filter articles by name, category, or description
  Future<List<InfoHub>> filterInfoArticles(String searchQuery) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('$baseUrl/infoHub/filter?searchQuery=$searchQuery'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> articlesJson = jsonDecode(response.body)['articles'];
      return articlesJson.map((json) => InfoHub.fromJson(json)).toList();
    } else {
      throw Exception('No matching articles found');
    }
  }

}



