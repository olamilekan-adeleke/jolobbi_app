import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cores/components/app_bar_widget.dart';
import '../../../../../cores/components/custom_scaffold_widget.dart';
import '../../../../../cores/components/error_widget.dart';
import '../../../../../cores/components/loading_indicator.dart';
import '../../../../../cores/components/search_bar_widget.dart';
import '../../../../../cores/navigator/app_router.dart';
import '../../../../../cores/utils/sizer_utils.dart';
import '../../../cubit/food_vendor_cubit.dart';
import '../../../enum/food_enum.dart';
import '../../../model/food_vendor_data_model.dart';
import '../../../model/food_vendor_state_model.dart';
import '../../widgets/vendor/vendor_item_list_tile.dart';
import 'selected_vendor_screen.dart';

class AllFoodVendorScreen extends StatefulWidget {
  const AllFoodVendorScreen({Key? key}) : super(key: key);

  static const String route = '/all-food-vendor';

  @override
  State<AllFoodVendorScreen> createState() => _AllFoodVendorScreenState();
}

class _AllFoodVendorScreenState extends State<AllFoodVendorScreen> {
  static final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final FoodVendorCubit cubit = context.read<FoodVendorCubit>();

      cubit.getFoodVendor();

      cubit.initScrollListener(scrollController);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      useSingleScroll: false,
      body: Column(
        children: <Widget>[
          verticalSpace(),
          const AppBarWidget('Vendors'),
          verticalSpace(),
          const SearchBarWidget(title: 'Search for vendor'),
          verticalSpace(),
          BlocBuilder<FoodVendorCubit, FoodVendorStateModel>(
            builder: (context, state) {
              if (state.status == FoodVendorStatus.getAllBusy) {
                return Center(
                  child: Column(
                    children: [
                      const CustomLoadingIndicatorWidget(),
                      verticalSpace(5),
                    ],
                  ),
                );
              }

              if (state.status == FoodVendorStatus.getAllError) {
                return Center(
                  child: Column(
                    children: [
                      CustomErrorWidget(
                        message: state.allErrorText,
                        callback: context.read<FoodVendorCubit>().getFoodVendor,
                      ),
                      verticalSpace(5),
                    ],
                  ),
                );
              }

              return Flexible(
                child: Stack(
                  children: [
                    ListView.builder(
                      controller: scrollController,
                      itemCount: state.allFoodVendorDataModels.length,
                      itemBuilder: (_, int index) {
                        final FoodVendorDataModel foodVendor =
                            state.allFoodVendorDataModels[index];

                        return GestureDetector(
                          onTap: () {
                            AppRouter.instance.navigateTo(
                              SelectedVendorScreen.route,
                              arguments: foodVendor,
                            );
                          },
                          child: VendorItemListTileWidget(foodVendor),
                        );
                      },
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: state.status == FoodVendorStatus.getMoreAllBusy
                          ? const LoadingMoreWidget()
                          : Container(),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
