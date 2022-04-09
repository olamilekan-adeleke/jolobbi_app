import '../enum/wallet_enum.dart';
import 'wallet_data_model.dart';

class WalletStateModel {
  final WalletDataModel? walletData;
  final String errorText;
  final WalletStatus status;

  WalletStateModel({
    this.walletData,
     this.errorText ='',
     this.status = WalletStatus.unknown
  });

  WalletStateModel copyWith({
    WalletDataModel? walletData,
    String? errorText,
    WalletStatus? status,
  }) {
    return WalletStateModel(
      walletData: walletData ?? this.walletData,
      errorText: errorText ?? this.errorText,
      status: status ?? this.status,
    );
  }
}
