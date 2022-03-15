import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/food_vendor_state_model.dart';
import '../service/food_vendor_service.dart';

class FoodVendorCubit extends Cubit<FoodVendorStateModel> {
  FoodVendorCubit(this.foodVendorService) : super(FoodVendorStateModel());

  final FoodVendorService foodVendorService;
}
