import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';

import '../../enum/profile_enum.dart';
import '../../model/address/update_address_state_model.dart';
import '../../service/update_wallet_service.dart';

class UpdateAddressCubit extends Cubit<UpdateAddressStateModel> {
  UpdateAddressCubit(this.updateAddressService)
      : super(UpdateAddressStateModel());

  final UpdateAddressService updateAddressService;
  Prediction? prediction;

  void onLocationChange(Prediction prediction) {
    this.prediction = prediction;

    emit(
      state.copyWith(
        location: prediction.description,
        status: UpdateAddressStatus.unknown,
      ),
    );
  }

  void onLocationDescriptionChange(String description) {
    emit(
      state.copyWith(
        locationDescription: description,
        status: UpdateAddressStatus.unknown,
      ),
    );
  }
}
