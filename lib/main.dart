import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jolobbi_app/app.dart';
import 'package:monnify_flutter_sdk/monnify_flutter_sdk.dart';

import 'features/authentication/repository/push_notification_repo.dart';

Future<void> main() async {
  if (kIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    await PushNotificationService().initNotification();

    MonnifyFlutterSdk.initialize(
      'MK_TEST_BM0J9L4PF8',
      '5496050632',
      ApplicationMode.TEST,
    );

    runApp(const JolobbiApp());
  } else {
    runZonedGuarded<Future<void>>(
      () async {
        WidgetsFlutterBinding.ensureInitialized();
        await Firebase.initializeApp();

        await PushNotificationService().initNotification();

        MonnifyFlutterSdk.initialize(
          'MK_TEST_BM0J9L4PF8',
          '5496050632',
          ApplicationMode.TEST,
        );

        runApp(const JolobbiApp());
      },
      (error, stack) => FirebaseCrashlytics.instance.recordError(
        error,
        stack,
      ),
    );
  }
}
