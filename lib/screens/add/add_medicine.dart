import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:medicare_admin/screens/database/database.dart';
import 'package:medicare_admin/screens/database/storage_methods.dart';
import 'package:medicare_admin/screens/main/home_page.dart';
import 'package:medicare_admin/utils/app_colors.dart';
import 'package:medicare_admin/utils/app_style.dart';
import 'package:medicare_admin/utils/buttons.dart';
import 'package:medicare_admin/utils/colors.dart';
import 'package:medicare_admin/utils/image_utils.dart';
import 'package:medicare_admin/utils/input_text.dart';
import 'package:medicare_admin/utils/message_utils.dart';
import 'package:uuid/uuid.dart';

class AddMedicine extends StatelessWidget {
  const AddMedicine({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: const [
                _FormSection(),
                _ImageSection(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _FormSection extends StatefulWidget {
  const _FormSection({Key? key}) : super(key: key);

  @override
  State<_FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends State<_FormSection> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  var uuid = Uuid().v4();
  //Image
  Uint8List? _image;
  //loader
  bool isLoading = false;

  String dropdownvalue = 'Pediatric';

  var items = [
    'Pediatric',
    'Hypertension, Diabetes',
    'Tablets',
    'Capsules',
    'Syrups',
    'Injections',
    'Topical',
    'Inhalers',
    'Eye/Ear Drops',
    'Infections, Pain Relief',
    'Generic Medications',
    'Oncology',
    'Rheumatology',
    'Endocrinology',
    'Psychiatry',
    'Medicine',
    'Oncology',
    'ENT'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.neutral,
        width: 448,
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            "Add Medicine",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25.63),
          ),
          const SizedBox(height: 41),
          GestureDetector(
            onTap: () => selectImage(),
            child: Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 59, backgroundImage: MemoryImage(_image!))
                    : GestureDetector(
                        onTap: () => selectImage(),
                        child: CircleAvatar(
                          radius: 59,
                          backgroundImage: AssetImage('assets/person.png'),
                        ),
                      ),
              ],
            ),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Medicine Name",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ),
          const SizedBox(height: 9),
          InputText(
            controller: _nameController,
            labelText: " Medicine Name",
            keyboardType: TextInputType.visiblePassword,
            onChanged: (value) {},
            onSaved: (val) {},
            textInputAction: TextInputAction.done,
            isPassword: false,
            enabled: true,
          ),
          const SizedBox(height: 9),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Category",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ),
          const SizedBox(height: 9),
          Container(
            decoration: BoxDecoration(
              color: Color(0xffF6F7F9),
            ),
            margin:
                const EdgeInsets.only(left: 8.0, right: 8, top: 4, bottom: 5),
            padding: const EdgeInsets.only(left: 8.0, right: 8, top: 4),
            child: DropdownButton(
              isExpanded: true,
              value: dropdownvalue,
              underline: SizedBox(),
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: black,
              ),
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(
                    items,
                    style: GoogleFonts.nunitoSans(fontSize: 12),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
            ),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Medicine Price",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ),
          const SizedBox(height: 9),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              focusedBorder: AppStyles.focusedBorder,
              disabledBorder: AppStyles.focusBorder,
              enabledBorder: AppStyles.focusBorder,
              errorBorder: AppStyles.focusErrorBorder,
              focusedErrorBorder: AppStyles.focusErrorBorder,
              hintText: "Price",
              alignLabelWithHint: false,
              filled: true,
            ),
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(height: 30),
          SaveButton(
              color: mainBtnColor,
              title: "Add Medicine",
              onTap: () async {
                if (_image == null) {
                  showMessageBar("Photo is required", context);
                } else if (_nameController.text.isEmpty) {
                  showMessageBar("Medicine Name is required", context);
                } else if (_passwordController.text.isEmpty) {
                  showMessageBar("Medicine price is required", context);
                } else {
                  setState(() {
                    isLoading = true;
                  });
                  try {
                    String photoURL =
                        await StorageMethods().uploadImageToStorage(
                      'ProfilePics',
                      _image!,
                    );
                    print("Photo URL: $photoURL");
                    await FirebaseFirestore.instance
                        .collection("medics")
                        .doc(uuid)
                        .set({
                      "category": dropdownvalue,
                      "price": int.parse(_passwordController.text.trim()),
                      "medicineName": _nameController.text.trim(),
                      "photo": photoURL,
                    });
                    print("Medicine added successfully");
                  } catch (e) {
                    print("Error adding medicine: $e");
                    showMessageBar("Error adding medicine: $e", context);
                  }
                }
                setState(() {
                  isLoading = false;
                });
              })
        ]));
  }

  //Functions
  selectImage() async {
    Uint8List ui = await pickImage(ImageSource.gallery);
    setState(() {
      _image = ui;
    });
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
          ))
        ],
      ),
    );
  }
}
