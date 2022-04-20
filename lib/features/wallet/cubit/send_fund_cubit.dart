import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../enum/wallet_enum.dart';
import '../model/fund/send_fund_state_model.dart';
import '../services/wallet_service.dart';

class SendFundCubit extends Cubit<SendFundStateModel> {
  SendFundCubit() : super(SendFundStateModel());

  static final WalletService _walletService = WalletService();

  void onVendorTagChange(String vendorTag) {
    emit(state.copyWith(vendorTag: vendorTag, status: WalletStatus.unknown));
  }

  void onAmountChange(String amount) {
    emit(
      state.copyWith(amount: int.parse(amount), status: WalletStatus.unknown),
    );
  }

  Future<void> makeTransfer() async {
    try {
      emit(state.copyWith(errorText: '', status: WalletStatus.busy));

      await _walletService.transferToVendor(state.vendorTag, state.amount);

      emit(state.copyWith(errorText: '', status: WalletStatus.success));
    } catch (e, s) {
      log(e.toString());
      log(s.toString());

      emit(state.copyWith(errorText: '$e', status: WalletStatus.error));
    }
  }
}
