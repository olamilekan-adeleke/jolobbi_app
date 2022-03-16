import '../enum/food_enum.dart';
import 'food_item_data_model.dart';

class FoodItemStateModel {
  FoodItemStateModel({
    this.status = FoodItemStatus.unknown,
    this.errorText = "",
    List<FoodItemDataModel>? foodItemDataModel,
  }) : foodItemDataModel =foodItemDataModel ?? [];

  final FoodItemStatus status;
  final String errorText;
  List<FoodItemDataModel> foodItemDataModel;

  FoodItemStateModel copyWith({
    FoodItemStatus? status,
    String? errorText,
    List<FoodItemDataModel>? foodItemDataModels,
  }) {
    return FoodItemStateModel(
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
      foodItemDataModel:  foodItemDataModels ?? this.foodItemDataModel,
    );
  }

  
}