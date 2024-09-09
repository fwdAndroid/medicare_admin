import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicare_admin/utils/colors.dart';

class MedicinesList extends StatefulWidget {
  const MedicinesList({super.key});

  @override
  State<MedicinesList> createState() => _MedicinesListState();
}

class _MedicinesListState extends State<MedicinesList> {
  TextEditingController controller = TextEditingController();
  bool isShowUser = false;
  @override
  Widget build(BuildContext context) {
    return isShowUser
        ? StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("medics")
                .where("medicineName", isGreaterThanOrEqualTo: controller.text)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text('Loading...');
              }

              List<DocumentSnapshot> documents = snapshot.data!.docs;
              return Container(
                height: 400,
                child: ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    var documentData =
                        documents[index].data() as Map<String, dynamic>;
                    return ListTile(
                      onTap: () {},
                      title: Text(
                        documents[index]['medicineName'],
                        style: TextStyle(color: Colors.black),
                      ),
                      subtitle: Text(
                        documents[index]['price'],
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  },
                ),
              );
            },
          )
        : StreamBuilder(
            stream: FirebaseFirestore.instance.collection("medics").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              var data = snapshot.data!.docs;
              if (data.isEmpty) {
                // No records found
                return Center(
                  child: Text('Currently No Orders Available in Our System'),
                );
              }
              return LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  // Calculate the number of columns based on available width
                  int columns = (constraints.maxWidth / 300)
                      .floor(); // Assuming each item has a width of 200

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      var documentData =
                          data[index].data() as Map<String, dynamic>;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          color: mainBtnColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage:
                                      NetworkImage(documentData['photo']),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Name: " + documentData['medicineName'],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Category: " + documentData['category'],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            });
  }
}
