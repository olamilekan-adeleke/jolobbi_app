import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jolobbi_app/cores/components/custom_text_widget.dart';

import '../../../../cores/components/image_widget.dart';
import '../../../../cores/constants/color.dart';
import '../../../../cores/utils/currency_formater.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../../cubit/item_cart_cubit.dart';
import '../../model/food_item_data_model.dart';

class SelectedFoodItemExtraListViewWidget extends StatelessWidget {
  const SelectedFoodItemExtraListViewWidget(this.foodItem, {Key? key})
      : super(key: key);

  final FoodItemDataModel foodItem;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: foodItem.extras!.length,
      itemBuilder: (_, int index) {
        final Extras extra = foodItem.extras![index];

        return _FoodItemExtraWidget(foodItem, extra);
      },
    );
  }
}

class _FoodItemExtraWidget extends StatelessWidget {
  _FoodItemExtraWidget(this.extra, {Key? key}) : super(key: key);

  final Extras extra;
  
  int count = 0;

  @override
  Widget build(BuildContext context) {
    final ItemToCartCubit itemToCartCubit = context.read<ItemToCartCubit>();

    return Container(
      margin: EdgeInsets.only(bottom: sp(5)),
      child: Row(
        children: <Widget>[
          SizedBox(
            height: sp(40),
            width: sp(40),
            child: CustomImageWidget(
              imageUrl: extra.image,
              imageTypes: ImageTypes.network,
            ),
          ),
          horizontalSpace(5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                extra.name,
                fontSize: sp(12),
                fontWeight: FontWeight.w300,
              ),
              TextWidget(
                'NGN ${currencyFormatter(extra.price)}',
                fontSize: sp(14),
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: sp(10),
              vertical: sp(5),
            ),
            decoration: BoxDecoration(
              border: Border.all(color: kcIconGrey),
              borderRadius: BorderRadius.circular(sp(6)),
            ),
            child: StatefulBuilder(builder: (context, setState) {
              return Row(
                children: <Widget>[
                  _iconWidget(
                    Icons.remove_circle_outline,
                    onTap: () {
                      if (count >= 1) {
                        count--;
                      }
                      setState(() {});

                      itemToCartCubit.removeExtraItem(extra);
                    },
                  ),
                  horizontalSpace(8),
                  TextWidget(
                    '$count',
                    fontSize: sp(14),
                    fontWeight: FontWeight.w500,
                  ),
                  horizontalSpace(8),
                  _iconWidget(
                    Icons.add_circle_outlined,
                    onTap: () {
                      if (count <= 9) {
                        count++;
                      }
                      setState(() {});

                      itemToCartCubit.addExtraItem(extra);
                    },
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _iconWidget(IconData icon, {required onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(icon, size: sp(15), color: kcPrimaryColor),
    );
  }
}
