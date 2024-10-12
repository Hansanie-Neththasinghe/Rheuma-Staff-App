// class PatientVitals {
//   final double weight;
//   final double temperature;
//   final String bloodPressure;
//   final int heartRate;
//   final int respiratoryRate;
//   final int oxygenLevel;
//   final String examinedBy; // Intern ID
//   final DateTime date;
//   final String time;
//   final String patient; // Patient ID

//   PatientVitals({
//     required this.weight,
//     required this.temperature,
//     required this.bloodPressure,
//     required this.heartRate,
//     required this.respiratoryRate,
//     required this.oxygenLevel,
//     required this.examinedBy,
//     required this.date,
//     required this.time,
//     required this.patient,
//   });

//   // Factory constructor to create a PatientVitals object from a JSON map
//   factory PatientVitals.fromJson(Map<String, dynamic> json) {
//     return PatientVitals(
//       weight: json['weight'].toDouble(),
//       temperature: json['temperature'].toDouble(),
//       bloodPressure: json['bloodPressure']?.toString() ?? '',
//       heartRate: json['heartRate'],
//       respiratoryRate: json['respiratoryRate'],
//       oxygenLevel: json['oxygenLevel'],
//       examinedBy: json['examinedBy'],
//       date: DateTime.parse(json['date']),
//       time: json['time']?.toString() ?? '',
//       patient: json['patient']?.toString() ?? '',
//     );
//   }

//   // Method to convert a PatientVitals object to a JSON map
//   Map<String, dynamic> toJson() {
//     return {
//       'weight': weight,
//       'temperature': temperature,
//       'bloodPressure': bloodPressure,
//       'heartRate': heartRate,
//       'respiratoryRate': respiratoryRate,
//       'oxygenLevel': oxygenLevel,
//       'examinedBy': examinedBy,
//       'date': date.toIso8601String(),
//       'time': time,
//       'patient': patient,
//     };
//   }
// }

import 'package:staff/models/examiner.dart';

class PatientVitals {
  final double weight;
  final double temperature;
  final String bloodPressure;
  final int heartRate;
  final int respiratoryRate;
  final int oxygenLevel;
  final Examiner examinedBy; // Change here to use the Examiner class
  final DateTime date; // Date of examination
  final String time; // Time of examination
  final String patient; // Patient ID

  PatientVitals({
    required this.weight,
    required this.temperature,
    required this.bloodPressure,
    required this.heartRate,
    required this.respiratoryRate,
    required this.oxygenLevel,
    required this.examinedBy,
    required this.date,
    required this.time,
    required this.patient,
  });

  // Factory constructor to create a PatientVitals object from a JSON map
  factory PatientVitals.fromJson(Map<String, dynamic> json) {
    return PatientVitals(
      weight: json['weight'].toDouble(),
      temperature: json['temperature'].toDouble(),
      bloodPressure: json['bloodPressure']?.toString() ?? '',
      heartRate: json['heartRate'],
      respiratoryRate: json['respiratoryRate'],
      oxygenLevel: json['oxygenLevel'],
      examinedBy: Examiner.fromJson(json['examinedBy']), // Use Examiner class
      date: DateTime.parse(json['date']),
      time: json['time']?.toString() ?? '',
      patient: json['patient']?.toString() ?? '',
    );
  }

  // Method to convert a PatientVitals object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'weight': weight,
      'temperature': temperature,
      'bloodPressure': bloodPressure,
      'heartRate': heartRate,
      'respiratoryRate': respiratoryRate,
      'oxygenLevel': oxygenLevel,
      'examinedBy': examinedBy.toJson(), // Include toJson for Examiner
      'date': date.toIso8601String(),
      'time': time,
      'patient': patient,
    };
  }
}

// class PatientVitals {
//   final double weight;
//   final double temperature;
//   final String bloodPressure;
//   final int heartRate;
//   final int respiratoryRate;
//   final int oxygenLevel;
//   final String examinedBy; // Intern or Doctor ID
//   final String examinerType; // Type of examiner ('Doctor' or 'Intern')
//   final DateTime date; // Date of examination
//   final String time; // Time of examination
//   final String patient; // Patient ID

//   PatientVitals({
//     required this.weight,
//     required this.temperature,
//     required this.bloodPressure,
//     required this.heartRate,
//     required this.respiratoryRate,
//     required this.oxygenLevel,
//     required this.examinedBy,
//     required this.examinerType,
//     required this.date,
//     required this.time,
//     required this.patient,
//   });

//   // Factory constructor to create a PatientVitals object from a JSON map
//   factory PatientVitals.fromJson(Map<String, dynamic> json) {
//     return PatientVitals(
//       weight: json['weight'].toDouble(),
//       temperature: json['temperature'].toDouble(),
//       bloodPressure: json['bloodPressure']?.toString() ?? '',
//       heartRate: json['heartRate'],
//       respiratoryRate: json['respiratoryRate'],
//       oxygenLevel: json['oxygenLevel'],
//       examinedBy: json['examinedBy']?.toString() ?? '',
//       examinerType: json['examinerType']?.toString() ?? '', // Add examiner type
//       date: DateTime.parse(json['date']), // Ensure proper date parsing
//       time: json['time']?.toString() ?? '', // Ensure time is a string
//       patient: json['patient']?.toString() ?? '',
//     );
//   }

//   // Method to convert a PatientVitals object to a JSON map
//   Map<String, dynamic> toJson() {
//     return {
//       'weight': weight,
//       'temperature': temperature,
//       'bloodPressure': bloodPressure,
//       'heartRate': heartRate,
//       'respiratoryRate': respiratoryRate,
//       'oxygenLevel': oxygenLevel,
//       'examinedBy': examinedBy,
//       'examinerType': examinerType, // Include examiner type in JSON
//       'date': date.toIso8601String(),
//       'time': time,
//       'patient': patient,
//     };
//   }
// }

