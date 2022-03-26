import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cores/components/app_bar_widget.dart';
import '../../../../../cores/components/custom_scaffold_widget.dart';
import '../../../../../cores/components/custom_textfiled.dart';
import '../../../../../cores/components/error_widget.dart';
import '../../../../../cores/components/loading_indicator.dart';
import '../../../../../cores/navigator/app_router.dart';
import '../../../../../cores/utils/sizer_utils.dart';
import '../../../cubit/food_vendor_cubit.dart';
import '../../../enum/food_enum.dart';
import '../../../model/food_vendor_data_model.dart';
import '../../../model/food_vendor_state_model.dart';
import '../../widgets/vendor/vendor_item_list_tile.dart';
import 'selected_vendor_screen.dart';

class VendorSearchScreen extends StatefulWidget {
  const VendorSearchScreen({Key? key}) : super(key: key);

  static const String route = '/vendor-search-screen';

  @override
  State<VendorSearchScreen> createState() => _VendorSearchScreenState();
}

class _VendorSearchScreenState extends State<VendorSearchScreen> {
  static final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final FoodVendorCubit cubit = context.read<FoodVendorCubit>();

      cubit.initScrollListener(scrollController);
    });
    super.initState();
  }

  @override
  void dispose() {
    context.read<FoodVendorCubit>().onSearchFieldChanged('');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      useSingleScroll: false,
      body: Column(
        children: <Widget>[
          verticalSpace(),
          const AppBarWidget('Search Vendor'),
          verticalSpace(),
          CustomTextField(
            hintText: 'Enter text to search',
            onChanged: (String? val) {
              if (val == null) return;
              context.read<FoodVendorCubit>().onSearchFieldChanged(val);
            },
            fillColor: Colors.grey.shade300,
          ),
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
