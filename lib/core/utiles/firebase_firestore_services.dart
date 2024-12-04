import 'package:cloud_firestore/cloud_firestore.dart';

class Firestore {
  static Future<QuerySnapshot<Map<String, dynamic>>> getCollectionData({required String collectionPath}) async {
    return await FirebaseFirestore.instance.collection(collectionPath).get();
  }

  static Future<DocumentSnapshot<Map<String, dynamic>>> getDocumentData({required String collectionPath, required String docName}) async {
    return await FirebaseFirestore.instance.collection(collectionPath).doc(docName).get();
  }

  static Future<dynamic> getField({required String collectionPath, required String docName, required String key}) async {
    var data = await FirebaseFirestore.instance.collection(collectionPath).doc(docName).get();
    return data.data()![key];
  }

  static Future<void> setField({required String collectionPath, required String docName, required Map<String, dynamic> data, bool merge = true}) async {
    await FirebaseFirestore.instance.collection(collectionPath).doc(docName).set(data, SetOptions(merge: merge));
  }

  static Future<void> updateField({required String collectionPath, required String docName, required Map<String, dynamic> data}) async {
    await FirebaseFirestore.instance.collection(collectionPath).doc(docName).update(data);
  }

  static Future<void> deleteField({required String collectionPath, required String docName, required String key}) async {
    await FirebaseFirestore.instance.collection(collectionPath).doc(docName).update(<String, dynamic>{
      key: FieldValue.delete(),
    });
  }

  static Future<void> deleteDoc({required String collectionPath, required String docName, required Map<String, dynamic> data}) async {
    await FirebaseFirestore.instance.collection(collectionPath).doc(docName).delete();
  }
}
