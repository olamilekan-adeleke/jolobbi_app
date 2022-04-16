import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jolobbi_app/cores/components/custom_text_widget.dart';

import '../../../../cores/components/image_widget.dart';
import '../../../../cores/constants/color.dart';
import '../../../../cores/utils/currency_formater.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../../../cart/cubit/item_cart_cubit.dart';
import '../../../cart/model/item_to_cart_model.dart';
import '../../model/food_item_data_model.dart';


class FoodItemAddOnListViewWidget extends StatelessWidget {
  const FoodItemAddOnListViewWidget(this.foodItem, {Key? key})
      : super(key: key);

  final FoodItemDataModel foodItem;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: foodItem.addOn!.length,
      itemBuilder: (_, int index) {
        final AddOn addOn = foodItem.addOn![index];

        return FoodItemAddOnWidget(addOn);
      },
    );
  }
}

class FoodItemAddOnWidget extends StatelessWidget {
  const FoodItemAddOnWidget(this.addOn, {Key? key}) : super(key: key);

  final AddOn addOn;

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
              imageUrl: addOn.image,
              imageTypes: ImageTypes.network,
            ),
          ),
          horizontalSpace(5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                addOn.name,
                fontSize: sp(12),
                fontWeight: FontWeight.w300,
              ),
              TextWidget(
                'NGN ${currencyFormatter(addOn.price)}',
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
            child: Row(
              children: <Widget>[
                _iconWidget(
                  Icons.remove_circle_outline,
                  onTap: () => itemToCartCubit.removeAddonItem(addOn),
                ),
                horizontalSpace(8),
                BlocBuilder<ItemToCartCubit, ItemToCartModel>(
                  builder: (context, state) {
                    return TextWidget(
                      '${itemToCartCubit.getAddOnCount(addOn)}',
                      fontSize: sp(14),
                      fontWeight: FontWeight.w500,
                    );
                  },
                ),
                horizontalSpace(8),
                _iconWidget(
                  Icons.add_circle_outlined,
                  onTap: () => itemToCartCubit.addAddonItem(addOn),
                ),
              ],
            ),
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
