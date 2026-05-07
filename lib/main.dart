import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:harry_potter_char_app/src/domain/models/house_name.dart';
import 'package:harry_potter_char_app/src/presentation/home_screen.dart';
import 'package:harry_potter_char_app/src/presentation/settings_screen.dart';
import 'package:harry_potter_char_app/src/presentation/providers/character_notifier.dart';
import 'package:harry_potter_char_app/src/presentation/widgets/main_scaffold.dart';

import 'package:harry_potter_char_app/src/presentation/detail_screen.dart';
import 'package:harry_potter_char_app/src/presentation/favorite_character_screen.dart';
import 'package:harry_potter_char_app/src/domain/models/character_model.dart';
import 'package:harry_potter_char_app/src/domain/models/favorite_character.dart';
import 'package:harry_potter_char_app/src/data/character_providers.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final _router = GoRouter(
  navigatorKey: _rootNavigatorKey,
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
    GoRoute(
      path: '/favorites',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const FavoriteCharacterScreen(),
    ),
    GoRoute(
      path: '/details',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final extras = state.extra as Map<String, dynamic>;
        final character = extras['character'] as CharacterModel;
        final house = extras['house'] as House;
        return DetailScreen(characterDetail: character, house: house);
      },
    ),
  ],
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [FavoriteCharacterSchema],
    directory: dir.path,
  );

  runApp(
    ProviderScope(
      overrides: [
        isarProvider.overrideWithValue(isar),
      ],
      child: const HarryPotterApp(),
    ),
  );
}

class HarryPotterApp extends ConsumerWidget {
  const HarryPotterApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initial fetch
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(characterProvider.notifier)
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
