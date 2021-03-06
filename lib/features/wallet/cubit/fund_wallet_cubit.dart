import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cores/utils/crashlytics_helper.dart';
import '../enum/wallet_enum.dart';
import '../model/fund/fund_wallet_state_model.dart';
import '../services/wallet_service.dart';

class FundWalletCubit extends Cubit<FundWalletStateModel> {
  FundWalletCubit() : super(FundWalletStateModel());

  static final WalletService _walletService = WalletService();
  static final CrashlyticsHelper _crashlyticsHelper = CrashlyticsHelper();

  void onAmountChange(String amount) {
    emit(state.copyWith(amount: amount, status: WalletStatus.unknown));
  }

  @Deprecated('not in use any more!')
  void fundWallet(int transactionRef) async {
    try {
      emit(state.copyWith(errorText: '', status: WalletStatus.unknown));

      await _walletService.verifyTransaction(transactionRef);

      emit(state.copyWith(status: WalletStatus.success, amount: ''));
    } catch (e, s) {
      emit(state.copyWith(errorText: '$e', status: WalletStatus.error));

      _crashlyticsHelper.logError(
        e.toString(),
        s,
        functionName: 'fundWallet',
      );
    }
  }
}
