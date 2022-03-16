import '../enum/food_enum.dart';
import 'food_vendor_data_model.dart';

class FoodVendorStateModel {
  FoodVendorStateModel({
    this.status = FoodVendorStatus.unknown,
    this.errorText = "",
    List<FoodVendorDataModel>? foodVendorDataModels,
  }) : foodVendorDataModels = foodVendorDataModels ?? [];

  final FoodVendorStatus status;
  final String errorText;
  List<FoodVendorDataModel> foodVendorDataModels = [];

  

  FoodVendorStateModel copyWith({
    FoodVendorStatus? status,
    String? errorText,
    List<FoodVendorDataModel>? foodVendorDataModels,
  }) {
    return FoodVendorStateModel(
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
      foodVendorDataModels:  foodVendorDataModels ?? this.foodVendorDataModels,
    );
  }
}
