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
    required this.averageRating,
    required this.ratingCount,
  });

  final int likesCount;
  final String image;
  final List<String> searchKey;
  final List<AddOn>? addOn;
  final int price;
  final List<AddOn>? extra;
  final String name;
  final String fastFoodId;
  final String fastFoodName;
  final String description;
  final String id;
  final String type;
  final double averageRating;
  final double ratingCount;

  factory FoodItemDataModel.fromMap(Map<String, dynamic> json) {
    return FoodItemDataModel(
      likesCount: json["likes_count"],
      image: json["image"],
      searchKey: List<String>.from(json["search_key"].map((x) => x)),
      addOn: json["addOn"] == null
          ? null
          : List<AddOn>.from(json["addOn"].map((x) => AddOn.fromMap(x))),
      price: json["price"],
      extra: json["extra"] == null
          ? null
          : List<AddOn>.from(json["extra"].map((x) => AddOn.fromMap(x))),
      name: json["name"],
      fastFoodId: json["fast_food_id"],
      fastFoodName: json["fast_food_name"],
      description: json["description"],
      id: json["id"],
      type: json["type"],
      averageRating: json["average_rating"] ?? 0.0,
      ratingCount: json["rating_count"] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "likes_count": likesCount,
      "image": image,
      "search_key": List<dynamic>.from(searchKey.map((x) => x)),
      "addOn": addOn == null
          ? null
          : List<dynamic>.from(addOn!.map((x) => x.toMap())),
      "price": price,
      "extra": extra == null
          ? null
          : List<dynamic>.from(extra!.map((x) => x.toMap())),
      "name": name,
      "fast_food_id": fastFoodId,
      "fast_food_name": fastFoodName,
      "description": description,
      "id": id,
      "type": type,
      "average_rating": averageRating,
      "rating_count": ratingCount,
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
