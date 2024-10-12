// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// import 'package:staff/providers/appointment_provider.dart'; // Adjust this import based on your project structure
// import 'package:intl/intl.dart';

// class CreateAppointmentPage extends StatefulWidget {
//  final String patientId; // Add this parameter

//   const CreateAppointmentPage({Key? key, required this.patientId}) : super(key: key); // Modify constructor
//   @override
//   State<CreateAppointmentPage> createState() => _CreateAppointmentPageState();
// }

// class _CreateAppointmentPageState extends State<CreateAppointmentPage> {
//   final _formKey = GlobalKey<FormState>();

//   DateTime? _selectedDate;
//   String _selectedTime = '';
//   DateTime? _nextAppDate;
//   DateTime? _lastAppDate;
//   String _roomNo = '';
//   String _status = 'Scheduled';

//   @override
//   void initState() {
//     super.initState();
//     _getConsultantId(); // Fetch the consultant ID when the page is initialized
//   }

//   Future<void> _getConsultantId() async {
//     // SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       // _consultantId = prefs.getString('_id'); // Get the logged-in doctor's ID
//     });
//   }


// @override
//   Widget build(BuildContext context) {
//     final appointmentProvider = Provider.of<AppointmentProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Create Appointment'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               _buildDatePicker(
//                 title: Text(
//                   _selectedDate == null 
//                   ? 'Select Date' 
//                   : DateFormat('yyyy-MM-dd').format(_selectedDate!), // Display only the date part
//                 ),
//               ),
//               _buildTimeField(),
//               _buildTextField('Room Number', (value) => _roomNo = value),
//               _buildDropdownField(),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: appointmentProvider.isLoading
//                     ? null
//                     : () async {
//                         if (_formKey.currentState!.validate()) {
//                           _formKey.currentState!.save();

//                           if (_selectedDate == null) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(content: Text('Please select a date.')),
//                             );
//                             return; // Stop further execution if date is null.
//                           }

//                           try {
//                             await appointmentProvider.createAppointment(
//                               context, // Pass the context here
//                               date: _selectedDate!,
//                               time: _selectedTime,
//                               nextAppDateTime: _nextAppDate,
//                               lastAppDateTime: _lastAppDate,
//                               roomNo: _roomNo,
//                               status: _status,
//                               patientId: widget.patientId, // Use the patient ID passed from the previous screen
//                             );
//                             ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(content: Text('Appointment created successfully!')));
//                                 Navigator.of(context).pop();
//                           } catch (error) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(content: Text('Error creating appointment: $error')));
//                           }
//                         }
//                       },
//                 child: appointmentProvider.isLoading
//                     ? CircularProgressIndicator()
//                     : Text('Create Appointment'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   // Date picker for selecting appointment date
//   Widget _buildDatePicker({required Text title}) {
//     return ListTile(
//       title: Text(_selectedDate == null ? 'Select Date' : _selectedDate!.toLocal().toString()),
//       trailing: Icon(Icons.calendar_today),
//       onTap: () async {
//         final DateTime? pickedDate = await showDatePicker(
//           context: context,
//           initialDate: DateTime.now(),
//           firstDate: DateTime(2020),
//           lastDate: DateTime(2030),
//         );
//         if (pickedDate != null && pickedDate != _selectedDate) {
//           setState(() {
//             _selectedDate = pickedDate;
//           });
//         }
//       },
//     );
//   }

//   // Time field for entering appointment time
//   Widget _buildTimeField() {
//     return TextFormField(
//       decoration: InputDecoration(labelText: 'Time (e.g., 10:30 AM)'),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please enter a time';
//         }
//         return null;
//       },
//       onSaved: (value) {
//         _selectedTime = value!;
//       },
//     );
//   }

//   // Generic text field builder
//   Widget _buildTextField(String label, Function(String) onSaved) {
//     return TextFormField(
//       decoration: InputDecoration(labelText: label),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please enter $label';
//         }
//         return null;
//       },
//       onSaved: (value) {
//         onSaved(value!);
//       },
//     );
//   }

//   // Dropdown for selecting appointment status
//   Widget _buildDropdownField() {
//     return DropdownButtonFormField<String>(
//       value: _status,
//       decoration: InputDecoration(labelText: 'Status'),
//       onChanged: (String? newValue) {
//         setState(() {
//           _status = newValue!;
//         });
//       },
//       items: <String>['Scheduled', 'Completed', 'Cancelled', 'Rescheduled']
//           .map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staff/providers/appointment_provider.dart';
import 'package:intl/intl.dart';

class CreateAppointmentPage extends StatefulWidget {
  final String patientId; 

  const CreateAppointmentPage({Key? key, required this.patientId}) : super(key: key);

  @override
  State<CreateAppointmentPage> createState() => _CreateAppointmentPageState();
}

class _CreateAppointmentPageState extends State<CreateAppointmentPage> {
  final _formKey = GlobalKey<FormState>();

  DateTime? _selectedDate;
  String _selectedTime = '8:30';
  String _selectedLocation = 'Arthritis Clinic';
  String _selectedRoom = 'Room A';
  DateTime? _nextAppDate;
  DateTime? _lastAppDate;
  String _status = 'Scheduled';

  @override
  void initState() {
    super.initState();
    _getConsultantId();
  }

  Future<void> _getConsultantId() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final appointmentProvider = Provider.of<AppointmentProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Appointment', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Date Picker
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 3,
                child: ListTile(
                  leading: const Icon(Icons.calendar_today, color: Colors.blueAccent),
                  title: Text(
                    _selectedDate == null
                        ? 'Select Appointment Date'
                        : DateFormat('yyyy-MM-dd').format(_selectedDate!),
                    style: const TextStyle(fontSize: 16),
                  ),
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );
                    if (pickedDate != null && pickedDate != _selectedDate) {
                      setState(() {
                        _selectedDate = pickedDate;
                      });
                    }
                  },
                  trailing: const Icon(Icons.arrow_drop_down),
                ),
              ),
              
              const SizedBox(height: 16),

              // Time Dropdown
              _buildDropdownField(
                labelText: 'Select Time',
                icon: Icons.access_time,
                value: _selectedTime,
                items: <String>['8:30', '10:30', '12:30'],
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedTime = newValue!;
                  });
                },
              ),

              const SizedBox(height: 16),

              // Location Dropdown
              _buildDropdownField(
                labelText: 'Select Location',
                icon: Icons.location_on,
                value: _selectedLocation,
                items: <String>[
                  'Arthritis Clinic', 
                  'Pediatric Rheumatology Clinic', 
                  'Rheumatology Infusion Clinic',
                  'Rheumatology Outpatient Clinic', 
                  'Vasculitis Clinic', 
                  'Osteoporosis Clinic', 
                  'Joint Injection Clinic', 
                  'Autoimmune Disease Clinic'
                ],
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedLocation = newValue!;
                  });
                },
              ),

              const SizedBox(height: 16),

              // Room Dropdown
              _buildDropdownField(
                labelText: 'Select Room Number',
                icon: Icons.meeting_room,
                value: _selectedRoom,
                items: <String>['Room A', 'Room B'],
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedRoom = newValue!;
                  });
                },
              ),

              const SizedBox(height: 16),

              // Status Dropdown
              _buildDropdownField(
                labelText: 'Appointment Status',
                icon: Icons.info_outline,
                value: _status,
                items: <String>['Scheduled', 'Completed', 'Cancelled', 'Rescheduled'],
                onChanged: (String? newValue) {
                  setState(() {
                    _status = newValue!;
                  });
                },
              ),

              const SizedBox(height: 24),

              // Create Appointment Button
              ElevatedButton(
                onPressed: appointmentProvider.isLoading
                    ? null
                    : () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          if (_selectedDate == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Please select a date.')),
                            );
                            return;
                          }

                          try {
                            await appointmentProvider.createAppointment(
                              context, 
                              date: _selectedDate!,
                              time: _selectedTime,
                              nextAppDateTime: _nextAppDate,
                              lastAppDateTime: _lastAppDate,
                              roomNo: _selectedRoom,
                              status: _status,
                              patientId: widget.patientId,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Appointment created successfully!')));
                            Navigator.of(context).pop();
                          } catch (error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Error creating appointment: $error')));
                          }
                        }
                      },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.blueAccent,
                ),
                child: appointmentProvider.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Create Appointment', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Dropdown Builder
  Widget _buildDropdownField({
    required String labelText,
    required IconData icon,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: DropdownButtonFormField<String>(
          value: value,
          icon: const Icon(Icons.arrow_drop_down),
          decoration: InputDecoration(
            labelText: labelText,
            prefixIcon: Icon(icon, color: Colors.blueAccent),
            border: InputBorder.none,
          ),
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:staff/providers/appointment_provider.dart'; // Adjust this import based on your project structure
// import 'package:intl/intl.dart';

// class CreateAppointmentPage extends StatefulWidget {
//   final String patientId; // Add this parameter

//   const CreateAppointmentPage({Key? key, required this.patientId}) : super(key: key); // Modify constructor

//   @override
//   State<CreateAppointmentPage> createState() => _CreateAppointmentPageState();
// }

// class _CreateAppointmentPageState extends State<CreateAppointmentPage> {
//   final _formKey = GlobalKey<FormState>();

//   DateTime? _selectedDate;
//   String _selectedTime = '8:30';
//   String _selectedLocation = 'Arthritis Clinic';
//   String _selectedRoom = 'Room A'; // Add a default room
//   DateTime? _nextAppDate;
//   DateTime? _lastAppDate;
//   String _status = 'Scheduled';

//   @override
//   void initState() {
//     super.initState();
//     _getConsultantId(); // Fetch the consultant ID when the page is initialized
//   }

//   Future<void> _getConsultantId() async {
//     // SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       // _consultantId = prefs.getString('_id'); // Get the logged-in doctor's ID
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final appointmentProvider = Provider.of<AppointmentProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Create Appointment'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               _buildDatePicker(
//                 title: Text(
//                   _selectedDate == null 
//                   ? 'Select Date' 
//                   : DateFormat('yyyy-MM-dd').format(_selectedDate!), // Display only the date part
//                 ),
//               ),
//               _buildTimeDropdown(), // Dropdown for times
//               _buildLocationDropdown(), // Dropdown for locations
//               _buildRoomDropdown(), // Dropdown for room numbers
//               _buildDropdownField(), // Status dropdown
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: appointmentProvider.isLoading
//                     ? null
//                     : () async {
//                         if (_formKey.currentState!.validate()) {
//                           _formKey.currentState!.save();

//                           if (_selectedDate == null) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(content: Text('Please select a date.')),
//                             );
//                             return; // Stop further execution if date is null.
//                           }

//                           try {
//                             await appointmentProvider.createAppointment(
//                               context, // Pass the context here
//                               date: _selectedDate!,
//                               time: _selectedTime,
//                               nextAppDateTime: _nextAppDate,
//                               lastAppDateTime: _lastAppDate,
//                               roomNo: _selectedRoom, // Use the selected room
//                               status: _status,
//                               patientId: widget.patientId, // Use the patient ID passed from the previous screen
//                             );
//                             ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(content: Text('Appointment created successfully!')));
//                             Navigator.of(context).pop();
//                           } catch (error) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(content: Text('Error creating appointment: $error')));
//                           }
//                         }
//                       },
//                 child: appointmentProvider.isLoading
//                     ? CircularProgressIndicator()
//                     : Text('Create Appointment'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Date picker for selecting appointment date
//   Widget _buildDatePicker({required Text title}) {
//     return ListTile(
//       title: Text(_selectedDate == null ? 'Select Date' : _selectedDate!.toLocal().toString()),
//       trailing: Icon(Icons.calendar_today),
//       onTap: () async {
//         final DateTime? pickedDate = await showDatePicker(
//           context: context,
//           initialDate: DateTime.now(),
//           firstDate: DateTime(2020),
//           lastDate: DateTime(2030),
//         );
//         if (pickedDate != null && pickedDate != _selectedDate) {
//           setState(() {
//             _selectedDate = pickedDate;
//           });
//         }
//       },
//     );
//   }

//   // Dropdown for selecting time
//   Widget _buildTimeDropdown() {
//     return DropdownButtonFormField<String>(
//       value: _selectedTime,
//       decoration: InputDecoration(labelText: 'Select Time'),
//       onChanged: (String? newValue) {
//         setState(() {
//           _selectedTime = newValue!;
//         });
//       },
//       items: <String>['8:30', '10:30', '12:30']
//           .map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
//   }

//   // Dropdown for selecting location
//   Widget _buildLocationDropdown() {
//     return DropdownButtonFormField<String>(
//       value: _selectedLocation,
//       decoration: InputDecoration(labelText: 'Select Location'),
//       onChanged: (String? newValue) {
//         setState(() {
//           _selectedLocation = newValue!;
//         });
//       },
//       items: <String>[
//         'Arthritis Clinic', 
//         'Pediatric Rheumatology Clinic', 
//         'Rheumatology Infusion Clinic',
//         'Rheumatology Outpatient Clinic', 
//         'Vasculitis Clinic', 
//         'Osteoporosis Clinic', 
//         'Joint Injection Clinic', 
//         'Autoimmune Disease Clinic'
//       ].map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
//   }

//   // Dropdown for selecting room number
//   Widget _buildRoomDropdown() {
//     return DropdownButtonFormField<String>(
//       value: _selectedRoom,
//       decoration: InputDecoration(labelText: 'Select Room Number'),
//       onChanged: (String? newValue) {
//         setState(() {
//           _selectedRoom = newValue!;
//         });
//       },
//       items: <String>['Room A', 'Room B']
//           .map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
//   }

//   // Dropdown for selecting appointment status
//   Widget _buildDropdownField() {
//     return DropdownButtonFormField<String>(
//       value: _status,
//       decoration: InputDecoration(labelText: 'Status'),
//       onChanged: (String? newValue) {
//         setState(() {
//           _status = newValue!;
//         });
//       },
//       items: <String>['Scheduled', 'Completed', 'Cancelled', 'Rescheduled']
//           .map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
//   }
// }
