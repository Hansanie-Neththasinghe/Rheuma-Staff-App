// class Appointment {
//   final String id; // Appointment ID
//   final DateTime date;
//   final String time;
//   final DateTime? nextAppDateTime;
//   final DateTime? lastAppDateTime;
//   final String roomNo;
//   final String consultantId; // ID of the consultant (Doctor)
//   final String status; // Appointment status
//   final String patientId; // ID of the patient
//   final List<String> patientVitals; // List of patient vitals IDs
//   final List<String> medicalRecords; // List of medical record IDs

//   Appointment({
//     required this.id,
//     required this.date,
//     required this.time,
//     this.nextAppDateTime,
//     this.lastAppDateTime,
//     required this.roomNo,
//     required this.consultantId,
//     required this.status,
//     required this.patientId,
//     required this.patientVitals,
//     required this.medicalRecords,
//   });

//   // Factory method to create an Appointment from JSON
//   factory Appointment.fromJson(Map<String, dynamic> json) {
//     return Appointment(
//       id: json['_id'] as String,
//       date: DateTime.parse(json['date'] as String),
//       time: json['time'] as String,
//       nextAppDateTime: json['nextAppDateTime'] != null
//           ? DateTime.parse(json['nextAppDateTime'] as String)
//           : null,
//       lastAppDateTime: json['lastAppDateTime'] != null
//           ? DateTime.parse(json['lastAppDateTime'] as String)
//           : null,
//       roomNo: json['roomNo'] as String,
//       consultantId: json['consultant'] as String,
//       status: json['status'] as String,
//       patientId: json['patientId'] as String,
//       patientVitals: List<String>.from(json['patientVitals'] ?? []),
//       medicalRecords: List<String>.from(json['medicalRecords'] ?? []),
//     );
//   }

//   // Method to convert Appointment to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'date': date.toIso8601String(),
//       'time': time,
//       'nextAppDateTime': nextAppDateTime?.toIso8601String(),
//       'lastAppDateTime': lastAppDateTime?.toIso8601String(),
//       'roomNo': roomNo,
//       'consultant': consultantId,
//       'status': status,
//       'patientId': patientId,
//       'patientVitals': patientVitals,
//       'medicalRecords': medicalRecords,
//     };
//   }
// }



import 'dart:convert';

class Appointment {
  final String id;
  final DateTime date;
  final String time;
  final DateTime? nextAppDateTime;
  final DateTime? lastAppDateTime;
  final String roomNo;
  final String consultant;
  final String status;
  final String patientId;

  Appointment({
    required this.id,
    required this.date,
    required this.time,
    this.nextAppDateTime,
    this.lastAppDateTime,
    required this.roomNo,
    required this.consultant,
    required this.status,
    required this.patientId,
  });

  // Factory constructor for creating an Appointment instance from a Map (from JSON)
  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['_id'],
      date: DateTime.parse(json['date']),
      time: json['time'],
      nextAppDateTime: json['nextAppDateTime'] != null
          ? DateTime.parse(json['nextAppDateTime'])
          : null,
      lastAppDateTime: json['lastAppDateTime'] != null
          ? DateTime.parse(json['lastAppDateTime'])
          : null,
      roomNo: json['roomNo'],
      consultant: json['consultant'],
      status: json['status'],
      patientId: json['patientId'],
    );
  }

  // Method to convert Appointment instance into a Map (to JSON)
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'date': date.toIso8601String(),
      'time': time,
      'nextAppDateTime': nextAppDateTime?.toIso8601String(),
      'lastAppDateTime': lastAppDateTime?.toIso8601String(),
      'roomNo': roomNo,
      'consultant': consultant,
      'status': status,
      'patientId': patientId,
    };
  }

  // Method to convert Appointment instance into a JSON string
  String toJsonString() {
    return jsonEncode(toJson());
  }
}
