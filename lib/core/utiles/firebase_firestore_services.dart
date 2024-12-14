import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  FirestoreServices();

  final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> getCollectionData(String collectionPath) async {
    return await firestoreInstance.collection(collectionPath).get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDocumentData(String collectionPath, String docName) async {
    return await getDocumentRef(collectionPath, docName).get();
  }

  DocumentReference<Map<String, dynamic>> getDocumentRef(String collectionPath, String docName) {
    return firestoreInstance.collection(collectionPath).doc(docName);
  }

  CollectionReference<Map<String, dynamic>> getCollectionRef(String collectionPath) {
    return firestoreInstance.collection(collectionPath);
  }

  Future<dynamic> getField(String collectionPath, String docName, String key) async {
    var data = await firestoreInstance.collection(collectionPath).doc(docName).get();
    return data.data()![key];
  }

  Future<void> setDocument(String collectionPath, Map<String, dynamic> data, [String? docName, bool merge = true]) async {
    await firestoreInstance.collection(collectionPath).doc(docName).set(data, SetOptions(merge: merge));
  }

  Future<void> updateField(String collectionPath, String docName, Map<String, dynamic> data) async {
    await firestoreInstance.collection(collectionPath).doc(docName).update(data);
  }

  Future<void> deleteField(String collectionPath, String docName, String key) async {
    await firestoreInstance.collection(collectionPath).doc(docName).update(<String, dynamic>{
      key: FieldValue.delete(),
    });
  }

  Future<void> deleteDoc(String collectionPath, String docName) async {
    await firestoreInstance.collection(collectionPath).doc(docName).delete();
  }
}
