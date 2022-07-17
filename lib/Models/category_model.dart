class CategoryModel {
  String? imageUrl, name, fcategoryId;
  int? categoryId;

  CategoryModel({
    this.imageUrl,
    this.name,
    this.categoryId,
    this.fcategoryId,
  });

  CategoryModel.fromJson(Map<dynamic, dynamic> map) {
    imageUrl = map['imageUrl'];

    name = map['name'];
    categoryId = map['categoryId'];
    fcategoryId = map['fcategoryId'];
  }

  toJson() {
    return {
      'imageUrl': imageUrl,
      'name': name,
      'categoryId': categoryId,
      'fcategoryId': fcategoryId,
    };
  }
}
