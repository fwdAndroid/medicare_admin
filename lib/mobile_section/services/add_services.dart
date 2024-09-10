import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicare_admin/mobile_section/main/main_dashboard.dart';
import 'package:medicare_admin/screens/database/database.dart';
import 'package:medicare_admin/screens/database/storage_methods.dart';
import 'package:medicare_admin/screens/main/home_page.dart';
import 'package:medicare_admin/utils/buttons.dart';
import 'package:medicare_admin/utils/colors.dart';
import 'package:medicare_admin/utils/image_utils.dart';
import 'package:medicare_admin/widgets/text_form_field.dart';
import 'package:uuid/uuid.dart';

class AddServices extends StatefulWidget {
  const AddServices({super.key});

  @override
  State<AddServices> createState() => _AddServicesState();
}

class _AddServicesState extends State<AddServices> {
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var uuid = Uuid().v4();
  final Map<String, List<String>> _serviceCategories = {
    'Body Contouring Packages': [
      '1D Ultrasound Cavitation Slimming Treatment',
      '2D Ultrasound Cavitation + RF + Vacu Slimming Treatment',
      '3D Ultrasound Cavitation + RF + Vacu Slimming Treatment',
      'Multipolar Radiofrequency Skin Lifting for Body and Face'
    ],
    'IV Drips Therapy': [
      'Anti-Aging IV Drips Therapy',
      'Detox IV Drips',
      'Hydration IV Drips',
      'Iron Drip Therapy',
      "NAD+ IV Drips Therapy",
    ],
    'IV Drips Therapy Packages': [
      'Anti-Aging IV Drips Packages',
      'Detox IV Packages',
      'Hydration IV Packages',
      'Iron Drip Packages',
      "NAD+ IV Drips Packages",
    ],
    'Health Checkup': [
      'Bio Advanced Blood Test',
      'Bio Executive Blood Test',
      'Bio Full Body Health Checkup Women',
      'Cancer Screen Male',
      'Cancer Screen Female',
      'Cardiac Risk Blood Test',
      'Female Hormone Profile',
      'Full Male Health Checkup',
      'STD Profile by PRC',
      'STD Risk Assessment'
    ],
    'Physiotherapy': [
      'Physiotherapy',
      'Sports Massage 50 min',
      'Madero Therapy -  Lymphatic Drainage Massage 50 min',
      'Cupping Therapy',
    ],
  };

  String? _selectedCategory;
  String? _selectedSubCategory;
  List<String> _subCategories = [];
  Uint8List? _image;
  bool isAdded = false;
  // Error message for discount
  String? discountErrorMessage;

  @override
  void initState() {
    super.initState();
    discountController.addListener(_validateDiscount);
  }

  @override
  void dispose() {
    discountController.removeListener(_validateDiscount);
    super.dispose();
  }

  void _validateDiscount() {
    final input = discountController.text;
    if (input.isNotEmpty) {
      final value = int.tryParse(input);
      setState(() {
        discountErrorMessage = (value != null && value > 100)
            ? 'Discount cannot be more than 100%'
            : null;
      });
    } else {
      setState(() {
        discountErrorMessage = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: white),
          backgroundColor: mainBtnColor,
          title: Text(
            "Add Services",
            style: TextStyle(color: white),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () => selectImage(),
                child: _image != null
                    ? CircleAvatar(
                        radius: 59, backgroundImage: MemoryImage(_image!))
                    : GestureDetector(
                        onTap: () => selectImage(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset("assets/Choose Image.png"),
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                child: DropdownButton<String>(
                  value: _selectedCategory,
                  isExpanded: true,
                  hint: Text('Select Category'),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue;
                      _subCategories = _serviceCategories[_selectedCategory]!;
                      _selectedSubCategory = null; // Reset subcategory
                    });
                  },
                  items: _serviceCategories.keys
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 10),

              // Subcategory Dropdown
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8,
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: _selectedSubCategory,
                  hint: Text('Select Subcategory'),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedSubCategory = newValue;
                    });
                  },
                  items: _subCategories
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: descriptionController,
                  maxLines: 12,
                  decoration: InputDecoration(
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(22)),
                        borderSide: BorderSide(
                          color: white,
                        )),
                    contentPadding: EdgeInsets.all(8),
                    fillColor: Color(0xffF6F7F9),
                    hintText: "Description",
                    hintStyle: GoogleFonts.nunitoSans(fontSize: 16),
                    border: InputBorder.none,
                  ),
                ),
              ),

              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                      child: TextFormInputField(
                        controller: priceController,
                        hintText: "Price",
                        textInputType: TextInputType.number,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                      child: Column(
                        children: [
                          TextFormInputField(
                            controller: discountController,
                            hintText: "Discount",
                            textInputType: TextInputType.number,
                          ),
                          if (discountErrorMessage != null)
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, top: 4.0),
                              child: Text(
                                discountErrorMessage!,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              isAdded
                  ? Center(child: CircularProgressIndicator())
                  : SaveButton(
                      color: mainBtnColor,
                      title: "Publish",
                      onTap: () async {
                        print("click");
                        if (descriptionController.text.isEmpty) {
                          showMessageBar("Description is Required", context);
                        } else if (_image == null) {
                          showMessageBar("Image is Required", context);
                        } else if (priceController.text.isEmpty) {
                          showMessageBar("Price is Required", context);
                        } else {
                          print("clsasdd");
                          int discount = 0;
                          if (discountController.text.isNotEmpty) {
                            discount =
                                int.tryParse(discountController.text) ?? 0;
                            if (discount > 100) {
                              showMessageBar(
                                  "Discount cannot be more than 100%", context);
                              return;
                            }
                          }

                          setState(() {
                            isAdded = true;
                          });

                          String photoURL =
                              await StorageMethods().uploadImageToStorage(
                            'ProfilePics',
                            _image!,
                          );

                          await FirebaseFirestore.instance
                              .collection("services")
                              .doc(uuid)
                              .set({
                            "serviceCategory": _selectedCategory!,
                            "serviceName": _selectedCategory!,
                            "serviceSubcategory": _selectedSubCategory!,
                            "price": int.parse(priceController.text),
                            "discount": discount,
                            "uuid": uuid,
                            "photoURL": photoURL
                          });
                          // await Database().addServices(
                          //     serviceDescription:
                          //         descriptionController.text.trim(),
                          //     serviceCategory: _selectedCategory!,
                          //     serviceName: _selectedCategory!,
                          //     file: _image!,
                          //     serviceSubcategory: _selectedSubCategory!,
                          //     price: priceController.text.trim(),
                          //     discount: discountController.text);
                          setState(() {
                            isAdded = false;
                          });
                          // Handle the result accordingly
                          showMessageBar(
                              "Service Category Added Successfully", context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => MainDashboard(),
                            ),
                          );
                        }
                      }),
            ],
          ),
        ));
  }

  selectImage() async {
    Uint8List ui = await pickImage(ImageSource.gallery);
    setState(() {
      _image = ui;
    });
  }
}

// Functions
/// Select Image From Gallery

void showMessageBar(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    ),
  );
}
