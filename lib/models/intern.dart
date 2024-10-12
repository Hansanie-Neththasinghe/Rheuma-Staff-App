class Intern {
  final String id;
  final String email;
  final String username;
  final String name;
  final String contact;
  final String nic;
  final String internId;
  final String? role;
  final String? createdAt; // For profile creation date
  final String? updatedAt;

  final List<String>? appointments;
  final List<String>? medicalRecords;
  final List<String>? patientVitals;
  final List<String>? doctors;
  final List<String>? interns;
  final List<String>? infoHub;

  Intern({
    required this.id,
    required this.email,
    required this.username,
    required this.name,
    required this.contact,
    required this.nic,
    required this.internId,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.appointments,
    this.medicalRecords,
    this.patientVitals,
    this.doctors,
    this.interns,
    this.infoHub,
  });

  // Factory method to create an Intern object from JSON
  factory Intern.fromJson(Map<String, dynamic> json) {
    return Intern(
      id: json['_id']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      username: json['username']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      contact: json['contact']?.toString() ?? '',
      nic: json['nic']?.toString() ?? '',
      internId: json['internId']?.toString() ?? '',
      role: json['role']?.toString() ?? '',
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
      appointments: json['appointments'] != null
          ? List<String>.from(json['appointments'])
          : [],
      medicalRecords: json['medicalRecords'] != null
          ? List<String>.from(json['medicalRecords'])
          : [],
      patientVitals: json['patientVitals'] != null
          ? List<String>.from(json['patientVitals'])
          : [],
      doctors: json['doctors'] != null
          ? List<String>.from(json['doctors'])
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
