import 'package:get/get.dart';
import 'package:storeapp/Models/productExtrasModel.dart';
import 'package:storeapp/Services/extras_product_serivce.dart';

class ExtrasProductcontroller extends GetxController {
  List<ProductExtrasModel> extarsModel = [];

  List<bool> extarsValueModel = [];

  bool extrasProducIsLoding = false;
  getExtrasProduct() async {
    extarsValueModel.clear();
    extarsModel.clear();
    extrasProducIsLoding = true;
    await ExtrasProductService().getExtrasProduct().then((value) {
      for (int i = 0; i < value.length; i++) {
        extarsModel.add(
          ProductExtrasModel.fromJson(value[i].data() as Map<dynamic, dynamic>),
        );
        extarsValueModel.add(false);
        print(
            'this is laithhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
        print(value[i].data());
      }
    });
    extrasProducIsLoding = false;
    update();
  }
}
