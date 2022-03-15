import '../enum/food_enum.dart';
import 'food_vendor_data_model.dart';

class FoodVendorStateModel {
  FoodVendorStateModel({
    this.status = FoodVendorStatus.unknown,
    this.errorText = "",
    this.foodVendorDataModel,
  });

  final FoodVendorStatus status;
  final String errorText;
  final FoodVendorDataModel? foodVendorDataModel;

  FoodVendorStateModel copyWith({
    FoodVendorStatus? status,
    String? errorText,
    FoodVendorDataModel? foodVendorDataModel,
  }) {
    return FoodVendorStateModel(
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
      foodVendorDataModel: foodVendorDataModel ?? this.foodVendorDataModel,
    );
  }
}
