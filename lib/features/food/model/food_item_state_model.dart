import '../enum/food_enum.dart';
import 'food_item_data_model.dart';

class FoodItemStateModel {
  FoodItemStateModel({
    this.foodItemStatus = FoodItemStatus.unknown,
    this.snackItemStatus = FoodItemStatus.unknown,
    this.drinkItemStatus = FoodItemStatus.unknown,
    this.foodErrorText = "",
    this.snackErrorText = "",
    this.drinkErrorText = "",
    List<FoodItemDataModel>? foodItems,
    List<FoodItemDataModel>? drinkItems,
    List<FoodItemDataModel>? snackItems,
  })  : foodItems = foodItems ?? [],
        drinkItems = drinkItems ?? [],
        snackItems = snackItems ?? [];

  final FoodItemStatus foodItemStatus;
  final FoodItemStatus snackItemStatus;
  final FoodItemStatus drinkItemStatus;
  final String foodErrorText;
  final String snackErrorText;
  final String drinkErrorText;
  List<FoodItemDataModel> foodItems;
  List<FoodItemDataModel> drinkItems;
  List<FoodItemDataModel> snackItems;

  FoodItemStateModel copyWith({
    FoodItemStatus? foodItemStatus,
    FoodItemStatus? snackItemStatus,
    FoodItemStatus? drinkItemStatus,
    String? foodErrorText,
    String? snackErrorText,
    String? drinkErrorText,
    List<FoodItemDataModel>? foodItems,
    List<FoodItemDataModel>? drinkItems,
    List<FoodItemDataModel>? snackItems,
  }) {
    return FoodItemStateModel(
      foodItemStatus: foodItemStatus ?? this.foodItemStatus,
      snackItemStatus: snackItemStatus ?? this.snackItemStatus,
      drinkItemStatus: drinkItemStatus ?? this.drinkItemStatus,
      foodErrorText: foodErrorText ?? this.foodErrorText,
      snackErrorText: snackErrorText ?? this.snackErrorText,
      drinkErrorText: drinkErrorText ?? this.drinkErrorText,
      foodItems: foodItems ?? this.foodItems,
      drinkItems: drinkItems ?? this.drinkItems,
      snackItems: snackItems ?? this.snackItems,
    );
  }
}
