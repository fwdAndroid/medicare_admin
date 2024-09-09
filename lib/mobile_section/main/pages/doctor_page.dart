import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicare_admin/mobile_section/details/doctor_detail.dart';
import 'package:medicare_admin/screens/main/home_page.dart';
import 'package:medicare_admin/utils/colors.dart';

class DoctorPage extends StatefulWidget {
  const DoctorPage({super.key});

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainBtnColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Medical Consultation",
          style: GoogleFonts.poppins(
              fontSize: 18, color: white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                scrollDirection:
                    Axis.vertical, // Keep the scroll direction vertical
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns in the grid
                  crossAxisSpacing: 10, // Spacing between columns
                  mainAxisSpacing: 10, // Spacing between rows
                  childAspectRatio: 0.8, // Adjust this ratio to fit the design
                ),
                itemCount: 10, // Replace with your dynamic list length
                itemBuilder: (context, index) {
                  return Card(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => DoctorDetail()));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment
                            .center, // Center the content vertically
                        crossAxisAlignment: CrossAxisAlignment
                            .center, // Center the content horizontally
                        children: [
                          Container(
                            height: 100,
                            child: Image.asset(
                              "assets/doctor.png",
                              width: 100,
                              height: 100,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 4.0, top: 8, right: 4),
                            child: Text(
                              "Dr. Farhan Ali",
                              style: GoogleFonts.poppins(
                                  fontSize: 12, color: appColor),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 4.0, top: 8, right: 4),
                            child: Text(
                              "Physiotherapy",
                              style: GoogleFonts.poppins(
                                  fontSize: 12, color: appColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
