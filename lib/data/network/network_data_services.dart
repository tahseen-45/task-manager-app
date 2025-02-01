import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:internship_task/utils/utils.dart';

// Service class for Firebase Firestore operations
class NetworkDataServices {
  // Dynamic function that returns Map<String,dynamic> data or null
  // so no need to create functions again and again to get data from Firebase
  // Firestore Collection, so that achieves solid principles
  Future<dynamic> getCollectionDocFields(
      String collectionName, String docId) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(docId)
          .get();
      if (snapshot.exists) {
        var data = snapshot.data();
        if (data is Map<String, dynamic>) {
          return data;
        } else {
          Utils.flutterToast("The data is not in recognized format");
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      Utils.flutterToast(e.toString());
      return null;
    }
  }
  // function to add data to Firebase Firestore
  Future<void> addCollectionDocFields(
      String collectionName, Map<String, dynamic> mapData) async {
    try {
      await FirebaseFirestore.instance.collection(collectionName).add(mapData);
    } catch (e) {
      Utils.flutterToast(e.toString());
    }
  }
}
