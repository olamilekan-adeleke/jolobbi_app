import 'package:jolobbi_app/features/wallet/model/wallet_data_model.dart';
import 'package:jolobbi_app/features/wallet/repository/wallet_repository.dart';

class WalletService {
  static final WalletRepository _walletRepository = WalletRepository();

  Future<WalletDataModel> getWalletData() async {
    Map<String, dynamic> data = await _walletRepository.getWalletBalance();

    return WalletDataModel.fromMap(data);
  }

  Future<void> verifyTransaction(String transactionRef) async {
    await _walletRepository.verifyTransaction(transactionRef);
  }
}
