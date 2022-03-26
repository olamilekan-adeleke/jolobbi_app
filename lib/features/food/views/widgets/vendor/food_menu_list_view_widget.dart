import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jolobbi_app/features/food/enum/food_enum.dart';

import '../../../../../cores/components/error_widget.dart';
import '../../../../../cores/components/loading_indicator.dart';
import '../../../cubit/vendor_meun_cubit.dart';
import '../../../model/food_item_data_model.dart';
import '../../../model/vendor_menu_state_model.dart';
import '../food_item_widget.dart';

class FoodMenuItemListView extends StatefulWidget {
  const FoodMenuItemListView(this.vendorId, {Key? key}) : super(key: key);

  final String vendorId;

  @override
  State<FoodMenuItemListView> createState() => _FoodMenuItemListViewState();
}

class _FoodMenuItemListViewState extends State<FoodMenuItemListView> {
  static final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {

      final VendorMenuCubit cubit = context.read<VendorMenuCubit>();

      cubit.getMenuFoodItem(widget.vendorId);

      cubit.initScrollListener(
        scrollController,
        callback: () => cubit.getMenuFoodItem(widget.vendorId, true),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VendorMenuCubit, VendorMenuStateModel>(
      builder: (context, state) {
        if (state.foodStatus == VendorMenuStatus.busy) {
          return const Center(child: CustomLoadingIndicatorWidget());
        }

        if (state.foodStatus == VendorMenuStatus.error) {
          return Center(
            child: CustomErrorWidget(
              message: state.foodErrorText,
              callback: () {
                context
                    .read<VendorMenuCubit>()
                    .getMenuFoodItem(widget.vendorId);
              },
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
                // return Container();
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: state.foodStatus == VendorMenuStatus.moreBusy
                  ? const LoadingMoreWidget()
                  : Container(),
            ),
          ],
        );
      },
    );
  }
}
