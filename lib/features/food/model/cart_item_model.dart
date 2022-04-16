import 'dart:convert';

class CartItemModel {
  final String image;
  final int price;
  final String name;
  final String fastFoodId;
  final String fastFoodName;
  final String id;
  final String type;
  final List<CartAddOn>? addOn;
  final List<CartAddOn>? extras;
  final int count;

  CartItemModel({
    required this.image,
    required this.price,
    required this.name,
    required this.fastFoodId,
    required this.fastFoodName,
    required this.id,
    required this.type,
    this.addOn,
    this.extras,
    required this.count,
  });

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'price': price,
      'name': name,
      'fastFoodId': fastFoodId,
      'fastFoodName': fastFoodName,
      'id': id,
      'type': type,
      'addOn': addOn?.map((x) => x.toMap()).toList(),
      'extras': extras?.map((x) => x.toMap()).toList(),
      'count': count,
    };
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      image: map['image'] ?? '',
      price: map['price']?.toInt() ?? 0,
      name: map['name'] ?? '',
      fastFoodId: map['fastFoodId'] ?? '',
      fastFoodName: map['fastFoodName'] ?? '',
      id: map['id'] ?? '',
      type: map['type'] ?? '',
      addOn: map['addOn'] != null
          ? List<CartAddOn>.from(map['addOn']?.map((x) => CartAddOn.fromMap(x)))
          : null,
      extras: map['extras'] != null
          ? List<CartAddOn>.from(
              map['extras']?.map((x) => CartAddOn.fromMap(x)))
          : null,
      count: map['count']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItemModel.fromJson(String source) =>
      CartItemModel.fromMap(json.decode(source));

  CartItemModel copyWith({
    String? image,
    int? price,
    String? name,
    String? fastFoodId,
    String? fastFoodName,
    String? id,
    String? type,
    List<CartAddOn>? addOn,
    List<CartAddOn>? extras,
    int? count,
  }) {
    return CartItemModel(
      image: image ?? this.image,
      price: price ?? this.price,
      name: name ?? this.name,
      fastFoodId: fastFoodId ?? this.fastFoodId,
      fastFoodName: fastFoodName ?? this.fastFoodName,
      id: id ?? this.id,
      type: type ?? this.type,
      addOn: addOn ?? this.addOn,
      extras: extras ?? this.extras,
      count: count ?? this.count,
    );
  }

  @override
  String toString() {
    return 'CartItemModel(image: $image, price: $price, name: $name, fastFoodId: $fastFoodId, fastFoodName: $fastFoodName, id: $id, type: $type, addOn: $addOn, extras: $extras, count: $count)';
  }
}

class CartAddOn {
  CartAddOn({
    required this.image,
    required this.price,
    required this.name,
    required this.count,
  });

  final String image;
  final int price;
  final String name;
  final int count;

  factory CartAddOn.fromMap(Map<String, dynamic> json) {
    return CartAddOn(
      image: json["image"],
      price: json["price"],
      name: json["name"],
      count: json["count"] ?? 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "image": image,
      "price": price,
      "name": name,
      "count": count,
    };
  }

  CartAddOn copyWith({
    String? image,
    int? price,
    String? name,
    int? count,
  }) {
    return CartAddOn(
      image: image ?? this.image,
      price: price ?? this.price,
      name: name ?? this.name,
      count: count ?? this.count,
    );
  }

  @override
  String toString() {
    return 'CartAddOn(image: $image, price: $price, name: $name, count: $count)';
  }
}

