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

  static final ScrollController scrollController = ScrollController();

  @override
  State<FoodItemListViewWidget> createState() => _FoodItemListViewWidgetState();
}

class _FoodItemListViewWidgetState extends State<FoodItemListViewWidget> {
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
    return Expanded(
      child: Column(
        children: <Widget>[
          const FoodItemListViewTabBarWidget(),
          verticalSpace(),
          BlocBuilder<FoodItemCubit, FoodItemStateModel>(
            builder: (context, state) {
              if (state.status == FoodItemStatus.busy) {
                return Center(
                  child: Column(
                    children: [
                      const CustomLoadingIndicatorWidget(),
                      verticalSpace(5),
                    ],
                  ),
                );
              }

              if (state.status == FoodItemStatus.error) {
                return Center(
                  child: CustomErrorWidget(
                    message: state.errorText,
                    callback: context.read<FoodItemCubit>().getFoodItem,
                  ),
                );
              }

              return Expanded(
                child: Stack(
                  children: [
                    ListView.builder(
                      controller: scrollController,
                      shrinkWrap: true,
                      itemCount: state.foodItems.length,
                      itemBuilder: (_, int index) {
                        final FoodItemDataModel foodItem =
                            state.foodItems[index];

                        return FoodItemWidget(foodItem);
                      },
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: state.status == FoodItemStatus.moreBusy
                          ? const LoadingMoreWidget()
                          : Container(),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
