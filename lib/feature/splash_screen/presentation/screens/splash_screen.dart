import 'package:bookia_118/core/constants/app_strings.dart';
import 'package:bookia_118/core/constants/constants.dart';
import 'package:bookia_118/core/cubits/category_cubit/category_cubit.dart';
import 'package:bookia_118/core/functions/navigation.dart';
import 'package:bookia_118/core/theming/styles.dart';
import 'package:bookia_118/data/local/shared_keys.dart';
import 'package:bookia_118/feature/login/presentation/screens/login_screen.dart';
import 'package:bookia_118/feature/wrapper_screen/presentation/screen/wrapper_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/theming/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      const storage = FlutterSecureStorage();
      String? value = await storage.read(key: SharedKeys.token);
      if(!mounted) return ;   // this line to avoid the message( info: Don't use 'BuildContext's across async gaps. )
      if (value != null) {
        AppFunctions.navigateAndRemove(context, const WrapperHomeScreen());
      } else {
        AppFunctions.navigateAndRemove(context, const LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    CategoryCubit.get(context).getAllBooks();
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.backGround,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.splashLogo,
              fit: BoxFit.contain,
            ),
            const SizedBox(
              height: 9,
            ),
            Text(
              AppString.introSplash,
              style: font20RegularDark.copyWith(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
