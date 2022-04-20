import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../enum/wallet_enum.dart';
import '../model/transaction_history/transaction_history_data_model.dart';
import '../model/transaction_history/transaction_history_state_model.dart';
import '../services/wallet_service.dart';

class TransactionHistoryCubit extends Cubit<TransactionHistoryStateModel> {
  TransactionHistoryCubit() : super(TransactionHistoryStateModel());

  static final WalletService _walletService = WalletService();

  void initScrollListener(ScrollController scrollController) {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        log('end of line');

        getMoreUserTransactionHistory();
      }
    });
  }

  Future<void> getUserTransactionHistory() async {
    try {
      emit(state.copyWith(status: WalletStatus.busy));

      final List<TransactionHistoryDataModel> result =
          await _walletService.getUserTransactionHistory();

      emit(
        state.copyWith(
          status: WalletStatus.success,
          transactionHistory: result,
        ),
      );
    } catch (e, s) {
      log(e.toString());
      log(s.toString());

      emit(state.copyWith(errorText: '$e', status: WalletStatus.error));
    }
  }

  Future<void> getMoreUserTransactionHistory() async {
    try {
      emit(state.copyWith(status: WalletStatus.moreBusy));

      final List<TransactionHistoryDataModel> result =
          await _walletService.getUserTransactionHistory(
        lastDocTime: state.transactionHistory.last.timestamp,
      );

      emit(
        state.copyWith(
          status: WalletStatus.success,
          transactionHistory: [...state.transactionHistory, ...result],
        ),
      );
    } catch (e, s) {
      log(e.toString());
      log(s.toString());

      emit(state.copyWith(errorText: '$e', status: WalletStatus.error));
    }
  }
}
