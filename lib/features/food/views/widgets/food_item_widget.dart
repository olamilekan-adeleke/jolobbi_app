import 'package:flutter/material.dart';

import '../../../../cores/components/custom_text_widget.dart';
import '../../../../cores/components/image_widget.dart';
import '../../../../cores/constants/color.dart';
import '../../../../cores/navigator/app_router.dart';
import '../../../../cores/utils/currency_formater.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../../model/food_item_data_model.dart';
import '../screen/selcted_food_item_screen.dart';

class FoodItemWidget extends StatelessWidget {
  const FoodItemWidget(this.foodItem, {Key? key}) : super(key: key);

  final FoodItemDataModel foodItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppRouter.instance.navigateTo(
          SelectedFoodItemWidget.route,
          arguments: foodItem,
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: sp(5)),
        height: sp(170),
        width: double.infinity,
        decoration: BoxDecoration(
          color: kcWhite,
          borderRadius: BorderRadius.circular(sp(5)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 4,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: sp(120),
              width: double.infinity,
              child: CustomImageWidget(
                imageUrl: foodItem.image,
                imageTypes: ImageTypes.network,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: sp(10),
                vertical: sp(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        foodItem.name,
                        fontSize: sp(16),
                        fontWeight: FontWeight.w500,
                      ),
                      TextWidget(
                        foodItem.fastFoodName,
                        fontSize: sp(11),
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextWidget(
                        'NGN ${currencyFormatter(foodItem.price)}',
                        fontSize: sp(16),
                        fontWeight: FontWeight.w500,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.star_rate,
                            size: sp(13),
                            color: kcPrimaryColor,
                          ),
                          horizontalSpace(2),
                          TextWidget(
                            '${foodItem.averageRating}(${foodItem.ratingCount})',
                            fontSize: sp(12),
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ],
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
