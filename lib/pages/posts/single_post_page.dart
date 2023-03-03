import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sample/data/app_data.dart';
import 'package:sample/utils/dynamic_link.dart';

class SinglePostPage extends StatelessWidget {
  final int postId;
  const SinglePostPage({
    Key? key,
    @PathParam() required this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final post = Post.posts[postId - 1];
    final _dynamicLinkHandler = DynamicLinkHandler.shared;
    print("path: " + context.router.currentPath);
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: AppColors.kPrimaryColor,
        leading: const AutoLeadingButton(),
      ),
      backgroundColor: post.color,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                post.title,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                textAlign: TextAlign.center,
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
                        iconColor:
                            MaterialStateProperty.all<Color>(Colors.white),
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
                        iconColor:
                            MaterialStateProperty.all<Color>(Colors.white),
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
      ),
    );
  }
}
