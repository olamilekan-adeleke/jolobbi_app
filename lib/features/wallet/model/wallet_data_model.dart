class WalletDataModel {
  final int cashBalance;
  final int coinBalance;

  WalletDataModel({
    required this.cashBalance,
    required this.coinBalance,
  });

  Map<String, dynamic> toMap() {
    return {
      'cash_balance': cashBalance,
      'coin_balance': coinBalance,
    };
  }

  factory WalletDataModel.fromMap(Map<String, dynamic> map) {
    return WalletDataModel(
      cashBalance: (map['cash_balance']?.toInt() ?? 0) ~/ 100,
      coinBalance: (map['coin_balance']?.toInt() ?? 0) ~/ 100,
    );
  }
}
