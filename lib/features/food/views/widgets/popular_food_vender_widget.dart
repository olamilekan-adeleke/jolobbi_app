import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jolobbi_app/cores/components/loading_indicator.dart';

import '../../../../cores/components/custom_text_widget.dart';
import '../../../../cores/components/image_widget.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../../cubit/food_vendor_cubit.dart';
import '../../enum/food_enum.dart';
import '../../model/food_vendor_state_model.dart';

class PopularFoodVendorWidget extends StatelessWidget {
  const PopularFoodVendorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          'Popular Vendors',
          fontSize: sp(16),
          fontWeight: FontWeight.w500,
        ),
        verticalSpace(20),
        BlocBuilder<FoodVendorCubit, FoodVendorStateModel>(
          builder: (context, state) {
            if (state.status == FoodVendorStatus.busy) {
              return const CustomLoadingIndicatorWidget();
            }

            return SizedBox(
              height: sp(60),
              width: double.infinity,
              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, snapshot) {
                  return SizedBox(
                    width: sp(65),
                    child: Column(
                      children: [
                        SizedBox(
                          height: sp(40),
                          width: sp(40),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(sp(100)),
                            child: const CustomImageWidget(
                              imageUrl: 'assets/images/food.png',
                              imageTypes: ImageTypes.asset,
                            ),
                          ),
                        ),
                        TextWidget(
                          'Shoprite',
                          fontSize: sp(14),
                          fontWeight: FontWeight.w400,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        )
      ],
    );
  }
}
