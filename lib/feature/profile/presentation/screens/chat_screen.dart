import 'package:flutter/material.dart';
import 'package:flutter_tawkto/flutter_tawk.dart';
import '../../../../core/cubits/auth_cubit/auth_cubit.dart';
import '../../../../core/theming/app_colors.dart';


class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = AuthCubit.get(context);
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.backGround,
          body: Tawk(
            //YOUR_DIRECT_CHAT_LINK => you git it from the dashboard of tawkto
            directChatLink: 'https://tawk.to/chat/674388a72480f5b4f5a35fe3/1idfsrjs3',
            visitor: TawkVisitor(
              name: authCubit.userName,
              email: authCubit.userEmail,
            ),
            onLoad: () {
              debugPrint('Hello Tawk!');
            },
            onLinkTap: (String url) {
              debugPrint(url);
            },
            placeholder: const Center(
              child: CircularProgressIndicator(),
            ),
          )),
    );
  }
}
