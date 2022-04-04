import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';

import '../../../../../cores/components/custom_text_widget.dart';
import '../../../../../cores/components/custom_textfiled.dart';
import '../../../../../cores/constants/color.dart';
import '../../../../../cores/constants/keys.dart';
import '../../../../../cores/utils/sizer_utils.dart';
import '../../../cubit/address_cubit/update_address_cubit.dart';

class UpdateAddressFormWidget extends StatelessWidget {
  const UpdateAddressFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UpdateAddressCubit updateAddressCubit =
        context.read<UpdateAddressCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextWidget('Current Address', fontSize: sp(15)),
        verticalSpace(),
        GestureDetector(
          onTap: () async {
            Prediction? p = await PlacesAutocomplete.show(
              context: context,
              apiKey: kGoogleApiKey,
              mode: Mode.overlay,
              components: [Component(Component.country, "ng")],
            );

            if (p != null) updateAddressCubit.onLocationChange(p);
          },
          child: CustomTextField(
            fillColor: kcWhite,
            hintText: updateAddressCubit.state.location.isEmpty
                ? 'Search Location'
                : updateAddressCubit.state.location,
            enabled: false,
            onChanged: (_) {},
          ),
        ),
        verticalSpace(5),
        CustomTextField(
          fillColor: kcWhite,
          hintText: 'Address (Describe your address in more details)',
          onChanged: updateAddressCubit.onLocationDescriptionChange,
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
              title: 'Office',
              isSelected: false,
              onTap: (bool val) {},
            ),
          ],
        )
      ],
    );
  }

  Container choiceWidget({
    required String title,
    required bool isSelected,
    required Function(bool selected) onTap,
  }) {
    return Container(
      child: TextWidget(
        title,
        fontSize: sp(15),
        textColor: isSelected ? kcWhite : null,
      ),
      padding: EdgeInsets.symmetric(horizontal: sp(15), vertical: sp(8)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(sp(5)),
        color: isSelected ? kcPrimaryColor : Colors.transparent,
        border: Border.all(
          color: isSelected ? Colors.transparent : kcTextColor,
        ),
      ),
    );
  }
}
