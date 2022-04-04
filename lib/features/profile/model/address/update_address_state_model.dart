import '../../enum/profile_enum.dart';

class UpdateAddressStateModel {
  final String location;
  final String locationDescription;
  final String tag;
  final double lat;
  final double lng;
  final UpdateAddressStatus status;

  UpdateAddressStateModel({
    this.location = '',
    this.locationDescription = '',
    this.tag = '',
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
  }) {
    return UpdateAddressStateModel(
      location: location ?? this.location,
      locationDescription: locationDescription ?? this.locationDescription,
      tag: tag ?? this.tag,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      status: status ?? this.status,
    );
  }
}
