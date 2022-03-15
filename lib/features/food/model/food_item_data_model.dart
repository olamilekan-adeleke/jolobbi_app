class FoodItemDataModel {
  FoodItemDataModel({
    required this.likesCount,
    required this.image,
    required this.searchKey,
    required this.addOn,
    required this.price,
    required this.extra,
    required this.name,
    required this.fastFoodId,
    required this.fastFoodName,
    required this.description,
    required this.id,
    required this.type,
  });

  final int likesCount;
  final String image;
  final List<String> searchKey;
  final List<AddOn> addOn;
  final int price;
  final List<AddOn> extra;
  final String name;
  final String fastFoodId;
  final String fastFoodName;
  final String description;
  final String id;
  final String type;

  factory FoodItemDataModel.fromMap(Map<String, dynamic> json) {
    return FoodItemDataModel(
      likesCount: json["likes_count"],
      image: json["image"],
      searchKey: List<String>.from(json["search_key"].map((x) => x)),
      addOn: List<AddOn>.from(json["addOn"].map((x) => AddOn.fromMap(x))),
      price: json["price"],
      extra: List<AddOn>.from(json["extra"].map((x) => AddOn.fromMap(x))),
      name: json["name"],
      fastFoodId: json["fast_food_id"],
      fastFoodName: json["fast_food_name"],
      description: json["description"],
      id: json["id"],
      type: json["type"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "likes_count": likesCount,
      "image": image,
      "search_key": List<dynamic>.from(searchKey.map((x) => x)),
      "addOn": List<dynamic>.from(addOn.map((x) => x.toMap())),
      "price": price,
      "extra": List<dynamic>.from(extra.map((x) => x.toMap())),
      "name": name,
      "fast_food_id": fastFoodId,
      "fast_food_name": fastFoodName,
      "description": description,
      "id": id,
      "type": type,
    };
  }
}

class AddOn {
  AddOn({
    required this.image,
    required this.price,
    required this.name,
  });

  final String image;
  final int price;
  final String name;

  factory AddOn.fromMap(Map<String, dynamic> json) {
    return AddOn(
      image: json["image"],
      price: json["price"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "image": image,
      "price": price,
      "name": name,
    };
  }
}
