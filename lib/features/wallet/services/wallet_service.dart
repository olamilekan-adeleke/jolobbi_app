import '../model/transaction_history/transaction_history_data_model.dart';
import '../model/wallet_data/wallet_data_model.dart';
import '../repository/wallet_repository.dart';

class WalletService {
  static final WalletRepository _walletRepository = WalletRepository();

  Future<WalletDataModel> getWalletData() async {
    Map<String, dynamic> data = await _walletRepository.getWalletBalance();

    return WalletDataModel.fromMap(data);
  }

  Future<void> verifyTransaction(int transactionRef) async {
    await _walletRepository.verifyTransaction(transactionRef);
  }

  Future<void> transferToVendor(String vendorTag, int amount) async {
    await _walletRepository.transferByBusinessTag(
      <String, dynamic>{'amount': amount, 'businessTag': vendorTag},
    );
  }

  Future<List<TransactionHistoryDataModel>> getUserTransactionHistory() async {
    List<Map<String, dynamic>> result =
        await _walletRepository.getUserTransactionHistory();

    return result
        .map((ele) => TransactionHistoryDataModel.fromMap(ele))
        .toList();
  }
}
