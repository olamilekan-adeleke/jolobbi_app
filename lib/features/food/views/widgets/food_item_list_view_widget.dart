import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cores/components/error_widget.dart';
import '../../../../cores/components/loading_indicator.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../../cubit/food_item_cubit.dart';
import '../../enum/food_enum.dart';
import '../../model/food_item_data_model.dart';
import '../../model/food_item_state_model.dart';
import 'food_item_list_view_tab_bar_widget.dart';
import 'food_item_widget.dart';

class FoodItemListViewWidget extends StatefulWidget {
  const FoodItemListViewWidget({Key? key}) : super(key: key);

  @override
  State<FoodItemListViewWidget> createState() => _FoodItemListViewWidgetState();
}

class _FoodItemListViewWidgetState extends State<FoodItemListViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: const <Widget>[
            TabBar(
              tabs: [
                Tab(text: 'Foods'),
                Tab(text: 'Snacks'),
                Tab(text: 'Drinks'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  FoodListScreen(),
                  SnackListScreen(),
                  DrinkListScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FoodListScreen extends StatefulWidget {
  const FoodListScreen({Key? key}) : super(key: key);

  @override
  State<FoodListScreen> createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {
  static final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<FoodItemCubit>().initScrollListener(scrollController);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodItemCubit, FoodItemStateModel>(
      builder: (context, state) {
        if (state.foodItemStatus == FoodItemStatus.busy) {
          return Center(
            child: Column(
              children: [
                const CustomLoadingIndicatorWidget(),
                verticalSpace(5),
              ],
            ),
          );
        }

        if (state.foodItemStatus == FoodItemStatus.error) {
          return Center(
            child: CustomErrorWidget(
              message: state.foodErrorText,
              callback: context.read<FoodItemCubit>().getFoodItem,
            ),
          );
        }

        return Stack(
          children: [
            ListView.builder(
              controller: scrollController,
              shrinkWrap: true,
              itemCount: state.foodItems.length,
              itemBuilder: (_, int index) {
                final FoodItemDataModel foodItem = state.foodItems[index];

                return FoodItemWidget(foodItem);
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: state.foodItemStatus == FoodItemStatus.moreBusy
                  ? const LoadingMoreWidget()
                  : Container(),
            ),
          ],
        );
      },
    );
  }
}

class SnackListScreen extends StatefulWidget {
  const SnackListScreen({Key? key}) : super(key: key);

  @override
  State<SnackListScreen> createState() => _SnackListScreenState();
}

class _SnackListScreenState extends State<SnackListScreen> {
  static final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<FoodItemCubit>().initSnackScrollListener(scrollController);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodItemCubit, FoodItemStateModel>(
      builder: (context, state) {
        if (state.snackItemStatus == FoodItemStatus.busy) {
          return Center(
            child: Column(
              children: [
                const CustomLoadingIndicatorWidget(),
                verticalSpace(5),
              ],
            ),
          );
        }

        if (state.snackItemStatus == FoodItemStatus.error) {
          return Center(
            child: CustomErrorWidget(
              message: state.snackErrorText,
              callback: context.read<FoodItemCubit>().getSnackItem,
            ),
          );
        }

        return Stack(
          children: [
            ListView.builder(
              controller: scrollController,
              shrinkWrap: true,
              itemCount: state.snackItems.length,
              itemBuilder: (_, int index) {
                final FoodItemDataModel snackItem = state.snackItems[index];

                return FoodItemWidget(snackItem);
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: state.snackItemStatus == FoodItemStatus.moreBusy
                  ? const LoadingMoreWidget()
                  : Container(),
            ),
          ],
        );
      },
    );
  }
}

class DrinkListScreen extends StatefulWidget {
  const DrinkListScreen({Key? key}) : super(key: key);

  @override
  State<DrinkListScreen> createState() => _DrinkListScreenState();
}

class _DrinkListScreenState extends State<DrinkListScreen> {
  static final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<FoodItemCubit>().initDrinkScrollListener(scrollController);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodItemCubit, FoodItemStateModel>(
      builder: (context, state) {
        if (state.drinkItemStatus == FoodItemStatus.busy) {
          return Center(
            child: Column(
              children: [
                const CustomLoadingIndicatorWidget(),
                verticalSpace(5),
              ],
            ),
          );
        }

        if (state.drinkItemStatus == FoodItemStatus.error) {
          return Center(
            child: CustomErrorWidget(
              message: state.drinkErrorText,
              callback: context.read<FoodItemCubit>().getDrinkItem,
            ),
          );
        }

        return Stack(
          children: [
            ListView.builder(
              controller: scrollController,
              shrinkWrap: true,
              itemCount: state.drinkItems.length,
              itemBuilder: (_, int index) {
                final FoodItemDataModel drinkItem = state.drinkItems[index];

                return FoodItemWidget(drinkItem);
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: state.drinkItemStatus == FoodItemStatus.moreBusy
                  ? const LoadingMoreWidget()
                  : Container(),
            ),
          ],
        );
      },
    );
  }
}
