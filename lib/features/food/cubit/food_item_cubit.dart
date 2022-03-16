import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cores/utils/crashlytics_helper.dart';
import '../enum/food_enum.dart';
import '../model/food_item_data_model.dart';
import '../model/food_item_state_model.dart';
import '../service/food_vendor_service.dart';

class FoodItemCubit extends Cubit<FoodItemStateModel> {
  FoodItemCubit(this.foodVendorService) : super(FoodItemStateModel());

  final FoodVendorService foodVendorService;
  static final CrashlyticsHelper _crashlyticsHelper = CrashlyticsHelper();

  Future<void> getFoodItem() async {
    try {
      emit(state.copyWith(status: FoodItemStatus.busy, errorText: ''));

      List<FoodItemDataModel> foodList = await foodVendorService.getFoodItems();

      emit(
        state.copyWith(
          status: FoodItemStatus.success,
          foodItemDataModels: foodList,
        ),
      );
    } catch (e, s) {
      emit(
        state.copyWith(
          status: FoodItemStatus.error,
          errorText: e.toString(),
        ),
      );

      _crashlyticsHelper.logError(
        e.toString(),
        s,
        functionName: 'getFoodItem',
      );
    }
  }
}
