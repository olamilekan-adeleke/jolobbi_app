import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/wallet_state_model.dart';

class WalletCubit extends Cubit<WalletStateModel> {
  WalletCubit() : super(WalletStateModel());

  void getWalletData(){}
}