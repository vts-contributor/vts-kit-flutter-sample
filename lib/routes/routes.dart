import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:sample/bottom_nav_bar.dart';
import 'package:sample/pages/dashboard/dashboard_screen.dart';
import 'package:sample/pages/forgot_password/change_password_screen.dart';
import 'package:sample/pages/forgot_password/code_form_screen.dart';
import 'package:sample/pages/forgot_password/email_form_screen.dart';
import 'package:sample/pages/login/login_screen.dart';
import 'package:sample/pages/notifications/notification_page.dart';
import 'package:sample/pages/posts/posts_page.dart';
import 'package:sample/pages/posts/single_post_page.dart';
import 'package:sample/pages/settings/settings_page.dart';
import 'package:sample/pages/users/user_profile_page.dart';
import 'package:sample/pages/users/users_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: 'bottomNavBar',
      page: BottomNavBar,
      children: [
        AutoRoute(
          path: 'dashboard',
          name: 'DashboardRouter',
          page: DashboardScreen,
        ),
        AutoRoute(
          path: 'posts',
          name: 'PostsRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: PostsPage),
            AutoRoute(path: ':postId', page: SinglePostPage),
          ],
        ),
        AutoRoute(
          path: 'users',
          name: 'UsersRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: UsersPage),
            AutoRoute(path: ':userId', page: UserProfilePage),
          ],
        ),
        AutoRoute(
          path: 'notifications',
          name: 'NotificationsRouter',
          page: NotificationPage,
          initial: false,
        ),
        AutoRoute(
          path: 'settings',
          name: 'SettingsRouter',
          page: SettingsPage,
        ),
      ],
    ),
    AutoRoute(
      path: '/',
      page: LoginScreen,
      name: 'LoginRouter',
      initial: true,
    ),
    AutoRoute(
      path: 'email',
      page: EmailFormScreen,
      name: 'EmailFormRouter',
    ),
    AutoRoute(
      path: 'change_pass',
      page: ChangePasswordScreen,
      name: 'ResetPassRouter',
    ),
    AutoRoute(
      path: 'code',
      page: CodeFormScreen,
      name: 'CodeFormRouter',
    ),
  ],
)
class $AppRouter {}
