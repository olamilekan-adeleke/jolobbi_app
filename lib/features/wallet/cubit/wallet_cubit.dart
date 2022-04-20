import 'package:flutter_bloc/flutter_bloc.dart';
import '../enum/wallet_enum.dart';
import '../model/wallet_data/wallet_data_model.dart';

import '../../../cores/utils/crashlytics_helper.dart';
import '../model/wallet_data/wallet_state_model.dart';
import '../services/wallet_service.dart';

class WalletCubit extends Cubit<WalletStateModel> {
  WalletCubit() : super(WalletStateModel());

  static final WalletService _walletService = WalletService();
  static final CrashlyticsHelper _crashlyticsHelper = CrashlyticsHelper();

  Future<void> getWalletBalance() async {
    try {
      emit(state.copyWith(errorText: '', status: WalletStatus.busy));

      final WalletDataModel data = await _walletService.getWalletData();

      emit(state.copyWith(walletData: data, status: WalletStatus.success));
    } catch (e, s) {
      emit(state.copyWith(errorText: '$e', status: WalletStatus.error));

      _crashlyticsHelper.logError(
        e.toString(),
        s,
        functionName: 'getWalletBalance',
      );
    }
  }
}
