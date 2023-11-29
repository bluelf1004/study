import 'package:go_router/go_router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_flutter/common/view/root_tab.dart';
import 'package:study_flutter/common/view/splash_screen.dart';
import 'package:study_flutter/restaurant/view/restaurant_detail_screen.dart';
import 'package:study_flutter/user/model/user_model.dart';
import 'package:study_flutter/user/provider/user_me_provider.dart';
import 'package:study_flutter/user/view/login_screen.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({
    required this.ref,
  }) {
    ref.listen<UserModelBase?>(userMeProvider, (previous, next) {
      if (previous != next) {
        notifyListeners();
      }
    });
  }

  List<GoRoute> get routes => [
        GoRoute(
          path: '/',
          name: RootTab.routeName,
          builder: (_, __) => const RootTab(),
          routes: [
            GoRoute(
              path: 'restaurant/:id',
              builder: (_, state) =>
                  RestaurantDetailScreen(id: state.pathParameters['rid']!),
            ),
          ],
        ),
        GoRoute(
          path: '/splash',
          name: SplashScreen.routeName,
          builder: (_, __) => const SplashScreen(),
        ),
        GoRoute(
          path: '/login',
          name: LoginScreen.routeName,
          builder: (_, __) => const LoginScreen(),
        ),
      ];

  void logout() {
    ref.read(authProvider.notifier).logout();
  }

  /**
   SplachScreen
   앱을 처음 시작했을 때
   토큰이 존재하는지 확인하고
   LoginScreen으로 보내줄 지 HomeScreen으로 보내줄 지 확인하는 과정이 필요
   */
  String? redirectLogic(GoRouterState state) {
    final UserModelBase? user = ref.read(userMeProvider);

    final logginIn = state.location == '/login';

    // 유저 정보가 없는데 로그인 중이면
    // 그대로 로그인 페이지에 두고
    // 만약 로그인 중이 아니라면 로그인 페이지로 이동
    if (user == null) {
      return logginIn ? null : '/login';
    }

    // user가 null이 아님
    // UserModel
    // 사용자 정보고 있는 상태면
    // 로그인 중이거나 현재 위치가 Splashscreen이면
    // homeScreen으로 이동
    if (user is UserModel) {
      return logginIn || state.location == '/splash' ? '/' : null;
    }

    // UserModelError
    if (user is UserModelError) {
      return !logginIn ? '/login' : null;
    }
    return null;
  }
}
