import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jolobbi_app/features/food/model/vendor_menu_state_model.dart';

import '../../../cores/utils/crashlytics_helper.dart';
import '../enum/food_enum.dart';
import '../model/food_item_data_model.dart';
import '../service/food_vendor_service.dart';

class VendorMenuCubit extends Cubit<VendorMenuStateModel> {
  VendorMenuCubit(this.foodVendorService) : super(VendorMenuStateModel());

  final FoodVendorService foodVendorService;

  static final CrashlyticsHelper _crashlyticsHelper = CrashlyticsHelper();

  void initScrollListener(
    ScrollController scrollController, {
    Function()? callback,
  }) {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        log('end of line');

        if (callback != null) {
          callback();
        }
      }
    });
  }

  Future<void> getMenuFoodItem(String fastFoodId,
      [bool getMore = false]) async {
    try {
      if (getMore) {
        emit(
          state.copyWith(
            foodStatus: VendorMenuStatus.moreBusy,
            foodErrorText: '',
          ),
        );
      } else {
        emit(
          state.copyWith(
            foodStatus: VendorMenuStatus.busy,
            foodErrorText: '',
          ),
        );
      }

      List<FoodItemDataModel> foodList = [];

      if (getMore) {
        foodList = await foodVendorService.getFoodItems(
          limit: 5,
          lastDocId: state.foodItems.last.id,
          timeAdded: state.foodItems.last.timestamp,
          vendorId: fastFoodId,
        );
      } else {
        foodList = await foodVendorService.getFoodItems(
          limit: 5,
          vendorId: fastFoodId,
        );
      }

      emit(
        state.copyWith(
          foodStatus: VendorMenuStatus.success,
          foodItems: [...state.foodItems, ...foodList],
        ),
      );
    } catch (e, s) {
      emit(
        state.copyWith(
          foodStatus: VendorMenuStatus.error,
          foodErrorText: e.toString(),
        ),
      );

      _crashlyticsHelper.logError(
        e.toString(),
        s,
        functionName: 'getMenuFoodItem',
      );
    }
  }

  Future<void> getMenuDrinkItem(String fastFoodId,
      [bool getMore = false]) async {
    try {
      if (getMore) {
        emit(
          state.copyWith(
            drinkStatus: VendorMenuStatus.moreBusy,
            drinkErrorText: '',
          ),
        );
      } else {
        emit(
          state.copyWith(
            drinkStatus: VendorMenuStatus.busy,
            drinkErrorText: '',
          ),
        );
      }

      List<FoodItemDataModel> drinkList = [];

      if (getMore) {
        drinkList = await foodVendorService.getDrinkItems(
          limit: 5,
          lastDocId: state.drinkItems.last.id,
          timeAdded: state.drinkItems.last.timestamp,
          vendorId: fastFoodId,
        );
      } else {
        drinkList = await foodVendorService.getDrinkItems(
          limit: 5,
          vendorId: fastFoodId,
        );
      }

      emit(
        state.copyWith(
          drinkStatus: VendorMenuStatus.success,
          drinkItems: [...state.drinkItems, ...drinkList],
        ),
      );
    } catch (e, s) {
      emit(
        state.copyWith(
          drinkStatus: VendorMenuStatus.error,
          drinkErrorText: e.toString(),
        ),
      );

      _crashlyticsHelper.logError(
        e.toString(),
        s,
        functionName: 'getMenuDrinkItem',
      );
    }
  }

  Future<void> getMenuSnackItem(String fastFoodId,
      [bool getMore = false]) async {
    try {
      if (getMore) {
        emit(
          state.copyWith(
            snackStatus: VendorMenuStatus.moreBusy,
            snackErrorText: '',
          ),
        );
      } else {
        emit(
          state.copyWith(
            snackStatus: VendorMenuStatus.busy,
            snackErrorText: '',
          ),
        );
      }

      List<FoodItemDataModel> snackList = [];

      if (getMore) {
        snackList = await foodVendorService.getSnackItems(
          limit: 5,
          lastDocId: state.snackItems.last.id,
          timeAdded: state.snackItems.last.timestamp,
          vendorId: fastFoodId,
        );
      } else {
        snackList = await foodVendorService.getSnackItems(
          limit: 5,
          vendorId: fastFoodId,
        );
      }

      emit(
        state.copyWith(
          snackStatus: VendorMenuStatus.success,
          snackItems: [...state.snackItems, ...snackList],
        ),
      );
    } catch (e, s) {
      emit(
        state.copyWith(
          snackStatus: VendorMenuStatus.error,
          snackErrorText: e.toString(),
        ),
      );

      _crashlyticsHelper.logError(
        e.toString(),
        s,
        functionName: 'getMenuSnackItem',
      );
    }
  }
}
