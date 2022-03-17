import '../enum/food_enum.dart';
import 'food_item_data_model.dart';

class FoodItemStateModel {
  FoodItemStateModel({
    this.status = FoodItemStatus.unknown,
    this.errorText = "",
    List<FoodItemDataModel>? foodItems,
    List<FoodItemDataModel>? drinkItems,
    List<FoodItemDataModel>? snackItems,
  })  : foodItems = foodItems ?? [],
        drinkItems = drinkItems ?? [],
        snackItems = snackItems ?? [];

  final FoodItemStatus status;
  final String errorText;
  List<FoodItemDataModel> foodItems;
  List<FoodItemDataModel> drinkItems;
  List<FoodItemDataModel> snackItems;

  FoodItemStateModel copyWith({
    FoodItemStatus? status,
    String? errorText,
    List<FoodItemDataModel>? foodItems,
    List<FoodItemDataModel>? drinkItems,
    List<FoodItemDataModel>? snackItems,
  }) {
    return FoodItemStateModel(
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
      foodItems: foodItems ?? this.foodItems,
      drinkItems: drinkItems ?? this.drinkItems,
      snackItems: snackItems ?? this.snackItems,
    );
  }
}
