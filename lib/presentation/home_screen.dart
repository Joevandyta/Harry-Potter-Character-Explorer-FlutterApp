import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harry_potter_char_app/domain/models/character_model.dart';
import 'package:harry_potter_char_app/domain/models/house_name.dart';
import 'package:harry_potter_char_app/presentation/character_bloc/character_bloc.dart';
import 'package:harry_potter_char_app/presentation/character_bloc/character_event.dart';
import 'package:harry_potter_char_app/presentation/character_bloc/character_state.dart';
import 'package:harry_potter_char_app/presentation/detail_screen.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isSearching = false;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: House.values.length, vsync: this);

    _fetchData(House.all);

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        final house = House.values[_tabController.index];
        _fetchData(house);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: _buildTabBar(),
      body: BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) {
          if (state.status == CharacterStatus.loading) {
            return _buildSkeletonList();
          } else if (state.status == CharacterStatus.error) {
            return Center(child: Text(state.error.toString()));
          } else if (state.status == CharacterStatus.success) {
            return NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (_isSearching) {
                  setState(() {
                    _isSearching = false;
                  });
                  FocusScope.of(context).unfocus();
                }
                return false;
              },
              child: GestureDetector(
                onTap: () {
                  if (_isSearching) {
                    setState(() {
                      _isSearching = false;
                    });
                    FocusScope.of(context).unfocus();
                  }
                },
                child: TabBarView(
                  controller: _tabController,
                  children: House.values.map((house) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: state.status == CharacterStatus.loading
                          ? _buildSkeletonList()
                          : _buildCharacterList(
                              state.searchQuery.isEmpty
                                  ? state.characters[house.displayName] ?? []
                                  : state.filteredCharacters[house
                                            .displayName] ??
                                        [],
                              house,
                            ),
                    );
                  }).toList(),
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  void _fetchData(House house) {
    print(house.displayName);
    context.read<CharacterBloc>().add(GetCharacterEvent(house.displayName));
  }

  PreferredSizeWidget _buildTabBar() {
    final state = context.watch<CharacterBloc>().state;
    return AppBar(
      backgroundColor: Colors.brown.shade700,
      foregroundColor: Colors.white,
      title: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: SizeTransition(
              sizeFactor: animation,
              axis: Axis.horizontal,
              child: child,
            ),
          );
        },
        child: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  hintText: 'Search character...',
                  hintStyle: const TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
                onChanged: (query) {
                  context.read<CharacterBloc>().add(
                    GetCharactersByQuery(query),
                  );
                },
                onSubmitted: (query) {
                  if (query.isNotEmpty) {
                    context.read<CharacterBloc>().add(
                      GetCharactersByQuery(query),
                    );
                  }
                  setState(() {
                    _isSearching = false;
                  });
                  FocusScope.of(context).unfocus();
                },
              )
            : MouseRegion(
                cursor: SystemMouseCursors.click,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _isSearching = true;
                      _searchController.text = state.searchQuery;
                      _searchController.selection = TextSelection.fromPosition(
                        TextPosition(offset: _searchController.text.length),
                      );
                    });
                  },

                  child: Text(
                    state.searchQuery.isEmpty
                        ? 'Harry Potter Characters'
                        : state.searchQuery,
                  ),
                ),
              ),
      ),
      actions: [
        IconButton(
          icon: Icon(_isSearching ? Icons.close : Icons.search),
          onPressed: () {
            setState(() {
              _isSearching = !_isSearching;

              if (_isSearching) {
                _searchController.text = state.searchQuery;
                _searchController.selection = TextSelection.fromPosition(
                  TextPosition(offset: _searchController.text.length),
                );
              }
            });
          },
        ),
      ],
      bottom: TabBar(
        controller: _tabController,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white60,
        indicatorColor: Colors.white,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        padding: EdgeInsets.zero,
        tabs: House.values.map((house) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Tab(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Text(house.displayName),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCharacterList(List<CharacterModel> charList, House house) {
    print("HOUSEDETAILS");
    print(house.displayName);
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth > 700 ? 2 : 1;

        return RefreshIndicator(
          onRefresh: () async {
            context.read<CharacterBloc>().add(
              GetCharacterEvent(house.displayName),
            );
          },
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              childAspectRatio: 3, // agar bentuk card mirip ListView
            ),
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            itemCount: charList.length,
            itemBuilder: (context, index) {
              final character = charList[index];

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
                          final charHouse = HouseExtension.fromString(
                            character.house,
                          );
                          return DetailScreen(
                            characterDetail: character,
                            house: charHouse,
                          );
                        },
                      ),
                    );
                  },
                  child: _buildCharacterCard(character, house),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildSkeletonList() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      itemCount: 10,
      itemBuilder: (context, index) {
        return _buildCharacterCardSkeleton();
      },
    );
  }

  Widget _buildCharacterCard(CharacterModel character, House house) {
    final house = HouseExtension.fromString(character.house);

    final primaryColor = house.primaryColor;
    final secondaryColor = house.secondaryColor;

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
            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  // Image
                  Positioned(
                    bottom: constraints.maxHeight * -0.6,
                    right: constraints.maxWidth * -0.2,
                    child: Opacity(
                      opacity: 0.3,
                      child: Image.asset(
                        house.image.toString(),
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
                                house.image.toString(),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Content
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                character.name,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: secondaryColor,
                                ),
                              ),
                              const SizedBox(height: 6),

                              if (house.displayName != 'All')
                                Container(
                                  padding: EdgeInsets.symmetric(
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
                                    house.displayName,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: secondaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              _miniInfo(
                                Icons.shield_outlined,
                                character.ancestry,
                              ),
                              Spacer(),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.70),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 7, height: 7,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: character.alive ? Colors.greenAccent : Colors.redAccent,
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        character.alive ? 'Alive' : 'Deceased',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: character.alive ? Colors.greenAccent : Colors.redAccent,
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

  Widget _miniInfo(IconData icon, String? value) {
    if (value == null || value.isEmpty) return SizedBox.shrink();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 11, color: Color(0xFFAAAAAA)),
        SizedBox(width: 3),
        Text(
          value,
          style: TextStyle(fontSize: 11, color: Color(0xFFAAAAAA)),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildCharacterCardSkeleton() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(20),
      ),
      child: AspectRatio(
        aspectRatio: 3,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Row(
                children: [
                  SizedBox(
                    width: constraints.maxWidth * 0.3,
                    height: constraints.maxHeight,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(color: Colors.white),
                    ),
                  ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// NAME
                            Container(
                              width: 140,
                              height: 18,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),

                            const SizedBox(height: 10),

                            Container(
                              width: double.infinity,
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              width: 180,
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),

                            const Spacer(),

                            /// GENDER ROW
                            Row(
                              children: [
                                Container(
                                  width: 14,
                                  height: 14,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Container(
                                  width: 60,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
