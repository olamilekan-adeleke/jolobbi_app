import '../model/food_vendor_data_model.dart';
import '../repository/food_repository.dart';

class FoodVendorService {
  final FoodRepository _foodRepository = FoodRepository();

  FoodVendorService() {
    getFoodVendor();
  }

  Future<List<FoodVendorDataModel>> getFoodVendor() async {
    List<Map<String, dynamic>> _foodVendorRawData =
        await _foodRepository.getFoodVendor();

    List<FoodVendorDataModel> vendorList = _foodVendorRawData
        .map((Map<String, dynamic> e) => FoodVendorDataModel.fromMap(e))
        .toList();

    return vendorList;
  }
}
