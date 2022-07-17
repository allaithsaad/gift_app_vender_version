import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ExtrasProductService {
  var _producteCollectionRef = FirebaseFirestore.instance
      .collection('Store')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('Extras');
  // .where('storeId', isEqualTo: FirebaseAuth.instance.currentUser!.uid);

  Future<List<QueryDocumentSnapshot>> getExtrasProduct() async {
    var value = await _producteCollectionRef.get();
    return value.docs;
  }
}
