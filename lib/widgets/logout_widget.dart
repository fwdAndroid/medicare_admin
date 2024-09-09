import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicare_admin/mobile_section/auth/login_screen.dart';
import 'package:medicare_admin/screens/main/home_page.dart';
import 'package:medicare_admin/utils/colors.dart';
import 'package:medicare_admin/utils/message_utils.dart';

class LogoutWidget extends StatelessWidget {
  const LogoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SingleChildScrollView(
            child: ListBody(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Oh No, You are leaving",
                      style: GoogleFonts.workSans(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: black,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Are you sure you want to logout?",
                      style: GoogleFonts.workSans(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: appColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      actions: <Widget>[
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "No",
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () async {
                // Sign out from Firebase
                await FirebaseAuth.instance.signOut();

                // Sign out from Google

                // Navigate to login screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (builder) => MobileLogin()),
                );

                // Show snack bar message
                showMessageBar("Logged out successfully", context);
              },
              child: Text(
                "Yes",
                style: TextStyle(color: white),
              ),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(137, 50),
                backgroundColor: mainBtnColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
