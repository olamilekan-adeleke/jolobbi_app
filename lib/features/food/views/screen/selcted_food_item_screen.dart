import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cores/components/custom_scaffold_widget.dart';
import '../../../../cores/components/custom_text_widget.dart';
import '../../../../cores/components/image_widget.dart';
import '../../../../cores/constants/color.dart';
import '../../../../cores/utils/currency_formater.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../../cubit/item_cart_cubit.dart';
import '../../model/food_item_data_model.dart';
import '../widgets/selected_food_description_widget.dart';
import '../widgets/food_item_cart_buttom_widget.dart';
import '../widgets/food_item_review_list_view_widget.dart';

class SelectedFoodItemWidget extends StatelessWidget {
  const SelectedFoodItemWidget(this.foodItem, {Key? key}) : super(key: key);

  static const String route = '/selected-food-item';

  final FoodItemDataModel foodItem;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ItemToCartCubit(),
      child: CustomScaffoldWidget(
        useSingleScroll: false,
        usePadding: false,
        useSafeArea: false,
        body: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: sh(35),
                width: double.infinity,
                child: CustomImageWidget(
                  imageUrl: foodItem.image,
                  imageTypes: ImageTypes.network,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: sh(68),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kcWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(sp(10)),
                    topRight: Radius.circular(sp(10)),
                  ),
                ),
                child: FoodItemBodyWidget(foodItem),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: FoodItemCartButtonWidget(foodItem),
            ),
          ],
        ),
      ),
    );
  }
}

class FoodItemBodyWidget extends StatelessWidget {
  const FoodItemBodyWidget(this.foodItem, {Key? key}) : super(key: key);

  final FoodItemDataModel foodItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sp(15), vertical: sp(20)),
      child: Column(
        children: <Widget>[
          FoodItemHeaderWidget(foodItem),
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: <Widget>[
                  const TabBar(
                    tabs: [Tab(text: 'Description'), Tab(text: 'Reviews')],
                  ),
                  Flexible(
                    child: TabBarView(
                      children: [
                        SelectedFoodDescriptionAndAddonWidget(foodItem),
                        const FoodItemReviewListViewWidget(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FoodItemHeaderWidget extends StatelessWidget {
  const FoodItemHeaderWidget(this.foodItem, {Key? key}) : super(key: key);

  final FoodItemDataModel foodItem;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                foodItem.name,
                fontSize: sp(18),
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.left,
              ),
              TextWidget(
                foodItem.fastFoodName,
                fontSize: sp(14),
                fontWeight: FontWeight.w300,
              ),
              Row(
                children: [
                  Icon(
                    Icons.star_rate,
                    size: sp(13),
                    color: kcPrimaryColor,
                  ),
                  TextWidget(
                    '${foodItem.averageRating}(${foodItem.ratingCount})',
                    fontSize: sp(15),
                  ),
                ],
              ),
            ],
          ),
        ),
        TextWidget(
          'NGN ${currencyFormatter(foodItem.price)}',
          fontSize: sp(18),
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}
