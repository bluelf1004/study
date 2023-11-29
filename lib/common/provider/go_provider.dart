import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:study_flutter/user/provider/auth_provider.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final provider = ref.read(authProvider.notifier);

  return GoRouter(
      routes: provider.routes,
      redirect: (_, state) {
        return provider.redirectLogic(state);
      });
});
