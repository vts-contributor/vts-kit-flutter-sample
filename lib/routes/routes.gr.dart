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
import 'package:auto_route/auto_route.dart' as _i15;
import 'package:auto_route/empty_router_widgets.dart' as _i8;
import 'package:flutter/material.dart' as _i16;

import '../bottom_nav_bar.dart' as _i1;
import '../pages/errors/error_page.dart' as _i6;
import '../pages/forgot_password/change_password_screen.dart' as _i4;
import '../pages/forgot_password/code_form_screen.dart' as _i5;
import '../pages/forgot_password/email_form_screen.dart' as _i3;
import '../pages/home/dashboard_page.dart' as _i7;
import '../pages/login/login_screen.dart' as _i2;
import '../pages/notifications/notification_page.dart' as _i9;
import '../pages/posts/posts_page.dart' as _i11;
import '../pages/posts/single_post_page.dart' as _i12;
import '../pages/settings/settings_page.dart' as _i10;
import '../pages/users/user_profile_page.dart' as _i14;
import '../pages/users/users_page.dart' as _i13;

class AppRouter extends _i15.RootStackRouter {
  AppRouter([_i16.GlobalKey<_i16.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i15.PageFactory> pagesMap = {
    BottomNavBar.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.BottomNavBar(),
      );
    },
    LoginRouter.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.LoginScreen(),
      );
    },
    EmailFormRouter.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.EmailFormScreen(),
      );
    },
    ResetPassRouter.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.ChangePasswordScreen(),
      );
    },
    CodeFormRouter.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.CodeFormScreen(),
      );
    },
    ErrorPageRouter.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.ErrorPage(),
      );
    },
    DashboardRouter.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.DashboardScreen(),
      );
    },
    PostsRouter.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.EmptyRouterPage(),
      );
    },
    UsersRouter.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.EmptyRouterPage(),
      );
    },
    NotificationsRouter.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i9.NotificationPage(),
      );
    },
    SettingsRouter.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i10.SettingsPage(),
      );
    },
    PostsRoute.name: (routeData) {
      final args = routeData.argsAs<PostsRouteArgs>(
          orElse: () => const PostsRouteArgs());
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i11.PostsPage(key: args.key),
      );
    },
    SinglePostRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SinglePostRouteArgs>(
          orElse: () =>
              SinglePostRouteArgs(postId: pathParams.getInt('postId')));
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i12.SinglePostPage(
          key: args.key,
          postId: args.postId,
        ),
      );
    },
    UsersRoute.name: (routeData) {
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i13.UsersPage(),
      );
    },
    UserProfileRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<UserProfileRouteArgs>(
          orElse: () =>
              UserProfileRouteArgs(userId: pathParams.getInt('userId')));
      return _i15.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i14.UserProfilePage(
          key: args.key,
          userId: args.userId,
        ),
      );
    },
  };

  @override
  List<_i15.RouteConfig> get routes => [
        _i15.RouteConfig(
          BottomNavBar.name,
          path: 'home',
          children: [
            _i15.RouteConfig(
              DashboardRouter.name,
              path: 'dashboard',
              parent: BottomNavBar.name,
            ),
            _i15.RouteConfig(
              PostsRouter.name,
              path: 'posts',
              parent: BottomNavBar.name,
              children: [
                _i15.RouteConfig(
                  PostsRoute.name,
                  path: '',
                  parent: PostsRouter.name,
                ),
                _i15.RouteConfig(
                  SinglePostRoute.name,
                  path: ':postId',
                  parent: PostsRouter.name,
                ),
              ],
            ),
            _i15.RouteConfig(
              UsersRouter.name,
              path: 'users',
              parent: BottomNavBar.name,
              children: [
                _i15.RouteConfig(
                  UsersRoute.name,
                  path: '',
                  parent: UsersRouter.name,
                ),
                _i15.RouteConfig(
                  UserProfileRoute.name,
                  path: ':userId',
                  parent: UsersRouter.name,
                ),
              ],
            ),
            _i15.RouteConfig(
              NotificationsRouter.name,
              path: 'notifications',
              parent: BottomNavBar.name,
            ),
            _i15.RouteConfig(
              SettingsRouter.name,
              path: 'settings',
              parent: BottomNavBar.name,
            ),
          ],
        ),
        _i15.RouteConfig(
          LoginRouter.name,
          path: '/',
        ),
        _i15.RouteConfig(
          EmailFormRouter.name,
          path: 'email',
        ),
        _i15.RouteConfig(
          ResetPassRouter.name,
          path: 'change_pass',
        ),
        _i15.RouteConfig(
          CodeFormRouter.name,
          path: 'code',
        ),
        _i15.RouteConfig(
          ErrorPageRouter.name,
          path: 'error',
        ),
      ];
}

/// generated route for
/// [_i1.BottomNavBar]
class BottomNavBar extends _i15.PageRouteInfo<void> {
  const BottomNavBar({List<_i15.PageRouteInfo>? children})
      : super(
          BottomNavBar.name,
          path: 'home',
          initialChildren: children,
        );

  static const String name = 'BottomNavBar';
}

/// generated route for
/// [_i2.LoginScreen]
class LoginRouter extends _i15.PageRouteInfo<void> {
  const LoginRouter()
      : super(
          LoginRouter.name,
          path: '/',
        );

  static const String name = 'LoginRouter';
}

/// generated route for
/// [_i3.EmailFormScreen]
class EmailFormRouter extends _i15.PageRouteInfo<void> {
  const EmailFormRouter()
      : super(
          EmailFormRouter.name,
          path: 'email',
        );

  static const String name = 'EmailFormRouter';
}

/// generated route for
/// [_i4.ChangePasswordScreen]
class ResetPassRouter extends _i15.PageRouteInfo<void> {
  const ResetPassRouter()
      : super(
          ResetPassRouter.name,
          path: 'change_pass',
        );

  static const String name = 'ResetPassRouter';
}

/// generated route for
/// [_i5.CodeFormScreen]
class CodeFormRouter extends _i15.PageRouteInfo<void> {
  const CodeFormRouter()
      : super(
          CodeFormRouter.name,
          path: 'code',
        );

  static const String name = 'CodeFormRouter';
}

/// generated route for
/// [_i6.ErrorPage]
class ErrorPageRouter extends _i15.PageRouteInfo<void> {
  const ErrorPageRouter()
      : super(
          ErrorPageRouter.name,
          path: 'error',
        );

  static const String name = 'ErrorPageRouter';
}

/// generated route for
/// [_i7.DashboardScreen]
class DashboardRouter extends _i15.PageRouteInfo<void> {
  const DashboardRouter()
      : super(
          DashboardRouter.name,
          path: 'dashboard',
        );

  static const String name = 'DashboardRouter';
}

/// generated route for
/// [_i8.EmptyRouterPage]
class PostsRouter extends _i15.PageRouteInfo<void> {
  const PostsRouter({List<_i15.PageRouteInfo>? children})
      : super(
          PostsRouter.name,
          path: 'posts',
          initialChildren: children,
        );

  static const String name = 'PostsRouter';
}

/// generated route for
/// [_i8.EmptyRouterPage]
class UsersRouter extends _i15.PageRouteInfo<void> {
  const UsersRouter({List<_i15.PageRouteInfo>? children})
      : super(
          UsersRouter.name,
          path: 'users',
          initialChildren: children,
        );

  static const String name = 'UsersRouter';
}

/// generated route for
/// [_i9.NotificationPage]
class NotificationsRouter extends _i15.PageRouteInfo<void> {
  const NotificationsRouter()
      : super(
          NotificationsRouter.name,
          path: 'notifications',
        );

  static const String name = 'NotificationsRouter';
}

/// generated route for
/// [_i10.SettingsPage]
class SettingsRouter extends _i15.PageRouteInfo<void> {
  const SettingsRouter()
      : super(
          SettingsRouter.name,
          path: 'settings',
        );

  static const String name = 'SettingsRouter';
}

/// generated route for
/// [_i11.PostsPage]
class PostsRoute extends _i15.PageRouteInfo<PostsRouteArgs> {
  PostsRoute({_i16.Key? key})
      : super(
          PostsRoute.name,
          path: '',
          args: PostsRouteArgs(key: key),
        );

  static const String name = 'PostsRoute';
}

class PostsRouteArgs {
  const PostsRouteArgs({this.key});

  final _i16.Key? key;

  @override
  String toString() {
    return 'PostsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i12.SinglePostPage]
class SinglePostRoute extends _i15.PageRouteInfo<SinglePostRouteArgs> {
  SinglePostRoute({
    _i16.Key? key,
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

  final _i16.Key? key;

  final int postId;

  @override
  String toString() {
    return 'SinglePostRouteArgs{key: $key, postId: $postId}';
  }
}

/// generated route for
/// [_i13.UsersPage]
class UsersRoute extends _i15.PageRouteInfo<void> {
  const UsersRoute()
      : super(
          UsersRoute.name,
          path: '',
        );

  static const String name = 'UsersRoute';
}

/// generated route for
/// [_i14.UserProfilePage]
class UserProfileRoute extends _i15.PageRouteInfo<UserProfileRouteArgs> {
  UserProfileRoute({
    _i16.Key? key,
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

  final _i16.Key? key;

  final int userId;

  @override
  String toString() {
    return 'UserProfileRouteArgs{key: $key, userId: $userId}';
  }
}
