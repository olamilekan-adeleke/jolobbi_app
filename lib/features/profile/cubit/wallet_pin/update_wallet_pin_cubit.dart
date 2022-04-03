import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/wallet_pin/update_wallet_pin_state_model.dart';

class UpdateWalletPinCubit extends Cubit<UpdateWalletPinStateModel> {
  UpdateWalletPinCubit() : super(UpdateWalletPinStateModel());

  void onPinChange(String pin) {
    emit(state.copyWith(pin: pin));
  }
}
