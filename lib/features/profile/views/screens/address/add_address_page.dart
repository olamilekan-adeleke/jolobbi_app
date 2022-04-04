import 'package:flutter/material.dart';

import '../../../../../cores/components/app_bar_widget.dart';
import '../../../../../cores/components/custom_scaffold_widget.dart';
import '../../../../../cores/components/custom_text_widget.dart';
import '../../../../../cores/components/custom_textfiled.dart';
import '../../../../../cores/components/image_widget.dart';
import '../../../../../cores/constants/color.dart';
import '../../../../../cores/utils/sizer_utils.dart';

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  static const String route = '/add-address-screen';

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      // useSingleScroll: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          verticalSpace(),
          const AppBarWidget('Add Address'),
          verticalSpace(30),
          SizedBox(
            height: sp(180),
            width: double.infinity,
            child: const CustomImageWidget(
              imageTypes: ImageTypes.asset,
              imageUrl: 'assets/images/map.png',
            ),
          ),
          verticalSpace(30),
          TextWidget('Current Address', fontSize: sp(15)),
          verticalSpace(),
          GestureDetector(
            child: CustomTextField(
              fillColor: kcWhite,
              hintText: 'Location',
              enabled: false,
              onChanged: (_) {},
            ),
          ),
          verticalSpace(5),
          CustomTextField(
            fillColor: kcWhite,
            hintText: 'Address (Describe your address in more details)',
            onChanged: (_) {},
            maxLine: 5,
          ),
          verticalSpace(20),
          TextWidget('Set Address as', fontSize: sp(15)),
          verticalSpace(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              choiceWidget(
                title: 'Home',
                isSelected: true,
                onTap: (bool val) {},
              ),
              horizontalSpace(5),
              choiceWidget(
                title: 'Hostel',
                isSelected: false,
                onTap: (bool val) {},
              ),
              horizontalSpace(5),
              choiceWidget(
                title: 'Hostel',
                isSelected: false,
                onTap: (bool val) {},
              ),
            ],
          )
        ],
      ),
    );
  }

  FilterChip choiceWidget({
    required String title,
    required bool isSelected,
    required Function(bool selected) onTap,
  }) {
    return FilterChip(
      label: TextWidget(
        title,
        fontSize: sp(15),
        // textColor: isSelected ? kcWhite : null,
      ),
      selected: isSelected,
      padding: EdgeInsets.symmetric(horizontal: sp(10), vertical: sp(10)),
      onSelected: onTap,
      selectedColor: isSelected ? kcPrimaryColor : Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(sp(5)),
      ),
    );
  }
}
