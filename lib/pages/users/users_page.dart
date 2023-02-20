import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sample/data/app_data.dart';
import 'package:sample/routes/routes.gr.dart';
import 'package:sample/widgets/widgets.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    final users = User.users;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 40,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < users.length; i++)
                    UserAvatar(
                      avatarColor: users[i].color,
                      username: 'user${users[i].id}',
                      onAvatarTap: () {
                        context.router.push(
                          UserProfileRoute(
                            userId: users[i].id,
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
