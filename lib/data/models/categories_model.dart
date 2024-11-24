class CategoriesModel {
  num? categoryId;
  String? name;
  String? image;

  CategoriesModel({
    required this.categoryId,
    required this.name,
    required this.image,
  });

    CategoriesModel.fromJson(Map<String ,dynamic> json){
      categoryId = json["category_id"];
      name = json["name"];
      image = json["image"];
    }
}
