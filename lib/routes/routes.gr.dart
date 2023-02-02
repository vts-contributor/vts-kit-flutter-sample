// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i14;
import 'package:auto_route/empty_router_widgets.dart' as _i7;
import 'package:flutter/material.dart' as _i15;

import '../bottom_nav_bar.dart' as _i1;
import '../pages/dashboard/dashboard_screen.dart' as _i6;
import '../pages/forgot_password/change_password_screen.dart' as _i4;
import '../pages/forgot_password/code_form_screen.dart' as _i5;
import '../pages/forgot_password/email_form_screen.dart' as _i3;
import '../pages/login/login_screen.dart' as _i2;
import '../pages/notifications/notification_page.dart' as _i8;
import '../pages/posts/posts_page.dart' as _i10;
import '../pages/posts/single_post_page.dart' as _i11;
import '../pages/settings/settings_page.dart' as _i9;
import '../pages/users/user_profile_page.dart' as _i13;
import '../pages/users/users_page.dart' as _i12;

class AppRouter extends _i14.RootStackRouter {
  AppRouter([_i15.GlobalKey<_i15.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i14.PageFactory> pagesMap = {
    BottomNavBar.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.BottomNavBar(),
      );
    },
    LoginRouter.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.LoginScreen(),
      );
    },
    EmailFormRouter.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.EmailFormScreen(),
      );
    },
    ResetPassRouter.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.ChangePasswordScreen(),
      );
    },
    CodeFormRouter.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.CodeFormScreen(),
      );
    },
    DashboardRouter.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.DashboardScreen(),
      );
    },
    PostsRouter.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.EmptyRouterPage(),
      );
    },
    UsersRouter.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.EmptyRouterPage(),
      );
    },
    NotificationsRouter.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.NotificationPage(),
      );
    },
    SettingsRouter.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i9.SettingsPage(),
      );
    },
    PostsRoute.name: (routeData) {
      final args = routeData.argsAs<PostsRouteArgs>(
          orElse: () => const PostsRouteArgs());
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i10.PostsPage(key: args.key),
      );
    },
    SinglePostRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SinglePostRouteArgs>(
          orElse: () =>
              SinglePostRouteArgs(postId: pathParams.getInt('postId')));
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i11.SinglePostPage(
          key: args.key,
          postId: args.postId,
        ),
      );
    },
    UsersRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i12.UsersPage(),
      );
    },
    UserProfileRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<UserProfileRouteArgs>(
          orElse: () =>
              UserProfileRouteArgs(userId: pathParams.getInt('userId')));
      return _i14.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i13.UserProfilePage(
          key: args.key,
          userId: args.userId,
        ),
      );
    },
  };

  @override
  List<_i14.RouteConfig> get routes => [
        _i14.RouteConfig(
          BottomNavBar.name,
          path: 'bottomNavBar',
          children: [
            _i14.RouteConfig(
              DashboardRouter.name,
              path: 'dashboard',
              parent: BottomNavBar.name,
            ),
            _i14.RouteConfig(
              PostsRouter.name,
              path: 'posts',
              parent: BottomNavBar.name,
              children: [
                _i14.RouteConfig(
                  PostsRoute.name,
                  path: '',
                  parent: PostsRouter.name,
                ),
                _i14.RouteConfig(
                  SinglePostRoute.name,
                  path: ':postId',
                  parent: PostsRouter.name,
                ),
              ],
            ),
            _i14.RouteConfig(
              UsersRouter.name,
              path: 'users',
              parent: BottomNavBar.name,
              children: [
                _i14.RouteConfig(
                  UsersRoute.name,
                  path: '',
                  parent: UsersRouter.name,
                ),
                _i14.RouteConfig(
                  UserProfileRoute.name,
                  path: ':userId',
                  parent: UsersRouter.name,
                ),
              ],
            ),
            _i14.RouteConfig(
              NotificationsRouter.name,
              path: 'notifications',
              parent: BottomNavBar.name,
            ),
            _i14.RouteConfig(
              SettingsRouter.name,
              path: 'settings',
              parent: BottomNavBar.name,
            ),
          ],
        ),
        _i14.RouteConfig(
          LoginRouter.name,
          path: '/',
        ),
        _i14.RouteConfig(
          EmailFormRouter.name,
          path: 'email',
        ),
        _i14.RouteConfig(
          ResetPassRouter.name,
          path: 'change_pass',
        ),
        _i14.RouteConfig(
          CodeFormRouter.name,
          path: 'code',
        ),
      ];
}

/// generated route for
/// [_i1.BottomNavBar]
class BottomNavBar extends _i14.PageRouteInfo<void> {
  const BottomNavBar({List<_i14.PageRouteInfo>? children})
      : super(
          BottomNavBar.name,
          path: 'bottomNavBar',
          initialChildren: children,
        );

  static const String name = 'BottomNavBar';
}

/// generated route for
/// [_i2.LoginScreen]
class LoginRouter extends _i14.PageRouteInfo<void> {
  const LoginRouter()
      : super(
          LoginRouter.name,
          path: '/',
        );

  static const String name = 'LoginRouter';
}

/// generated route for
/// [_i3.EmailFormScreen]
class EmailFormRouter extends _i14.PageRouteInfo<void> {
  const EmailFormRouter()
      : super(
          EmailFormRouter.name,
          path: 'email',
        );

  static const String name = 'EmailFormRouter';
}

/// generated route for
/// [_i4.ChangePasswordScreen]
class ResetPassRouter extends _i14.PageRouteInfo<void> {
  const ResetPassRouter()
      : super(
          ResetPassRouter.name,
          path: 'change_pass',
        );

  static const String name = 'ResetPassRouter';
}

/// generated route for
/// [_i5.CodeFormScreen]
class CodeFormRouter extends _i14.PageRouteInfo<void> {
  const CodeFormRouter()
      : super(
          CodeFormRouter.name,
          path: 'code',
        );

  static const String name = 'CodeFormRouter';
}

/// generated route for
/// [_i6.DashboardScreen]
class DashboardRouter extends _i14.PageRouteInfo<void> {
  const DashboardRouter()
      : super(
          DashboardRouter.name,
          path: 'dashboard',
        );

  static const String name = 'DashboardRouter';
}

/// generated route for
/// [_i7.EmptyRouterPage]
class PostsRouter extends _i14.PageRouteInfo<void> {
  const PostsRouter({List<_i14.PageRouteInfo>? children})
      : super(
          PostsRouter.name,
          path: 'posts',
          initialChildren: children,
        );

  static const String name = 'PostsRouter';
}

/// generated route for
/// [_i7.EmptyRouterPage]
class UsersRouter extends _i14.PageRouteInfo<void> {
  const UsersRouter({List<_i14.PageRouteInfo>? children})
      : super(
          UsersRouter.name,
          path: 'users',
          initialChildren: children,
        );

  static const String name = 'UsersRouter';
}

/// generated route for
/// [_i8.NotificationPage]
class NotificationsRouter extends _i14.PageRouteInfo<void> {
  const NotificationsRouter()
      : super(
          NotificationsRouter.name,
          path: 'notifications',
        );

  static const String name = 'NotificationsRouter';
}

/// generated route for
/// [_i9.SettingsPage]
class SettingsRouter extends _i14.PageRouteInfo<void> {
  const SettingsRouter()
      : super(
          SettingsRouter.name,
          path: 'settings',
        );

  static const String name = 'SettingsRouter';
}

/// generated route for
/// [_i10.PostsPage]
class PostsRoute extends _i14.PageRouteInfo<PostsRouteArgs> {
  PostsRoute({_i15.Key? key})
      : super(
          PostsRoute.name,
          path: '',
          args: PostsRouteArgs(key: key),
        );

  static const String name = 'PostsRoute';
}

class PostsRouteArgs {
  const PostsRouteArgs({this.key});

  final _i15.Key? key;

  @override
  String toString() {
    return 'PostsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i11.SinglePostPage]
class SinglePostRoute extends _i14.PageRouteInfo<SinglePostRouteArgs> {
  SinglePostRoute({
    _i15.Key? key,
    required int postId,
  }) : super(
          SinglePostRoute.name,
          path: ':postId',
          args: SinglePostRouteArgs(
            key: key,
            postId: postId,
          ),
          rawPathParams: {'postId': postId},
        );

  static const String name = 'SinglePostRoute';
}

class SinglePostRouteArgs {
  const SinglePostRouteArgs({
    this.key,
    required this.postId,
  });

  final _i15.Key? key;

  final int postId;

  @override
  String toString() {
    return 'SinglePostRouteArgs{key: $key, postId: $postId}';
  }
}

/// generated route for
/// [_i12.UsersPage]
class UsersRoute extends _i14.PageRouteInfo<void> {
  const UsersRoute()
      : super(
          UsersRoute.name,
          path: '',
        );

  static const String name = 'UsersRoute';
}

/// generated route for
/// [_i13.UserProfilePage]
class UserProfileRoute extends _i14.PageRouteInfo<UserProfileRouteArgs> {
  UserProfileRoute({
    _i15.Key? key,
    required int userId,
  }) : super(
          UserProfileRoute.name,
          path: ':userId',
          args: UserProfileRouteArgs(
            key: key,
            userId: userId,
          ),
          rawPathParams: {'userId': userId},
        );

  static const String name = 'UserProfileRoute';
}

class UserProfileRouteArgs {
  const UserProfileRouteArgs({
    this.key,
    required this.userId,
  });

  final _i15.Key? key;

  final int userId;

  @override
  String toString() {
    return 'UserProfileRouteArgs{key: $key, userId: $userId}';
  }
}
