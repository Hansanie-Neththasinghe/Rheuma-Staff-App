class Doctor {
  final String id;
  final String email;
  final String username;
  final String name;
  final String contact;
  final String nic;
  final String docId;
  final String? role;
  final String? createdAt; // For "Member Since" or profile creation date
  final String? updatedAt;

  final List<String>? appointments;
  final List<String>? medicalRecords;
  final List<String>? patientVitals;
  final List<String>? patients;
  final List<String>? interns;
  final List<String>? infoHub;

  Doctor({
    required this.id,
    required this.email,
    required this.username,
    required this.name,
    required this.contact,
    required this.nic,
    required this.docId,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.appointments,
    this.medicalRecords,
    this.patientVitals,
    this.patients,
    this.interns,
    this.infoHub,
  });

  // Factory method to create a Doctor object from JSON
  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['_id']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      username: json['username']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      contact: json['contact']?.toString() ?? '',
      nic: json['nic']?.toString() ?? '',
      docId: json['docId']?.toString() ?? '',
      role: json['role']?.toString() ?? '',
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
      appointments: json['appointments'] != null
          ? List<String>.from(json['appointments'])
          : [],//Make this null safe
      medicalRecords: json['medicalRecords'] != null
          ? List<String>.from(json['medicalRecords'])
          : [],
      patientVitals: json['patientVitals'] != null
          ? List<String>.from(json['patientVitals'])
          : [],
      patients: json['patients'] != null
          ? List<String>.from(json['patients'])
          : [],
      interns: json['interns'] != null
          ? List<String>.from(json['interns'])
          : [],
      infoHub: json['infoHub'] != null
          ? List<String>.from(json['infoHub'])
          : [],
    );
  }
}
