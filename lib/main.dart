import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staff/providers/appointment_provider.dart';
import 'package:staff/providers/doctor_provider.dart';
import 'package:staff/providers/info_hub_provider.dart';
import 'package:staff/providers/intern_provider.dart';
import 'package:staff/providers/medical_record_provider.dart';
import 'package:staff/providers/patient_provider.dart';
import 'package:staff/providers/patient_vitals_provider.dart';
import 'package:staff/screens/CreateAppointment.dart';
import 'package:staff/screens/DoctorHomeScreen.dart';
import 'package:staff/screens/DoctorLoginScreen.dart';
import 'package:staff/screens/DoctorProfileScreen.dart';
import 'package:staff/screens/InitialScreen.dart';
import 'package:staff/screens/InternHomeScreen.dart';
import 'package:staff/screens/InternLoginScreen.dart';
import 'package:staff/screens/InternProfileScreen.dart';
import 'package:staff/screens/ViewAllPatients.dart';
import 'package:staff/screens/information_hub_screen.dart';
import 'package:staff/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DoctorProvider()),
        ChangeNotifierProvider(create: (_) => InternProvider()),
        ChangeNotifierProvider(create: (_) => PatientProvider()),
        ChangeNotifierProvider(create: (_) => MedicalRecordProvider()),
        ChangeNotifierProvider(create: (_) => PatientVitalProvider()),
        ChangeNotifierProvider(create: (_) => AppointmentProvider()),
        ChangeNotifierProvider(create: (_) => InfoHubProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
          title: 'Rheumatic Clinic App For Staff Members',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          // home: const InitialScreen(),
          home: SplashScreen(),
          routes: {
            '/initial': (context) => const InitialScreen(), //This gives an error
            '/doctorLogin': (context) => const DoctorLoginScreen(),
            '/internLogin': (context) => const InternLoginScreen(),
            '/doctorHome': (context) => const DoctorHomeScreen(),
            '/internHome': (context) => const InternHomescreen(),
            '/doctorProfile': (context) => const DoctorProfileScreen(),
            '/internProfile': (context) => const InternProfileScreen(),
            '/addAppointment': (context) => const CreateAppointmentPage(patientId: ''),
            '/allPatients': (context) => const ViewAllPatients(),
            '/infoHub': (context) => const InformationHubScreen(),

          },),
    );
  }
}
