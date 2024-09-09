import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicare_admin/mobile_section/appointments/appointment_begin.dart';
import 'package:medicare_admin/screens/main/home_page.dart';
import 'package:medicare_admin/utils/buttons.dart';
import 'package:medicare_admin/utils/colors.dart';

class DoctorDetail extends StatefulWidget {
  DoctorDetail({
    super.key,
  });

  @override
  State<DoctorDetail> createState() => _DoctorDetailState();
}

class _DoctorDetailState extends State<DoctorDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBtnColor,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: white,
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    size: 20,
                    Icons.arrow_back_ios_new,
                    color: textColor,
                  ),
                ),
              ),
            ),
          ),
        ),
        iconTheme: IconThemeData(color: white),
        backgroundColor: mainBtnColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage("assets/doctor.png"),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.41,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8, top: 17),
                    child: Text(
                      "Doctor Farhan Ali",
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: appColor),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: circle,
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  size: 20,
                                  Icons.badge,
                                  color: textColor,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "3 Years",
                            style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: appColor),
                          ),
                          Text(
                            "Experience",
                            style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: textColor),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: circle,
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  size: 20,
                                  Icons.star,
                                  color: textColor,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "5 Star",
                            style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: appColor),
                          ),
                          Text(
                            "Rating",
                            style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: textColor),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: circle,
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  size: 20,
                                  Icons.reviews,
                                  color: textColor,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "20",
                            style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: appColor),
                          ),
                          Text(
                            "Reviews",
                            style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: textColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "About Doctor",
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: appColor),
                  ),
                ),
                SizedBox(
                  height: 150,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8, top: 5),
                    child: Text(
                      "Dr. Farhan Ali Muhammad Boota is a Physiotherapist in Al Wasl, Dubai and has an experience of 3 years in this field. Dr. Farhan Ali Muhammad Boota practices at Estheva Polyclinic Llc in Al Wasl, Dubai.",
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: dateColor),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 80,
                    width: 360,
                    decoration: BoxDecoration(
                      color: circle,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: dividerColor,
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Consultation fee",
                                style: GoogleFonts.poppins(
                                  color: dateColor,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "\$",
                                    style: GoogleFonts.poppins(
                                        color: appColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "50\$",
                                    style: GoogleFonts.poppins(
                                        color: appColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "/Consultation fee",
                                    style: GoogleFonts.poppins(
                                      color: dateColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Follow-up fee",
                                style: GoogleFonts.poppins(
                                  color: dateColor,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "\$",
                                    style: GoogleFonts.poppins(
                                        color: appColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "50\$",
                                    style: GoogleFonts.poppins(
                                        color: appColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "(within 15 Days)",
                                    style: GoogleFonts.poppins(
                                      color: dateColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
