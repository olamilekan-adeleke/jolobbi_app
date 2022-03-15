import '../enum/food_enum.dart';
import 'food_item_data_model.dart';

class FoodItemStateModel {
  FoodItemStateModel({
    this.status = FoodItemStatus.unknown,
    this.errorText = "",
  });

  final FoodItemStatus status;
  final String errorText;
  final List<FoodItemDataModel> foodItemDataModel = [];

  FoodItemStateModel copyWith({
    FoodItemStatus? status,
    String? errorText,
  }) {
    return FoodItemStateModel(
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
    );
  }

  void addFoodItem(FoodItemDataModel foodItemDataModel) {
    this.foodItemDataModel.add(foodItemDataModel);
  }
}
