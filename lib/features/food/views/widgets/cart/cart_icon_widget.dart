import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cores/components/custom_text_widget.dart';
import '../../../../../cores/constants/color.dart';
import '../../../../../cores/utils/sizer_utils.dart';
import '../../../cubit/cart_cubit.dart';
import '../../../model/cart_list_state_model.dart';

class CartIconWidget extends StatelessWidget {
  const CartIconWidget({Key? key, this.iconColor}) : super(key: key);

  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sp(35),
      width: sp(30),
      child: Stack(
        children: [
          SizedBox(
            height: sp(35),
            width: sp(30),
            child: Icon(
              CupertinoIcons.cart,
              size: sp(20),
              color: iconColor ?? kcIconGrey,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              height: sp(15),
              width: sp(15),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: kcPrimaryColor,
              ),
              child: Center(
                child: BlocBuilder<CartCubit, CartListStateModel>(
                  builder: (context, state) {
                    return TextWidget(
                      '${state.foodItem.length}',
                      fontWeight: FontWeight.w500,
                      fontSize: sp(10),
                      textColor: kcWhite,
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
