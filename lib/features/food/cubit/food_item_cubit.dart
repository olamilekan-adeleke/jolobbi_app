import 'dart:developer';

import 'package:flutter/material.dart';
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

  void initScrollListener(ScrollController scrollController) {
    scrollController.addListener(() => _scrollListener(scrollController));
  }

  void _scrollListener(ScrollController scrollController) {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent) {
      getMoreFoodItem();
      log('end of line');
    }
  }

  Future<void> getFoodItem() async {
    try {
      emit(
        state.copyWith(foodItemStatus: FoodItemStatus.busy, foodErrorText: ''),
      );

      List<FoodItemDataModel> foodList = await foodVendorService.getFoodItems();

      emit(
        state.copyWith(
          foodItemStatus: FoodItemStatus.success,
          foodItems: foodList,
        ),
      );
    } catch (e, s) {
      emit(
        state.copyWith(
          foodItemStatus: FoodItemStatus.error,
          foodErrorText: e.toString(),
        ),
      );

      _crashlyticsHelper.logError(
        e.toString(),
        s,
        functionName: 'getFoodItem',
      );
    }
  }

  Future<void> getMoreFoodItem() async {
    if (state.foodItems.isEmpty ||
        state.foodItemStatus == FoodItemStatus.moreBusy) {
      return;
    }

    try {
      emit(state.copyWith(
          foodItemStatus: FoodItemStatus.moreBusy, foodErrorText: ''));

      List<FoodItemDataModel> foodList = await foodVendorService.getFoodItems(
        lastDocId: state.foodItems.last.id,
        timeAdded: state.foodItems.last.timestamp,
      );

      emit(
        state.copyWith(
          foodItemStatus: FoodItemStatus.success,
          foodItems: [...state.foodItems, ...foodList],
        ),
      );
    } catch (e, s) {
      emit(
        state.copyWith(
          foodItemStatus: FoodItemStatus.moreError,
          foodErrorText: e.toString(),
        ),
      );

      _crashlyticsHelper.logError(
        e.toString(),
        s,
        functionName: 'getMoreFoodItem',
      );
    }
  }
}
