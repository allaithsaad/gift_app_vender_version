class ProductModel {
  String? name;
  List<dynamic>? image;

  String? description, storeId, fProductId;
  bool? available;
  int? discount, price, popular, productId, categoryId, quantity, productStates;

  ProductModel(
      {this.name,
      this.image,
      this.description,
      this.storeId,
      this.fProductId,
      this.available,
      this.discount,
      this.price,
      this.popular,
      this.productId,
      this.categoryId,
      this.quantity,
      this.productStates});

  ProductModel.fromJson(Map<dynamic, dynamic> map) {
    name = map['name'];
    image = map['image'];
    description = map['description'];
    storeId = map['storeId'];
    fProductId = map['fProductId'];
    available = map['available'];
    discount = map['discount'];
    price = map['price'];
    popular = map['popular'];
    productId = map['productId'];
    categoryId = map['categoryId'];
    quantity = map['quantity'];
    productStates = map['productStates'];
  }

  toJson() {
    return {
      'name': name,
      'image': image,
      'description': description,
      'storeId': storeId,
      'fProductId': fProductId,
      'available': available,
      'discount': discount,
      'price': price,
      'popular': popular,
      'productId': productId,
      'categoryId': categoryId,
      'quantity': quantity,
      'productStates': productStates,
    };
  }
}
