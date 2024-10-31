import 'package:bookia_118/core/theming/app_colors.dart';
import 'package:bookia_118/feature/cart/presentation/screens/cart_screen.dart';
import 'package:bookia_118/feature/home/presentation/screens/home.dart';
import 'package:bookia_118/feature/profile/presentation/screens/profile_screen.dart';
import 'package:bookia_118/feature/wish_list/presentation/screens/wish_list_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../../home/presentation/screens/search_screen.dart';

class WrapperHomeScreen extends StatefulWidget {
  const WrapperHomeScreen({super.key});

  @override
  WrapperHomeScreenState createState() => WrapperHomeScreenState();
}

class WrapperHomeScreenState extends State<WrapperHomeScreen> {
  late final List<Widget> _pages = [
    const SearchScreen(), // Search PageHome Page
    const CartScreen(), // Home Page
    const HomeScreen(), // Home Page
    const WishlistScreen(), // wishlist page
    const ProfileScreen(), // Home Page
  ];
  int _selectedIndex = 2;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primary,
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: _selectedIndex,
          height: 55,
          items: const <Widget>[
            Icon(
              Icons.search,
              size: 30,
              color: AppColors.ivory,
            ),
            Icon(
              Icons.shopping_cart,
              size: 30,
              color: AppColors.ivory,
            ),
            Icon(
              Icons.home,
              size: 30,
              color: AppColors.ivory,
            ),
            Icon(
              Icons.favorite,
              size: 30,
              color: AppColors.ivory,
            ),
            Icon(
              Icons.person,
              size: 30,
              color: AppColors.ivory,
            ),
          ],
          color: AppColors.primary, // the color of the buttonNavBar
          buttonBackgroundColor: AppColors.primary, // the color of the icon's circle
          backgroundColor: AppColors.backGround, // the color of the background behind the icon
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 400),
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: _pages[_selectedIndex]);
  }
}
