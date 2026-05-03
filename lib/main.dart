import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:harry_potter_char_app/src/domain/models/house_name.dart';
import 'package:harry_potter_char_app/src/presentation/home_screen.dart';
import 'package:harry_potter_char_app/src/presentation/settings_screen.dart';
import 'package:harry_potter_char_app/src/presentation/providers/character_notifier.dart';
import 'package:harry_potter_char_app/src/presentation/widgets/main_scaffold.dart';

final _router = GoRouter(
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScaffold(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: HarryPotterApp()));
}

class HarryPotterApp extends ConsumerWidget {
  const HarryPotterApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initial fetch
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(characterNotifierProvider.notifier)
          .getCharacters(House.all.displayName);
    });

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
      ),
    );
  }
}
