import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicare_admin/utils/buttons.dart';

class DoctorDetails extends StatefulWidget {
  final String uid,
      email,
      fullName,
      password,
      contactNumber,
      hospitalName,
      department,
      experience;
  bool blocked;

  DoctorDetails({
    super.key,
    required this.contactNumber,
    required this.email,
    required this.fullName,
    required this.password,
    this.blocked = false,
    required this.department,
    required this.experience,
    required this.hospitalName,
    required this.uid,
  });

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                FormSection(
                  contactNumber: widget.contactNumber,
                  email: widget.email,
                  fullName: widget.fullName,
                  password: widget.password,
                  hospitalName: widget.hospitalName,
                  experience: widget.experience,
                  department: widget.department,
                  uid: widget.uid,
                  blocked: widget.blocked,
                  onStatusChanged: (bool newStatus) {
                    setState(() {
                      widget.blocked = newStatus;
                    });
                  },
                ),
                const _ImageSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FormSection extends StatefulWidget {
  final String contactNumber,
      email,
      uid,
      fullName,
      password,
      hospitalName,
      department,
      experience;
  bool blocked;
  final ValueChanged<bool> onStatusChanged;

  FormSection({
    Key? key,
    required this.password,
    required this.email,
    required this.fullName,
    required this.contactNumber,
    required this.uid,
    required this.blocked,
    required this.hospitalName,
    required this.department,
    required this.experience,
    required this.onStatusChanged,
  }) : super(key: key);

  @override
  State<FormSection> createState() => FormSectionState();
}

class FormSectionState extends State<FormSection> {
  Future<void> _toggleBlockStatus() async {
    setState(() {
      widget.blocked = !widget.blocked;
    });
    widget.onStatusChanged(widget.blocked);

    try {
      await FirebaseFirestore.instance
          .collection('doctors')
          .doc(widget.uid)
          .update({'isblocked': widget.blocked});
    } catch (e) {
      print('Failed to update user status: $e');
      // Handle the error, e.g., show a message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: 448,
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/logo.png"),
            const SizedBox(height: 9),
            Row(children: [
              const Text(
                "Name:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10),
              Text(widget.fullName),
            ]),
            const SizedBox(height: 9),
            Row(children: [
              const Text(
                "Email:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10),
              Text(widget.email),
            ]),
            const SizedBox(height: 9),
            Row(children: [
              const Text(
                "Password:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10),
              Text(widget.password),
            ]),
            const SizedBox(height: 9),
            Row(children: [
              const Text(
                "Hospital Name:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10),
              Text(widget.hospitalName),
            ]),
            const SizedBox(height: 9),
            Row(children: [
              const Text(
                "Department:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10),
              Text(widget.department),
            ]),
            const SizedBox(height: 9),
            Row(children: [
              const Text(
                "Contact Number:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10),
              Text(widget.contactNumber),
            ]),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SaveButton(
                  onTap: _toggleBlockStatus,
                  title: widget.blocked ? "Unblock" : "Block",
                  color: widget.blocked ? Colors.red : Colors.green,
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class _ImageSection extends StatelessWidget {
  const _ImageSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/logo.png",
              height: 300,
            ),
          ),
        ],
      ),
    );
  }
}
