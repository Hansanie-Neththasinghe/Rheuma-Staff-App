// class MedicalRecord {
//   final String id;
//   final String photo; // URL to the photo
//   final DateTime date; // Date when the record was generated
//   final String generatedBy; // Doctor ID who generated the record
//   final String patientId; // Patient ID associated with the record

//   MedicalRecord({
//     required this.id,
//     required this.photo,
//     required this.date,
//     required this.generatedBy,
//     required this.patientId,
//   });

//   factory MedicalRecord.fromJson(Map<String, dynamic> json) {
//     return MedicalRecord(
//       id: json['_id']?.toString() ?? '',
//       photo: json['photo']?.toString() ?? '',
//       date: DateTime.parse(json['date']), // Parse the date
//       generatedBy: json['generatedBy']?.toString() ?? '', // Reference to the doctor ID
//       patientId: json['patient']?.toString() ?? '', // Reference to the patient ID
//     );
//   }
// }

import 'package:staff/models/doctor.dart';

class MedicalRecord {
  final String id;
  final String description; // Description of the medical condition
  final String duration; // Duration of the illness
  final List<String> medicines; // List of medicines
  final DateTime date; // Date when the record was generated
  final Doctor generatedBy; // Doctor object who generated the record
  final String patientId; // Patient ID associated with the record

  MedicalRecord({
    required this.id,
    required this.description,
    required this.duration,
    required this.medicines,
    required this.date,
    required this.generatedBy,
    required this.patientId,
  });

  // Factory method to create a MedicalRecord from JSON data
  factory MedicalRecord.fromJson(Map<String, dynamic> json) {
    return MedicalRecord(
      id: json['_id']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      duration: json['duration']?.toString() ?? '',
      medicines: List<String>.from(json['medicines'] ?? []), // Convert array of medicines
      date: DateTime.parse(json['date']), // Parse the date
      generatedBy: Doctor.fromJson(json['generatedBy']), // Create Doctor object from JSON
      patientId: json['patient']?.toString() ?? '', // Reference to the patient ID
    );
  }
}



// class MedicalRecord {
//   final String id;
//   final String description; // Description of the medical condition
//   final String duration; // Duration of the illness
//   final List<String> medicines; // List of medicines
//   final DateTime date; // Date when the record was generated
//   final String generatedBy; // Doctor ID who generated the record
//   final String patientId; // Patient ID associated with the record

//   MedicalRecord({
//     required this.id,
//     required this.description,
//     required this.duration,
//     required this.medicines,
//     required this.date,
//     required this.generatedBy,
//     required this.patientId,
//   });

//   // Factory method to create a MedicalRecord from JSON data
//   factory MedicalRecord.fromJson(Map<String, dynamic> json) {
//     return MedicalRecord(
//       id: json['_id']?.toString() ?? '',
//       description: json['description']?.toString() ?? '',
//       duration: json['duration']?.toString() ?? '',
//       medicines: List<String>.from(json['medicines'] ?? []), // Convert array of medicines
//       date: DateTime.parse(json['date']), // Parse the date
//       generatedBy: json['generatedBy']?.toString() ?? '', // Reference to the doctor ID
//       patientId: json['patient']?.toString() ?? '', // Reference to the patient ID
//     );
//   }

//   // Optional: Convert MedicalRecord to JSON if needed
//   // Map<String, dynamic> toJson() {
//   //   return {
//   //     '_id': id,
//   //     'description': description,
//   //     'duration': duration,
//   //     'medicines': medicines,
//   //     'date': date.toIso8601String(),
//   //     'generatedBy': generatedBy,
//   //     'patient': patientId,
//   //   };
//   // }
// }
