import 'package:flutter/material.dart';

import '../../../../../cores/components/custom_text_widget.dart';
import '../../../../../cores/components/image_widget.dart';
import '../../../../../cores/constants/color.dart';
import '../../../../../cores/utils/sizer_utils.dart';



class DrawerUserProfileWidget extends StatelessWidget {
  const DrawerUserProfileWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: sp(45),
          width: sp(45),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(sp(100)),
            child: const CustomImageWidget(
              imageUrl:
                  'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cmFuZG9tJTIwcGVyc29ufGVufDB8fDB8fA%3D%3D&w=1000&q=80',
              imageTypes: ImageTypes.network,
            ),
          ),
        ),
        horizontalSpace(10),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                'Olamilekan Kod-x ',
                fontSize: sp(14),
                fontWeight: FontWeight.w600,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textColor: kcWhite,
              ),
              TextWidget(
                'Olamilekan@Kod-x.com',
                fontSize: sp(12),
                fontWeight: FontWeight.w300,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textColor: kcWhite,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
