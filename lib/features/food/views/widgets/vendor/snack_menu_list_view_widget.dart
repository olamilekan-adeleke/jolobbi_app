import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jolobbi_app/features/food/enum/food_enum.dart';

import '../../../../../cores/components/error_widget.dart';
import '../../../../../cores/components/loading_indicator.dart';
import '../../../cubit/vendor_meun_cubit.dart';
import '../../../model/food_item_data_model.dart';
import '../../../model/vendor_menu_state_model.dart';
import '../food_item_widget.dart';

class SnackMenuItemListView extends StatefulWidget {
  const SnackMenuItemListView(this.vendorId, {Key? key}) : super(key: key);

  final String vendorId;

  @override
  State<SnackMenuItemListView> createState() => SnackMenuItemListViewState();
}

class SnackMenuItemListViewState extends State<SnackMenuItemListView> {
  static final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final VendorMenuCubit cubit = context.read<VendorMenuCubit>();

      cubit.getMenuSnackItem(widget.vendorId);

      cubit.initScrollListener(
        scrollController,
        callback: () => cubit.getMenuSnackItem(widget.vendorId, true),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VendorMenuCubit, VendorMenuStateModel>(
      builder: (context, state) {
        if (state.snackStatus == VendorMenuStatus.busy) {
          return const Center(child: CustomLoadingIndicatorWidget());
        }

        if (state.snackStatus == VendorMenuStatus.error) {
          return Center(
            child: CustomErrorWidget(
              message: state.snackErrorText,
              callback: () {
                context
                    .read<VendorMenuCubit>()
                    .getMenuSnackItem(widget.vendorId);
              },
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
                final FoodItemDataModel foodItem = state.snackItems[index];

                return FoodItemWidget(foodItem);
                // return Container();
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: state.snackStatus == VendorMenuStatus.moreBusy
                  ? const LoadingMoreWidget()
                  : Container(),
            ),
          ],
        );
      },
    );
  }
}
