class FoodVendorDataModel {
  FoodVendorDataModel({
    required this.image,
    required this.searchKey,
    required this.contact,
    required this.numberOfRatings,
    required this.name,
    required this.rating,
    required this.location,
    required this.id,
    required this.categories,
  });

  final String image;
  final List<String> searchKey;
  final FoodVendorContact contact;
  final int numberOfRatings;
  final String name;
  final double rating;
  final FoodVendorLocation location;
  final String id;
  final List<String> categories;

  factory FoodVendorDataModel.fromMap(Map<String, dynamic> json) {
    return FoodVendorDataModel(
      image: json["image"],
      searchKey: List<String>.from(json["search_key"].map((x) => x)),
      contact: FoodVendorContact.fromMap(json["contact"]),
      numberOfRatings: json["number_of_ratings"],
      name: json["name"],
      rating: json["rating"].toDouble(),
      location: FoodVendorLocation.fromMap(json["location"]),
      id: json["id"],
      categories: List<String>.from(json["categories"].map((x) => x)),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "image": image,
      "search_key": List<dynamic>.from(searchKey.map((x) => x)),
      "contact": contact.toMap(),
      "number_of_ratings": numberOfRatings,
      "name": name,
      "rating": rating,
      "location": location.toMap(),
      "id": id,
      "categories": List<dynamic>.from(categories.map((x) => x)),
    };
  }
}

class FoodVendorContact {
  FoodVendorContact({
    required this.number,
    required this.email,
  });

  final int number;
  final String email;

  factory FoodVendorContact.fromMap(Map<String, dynamic> json) {
    return FoodVendorContact(
      number: json["number"],
      email: json["email"],
    );
  }

  Future<Map<String, dynamic>> toMap() async {
    return {
      "number": number,
      "email": email,
    };
  }
}

class FoodVendorLocation {
  FoodVendorLocation({
    required this.locationName,
    required this.locationDes,
    required this.lng,
    required this.lat,
  });

  final String locationName;
  final String locationDes;
  final double lng;
  final double lat;

  factory FoodVendorLocation.fromMap(Map<String, dynamic> json) {
    return FoodVendorLocation(
      locationName: json["location_name"],
      locationDes: json["location_des"],
      lng: json["lng"].toDouble(),
      lat: json["lat"].toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "location_name": locationName,
      "location_des": locationDes,
      "lng": lng,
      "lat": lat,
    };
  }
}
