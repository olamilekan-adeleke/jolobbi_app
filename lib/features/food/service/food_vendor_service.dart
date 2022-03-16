import '../model/food_vendor_data_model.dart';
import '../repository/food_repository.dart';

class FoodVendorService {
  final FoodRepository _foodRepository = FoodRepository();

 

  Future<List<FoodVendorDataModel>> getFoodVendors() async {
    List<Map<String, dynamic>> _foodVendorRawData =
        await _foodRepository.getFoodVendor();

    List<FoodVendorDataModel> vendorList = _foodVendorRawData
        .map((Map<String, dynamic> e) => FoodVendorDataModel.fromMap(e))
        .toList();

    // todo: save item to local storage

    return vendorList;
  }

  Future<void> getFoodItems() async {
    await _foodRepository.getFoodItem();
  }
}
