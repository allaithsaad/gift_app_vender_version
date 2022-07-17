class CategoriesModel {
  var iconName;
  String? name;
  int? categoryId;
  bool? categoryStatues;

  CategoriesModel(this.iconName, this.name, this.categoryId);

  CategoriesModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    iconName = map['iconName'];
    name = map['name'];
    categoryId = map['categoryId'];
    categoryStatues = map['categoryStatues'];
  }

  toJson() {
    return {
      'iconName': iconName,
      'name': name,
      'categoryId': categoryId,
      'categoryStatues': categoryStatues,
    };
  }
}
