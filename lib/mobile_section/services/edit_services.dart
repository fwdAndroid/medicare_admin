import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicare_admin/mobile_section/main/main_dashboard.dart';
import 'package:medicare_admin/mobile_section/services/add_services.dart';
import 'package:medicare_admin/utils/buttons.dart';
import 'package:medicare_admin/utils/colors.dart';
import 'package:medicare_admin/utils/image_utils.dart';
import 'package:medicare_admin/widgets/text_form_field.dart';

class EditServices extends StatefulWidget {
  final uuid;
  const EditServices({super.key, required this.uuid});

  @override
  State<EditServices> createState() => _EditServicesState();
}

class _EditServicesState extends State<EditServices> {
  TextEditingController serviceDescription = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController discount = TextEditingController();
  bool _isLoading = false;
  Uint8List? _image;
  String? imageUrl;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    // Fetch data from Firestore
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('services')
        .doc(widget.uuid)
        .get();

    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // Update the controllers with the fetched data
    setState(() {
      serviceDescription.text = data['serviceDescription'];
      price.text = data['price'];
      discount.text = data['discount'];
      imageUrl = data['photoURL'];
    });
  }

  Future<void> selectImage() async {
    Uint8List ui = await pickImage(ImageSource.gallery);
    setState(() {
      _image = ui;
    });
  }

  Future<String> uploadImageToStorage(Uint8List image) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('services')
        .child('${FirebaseAuth.instance.currentUser!.uid}.jpg');
    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: colorwhite,
              )),
          title: Text(
            "Edit Service",
            style: GoogleFonts.workSans(
                color: colorwhite, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: mainBtnColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () => selectImage(),
                  child: _image != null
                      ? CircleAvatar(
                          radius: 59, backgroundImage: MemoryImage(_image!))
                      : imageUrl != null
                          ? CircleAvatar(
                              radius: 59,
                              backgroundImage: NetworkImage(imageUrl!))
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset("assets/Choose Image.png"),
                            ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormInputField(
                    controller: serviceDescription,
                    hintText: "Description",
                    IconSuffix: Icons.text_decrease,
                    textInputType: TextInputType.text),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: TextFormInputField(
                    controller: price,
                    hintText: "Price",
                    IconSuffix: Icons.price_change,
                    textInputType: TextInputType.number),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: TextFormInputField(
                    controller: discount,
                    hintText: "Discount",
                    IconSuffix: Icons.discord,
                    textInputType: TextInputType.number),
              ),
              Center(
                child: _isLoading
                    ? CircularProgressIndicator(
                        color: mainBtnColor,
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SaveButton(
                            color: mainBtnColor,
                            title: "Confirm",
                            onTap: () async {
                              setState(() {
                                _isLoading = true;
                              });
                              setState(() {
                                _isLoading = true;
                              });

                              String? downloadUrl;
                              if (_image != null) {
                                downloadUrl =
                                    await uploadImageToStorage(_image!);
                              } else {
                                downloadUrl = imageUrl;
                              }

                              await FirebaseFirestore.instance
                                  .collection("services")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .update({
                                "serviceDescription": serviceDescription.text,
                                "price": int.parse(price.text),
                                "discount": int.parse(discount.text),
                                "photoURL": downloadUrl
                              });
                              setState(() {
                                _isLoading = false;
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => MainDashboard()));
                              showMessageBar(
                                  "Medical Services Updated Successfully ",
                                  context);
                            }),
                      ),
              ),
            ],
          ),
        ));
  }
}
