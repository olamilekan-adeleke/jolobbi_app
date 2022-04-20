import 'dart:convert';

class UserProfileDataModel {
  final String id;
  final String email;
  final String password;
  final String name;
  final String? mobile;
  final String? profileUrl;
  final int? dateJoined;
  final List<AddressModel>? address;

  const UserProfileDataModel({
    this.id = '',
    this.email = '',
    this.password = '',
    this.name = '',
    this.mobile = '',
    this.profileUrl,
    this.dateJoined,
    this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'name': name,
      'mobile': mobile,
      'profileUrl': profileUrl,
      'dateJoined': dateJoined,
      'address': address?.map((ele) => ele.toMap()).toList(),
    };
  }

   Map<String, dynamic> toMapString() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'mobile': mobile.toString(),
      'profileUrl': profileUrl,
    };
  }

  factory UserProfileDataModel.fromMap(Map<String, dynamic> map) {
    return UserProfileDataModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      name: map['name'] ?? '',
      mobile: map['mobile'],
      profileUrl: map['profileUrl'],
      dateJoined: map['dateJoined']?.toInt(),
      address: map['address'] == null
          ? null
          : List<AddressModel>.from(
              map['address'].map((ele) => AddressModel.fromMap(ele)),
            ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfileDataModel.fromJson(String source) =>
      UserProfileDataModel.fromMap(json.decode(source));

  UserProfileDataModel copyWith({
    String? id,
    String? email,
    String? password,
    String? name,
    String? mobile,
    String? profileUrl,
    int? dateJoined,
  }) {
    return UserProfileDataModel(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      profileUrl: profileUrl ?? this.profileUrl,
      dateJoined: dateJoined ?? this.dateJoined,
    );
  }
}

class AddressModel {
  final String location;
  final String locationDescription;
  final String tag;
  final double lat;
  final double lng;

  AddressModel({
    required this.location,
    required this.locationDescription,
    required this.tag,
    required this.lat,
    required this.lng,
  });

  Map<String, dynamic> toMap() {
    return {
      'location': location,
      'locationDescription': locationDescription,
      'tag': tag,
      'lat': lat,
      'lng': lng,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      location: map['location'] ?? '',
      locationDescription: map['locationDescription'] ?? '',
      tag: map['tag'] ?? '',
      lat: map['lat']?.toDouble() ?? 0.0,
      lng: map['lng']?.toDouble() ?? 0.0,
    );
  }
}
