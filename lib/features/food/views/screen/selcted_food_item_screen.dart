import 'package:flutter/material.dart';

import '../../../../cores/components/custom_scaffold_widget.dart';
import '../../../../cores/components/custom_text_widget.dart';
import '../../../../cores/components/image_widget.dart';
import '../../../../cores/constants/color.dart';
import '../../../../cores/utils/sizer_utils.dart';
import '../widgets/food_description_widget.dart';

class SelectedFoodItemWidget extends StatelessWidget {
  const SelectedFoodItemWidget({Key? key}) : super(key: key);

  static const String route = '/selected-food-item';

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
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
              child: const CustomImageWidget(
                imageUrl: 'assets/images/food_3.png',
                imageTypes: ImageTypes.asset,
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
              child: const FoodItemBodyWidget(),
            ),
          ),
        ],
      ),
    );
  }
}

class FoodItemBodyWidget extends StatelessWidget {
  const FoodItemBodyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sp(15), vertical: sp(20)),
      child: Column(
        children: <Widget>[
          const FoodItemHeaderWidget(),
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: <Widget>[
                  const TabBar(
                    tabs: [
                      Tab(text: 'Description'),
                      Tab(text: 'Reviews'),
                    ],
                  ),
                  Flexible(
                    child: TabBarView(
                      children: [
                        const FoodDescriptionAndAddonWidget(),
                        Center(child: TextWidget('Reviews' * 5)),
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
  const FoodItemHeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              'Sushi Shima',
              fontSize: sp(18),
              fontWeight: FontWeight.w500,
            ),
            Row(
              children: [
                Icon(
                  Icons.star_rate,
                  size: sp(13),
                  color: kcPrimaryColor,
                ),
                TextWidget('4.5(283)', fontSize: sp(15)),
                TextWidget(
                  'Charcoal',
                  fontSize: sp(14),
                  fontWeight: FontWeight.w300,
                ),
              ],
            ),
          ],
        ),
        TextWidget(
          'NGN 2,000',
          fontSize: sp(18),
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}
