import 'package:flutter/material.dart';

class Doctor extends StatefulWidget {
  @override
  _DoctorState createState() => _DoctorState();
}

class _DoctorState extends State<Doctor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bác sĩ"),
      ),
      body: Center(
        child: Text("Bác sĩ"),
      ),
    );
  }
}
