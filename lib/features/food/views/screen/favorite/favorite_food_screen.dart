import 'package:flutter/material.dart';

import '../../../../../cores/components/app_bar_widget.dart';
import '../../../../../cores/components/custom_scaffold_widget.dart';
import '../../../../../cores/components/custom_text_widget.dart';
import '../../../../../cores/components/image_widget.dart';
import '../../../../../cores/utils/sizer_utils.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  static const String route = '/favorite-screen';

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      useSingleScroll: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          verticalSpace(),
          const AppBarWidget('Favorite'),
          verticalSpace(),
          TextWidget(
            'My favorite food',
            fontSize: sp(16),
            fontWeight: FontWeight.w500,
          ),
          Flexible(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (_, int index) {
                return const FavoriteFoodItemListTileWidget();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FavoriteFoodItemListTileWidget extends StatelessWidget {
  const FavoriteFoodItemListTileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: sp(5), vertical: sp(10)),
        child: Row(
          children: <Widget>[
            SizedBox(
              height: sp(70),
              width: sp(70),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(sp(5)),
                child: const CustomImageWidget(
                  imageUrl:
                      'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?cs=srgb&dl=pexels-ella-olsson-1640777.jpg&fm=jpg',
                  imageTypes: ImageTypes.network,
                ),
              ),
            ),
            horizontalSpace(),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    'Bread and Beans',
                    fontSize: sp(15),
                    fontWeight: FontWeight.w300,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  TextWidget(
                    'NGN 300.',
                    fontSize: sp(16),
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Icon(Icons.cancel, size: sp(25), color: Colors.red),
          ],
        ),
      ),
    );
  }
}
