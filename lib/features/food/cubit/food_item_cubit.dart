import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/food_item_state_model.dart';
import '../service/food_vendor_service.dart';

class FoodItemCubit extends Cubit<FoodItemStateModel> {
  FoodItemCubit(this.foodVendorService) : super(FoodItemStateModel());

  final FoodVendorService foodVendorService;
}
