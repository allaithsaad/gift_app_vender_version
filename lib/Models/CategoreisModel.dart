class CategoriesModel{
  var iconName;
  String? name;
  int? categoryId;

  CategoriesModel(this.iconName,this.name,this.categoryId);

  CategoriesModel.fromJson(Map<dynamic, dynamic> map){
    if (map == null) {
      return;
    }
    iconName = map['iconName'];
    name = map['name'];
    categoryId = map['categoryId'];

  }

  toJson(){
    return{'iconName': iconName,
      'name': name,
      'categoryId': categoryId,

    };
  }
}