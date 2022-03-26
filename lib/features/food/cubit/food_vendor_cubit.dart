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

  Future<void> getPopularFoodVendor() async {
    try {
      emit(state.copyWith(
          status: FoodVendorStatus.getPopularBusy, errorText: ''));

      List<FoodVendorDataModel> foodVendor =
          await foodVendorService.getFoodVendors();

      emit(
        state.copyWith(
          status: FoodVendorStatus.getPopularSuccess,
          popularFoodVendorDataModels: foodVendor,
        ),
      );
    } catch (e, s) {
      emit(
        state.copyWith(
          status: FoodVendorStatus.getPopularError,
          errorText: e.toString(),
        ),
      );

      _crashlyticsHelper.logError(
        e.toString(),
        s,
        functionName: 'getPopularFoodVendor',
      );
    }
  }

  Future<void> getFoodVendor([bool getMore = false]) async {
    try {
      emit(
        state.copyWith(
          status: FoodVendorStatus.getAllBusy,
          allErrorText: '',
        ),
      );

      List<FoodVendorDataModel> foodVendor = [];

      if (getMore) {
        foodVendor = await foodVendorService.getFoodVendors(
          lastDocId: state.allFoodVendorDataModels.last.id,
        );
      } else {
        foodVendor = await foodVendorService.getFoodVendors();
      }

      emit(
        state.copyWith(
          status: FoodVendorStatus.getAllSuccess,
          allFoodVendorDataModels: foodVendor,
        ),
      );
    } catch (e, s) {
      emit(
        state.copyWith(
          status: FoodVendorStatus.getAllError,
          allErrorText: e.toString(),
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
