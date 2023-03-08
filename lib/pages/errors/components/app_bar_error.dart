import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sample/pages/errors/components/fade_animation.dart';

class ErrorAppBar extends StatelessWidget with PreferredSizeWidget {
  const ErrorAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(55);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return FadeAnimation(
      delay: 3,
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              context.navigateBack();
            },
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
