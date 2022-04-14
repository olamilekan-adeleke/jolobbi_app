import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cores/components/custom_text_widget.dart';
import '../../../../../cores/components/image_widget.dart';
import '../../../../../cores/constants/color.dart';
import '../../../../../cores/utils/currency_formater.dart';
import '../../../../../cores/utils/sizer_utils.dart';
import '../../../cubit/cart_cubit.dart';
import '../../../model/cart_item_model.dart';
import '../../../model/cart_list_state_model.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget(this.cart, {Key? key}) : super(key: key);

  final CartItemModel cart;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: sp(5), vertical: sp(5)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _CartFoodItemWidget(cart),
            if ((cart.addOn?.isNotEmpty ?? false) ||
                (cart.extras?.isNotEmpty ?? false))
              const Divider(),
            _ExtraItemWidget(cart),
          ],
        ),
      ),
    );
  }
}

class _ExtraItemWidget extends StatelessWidget {
  const _ExtraItemWidget(this.cart, {Key? key}) : super(key: key);

  final CartItemModel cart;

  @override
  Widget build(BuildContext context) {
    final CartCubit cartCubit = context.read<CartCubit>();

    return Flexible(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: ((cart.extras?.length ?? 0) + (cart.addOn?.length ?? 0)),
        itemBuilder: (_, int index) {
          final List list = [...?cart.extras, ...?cart.addOn];

          return _item(list[index], cartCubit);
        },
      ),
    );
  }

  Widget _item(item, CartCubit cartCubit) {
    return Dismissible(
      key: Key(item.name),
      onDismissed: (_) {
        cartCubit.deleteExtraCartItem(cart, item);
      },
      background: Container(color: Colors.red),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: sp(5)),
        child: Row(
          children: <Widget>[
            SizedBox(
              height: sp(35),
              width: sp(35),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(sp(5)),
                child: CustomImageWidget(
                  imageUrl: item.image,
                  imageTypes: ImageTypes.network,
                ),
              ),
            ),
            horizontalSpace(5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextWidget(
                  item.name,
                  fontSize: sp(12),
                  fontWeight: FontWeight.w300,
                ),
                TextWidget(
                  'NGN ${currencyFormatter(item.price)}',
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
                    onTap: () => {},
                  ),
                  horizontalSpace(8),
                  BlocBuilder<CartCubit, CartListStateModel>(
                    builder: (context, state) {
                      return TextWidget(
                        '0',
                        fontSize: sp(14),
                        fontWeight: FontWeight.w500,
                      );
                    },
                  ),
                  horizontalSpace(8),
                  _iconWidget(
                    Icons.add_circle_outlined,
                    onTap: () => {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartFoodItemWidget extends StatelessWidget {
  const _CartFoodItemWidget(this.cart, {Key? key}) : super(key: key);

  final CartItemModel cart;

  @override
  Widget build(BuildContext context) {
    final CartCubit cartCubit = context.read<CartCubit>();

    return Dismissible(
      key: Key(cart.name),
      onDismissed: (_) {
        cartCubit.deleteCartItem(cart);
      },
      child: Row(
        children: <Widget>[
          SizedBox(
            height: sp(55),
            width: sp(55),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(sp(5)),
              child: CustomImageWidget(
                imageUrl: cart.image,
                imageTypes: ImageTypes.network,
              ),
            ),
          ),
          horizontalSpace(5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextWidget(
                cart.name,
                fontSize: sp(12),
                fontWeight: FontWeight.w300,
              ),
              TextWidget(
                'NGN ${currencyFormatter(cart.price)}',
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
            child: Column(
              children: <Widget>[
                _iconWidget(
                  Icons.remove_circle_outline,
                  onTap: () => cartCubit.decrementCartItem(cart),
                ),
                verticalSpace(5),
                BlocBuilder<CartCubit, CartListStateModel>(
                  builder: (context, state) {
                    return TextWidget(
                      '${cartCubit.getCartItemCount(cart)}',
                      fontSize: sp(14),
                      fontWeight: FontWeight.w500,
                    );
                  },
                ),
                verticalSpace(5),
                _iconWidget(
                  Icons.add_circle_outlined,
                  onTap: () => cartCubit.incrementCartItem(cart),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _iconWidget(IconData icon, {required onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Icon(icon, size: sp(15), color: kcPrimaryColor),
  );
}
