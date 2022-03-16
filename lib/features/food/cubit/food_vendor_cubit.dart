import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jolobbi_app/features/food/enum/food_enum.dart';

import '../../../cores/utils/crashlytics_helper.dart';
import '../model/food_vendor_data_model.dart';
import '../model/food_vendor_state_model.dart';
import '../service/food_vendor_service.dart';

class FoodVendorCubit extends Cubit<FoodVendorStateModel> {
  FoodVendorCubit(this.foodVendorService) : super(FoodVendorStateModel());

  final FoodVendorService foodVendorService;
  static final CrashlyticsHelper _crashlyticsHelper = CrashlyticsHelper();

  Future<void> getFoodVendor() async {
    try {
      emit(state.copyWith(status: FoodVendorStatus.busy, errorText: ''));

      List<FoodVendorDataModel> foodVendor =
          await foodVendorService.getFoodVendors();

      foodVendor.forEach(state.addFoodVendor);

      emit(state);
    } catch (e, s) {
      emit(
        state.copyWith(
          status: FoodVendorStatus.busy,
          errorText: e.toString(),
        ),
      );

      _crashlyticsHelper.logError(
        e.toString(),
        s,
        functionName: 'getFoodVendor',
      );
    }
  }
}
