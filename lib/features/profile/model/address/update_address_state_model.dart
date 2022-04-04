import '../../enum/profile_enum.dart';

class UpdateAddressStateModel {
  final String location;
  final String locationDescription;
  final String tag;
  final double lat;
  final double lng;
  final UpdateAddressStatus status;
  final String errorText;

  UpdateAddressStateModel({
    this.location = '',
    this.locationDescription = '',
    this.tag = '',
    this.errorText = '',
    this.lat = 0,
    this.lng = 0,
    this.status = UpdateAddressStatus.unknown,
  });

  UpdateAddressStateModel copyWith({
    String? location,
    String? locationDescription,
    String? tag,
    double? lat,
    double? lng,
    UpdateAddressStatus? status,
    String? errorText,
  }) {
    return UpdateAddressStateModel(
      location: location ?? this.location,
      locationDescription: locationDescription ?? this.locationDescription,
      tag: tag ?? this.tag,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
    );
  }

  UpdateAddressStateModel reset() {
    return UpdateAddressStateModel(
      location: '',
      locationDescription: '',
      tag: '',
      lat: 0,
      lng: 0,
      errorText: '',
      status: UpdateAddressStatus.success,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'location': location,
      'locationDescription': locationDescription,
      'tag': tag,
      'lat': lat,
      'lng': lng,
    };
  }
}
