import '../enum/wallet_enum.dart';

class FundWalletStateModel {
  final WalletStatus status;
  final String errorText;
  final String amount;
  
  FundWalletStateModel({
     this.status = WalletStatus.unknown,
     this.errorText = '',
     this.amount ='',
  });

  FundWalletStateModel copyWith({
    WalletStatus? status,
    String? errorText,
    String? amount,
  }) {
    return FundWalletStateModel(
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
      amount: amount ?? this.amount,
    );
  }
}
