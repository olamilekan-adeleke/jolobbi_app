import '../enum/food_enum.dart';
import 'food_vendor_data_model.dart';

class FoodVendorStateModel {
  FoodVendorStateModel({
    this.status = FoodVendorStatus.unknown,
    this.errorText = "",
  });

  final FoodVendorStatus status;
  final String errorText;
  final List<FoodVendorDataModel> foodVendorDataModels = [];

  FoodVendorStateModel copyWith({
    FoodVendorStatus? status,
    String? errorText,
  }) {
    return FoodVendorStateModel(
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
    );
  }

  void addFoodVendor(FoodVendorDataModel foodVendorDataModel) {
    foodVendorDataModels.add(foodVendorDataModel);
  }
}
