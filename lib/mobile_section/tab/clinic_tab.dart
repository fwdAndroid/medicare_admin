import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medicare_admin/mobile_section/services/clinic_add_service.dart';
import 'package:medicare_admin/utils/colors.dart';

import '../../screens/main/home_page.dart';

class ClinicTab extends StatefulWidget {
  const ClinicTab({super.key});

  @override
  State<ClinicTab> createState() => _ClinicTabState();
}

class _ClinicTabState extends State<ClinicTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: white,
          ),
          backgroundColor: mainBtnColor,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (builder) => ClinicAddService()));
          }),
      body: Column(
        children: [],
      ),
    );
  }
}
