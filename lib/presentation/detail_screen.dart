import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:harry_potter_char_app/domain/models/character_model.dart';
import 'package:harry_potter_char_app/domain/models/house_name.dart';

class DetailScreen extends StatefulWidget {
  final CharacterModel characterDetail;
  final House house;

  const DetailScreen({
    super.key,
    required this.characterDetail,
    required this.house,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final textContainerColor = Colors.grey.shade200;
  late final nameColor =
      widget.house == House.gryffindor ||
          widget.house == House.slytherin ||
          widget.house == House.ravenclaw
      ? Colors.white
      : Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: textContainerColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: widget.house.primaryColor,
            foregroundColor: nameColor,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(widget.characterDetail.name),
          ),
          SliverToBoxAdapter(child: _characterDetailBody()),
        ],
      ),
    );
  }

  Widget _characterDetailBody() {
    final maxWidth = MediaQuery.of(context).size.width;
    final maxHeight = MediaQuery.of(context).size.height;
    final imageWidth = min(maxWidth * 0.4, 250.0);
    final topContentHeight = (kToolbarHeight * 3) + imageWidth;
    final char = widget.characterDetail;
    final isBlack =
        widget.house == House.gryffindor ||
        widget.house == House.slytherin ||
        widget.house == House.ravenclaw;

    return Stack(
      children: [
        // Background dark purple
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: (kToolbarHeight * 3) + (imageWidth * 2),
          child: Container(color: widget.house.primaryColor),
        ),

        // Faded house image
        Positioned(
          top: -kToolbarHeight + 20,
          left: -50,
          right: -50,
          child: Opacity(
            opacity: 0.15,
            child: Image.asset(
              widget.house.image.toString(),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Decorative circles
        Positioned(
          top: 20,
          left: -60,
          child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.house.secondaryColor.withValues(alpha: 0.08),
            ),
          ),
        ),
        Positioned(
          top: 60,
          right: -40,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.house.secondaryColor.withValues(alpha: 0.06),
            ),
          ),
        ),

        // Rounded white body
        Column(
          children: [
            SizedBox(height: kToolbarHeight),
            // Avatar
            Container(
              width: imageWidth,
              height: imageWidth,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: widget.house.secondaryColor.withValues(alpha: 0.6),
                  width: 3,
                ),
              ),
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: char.image.toString(),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  errorWidget: (_, __, ___) => Container(
                    color: widget.house.primaryColor.withValues(alpha: 0.3),
                    child: Container(
                      color: Colors.white,
                      child: Image.asset(widget.house.image),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            // Name & alternate names
            Text(
              char.name,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: nameColor,
              ),
              textAlign: TextAlign.center,
            ),
            if (char.alternateNames.isNotEmpty) ...[
              SizedBox(height: 4),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  char.alternateNames.join(', '),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: nameColor.withValues(alpha: 0.6),
                  ),
                ),
              ),
            ],
            SizedBox(height: 12),

            // Top badges
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 8,
                runSpacing: 6,
                alignment: WrapAlignment.center,
                children: [
                  if (char.house != null)
                    _topBadge(widget.house.displayName, isBlack: isBlack),
                  if (char.alive) _topBadge('Alive', isBlack: isBlack),
                  if (char.wizard) _topBadge('Wizard', isBlack: isBlack),
                  if (char.hogwartsStudent)
                    _topBadge('Hogwarts Student', isBlack: isBlack),
                  if (char.hogwartsStaff)
                    _topBadge('Hogwarts Staff', isBlack: isBlack),
                ],
              ),
            ),
            SizedBox(height: 24),

            // White body content
            Container(
              width: maxWidth,
              constraints: BoxConstraints(
                minHeight: maxHeight - topContentHeight,
              ),
              decoration: BoxDecoration(
                color: textContainerColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              padding: EdgeInsets.fromLTRB(20, 24, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionLabel('Personal Info'),
                  SizedBox(height: 12),


                  _buildInfoGrid(widget.characterDetail),
                  SizedBox(height: 20),

                  if (!char.wand!.isWandEmpty) ...[
                    _sectionLabel('Wand'),
                    SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _wandRow('Wood', char.wand?.wood),
                          Divider(height: 20),
                          _wandRow('Core', char.wand?.core),
                          Divider(height: 20),
                          _wandRow('Length', char.wand?.length?.toString()),
                        ],
                      ),
                    ),
                  ],
                  SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _sectionLabel(String text) => Text(
    text.toUpperCase(),
    style: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      letterSpacing: 0.8,
    ),
  );

  Widget _statItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildInfoGrid(CharacterModel char) {
    final items = <Map<String, dynamic>>[
      {'icon': Icons.person_outline, 'label': 'Species', 'value': char.species},
      {'icon': Icons.wc, 'label': 'Gender', 'value': char.gender},
      {'icon': Icons.cake_outlined, 'label': 'Date of Birth', 'value': char.dateOfBirth},
      {'icon': Icons.shield_outlined, 'label': 'Ancestry', 'value': char.ancestry},
      {'icon': Icons.visibility_outlined, 'label': 'Eye Colour', 'value': char.eyeColour},
      {'icon': Icons.face_outlined, 'label': 'Hair Colour', 'value': char.hairColour},
      {'icon': Icons.pets_outlined, 'label': 'Patronus', 'value': char.patronus},
      {'icon': Icons.movie_outlined, 'label': 'Actor', 'value': char.actor},
    ].where((e) => e['value'] != null && (e['value'] as String).isNotEmpty).toList();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.8,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          final isRightColumn = index % 2 == 0;
          final isOddTotal = items.length % 2 == 1;
          final isLastRow = isOddTotal
              ? index == items.length - 1      // odd: last row = 1 item
              : index >= items.length - 2;

          final isLastItem = index == items.length - 1;
          final isAloneInLastRow = isOddTotal && isLastItem;

          return Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: isLastRow
                    ? BorderSide.none
                    : BorderSide(color: Colors.grey.shade200, width: 0.8),
                right: isAloneInLastRow || isRightColumn
                    ? BorderSide(color: Colors.grey.shade200, width: 0.8)
                    : BorderSide.none,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: widget.house.primaryColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    item['icon'] as IconData,
                    size: 16,
                    color: widget.house.primaryColor,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item['label'] as String,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        item['value'] as String,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _wandRow(String label, String? value) {
    if (value == null || value.isEmpty) return SizedBox.shrink();
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade700,
              letterSpacing: 0.3,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _topBadge(String label, {bool isBlack = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: isBlack
            ? Colors.black.withValues(alpha: 0.3)
            : Colors.white.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isBlack
              ? Colors.white.withValues(alpha: 0.3)
              : Colors.black.withValues(alpha: 0.2),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          color: isBlack
              ? Colors.white.withValues(alpha: 0.8)
              : Colors.black.withValues(alpha: 0.8),
        ),
      ),
    );
  }
}
