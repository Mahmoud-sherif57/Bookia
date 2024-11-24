import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../data/local/app_data.dart';
import 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  late PageController controller;
  int _currentPage = 0;
  Timer? _timer;

  HomeScreenCubit() : super(HomeScreenInitial()) {
    controller = PageController(initialPage: 1, viewportFraction: 0.8);

    // إضافة التأكد من وجود الـ PageController
    if (bannerList.isNotEmpty) {
      _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
        if (controller.hasClients) {
          // التأكد من ارتباط الـ controller بـ PageView
          if (_currentPage < bannerList.length - 1) {
            _currentPage++;
          } else {
            _currentPage = 0;
          }

          controller.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeIn,
          );
          emit(HomePageChanged(_currentPage));
        }
      });
    }
  }

  @override
  Future<void> close() async {
    controller.dispose();
    _timer?.cancel();
    super.close();
  }
}
