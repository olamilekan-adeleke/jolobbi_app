import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cores/utils/crashlytics_helper.dart';
import '../../enum/profile_enum.dart';
import '../../model/wallet_pin/update_wallet_pin_state_model.dart';
import '../../service/wallet_service.dart';

class UpdateWalletPinCubit extends Cubit<UpdateWalletPinStateModel> {
  UpdateWalletPinCubit(this.walletPinService)
      : super(UpdateWalletPinStateModel());

  final WalletPinService walletPinService;
  static final CrashlyticsHelper _crashlyticsHelper = CrashlyticsHelper();

  void onPinChange(String pin) {
    emit(state.copyWith(pin: pin, status: UpdateWalletPinStatus.unknown));
  }

  Future<void> createWalletPin() async {
    try {
      if (state.pin.isEmpty || state.pin.length < 4) {
        throw 'Please enter your 4-digit pin!';
      }

      emit(
        state.copyWith(errorText: '', status: UpdateWalletPinStatus.busy),
      );

      await walletPinService.createWalletPin(state.pin);

      emit(
        state.copyWith(pin: '', status: UpdateWalletPinStatus.success),
      );
    } catch (e, s) {
      emit(
        state.copyWith(errorText: '$e', status: UpdateWalletPinStatus.error),
      );

      _crashlyticsHelper.logError(
        e.toString(),
        s,
        functionName: 'createWalletPin',
      );
    }
  }

  void validatePinLength() {
    if (state.oldPin.isEmpty || state.oldPin.length < 4) {
      emit(
        state.copyWith(
          errorText: 'Please enter your 4-digit pin!',
          status: UpdateWalletPinStatus.error,
        ),
      );
    }
  }

  Future<void> updateWalletPin() async {
    try {
      if (state.pin.isEmpty || state.pin.length < 4) {
        throw 'Please enter your 4-digit pin!';
      }

      emit(
        state.copyWith(errorText: '', status: UpdateWalletPinStatus.busy),
      );

      await walletPinService.updateWalletPin(state.oldPin, state.pin);

      emit(
        state.copyWith(pin: '', status: UpdateWalletPinStatus.success),
      );
    } catch (e, s) {
      emit(
        state.copyWith(errorText: '$e', status: UpdateWalletPinStatus.error),
      );

      _crashlyticsHelper.logError(
        e.toString(),
        s,
        functionName: 'updateWalletPin',
      );
    }
  }
}
