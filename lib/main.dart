import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:jolobbi_app/app.dart';

import 'features/authentication/repository/push_notification_repo.dart';

Future<void> main() async {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();

      await PushNotificationService().initNotification();

      runApp(const JolobbiApp());
    },
    (error, stack) => FirebaseCrashlytics.instance.recordError(
      error,
      stack,
    ),
  );
}
