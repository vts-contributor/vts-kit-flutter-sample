import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sample/data/app_data.dart';
import 'package:sample/utils/dynamic_link.dart';
import 'package:sample/widgets/widgets.dart';

class UserProfilePage extends StatelessWidget {
  final int userId;
  const UserProfilePage({
    Key? key,
    @PathParam() required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("path: " + context.router.currentPath);
    final user = User.users[userId - 1];
    final _dynamicLinkHandler = DynamicLinkHandler.shared;
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: AppColors.kPrimaryColor,
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
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton2(
                      onPressed: () => _dynamicLinkHandler.generateLink(
                          context, context.router.currentPath),
                      iconColor: MaterialStateProperty.all<Color>(Colors.white),
                      icon: const Icon(
                        Icons.qr_code,
                        size: 25,
                      ),
                      label: const Text("Get your link!"),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: CustomButton2(
                      onPressed: () => _dynamicLinkHandler.shareLink(
                          context, context.router.currentPath),
                      iconColor: MaterialStateProperty.all<Color>(Colors.white),
                      icon: const Icon(
                        Icons.ios_share,
                        size: 25,
                      ),
                      label: const Text("Share"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
