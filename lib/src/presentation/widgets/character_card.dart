import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:harry_potter_char_app/src/domain/models/character_model.dart';
import 'package:harry_potter_char_app/src/domain/models/house_name.dart';
import 'package:harry_potter_char_app/src/presentation/detail_screen.dart';

class CharacterCard extends StatefulWidget {
  final CharacterModel character;
  final House house;

  const CharacterCard({
    required this.character,
    required this.house,
    super.key,
  });

  @override
  State<CharacterCard> createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 300),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                final charHouse = House.fromString(widget.character.house);
                return DetailScreen(
                  characterDetail: widget.character,
                  house: charHouse,
                );
              },
            ),
          );
        },
        child: _buildCharacterCard(widget.character),
      ),
    );
  }

  Widget _buildCharacterCard(CharacterModel character) {
    final charHouse = House.fromString(character.house);
    final primaryColor = charHouse.primaryColor;
    final secondaryColor = charHouse.secondaryColor;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: primaryColor.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 8,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: AspectRatio(
        aspectRatio: 3,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final nameFont = constraints.maxWidth < 500
                ? 18.0
                : constraints.maxWidth < 700
                ? 24.0
                : 32.0;
            final subInfo = constraints.maxWidth < 500
                ? 10.0
                : constraints.maxWidth < 700
                ? 16.0
                : 20.0;
            final iconSize = constraints.maxWidth < 500
                ? 7.0
                : constraints.maxWidth < 700
                ? 10.0
                : 10.0;
            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  Positioned(
                    bottom: constraints.maxHeight * -0.6,
                    right: constraints.maxWidth * -0.2,
                    child: Opacity(
                      opacity: 0.3,
                      child: Image.asset(
                        charHouse.image.toString(),
                        height: constraints.maxHeight * 1.8,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: constraints.maxWidth * 0.3,
                        height: constraints.maxHeight,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: CachedNetworkImage(
                            imageUrl: character.image.toString(),
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                            errorWidget: (context, url, error) => Container(
                              color: Colors.white,
                              child: Image.asset(
                                charHouse.image.toString(),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                character.name,
                                style: TextStyle(
                                  fontSize: nameFont,
                                  fontWeight: FontWeight.w700,
                                  color: secondaryColor,
                                ),
                              ),
                              const SizedBox(height: 6),
                              if (charHouse.displayName != 'All')
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: secondaryColor.withValues(
                                      alpha: 0.15,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: secondaryColor.withValues(
                                        alpha: 0.3,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    charHouse.displayName,
                                    style: TextStyle(
                                      fontSize: subInfo,
                                      color: secondaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 4),
                              _miniInfo(
                                Icons.shield_outlined,
                                character.ancestry,
                                subInfo,
                              ),
                              const Spacer(),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 1,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.70),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.white.withValues(
                                        alpha: 0.3,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: iconSize,
                                        height: iconSize,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: character.alive
                                              ? Colors.greenAccent
                                              : Colors.redAccent,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        character.alive ? 'Alive' : 'Deceased',
                                        style: TextStyle(
                                          fontSize: subInfo,
                                          color: character.alive
                                              ? Colors.greenAccent
                                              : Colors.redAccent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _miniInfo(IconData icon, String? value, double size) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: size, color: const Color(0xFFAAAAAA)),
        const SizedBox(width: 3),
        Text(
          value,
          style: TextStyle(fontSize: size, color: const Color(0xFFAAAAAA)),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
