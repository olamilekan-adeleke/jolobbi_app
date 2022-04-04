import '../repository/wallet_pin_repository.dart';

class WalletPinService {
  static final WalletPinRepository _walletPinRepository = WalletPinRepository();

  Future<void> createWallet(String pin) async {
    await _walletPinRepository.createWalletPin(pin);
  }
}
