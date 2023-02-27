import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:sample/data/app_data.dart';
import 'package:sample/routes/routes.gr.dart';
import 'package:sample/widgets/widgets.dart';

class PostsPage extends StatefulWidget {
  PostsPage({Key? key}) : super(key: key);

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final posts = Post.posts;

  @override
  Widget build(BuildContext context) {
    print(context.router.currentPath);
    return SingleChildScrollView(
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
                for (int i = 0; i < posts.length; i++)
                  PostTile(
                    tileColor: posts[i].color,
                    postTitle: posts[i].title,
                    onTileTap: () {
                      context.router.push(SinglePostRoute(
                        postId: posts[i].id,
                      ));
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
