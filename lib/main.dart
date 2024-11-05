import 'package:bookia_118/bookia_app.dart';
import 'package:bookia_118/core/theming/app_colors.dart';
import 'package:bookia_118/data/local/shared_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized() ;
  await SharedHelper.init();

  /// register
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.blue, // navigation bar color
    statusBarColor: AppColors.primary, // status bar color:
  statusBarIconBrightness: Brightness.light
  ),



  );

  runApp(const BookiaApp());
  configLoading();



}

  void configLoading(){
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
      ..dismissOnTap = true ;


    // ..customAnimation = CustomAnimation();
 }
