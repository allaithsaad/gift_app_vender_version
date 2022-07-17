class ProductExtrasModel {
  String? name, image, description, storeId, fProductId;
  bool? available, multeTimes;
  int? discount, price, popular, productId, productStates;
  DateTime? uploadingDate;

  ProductExtrasModel({
    this.name,
    this.image,
    this.description,
    this.storeId,
    this.fProductId,
    this.available,
    this.multeTimes,
    this.discount,
    this.price,
    this.popular,
    this.productId,
    this.productStates,
    this.uploadingDate,
  });

  ProductExtrasModel.fromJson(Map<dynamic, dynamic> map) {
    name = map['name'];
    image = map['image'];
    description = map['description'];
    storeId = map['storeId'];
    fProductId = map['fProductId'];
    available = map['available'];
    multeTimes = map['multeTimes'];
    discount = map['discount'];
    price = map['price'];
    popular = map['popular'];
    productId = map['productId'];
    productStates = map['productStates'];
    uploadingDate = DateTime.fromMicrosecondsSinceEpoch(
        map['uploadingDate'].microsecondsSinceEpoch);
  }

  toJson() {
    return {
      'name': name,
      'image': image,
      'description': description,
      'storeId': storeId,
      'fProductId': fProductId,
      'available': available,
      'multeTimes': multeTimes,
      'discount': discount,
      'price': price,
      'popular': popular,
      'productId': productId,
      'productStates': productStates,
      'uploadingDate': uploadingDate,
    };
  }
}
