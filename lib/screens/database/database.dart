import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicare_admin/model/medicine_model.dart';
import 'package:medicare_admin/screens/database/storage_methods.dart';
import 'package:uuid/uuid.dart';

class Database {
  Future<String> addMedicine(
      {required String medicineName,
      required int price,
      required String category,
      required Uint8List file}) async {
    String res = 'Wrong medicineName or uuidword';
    try {
      if (medicineName.isNotEmpty || category.isNotEmpty) {
        String photoURL = await StorageMethods().uploadImageToStorage(
          'ProfilePics',
          file,
        );

        var uuid = Uuid().v4();
        //Add User to the database with modal
        MedicModel userModel = MedicModel(
            medicineName: medicineName,
            category: category,
            price: price,
            uuid: uuid,
            photoURL: photoURL);
        await FirebaseFirestore.instance
            .collection('medicine')
            .doc(uuid)
            .set(userModel.toJson());
        res = 'success';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
