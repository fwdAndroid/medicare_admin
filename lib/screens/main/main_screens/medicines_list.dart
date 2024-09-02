import 'package:flutter/material.dart';

class MedicinesList extends StatefulWidget {
  const MedicinesList({super.key});

  @override
  State<MedicinesList> createState() => _MedicinesListState();
}

class _MedicinesListState extends State<MedicinesList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
              "Related to Products Api Once Our Product Api Ready than result of recent order shows here")
        ],
      ),
    );
  }
}
