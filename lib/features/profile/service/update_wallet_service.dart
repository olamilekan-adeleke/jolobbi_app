import 'package:jolobbi_app/features/profile/repository/update_address_repository.dart';

class UpdateAddressService {
  static final UpdateAddressRepository _updateAddressRepository =
      UpdateAddressRepository();

  Future<void> addAddress(Map<String, dynamic> data) async {
    await _updateAddressRepository.addAddress(data);
  }
}
