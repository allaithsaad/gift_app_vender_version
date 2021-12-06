import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductService {
  var _producteCollectionRef =
      FirebaseFirestore.instance.collection('productesNew');
  // .where('storeId', isEqualTo: FirebaseAuth.instance.currentUser!.uid);

  Future<List<QueryDocumentSnapshot>> getProduct() async {
    var value = await _producteCollectionRef.get();
    return value.docs;
  }
}
