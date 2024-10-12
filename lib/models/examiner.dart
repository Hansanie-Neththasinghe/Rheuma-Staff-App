class Examiner {
  final String id; // Examiner ID
  final String name; // Examiner Name
  final String type; // Type of examiner ('Doctor' or 'Intern')

  Examiner({
    required this.id,
    required this.name,
    required this.type,
  });

  // Factory constructor to create an Examiner object from a JSON map
  factory Examiner.fromJson(Map<String, dynamic> json) {
    return Examiner(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      type: json['examinerType']?.toString() ?? '', // Include examiner type
    );
  }

  // Method to convert an Examiner object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'examinerType': type,
    };
  }
}
