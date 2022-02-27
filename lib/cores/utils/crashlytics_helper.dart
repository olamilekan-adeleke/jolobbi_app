import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:jolobbi_app/cores/utils/local_storage.dart';

class CrashlyticsHelper {
  final LocalStorage _localStorage = LocalStorage.instance;

  CrashlyticsHelper() {
    _init();
  }

  Future<void> _init() async {
    // FirebaseCrashlytics.instance.crash();
    if (kDebugMode) {
      // Force disable Crashlytics collection while doing every day development.
      // Temporarily toggle this to true if you want to test crash reporting in your app.
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    } else {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      // Handle Crashlytics enabled status when not in Debug,
      // e.g. allow your users to opt-in to crash reporting.
    }
  }

  Future<void> setUserDetailsKey(String userId, String email) async {
    await FirebaseCrashlytics.instance.setCustomKey('user_id', userId);
    await FirebaseCrashlytics.instance.setCustomKey('username', email);
  }

  Future<void> log(String message, {Map? extraData}) async {
    await FirebaseCrashlytics.instance.log(
      '$message | ${extraData != null ? extraData.toString() : ''}',
    );
  }

  Future<void> logError(
    String error,
    StackTrace stackTrace, {
    required String functionName,
    String? action,
    bool fatal = true,
  }) async {
    final String userId = _localStorage.userEmail;

    FirebaseCrashlytics.instance.setUserIdentifier(userId);

    await FirebaseCrashlytics.instance.recordError(
      error,
      stackTrace,
      reason: '@$functionName | ${action ?? ''}',
      fatal: fatal,
    );

    log(error);
    log(stackTrace.toString());
  }
}
