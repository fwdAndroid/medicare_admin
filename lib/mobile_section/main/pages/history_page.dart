import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicare_admin/mobile_section/appointments/appointment_history.dart';
import 'package:medicare_admin/mobile_section/setting_pages/change_password.dart';
import 'package:medicare_admin/mobile_section/setting_pages/notification_screen.dart';
import 'package:medicare_admin/mobile_section/setting_pages/payment_page.dart';
import 'package:medicare_admin/mobile_section/setting_pages/privacy_policy.dart';
import 'package:medicare_admin/mobile_section/setting_pages/support.dart';
import 'package:medicare_admin/screens/main/home_page.dart';
import 'package:medicare_admin/utils/buttons.dart';
import 'package:medicare_admin/utils/colors.dart';
import 'package:medicare_admin/widgets/logout_widget.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool get isGoogleSignIn =>
      _auth.currentUser?.providerData[0].providerId == 'google.com';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "Farhan Ali",
                      style: GoogleFonts.workSans(
                          fontWeight: FontWeight.w600, fontSize: 22),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12))),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => AppointmentHistory()));
                      },
                      leading: Icon(
                        Icons.post_add,
                        color: appColor,
                      ),
                      title: Text(
                        "Records",
                        style: GoogleFonts.workSans(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: appColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Divider(
                        color: borderColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Divider(
                        color: borderColor,
                      ),
                    ),
                    if (!isGoogleSignIn)
                      ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => ChangePassword()));
                        },
                        leading: Icon(
                          Icons.language_outlined,
                          color: appColor,
                        ),
                        title: Text(
                          "Change Password",
                          style: GoogleFonts.workSans(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: appColor,
                        ),
                      ),
                    if (!isGoogleSignIn)
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Divider(
                          color: borderColor,
                        ),
                      ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => PaymentPage()));
                      },
                      leading: Icon(
                        Icons.payment,
                        color: appColor,
                      ),
                      title: Text(
                        "Payment Method",
                        style: GoogleFonts.workSans(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: appColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Divider(
                        color: borderColor,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => NotificationScreen()));
                      },
                      leading: Icon(
                        Icons.notifications,
                        color: appColor,
                      ),
                      title: Text(
                        "Notifications",
                        style: GoogleFonts.workSans(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: appColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Divider(
                        color: borderColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Divider(
                        color: borderColor,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: mainBtnColor,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "About App",
                          style: GoogleFonts.workSans(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff5496FB)),
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => PrivacyPolicy()));
                      },
                      leading: Icon(
                        Icons.privacy_tip,
                        color: appColor,
                      ),
                      title: Text(
                        "Privacy Policy ",
                        style: GoogleFonts.workSans(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: appColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Divider(
                        color: borderColor,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (builder) => Support()));
                      },
                      leading: Icon(
                        Icons.help,
                        color: appColor,
                      ),
                      title: Text(
                        "Help & Support",
                        style: GoogleFonts.workSans(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: appColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Divider(
                        color: borderColor,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SaveButton(
                    color: mainBtnColor,
                    title: "Logout",
                    onTap: () {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return LogoutWidget();
                        },
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
