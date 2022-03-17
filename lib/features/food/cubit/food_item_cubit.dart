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
      emit(state.copyWith(status: FoodItemStatus.busy, errorText: ''));

      List<FoodItemDataModel> foodList = await foodVendorService.getFoodItems();

      emit(
        state.copyWith(
          status: FoodItemStatus.success,
          foodItems: foodList,
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

  Future<void> getMoreFoodItem() async {
    if (state.foodItems.isEmpty ||
        state.status == FoodItemStatus.moreBusy) {
      return;
    }

    try {
      emit(state.copyWith(status: FoodItemStatus.moreBusy, errorText: ''));

      List<FoodItemDataModel> foodList = await foodVendorService.getFoodItems(
        lastDocId: state.foodItems.last.id,
      );

      emit(
        state.copyWith(
          status: FoodItemStatus.success,
          foodItems: [...state.foodItems, ...foodList],
        ),
      );
    } catch (e, s) {
      emit(
        state.copyWith(
          status: FoodItemStatus.moreError,
          errorText: e.toString(),
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
