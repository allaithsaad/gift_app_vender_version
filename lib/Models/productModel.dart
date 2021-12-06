

class ProductModel {
  String? name, image, description, storeId, componentId,fProductId;
  bool? available, favorite;
  int? discount, price, popular,productId,categoryId,quantity,productStates;

  ProductModel({
    this.name,
    this.image,
    this.description,
    this.storeId,
    this.componentId,
    this.fProductId,
    this.available,
    this.favorite,
    this.discount,
    this.price,
    this.popular,
    this.productId,
    this.categoryId,
    this.quantity,
    this.productStates
  });

  ProductModel.fromJson(Map<dynamic, dynamic> map) {
    name = map['name'];
    image = map['image'];
    description = map['description'];
    storeId = map['storeId'];
    componentId = map['componentId'];
    fProductId = map['fProductId'];
    available = map['available'];
    favorite = map['favorite'];
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
      'componentId': componentId,
      'fProductId': fProductId,
      'available': available,
      'favorite': favorite,
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
