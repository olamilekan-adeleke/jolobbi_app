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

  void initSnackScrollListener(ScrollController scrollController) {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        getMoreSnackItem();
        log('end of line');
      }
    });
  }

  void initDrinkScrollListener(ScrollController scrollController) {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        getMoreDrinkItem();
        log('end of line');
      }
    });
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

  Future<void> getSnackItem() async {
    try {
      emit(state.copyWith(snackItemStatus: FoodItemStatus.busy));

      List<FoodItemDataModel> snackList =
          await foodVendorService.getSnackItems();

      emit(
        state.copyWith(
          snackItemStatus: FoodItemStatus.success,
          foodItems: snackList,
        ),
      );
    } catch (e, s) {
      emit(
        state.copyWith(
          snackItemStatus: FoodItemStatus.error,
          snackErrorText: e.toString(),
        ),
      );

      _crashlyticsHelper.logError(
        e.toString(),
        s,
        functionName: 'getSnackItem',
      );
    }
  }

  Future<void> getMoreSnackItem() async {
    if (state.snackItems.isEmpty ||
        state.snackItemStatus == FoodItemStatus.moreBusy) {
      return;
    }

    try {
      emit(state.copyWith(snackItemStatus: FoodItemStatus.moreBusy));

      List<FoodItemDataModel> snackList = await foodVendorService.getSnackItems(
        lastDocId: state.snackItems.last.id,
        timeAdded: state.snackItems.last.timestamp,
      );

      emit(
        state.copyWith(
          snackItemStatus: FoodItemStatus.success,
          snackItems: [...state.snackItems, ...snackList],
        ),
      );
    } catch (e, s) {
      emit(
        state.copyWith(
          snackItemStatus: FoodItemStatus.moreError,
          snackErrorText: e.toString(),
        ),
      );

      _crashlyticsHelper.logError(
        e.toString(),
        s,
        functionName: 'getMoreSnackItem',
      );
    }
  }

  Future<void> getDrinkItem() async {
    try {
      emit(state.copyWith(drinkItemStatus: FoodItemStatus.busy));

      List<FoodItemDataModel> drinkList =
          await foodVendorService.getDrinkItems();

      emit(
        state.copyWith(
          drinkItemStatus: FoodItemStatus.success,
          drinkItems: drinkList,
        ),
      );
    } catch (e, s) {
      emit(
        state.copyWith(
          drinkItemStatus: FoodItemStatus.error,
          drinkErrorText: e.toString(),
        ),
      );

      _crashlyticsHelper.logError(
        e.toString(),
        s,
        functionName: 'getDrinkItem',
      );
    }
  }

  Future<void> getMoreDrinkItem() async {
    if (state.drinkItems.isEmpty ||
        state.drinkItemStatus == FoodItemStatus.moreBusy) {
      return;
    }

    try {
      emit(state.copyWith(drinkItemStatus: FoodItemStatus.moreBusy));

      List<FoodItemDataModel> drinkList = await foodVendorService.getDrinkItems(
        lastDocId: state.drinkItems.last.id,
        timeAdded: state.drinkItems.last.timestamp,
      );

      emit(
        state.copyWith(
          drinkItemStatus: FoodItemStatus.success,
          drinkItems: [...state.drinkItems, ...drinkList],
        ),
      );
    } catch (e, s) {
      emit(
        state.copyWith(
          drinkItemStatus: FoodItemStatus.moreError,
          drinkErrorText: e.toString(),
        ),
      );

      _crashlyticsHelper.logError(
        e.toString(),
        s,
        functionName: 'getMoreDrinkItem',
      );
    }
  }
}
