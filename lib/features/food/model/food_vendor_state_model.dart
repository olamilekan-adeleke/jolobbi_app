import '../enum/food_enum.dart';
import 'food_vendor_data_model.dart';

class FoodVendorStateModel {
  FoodVendorStateModel({
    this.status = FoodVendorStatus.unknown,
    this.errorText = "",
    this.allErrorText = "",
    List<FoodVendorDataModel>? popularFoodVendorDataModels,
    List<FoodVendorDataModel>? allFoodVendorDataModels,
  }) : popularFoodVendorDataModels = popularFoodVendorDataModels ?? [],
        allFoodVendorDataModels = allFoodVendorDataModels ?? [];

  final FoodVendorStatus status;
  final String errorText;
  final String allErrorText;
  List<FoodVendorDataModel> popularFoodVendorDataModels = [];
  List<FoodVendorDataModel> allFoodVendorDataModels = [];

  FoodVendorStateModel copyWith({
    FoodVendorStatus? status,
    String? errorText,
    String? allErrorText,
    List<FoodVendorDataModel>? popularFoodVendorDataModels,
    List<FoodVendorDataModel>? allFoodVendorDataModels,
  }) {
    return FoodVendorStateModel(
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
      allErrorText: allErrorText ?? this.allErrorText,
      popularFoodVendorDataModels:
          popularFoodVendorDataModels ?? this.popularFoodVendorDataModels,
          allFoodVendorDataModels:
          allFoodVendorDataModels ?? this.allFoodVendorDataModels,
    );
  }
}
