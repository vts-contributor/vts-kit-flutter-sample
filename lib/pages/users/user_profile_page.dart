import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sample/constants/colors.dart';
import 'package:sample/data/app_data.dart';
import 'package:sample/widgets/widgets.dart';

class UserProfilePage extends StatelessWidget {
  final int userId;
  const UserProfilePage({
    Key? key,
    @PathParam() required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = User.users[userId - 1];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kPrimaryColor,
        leading: const AutoLeadingButton(),
      ),
      backgroundColor: user.color,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UserAvatar(
              avatarColor: Colors.white,
              username: 'user${user.id}',
            )
          ],
        ),
      ),
    );
  }
}
