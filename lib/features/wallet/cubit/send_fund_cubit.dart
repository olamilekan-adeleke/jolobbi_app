import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../enum/wallet_enum.dart';
import '../model/send_fund_state_model.dart';

class SendFundCubit extends Cubit<SendFundStateModel> {
  SendFundCubit() : super(SendFundStateModel());

  void onVendorTagChange(String vendorTag) {
    emit(state.copyWith(vendorTag: vendorTag, status: WalletStatus.unknown));
  }

  void onAmountChange(String amount) {
    emit(
      state.copyWith(amount: int.parse(amount), status: WalletStatus.unknown),
    );
  }

  void makeTransfer() {
    try {
      emit(state.copyWith(errorText: '', status: WalletStatus.busy));

      // add function call

      emit(state.copyWith(errorText: '', status: WalletStatus.success));
    } catch (e, s) {
      log(e.toString());
      log(s.toString());

      emit(state.copyWith(errorText: '$e', status: WalletStatus.error));
    }
  }
}
