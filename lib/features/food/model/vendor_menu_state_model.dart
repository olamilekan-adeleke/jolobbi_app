import '../enum/food_enum.dart';
import 'food_item_data_model.dart';

class VendorMenuStateModel{
   VendorMenuStateModel({
    this.foodStatus = VendorMenuStatus.unknown,
    this.drinkStatus = VendorMenuStatus.unknown,
    this.snackStatus = VendorMenuStatus.unknown,
    this.foodErrorText = "",
    this.drinkErrorText = "",
    this.snackErrorText = "",
    List<FoodItemDataModel>? foodItems,
    List<FoodItemDataModel>? drinkItems,
    List<FoodItemDataModel>? snackItems,
  })  : foodItems = foodItems ?? [],
        drinkItems = drinkItems ?? [],
        snackItems = snackItems ?? [];

  final VendorMenuStatus foodStatus;
  final VendorMenuStatus drinkStatus;
  final VendorMenuStatus snackStatus;
  final String foodErrorText;
  final String drinkErrorText;
  final String snackErrorText;
  List<FoodItemDataModel> foodItems;
  List<FoodItemDataModel> drinkItems;
  List<FoodItemDataModel> snackItems;

  VendorMenuStateModel copyWith({
    VendorMenuStatus? foodStatus,
    VendorMenuStatus? drinkStatus,
    VendorMenuStatus? snackStatus,
    String? foodErrorText,
    String? drinkErrorText,
    String? snackErrorText,
    List<FoodItemDataModel>? foodItems,
    List<FoodItemDataModel>? drinkItems,
    List<FoodItemDataModel>? snackItems,
  }) {
    return VendorMenuStateModel(
      foodStatus: foodStatus ?? this.foodStatus,
      drinkStatus: drinkStatus ?? this.drinkStatus,
      snackStatus: snackStatus ?? this.snackStatus,
      foodErrorText: foodErrorText ?? this.foodErrorText,
      drinkErrorText: drinkErrorText ?? this.drinkErrorText,
      snackErrorText: snackErrorText ?? this.snackErrorText,
      foodItems: foodItems ?? this.foodItems,
      drinkItems: drinkItems ?? this.drinkItems,
      snackItems: snackItems ?? this.snackItems,
    );
  }
}