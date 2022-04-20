import '../../enum/wallet_enum.dart';
import 'transaction_history_data_model.dart';

class TransactionHistoryStateModel {
  List<TransactionHistoryDataModel> transactionHistory = [];
  final WalletStatus status;
  final String errorText;

  TransactionHistoryStateModel({
    List<TransactionHistoryDataModel>? transactionHistory,
    this.status = WalletStatus.unknown,
    this.errorText = '',
  }) : transactionHistory = transactionHistory ?? [];

  TransactionHistoryStateModel copyWith({
    List<TransactionHistoryDataModel>? transactionHistory,
    WalletStatus? status,
    String? errorText,
  }) {
    return TransactionHistoryStateModel(
      transactionHistory: transactionHistory ?? this.transactionHistory,
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
    );
  }
}
