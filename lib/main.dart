import 'package:bookia_118/bookia_app.dart';
import 'package:bookia_118/core/theming/app_colors.dart';
import 'package:bookia_118/data/local/shared_helper.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedHelper.init();
  // to initialize sentry package( it helps you to know the errors shown to the user )
  //  if the user faced any error you will find it in the dashboard in sentry site..
  if (kReleaseMode) {
    await SentryFlutter.init(
      (options) {
        options.dsn =
            'https://bec7bb145664c9bd4f97efc3cc64a313@o4508302794227712.ingest.us.sentry.io/4508308540555264';
        // Set tracesSampleRate to 1.0 to capture 100% of transactions for tracing.
        // We recommend adjusting this value in production.
        options.tracesSampleRate = 0.01;
      },
      appRunner: () => runApp(const BookiaApp()),
    );
  } else {
    runApp(const BookiaApp());
  }

  // to initialize firebase..
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // it belongs to the firebase to avoid problems in social auth to declare that the app in debug mode
  if (!kDebugMode) {
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.playIntegrity,
      // webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    );
  } else {
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.debug,
    );
  }
  // await FirebaseAppCheck.instance.activate();

  /// register
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.blue, // navigation bar color
        statusBarColor: AppColors.primary, // status bar color:
        statusBarIconBrightness: Brightness.light),
  );
  // runApp(const BookiaApp());

  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 3000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = AppColors.primary
    ..backgroundColor = AppColors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = true;

  // ..customAnimation = CustomAnimation();
}
