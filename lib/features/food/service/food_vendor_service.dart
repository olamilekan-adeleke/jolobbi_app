import '../model/food_item_data_model.dart';
import '../model/food_vendor_data_model.dart';
import '../repository/food_repository.dart';

class FoodVendorService {
  final FoodRepository _foodRepository = FoodRepository();

  Future<List<FoodVendorDataModel>> getFoodVendors({
    int limit = 10,
    String? lastDocId,
    String? searchQuery,
  }) async {
    List<Map<String, dynamic>> _foodVendorRawData =
        await _foodRepository.getFoodVendor(
      limit: limit,
      lastDocId: lastDocId,
      searchQuery: searchQuery,
    );

    List<FoodVendorDataModel> vendorList = _foodVendorRawData
        .map((Map<String, dynamic> e) => FoodVendorDataModel.fromMap(e))
        .toList();

    return vendorList;
  }

  Future<List<FoodItemDataModel>> getFoodItems({
    int limit = 10,
    String? lastDocId,
    String? vendorId,
    int? timeAdded,
  }) async {
    List<Map<String, dynamic>> _foodItemRawData =
        await _foodRepository.getFoodItem(
      limit: limit,
      lastDocId: lastDocId,
      timeAdded: timeAdded,
      vendorId: vendorId,
    );

    List<FoodItemDataModel> foodList = _foodItemRawData
        .map((Map<String, dynamic> e) => FoodItemDataModel.fromMap(e))
        .toList();

    return foodList;
  }

  Future<List<FoodItemDataModel>> getDrinkItems({
    int limit = 10,
    String? lastDocId,
    String? vendorId,
    int? timeAdded,
  }) async {
    List<Map<String, dynamic>> _foodItemRawData =
        await _foodRepository.getDrinkItem(
      limit: limit,
      lastDocId: lastDocId,
      timeAdded: timeAdded,
      vendorId: vendorId,
    );

    List<FoodItemDataModel> foodList = _foodItemRawData
        .map((Map<String, dynamic> e) => FoodItemDataModel.fromMap(e))
        .toList();

    return foodList;
  }

  Future<List<FoodItemDataModel>> getSnackItems({
    int limit = 10,
    String? lastDocId,
    String? vendorId,
    int? timeAdded,
  }) async {
    List<Map<String, dynamic>> _foodItemRawData =
        await _foodRepository.getSnackItem(
      limit: limit,
      lastDocId: lastDocId,
      timeAdded: timeAdded,
      vendorId: vendorId,
    );

    List<FoodItemDataModel> foodList = _foodItemRawData
        .map((Map<String, dynamic> e) => FoodItemDataModel.fromMap(e))
        .toList();

    return foodList;
  }
}
