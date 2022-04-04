import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_webservice/places.dart';

import '../../../../cores/constants/keys.dart';
import '../../../../cores/utils/crashlytics_helper.dart';
import '../../enum/profile_enum.dart';
import '../../model/address/update_address_state_model.dart';
import '../../service/update_wallet_service.dart';

class UpdateAddressCubit extends Cubit<UpdateAddressStateModel> {
  UpdateAddressCubit(this.updateAddressService)
      : super(UpdateAddressStateModel());

  final UpdateAddressService updateAddressService;
  static final CrashlyticsHelper _crashlyticsHelper = CrashlyticsHelper();
  Prediction? prediction;
  static final GoogleMapsPlaces _places =
      GoogleMapsPlaces(apiKey: kGoogleApiKey);

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

  void onTagChange(String tag) {
    emit(
      state.copyWith(tag: tag, status: UpdateAddressStatus.unknown),
    );
  }

  void checkData() {
    if (state.location.isEmpty) throw 'Please specify a location';

    if (state.locationDescription.isEmpty) {
      throw 'Please enter your location description';
    }

    if (state.tag.isEmpty) throw 'Please select address type';

    if (prediction == null) throw 'Please specify a location!';
  }

  Future<void> addAddress() async {
    try {
      emit(state.copyWith(errorText: '', status: UpdateAddressStatus.busy));

      checkData();

      PlacesDetailsResponse _detail =
          await _places.getDetailsByPlaceId(prediction!.placeId.toString());

      log(_detail.result.formattedAddress.toString());

      emit(
        state.copyWith(
          lat: _detail.result.geometry!.location.lat,
          lng: _detail.result.geometry!.location.lat,
        ),
      );

      await updateAddressService.addAddress(state.toMap());

      emit(state.reset());
    } catch (e, s) {
      emit(
        state.copyWith(
          errorText: '$e',
          status: UpdateAddressStatus.error,
        ),
      );

      _crashlyticsHelper.logError(
        e.toString(),
        s,
        functionName: 'addAddress',
      );
    }
  }
}
