import '../../enum/wallet_enum.dart';

class SendFundStateModel {
  final String vendorTag;
  final int amount;
  final String errorText;
  final WalletStatus status;

  SendFundStateModel({
     this.vendorTag = '',
     this.amount = 0,
     this.errorText = '',
     this.status = WalletStatus.unknown,
  });

  SendFundStateModel copyWith({
    String? vendorTag,
    int? amount,
    String? errorText,
    WalletStatus? status,
  }) {
    return SendFundStateModel(
      vendorTag: vendorTag ?? this.vendorTag,
      amount: amount ?? this.amount,
      errorText: errorText ?? this.errorText,
      status: status ?? this.status,
    );
  }
}
