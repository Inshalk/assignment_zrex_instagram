import 'package:assignment_zrex_instagram/provider/user_provider.dart';
import 'package:assignment_zrex_instagram/view/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final userNotifier = ref.read(userProvider);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          title: Row(
            children: [
              Icon(Icons.keyboard_arrow_down, color: Colors.black),
              Text(
                user?.username.isNotEmpty ==true ? "${user?.username}":"Guest",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Iconsax.add_square_copy, color: Colors.black),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.black, size: 30),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SettingsScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProfileHeader(user!.fullName),
                    _buildActionButtons(),
                    const SizedBox(height: 15),
                    _buildHighlights(),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              // This makes the TabBar stick to the top while scrolling
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  const TabBar(
                    indicatorColor: Colors.black,
                    indicatorWeight: 1,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(icon: Icon(Icons.grid_on_sharp)),
                      Tab(icon: Icon(Iconsax.tag_user_copy)),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              // Tab 1: Posts Grid
              GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                ),
                itemCount: 18,
                itemBuilder: (context, index) {
                  return Image.network(
                    'https://picsum.photos/id/${index + 40}/400/400',
                    fit: BoxFit.cover,
                  );
                },
              ),
              // Tab 2: Tagged Photos
              const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Iconsax.tag_user_copy, size: 80, color: Colors.grey),
                    SizedBox(height: 10),
                    Text(
                      "Photos and videos of you",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Profile Header ---
  Widget _buildProfileHeader(String userName) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 43,
                backgroundColor: Colors.grey,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    'https://i.pravatar.cc/150?u=8',
                  ),
                ),
              ),
              const Spacer(),
              _buildStatItem("24", "Posts"),
              const SizedBox(width: 25),
              _buildStatItem("1.2k", "Followers"),
              const SizedBox(width: 25),
              _buildStatItem("350", "Following"),
              const SizedBox(width: 10),
            ],
          ),
          const SizedBox(height: 12),
           Text(
            userName.isNotEmpty ? userName: 'No Name Set',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const Text(
            'Documentary Storyteller | Silent Chronicles 📽️\nExploring the forgotten spells of the world.',
            style: TextStyle(fontSize: 14, height: 1.3),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }

  // --- Action Buttons ---
  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
      child: Row(
        children: [
          Expanded(child: _buildGreyButton("Edit Profile")),
          const SizedBox(width: 8),
          Expanded(child: _buildGreyButton("Share Profile")),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.person_add_outlined, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildGreyButton(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ),
    );
  }

  // --- Story Highlights ---
  Widget _buildHighlights() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(right: 18),
              child: Column(
                children: [
                  Container(
                    height: 64,
                    width: 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: const Icon(Icons.add, size: 30),
                  ),
                  const SizedBox(height: 5),
                  const Text("New", style: TextStyle(fontSize: 12)),
                ],
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(right: 18),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: NetworkImage(
                    'https://picsum.photos/id/${index + 10}/200/200',
                  ),
                ),
                const SizedBox(height: 5),
                Text("Story ${index}", style: const TextStyle(fontSize: 12)),
              ],
            ),
          );
        },
      ),
    );
  }
}

// --- Sticky TabBar Delegate ---
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);
  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.black12, width: 0.5)),
      ),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) => false;
}
