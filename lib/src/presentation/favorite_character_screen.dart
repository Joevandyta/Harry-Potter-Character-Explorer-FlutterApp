import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harry_potter_char_app/src/domain/models/house_name.dart';
import 'package:harry_potter_char_app/src/presentation/providers/favorite_characters_notifier.dart';
import 'package:harry_potter_char_app/src/presentation/widgets/character_card.dart';

class FavoriteCharacterScreen extends ConsumerWidget {
  const FavoriteCharacterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncFavorites = ref.watch(favoriteCharactersProvider);

    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        title: const Text('Favorite Characters'),
        backgroundColor: Colors.brown.shade700,
        foregroundColor: Colors.white,
      ),
      body: asyncFavorites.when(
        data: (favorites) {
          if (favorites.isEmpty) {
            return const Center(
              child: Text(
                'No favorite characters yet.',
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
            );
          }
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > 700 ? 2 : 1,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              childAspectRatio: 3,
            ),
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final character = favorites[index];
              final house = House.values.firstWhere(
                  (h) => h.displayName == character.house,
                  orElse: () => House.all);

              return CharacterCard(
                key: ValueKey(character.id),
                character: character,
                house: house,
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: Colors.white)),
        error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: Colors.white))),
      ),
    );
  }
}
