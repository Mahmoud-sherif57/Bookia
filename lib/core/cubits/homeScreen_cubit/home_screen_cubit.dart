import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../../data/local/app_data.dart';
import 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  late PageController controller;
  int _currentPage = 0;
  Timer? _timer;
  static HomeScreenCubit get(context) => BlocProvider.of<HomeScreenCubit>(context);

  HomeScreenCubit() : super(HomeScreenInitial()) {
    controller = PageController(initialPage: 1, viewportFraction: 0.8);
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (_currentPage < bannerList.length-1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  void changePage(int page) {
    emit(HomePageChanged(page));
  }

  @override
  Future<void> close() async {
    controller.dispose();
    _timer?.cancel();
    super.close();
  }
}


