class Patient {
  final String id;
  final String username;
  final String email;
  final String medicalId;
  final String? profilePhoto;
  final String? name;
  final String? birthday;
  final String? contactNumber;
  final String? bloodType;
  final String? rheumaticType;
  final int? age;
  final String? createdAt; // createdAt field for "Member Since" date

  Patient({
    required this.id,
    required this.username,
    required this.email,
    required this.medicalId,
    this.profilePhoto,
    this.name,
    this.birthday,
    this.contactNumber,
    this.bloodType,
    this.rheumaticType,
    this.age,
    this.createdAt, // Initialize createdAt field
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['_id']?.toString() ?? '',
      username: json['username']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      medicalId: json['medicalId']?.toString() ?? '',
      profilePhoto: json['profilePhoto']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      birthday: json['birthday']?.toString() ?? '',
      contactNumber: json['contactNumber']?.toString() ?? '',
      bloodType: json['bloodType']?.toString() ?? '',
      rheumaticType: json['rheumaticType']?.toString() ?? '',
      age: json['age'],
      createdAt: json['createdAt']?.toString() ?? '', // Map createdAt field from JSON
    );
  }
}
