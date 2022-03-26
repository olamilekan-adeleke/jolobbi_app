import '../model/food_item_data_model.dart';
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

  Future<List<FoodItemDataModel>> getFoodItems({
    int limit = 10,
    String? lastDocId,
    int? timeAdded,
  }) async {
    List<Map<String, dynamic>> _foodItemRawData =
        await _foodRepository.getFoodItem(
      limit: limit,
      lastDocId: lastDocId,
      timeAdded: timeAdded,
    );

    List<FoodItemDataModel> foodList = _foodItemRawData
        .map((Map<String, dynamic> e) => FoodItemDataModel.fromMap(e))
        .toList();

    return foodList;
  }
}
