import 'package:flutter/material.dart';

// push(BuildContext context, Widget view) {
//   Navigator.of(context).push(MaterialPageRoute(builder: (context) => view));
// }

// pushReplacement(BuildContext context, Widget view) {
//   Navigator.of(context)
//       .pushReplacement(MaterialPageRoute(builder: (context) => view));
// }

// pushAndRemoveUntil(BuildContext context, Widget view) {
//   Navigator.of(context).pushAndRemoveUntil(
//       MaterialPageRoute(builder: (context) => view), (route) => false);
// }



class AppFunctions {
  //1
  static Future navigateTo(BuildContext context,Widget screen) {
    return Navigator.push(context, MaterialPageRoute(builder: (context) {
      return screen;
    }));
  }

  //2
  static navigateAndReplacement(BuildContext context, Widget screen) {
    return Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) {
          return screen;
        }));
  }

  //3
  static navigateAndRemove(BuildContext context, Widget screen) {
    return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) {
        return screen;
      }),
          (route) => false,
    );
  }

  //4
  static navigatePop(BuildContext context) {
    return Navigator.pop(context);
  }

  //5
  // static translationFunction(BuildContext context) {
  //   return IconButton(
  //     onPressed: () {
  //       if (context.locale.toString() == 'ar') {
  //         context.setLocale(const Locale('en'));
  //       } else {
  //         context.setLocale(const Locale('ar'));
  //       }
  //     },
  //     icon: const Icon(Icons.translate),
  //   );
  // }



}
