import '../../enum/profile_enum.dart';

class UpdateWalletPinStateModel {
  final UpdateWalletPinStatus status;
  final String errorText;
  final String pin;
  final String oldPin;

  UpdateWalletPinStateModel({
    this.status = UpdateWalletPinStatus.unknown,
    this.errorText = '',
    this.pin = '',
    this.oldPin = '',
  });

  UpdateWalletPinStateModel copyWith({
    UpdateWalletPinStatus? status,
    String? errorText,
    String? pin,
    String? oldPin,
  }) {
    return UpdateWalletPinStateModel(
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
      pin: pin ?? this.pin,
      oldPin: oldPin ?? this.oldPin,
    );
  }
}
