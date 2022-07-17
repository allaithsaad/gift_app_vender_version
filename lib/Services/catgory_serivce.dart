import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CategoryService {
  var _producteCollectionRef =
      FirebaseFirestore.instance.collection('Category');

  // .where('storeId', isEqualTo: FirebaseAuth.instance.currentUser!.uid);

  Future<List<QueryDocumentSnapshot>> getCategory() async {
    var value = await _producteCollectionRef.get();
    return value.docs;
  }
}
