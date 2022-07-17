import 'package:cloud_firestore/cloud_firestore.dart';

class StoresService {
  final CollectionReference _categoriesRef =
      FirebaseFirestore.instance.collection('ProductNew1');
  Future<List<QueryDocumentSnapshot>> getCategories(cateId) async {
    var value =
        await _categoriesRef.where("categoryId", isEqualTo: cateId).get();
    return value.docs;
  }
}
