import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jolobbi_app/features/food/enum/food_enum.dart';

import '../../../../../cores/components/error_widget.dart';
import '../../../../../cores/components/loading_indicator.dart';
import '../../../cubit/vendor_meun_cubit.dart';
import '../../../model/food_item_data_model.dart';
import '../../../model/vendor_menu_state_model.dart';
import '../food_item_widget.dart';

class DrinkMenuItemListView extends StatefulWidget {
  const DrinkMenuItemListView(this.vendorId, {Key? key}) : super(key: key);

  final String vendorId;

  @override
  State<DrinkMenuItemListView> createState() => _DrinkMenuItemListViewState();
}

class _DrinkMenuItemListViewState extends State<DrinkMenuItemListView> {
  static final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final VendorMenuCubit cubit = context.read<VendorMenuCubit>();

      cubit.getMenuDrinkItem(widget.vendorId);

      cubit.initScrollListener(
        scrollController,
        callback: () => cubit.getMenuDrinkItem(widget.vendorId, true),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VendorMenuCubit, VendorMenuStateModel>(
      builder: (context, state) {
        if (state.drinkStatus == VendorMenuStatus.busy) {
          return const Center(child: CustomLoadingIndicatorWidget());
        }

        if (state.drinkStatus == VendorMenuStatus.error) {
          return Center(
            child: CustomErrorWidget(
              message: state.drinkErrorText,
              callback: () {
                context
                    .read<VendorMenuCubit>()
                    .getMenuDrinkItem(widget.vendorId);
              },
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
                final FoodItemDataModel foodItem = state.drinkItems[index];

                return FoodItemWidget(foodItem);
                // return Container();
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: state.drinkStatus == VendorMenuStatus.moreBusy
                  ? const LoadingMoreWidget()
                  : Container(),
            ),
          ],
        );
      },
    );
  }
}
