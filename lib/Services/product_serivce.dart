import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  var _producteCollectionRef =
      FirebaseFirestore.instance.collection('productesNew1');
  // .where('storeId', isEqualTo: FirebaseAuth.instance.currentUser!.uid);

  Future<List<QueryDocumentSnapshot>> getProduct() async {
    var value = await _producteCollectionRef.get();
    return value.docs;
  }
}
