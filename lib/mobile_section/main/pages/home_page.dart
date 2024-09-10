import 'package:flutter/material.dart';
import 'package:medicare_admin/mobile_section/tab/clinic_tab.dart';
import 'package:medicare_admin/mobile_section/tab/home_care_tab.dart';
import 'package:medicare_admin/screens/main/home_page.dart';
import 'package:medicare_admin/utils/colors.dart';

class MainHomeMobile extends StatefulWidget {
  const MainHomeMobile({super.key});

  @override
  State<MainHomeMobile> createState() => _MainHomeMobileState();
}

class _MainHomeMobileState extends State<MainHomeMobile> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Home Page',
            style: TextStyle(color: mainBtnColor),
          ),
          bottom: TabBar(
            unselectedLabelColor: black,
            labelColor: mainBtnColor,
            tabs: [
              Tab(icon: Icon(Icons.home_max), text: "Home Services"),
              Tab(icon: Icon(Icons.camera_alt), text: "Clincic Services")
            ],
          ),
        ),
        body: TabBarView(
          children: [
            HomeCareTab(),
            ClinicTab(),
          ],
        ),
      ),
    );
  }
}
