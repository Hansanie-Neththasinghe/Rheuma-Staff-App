import 'package:flutter/material.dart';

class ViewAllAppointments extends StatefulWidget {
  const ViewAllAppointments({super.key});

  @override
  State<ViewAllAppointments> createState() => _ViewAllAppointmentsState();
}

class _ViewAllAppointmentsState extends State<ViewAllAppointments> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Text("All App.."),
          ),
    );
  }
}