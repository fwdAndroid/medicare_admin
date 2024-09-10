import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicare_admin/model/doctor_model.dart';
import 'package:medicare_admin/model/medicine_model.dart';
import 'package:medicare_admin/model/service_model.dart';
import 'package:medicare_admin/screens/database/storage_methods.dart';
import 'package:uuid/uuid.dart';

class Database {
  Future<String> addDoctor(
      {required String serviceName,
      required String serviceCategory,
      required String experience,
      required String serviceDescription,
      required int price,
      required Uint8List file}) async {
    String res = 'Wrong Service Name';
    try {
      if (serviceName.isNotEmpty || serviceDescription.isNotEmpty) {
        String photoURL = await StorageMethods().uploadImageToStorage(
          'ProfilePics',
          file,
        );

        var uuid = Uuid().v4();
        //Add User to the database with modal
        DoctorModel userModel = DoctorModel(
            doctorCategory: serviceCategory,
            doctorDescription: serviceDescription,
            experience: experience,
            doctorName: serviceName,
            price: price,
            uuid: uuid,
            photoURL: photoURL);
        await FirebaseFirestore.instance
            .collection('doctors')
            .doc(uuid)
            .set(userModel.toJson());
        res = 'success';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> addServices(
      {required String serviceName,
      required String serviceCategory,
      required String serviceSubcategory,
      required String serviceDescription,
      required String price,
      required String discount,
      required Uint8List file}) async {
    String res = 'Wrong Service Name';
    try {
      if (serviceName.isNotEmpty || serviceDescription.isNotEmpty) {
        String photoURL = await StorageMethods().uploadImageToStorage(
          'ProfilePics',
          file,
        );

        var uuid = Uuid().v4();
        //Add User to the database with modal
        ServiceModel userModel = ServiceModel(
            serviceCategory: serviceCategory,
            serviceDescription: serviceDescription,
            serviceName: serviceName,
            serviceSubcategory: serviceSubcategory,
            discount: discount,
            price: price,
            uuid: uuid,
            photoURL: photoURL);
        await FirebaseFirestore.instance
            .collection('services')
            .doc(uuid)
            .set(userModel.toJson());
        res = 'success';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

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
