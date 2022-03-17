import 'package:flutter/material.dart';
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

class FoodItemListViewWidget extends StatelessWidget {
  const FoodItemListViewWidget({Key? key}) : super(key: key);

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
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.foodItemDataModels.length,
                  itemBuilder: (_, int index) {
                    final FoodItemDataModel foodItem =
                        state.foodItemDataModels[index];

                    return FoodItemWidget(foodItem);
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
