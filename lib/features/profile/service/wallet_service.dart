import '../repository/wallet_pin_repository.dart';

class WalletPinService {
  static final WalletPinRepository _walletPinRepository = WalletPinRepository();

  Future<void> createWalletPin(String pin) async {
    await _walletPinRepository.createWalletPin(pin);
  }

  Future<void> updateWalletPin(String oldPin, String newPin) async {
    await _walletPinRepository.updateWalletPin(oldPin, newPin);
  }
}
