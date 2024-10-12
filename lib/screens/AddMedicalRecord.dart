// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../providers/medical_record_provider.dart';

// class AddMedicalRecord extends StatefulWidget {
//   final String patientId; // Patient ID to associate with the record

//   const AddMedicalRecord({Key? key, required this.patientId}) : super(key: key);

//   @override
//   _AddMedicalRecordState createState() => _AddMedicalRecordState();
// }

// class _AddMedicalRecordState extends State<AddMedicalRecord> {
//   final _formKey = GlobalKey<FormState>();
//   String? _description; // Medical record description
//   String? _duration; // Duration of treatment
//   List<String> _medicines = []; // List of medicines to be added
//   DateTime _date = DateTime.now(); // Set current date, initialized

//   Future<void> _submitForm() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       try {
//         // Retrieve Doctor ID from SharedPreferences
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         String? generatedBy = prefs.getString('_id'); // Replace with the actual key used for storing doctor ID

//         if (generatedBy == null) {
//           throw Exception('Doctor ID not found');
//         }

//         // Call the provider to add the medical record
//         await Provider.of<MedicalRecordProvider>(context, listen: false)
//             .addMedicalRecord(_description!, _duration!, _medicines, widget.patientId, _date);
        
//         Navigator.of(context).pop(); // Go back after adding the record
//       } catch (error) {
//         // Handle the error (show dialog, snackbar, etc.)
//         print('Failed to add medical record: $error');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to add medical record: $error')),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Medical Record'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 decoration: const InputDecoration(labelText: 'Description'),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter a description';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _description = value;
//                 },
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 decoration: const InputDecoration(labelText: 'Duration'),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter duration';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _duration = value;
//                 },
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 decoration: const InputDecoration(labelText: 'Medicines (comma-separated)'),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter at least one medicine';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _medicines = value!.split(',').map((med) => med.trim()).toList();
//                 },
//               ),
//               const SizedBox(height: 20),
//               Text('Date: ${_date.toLocal()}'.split(' ')[0]), // Display current date
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _submitForm,
//                 child: const Text('Add Medical Record'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/medical_record_provider.dart';

class AddMedicalRecord extends StatefulWidget {
  final String patientId; 

  const AddMedicalRecord({Key? key, required this.patientId}) : super(key: key);

  @override
  _AddMedicalRecordState createState() => _AddMedicalRecordState();
}

class _AddMedicalRecordState extends State<AddMedicalRecord> {
  final _formKey = GlobalKey<FormState>();
  String? _description;
  String? _duration;
  List<String> _medicines = [];
  List<TextEditingController> _medicineControllers = [];
  DateTime _date = DateTime.now(); 

  @override
  void initState() {
    super.initState();
    _addMedicineField(); 
  }

  void _addMedicineField() {
    setState(() {
      _medicineControllers.add(TextEditingController());
      _medicines.add(''); 
    });
  }

  void _removeMedicineField() {
    if (_medicineControllers.isNotEmpty) {
      setState(() {
        _medicines.removeLast();
        _medicineControllers.removeLast(); 
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      _medicines = _medicineControllers.map((controller) => controller.text.trim()).toList();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? generatedBy = prefs.getString('_id'); 

        if (generatedBy == null) {
          throw Exception('Doctor ID not found');
        }

        await Provider.of<MedicalRecordProvider>(context, listen: false)
            .addMedicalRecord(_description!, _duration!, _medicines, widget.patientId, _date);
        
        Navigator.of(context).pop(); 
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add medical record: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Medical Record', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                _buildInputCard(
                  label: 'Description',
                  validator: (value) {
                    if (value!.isEmpty) return 'Please enter a description';
                    return null;
                  },
                  onSaved: (value) => _description = value,
                ),
                const SizedBox(height: 16),
                _buildInputCard(
                  label: 'Duration',
                  validator: (value) {
                    if (value!.isEmpty) return 'Please enter duration';
                    return null;
                  },
                  onSaved: (value) => _duration = value,
                ),
                const SizedBox(height: 16),
                _buildMedicineFields(),
                const SizedBox(height: 20),
                Text(
                  'Date: ${_date.toLocal()}'.split(' ')[0],
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Add Medical Record', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_medicineControllers.last.text.isNotEmpty) {
            _addMedicineField();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please fill in the current medicine field before adding another.')),
            );
          }
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
      ),
    );
  }

  // Input field wrapped in a card
  Widget _buildInputCard({
    required String label,
    required FormFieldValidator<String> validator,
    required FormFieldSetter<String> onSaved,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: label,
            border: InputBorder.none,
          ),
          validator: validator,
          onSaved: onSaved,
        ),
      ),
    );
  }

  // Medicine input fields dynamically created
  Widget _buildMedicineFields() {
    return Column(
      children: _medicineControllers.map((controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: TextFormField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: 'Medicine',
                  border: InputBorder.none,
                ),
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter a medicine';
                  return null;
                },
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  void dispose() {
    for (var controller in _medicineControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../providers/medical_record_provider.dart';

// class AddMedicalRecord extends StatefulWidget {
//   final String patientId; // Patient ID to associate with the record

//   const AddMedicalRecord({Key? key, required this.patientId}) : super(key: key);

//   @override
//   _AddMedicalRecordState createState() => _AddMedicalRecordState();
// }

// class _AddMedicalRecordState extends State<AddMedicalRecord> {
//   final _formKey = GlobalKey<FormState>();
//   String? _description; // Medical record description
//   String? _duration; // Duration of treatment
//   List<String> _medicines = []; // List of medicines to be added
//   List<TextEditingController> _medicineControllers = []; // Controllers for medicine input fields
//   DateTime _date = DateTime.now(); // Set current date, initialized

//   @override
//   void initState() {
//     super.initState();
//     _addMedicineField(); // Add initial medicine field
//   }

//   void _addMedicineField() {
//     // Create a new TextEditingController and add it to the list
//     setState(() {
//       _medicineControllers.add(TextEditingController());
//       _medicines.add(''); // Add an empty entry to the medicines list
//     });
//   }

//   void _removeMedicineField() {
//     if (_medicineControllers.isNotEmpty) {
//       setState(() {
//         _medicines.removeLast(); // Remove the last medicine from the list
//         _medicineControllers.removeLast(); // Remove the last controller
//       });
//     }
//   }

//   Future<void> _submitForm() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();

//       // Prepare the medicines list for submission
//       _medicines = _medicineControllers.map((controller) => controller.text.trim()).toList();

//       try {
//         // Retrieve Doctor ID from SharedPreferences
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         String? generatedBy = prefs.getString('_id'); // Replace with the actual key used for storing doctor ID

//         if (generatedBy == null) {
//           throw Exception('Doctor ID not found');
//         }

//         // Call the provider to add the medical record
//         await Provider.of<MedicalRecordProvider>(context, listen: false)
//             .addMedicalRecord(_description!, _duration!, _medicines, widget.patientId, _date);
        
//         Navigator.of(context).pop(); // Go back after adding the record
//       } catch (error) {
//         // Handle the error (show dialog, snackbar, etc.)
//         print('Failed to add medical record: $error');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to add medical record: $error')),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Medical Record'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 decoration: const InputDecoration(labelText: 'Description'),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter a description';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _description = value;
//                 },
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 decoration: const InputDecoration(labelText: 'Duration'),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter duration';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _duration = value;
//                 },
//               ),
//               const SizedBox(height: 16),
//               // Dynamic input fields for medicines
//               Column(
//                 children: _medicineControllers.map((controller) {
//                   return TextFormField(
//                     controller: controller,
//                     decoration: const InputDecoration(labelText: 'Medicine'),
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Please enter at least one medicine';
//                       }
//                       return null;
//                     },
//                   );
//                 }).toList(),
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {
//                       // Check if the last medicine input is empty before adding a new field
//                       if (_medicineControllers.last.text.isNotEmpty) {
//                         _addMedicineField();
//                       } else {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text('Please fill in the current medicine field before adding another.')),
//                         );
//                       }
//                     },
//                     child: const Text('+ Add Medicine'),
//                   ),
//                   if (_medicineControllers.length > 1) // Only show undo button if there's more than one input
//                     ElevatedButton(
//                       onPressed: _removeMedicineField,
//                       child: const Text('Undo'),
//                     ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               Text('Date: ${_date.toLocal()}'.split(' ')[0]), // Display current date
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _submitForm,
//                 child: const Text('Add Medical Record'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     // Dispose of all the controllers to free resources
//     for (var controller in _medicineControllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }
// }
