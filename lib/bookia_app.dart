import 'package:bookia_118/core/cubits/category_cubit/category_cubit.dart';
import 'package:bookia_118/core/cubits/homeScreen_cubit/home_screen_cubit.dart';
import 'package:bookia_118/feature/splash_screen/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theming/theming.dart';


class BookiaApp extends StatelessWidget {
  const BookiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> HomeScreenCubit()),
        BlocProvider(create: (context)=> CategoryCubit())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
       theme: lightTheme,
       home:  const SplashScreen(),
      ),
    );
  }
}
