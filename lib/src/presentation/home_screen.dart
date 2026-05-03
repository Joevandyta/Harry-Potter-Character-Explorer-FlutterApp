import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harry_potter_char_app/src/domain/models/character_model.dart';
import 'package:harry_potter_char_app/src/domain/models/house_name.dart';
import 'package:harry_potter_char_app/src/presentation/providers/character_notifier.dart';
import 'package:harry_potter_char_app/src/presentation/providers/character_state.dart';
import 'package:harry_potter_char_app/src/presentation/widgets/character_card.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
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
    final state = ref.watch(characterNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: _buildTabBar(state),
      body: Builder(
        builder: (context) {
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
          return const SizedBox.shrink();
        },
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _fetchData(House house) {
    ref
        .read(characterNotifierProvider.notifier)
        .getCharacters(house.displayName);
  }

  PreferredSizeWidget _buildTabBar(CharacterState state) {
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
                  ref
                      .read(characterNotifierProvider.notifier)
                      .searchCharacters(query);
                },
                onSubmitted: (query) {
                  if (query.isNotEmpty) {
                    ref
                        .read(characterNotifierProvider.notifier)
                        .searchCharacters(query);
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
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth > 700 ? 2 : 1;

        return RefreshIndicator(
          onRefresh: () async {
            ref
                .read(characterNotifierProvider.notifier)
                .getCharacters(house.displayName);
          },
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              childAspectRatio: 3,
            ),
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            itemCount: charList.length,
            itemBuilder: (context, index) {
              final character = charList[index];
              return CharacterCard(
                key: ValueKey(character.id),
                character: character,
                house: house,
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
