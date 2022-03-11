import 'package:flutter/material.dart';

import '../../../../cores/components/custom_scaffold_widget.dart';
import '../../../../cores/components/custom_text_widget.dart';

class SelectedFoodItemWidget extends StatelessWidget {
  const SelectedFoodItemWidget({Key? key}) : super(key: key);

  static const String route = '/selected-food-item';

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      body: TextWidget('selecteds food page'),
    );
  }
}
