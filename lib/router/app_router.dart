import 'package:go_router/go_router.dart';
import 'package:ui/features/home/home_page.dart';
import 'package:ui/features/login/view/login_page.dart';
import 'package:ui/features/setting/setting_page.dart';

class AppRouter {
  AppRouter._();

  static const String homeNamed = 'home';
  static const String homePath = '/home';

  static const String settingNamed = 'setting';
  static const String settingPath = '/setting';

  static const String loginName = 'login';
  static const String loginPath = '/';

  static GoRouter get router => _router;
  static final _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        name: loginName,
        path: loginPath,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        name: homeNamed,
        path: homePath,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        name: settingNamed,
        path: settingPath,
        builder: (context, state) => const SettingPage(),
      )
    ],
  );
}
