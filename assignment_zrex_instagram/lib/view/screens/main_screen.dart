import 'package:assignment_zrex_instagram/view/nav_screens/details_screen/home_screen.dart';
import 'package:assignment_zrex_instagram/view/nav_screens/details_screen/profile_screen.dart';
import 'package:assignment_zrex_instagram/view/nav_screens/details_screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
   const HomeScreen(),
    const Center(child: Text('Search')),
    const Center(child: Text('Messages')),
  const SearchScreen(),
   const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        // Instagram's signature subtle border
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.2), width: 0.5)),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,
          iconSize: 26,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Iconsax.home_1_copy),
              activeIcon: Icon(Iconsax.home_1),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Iconsax.video_play_copy),
              activeIcon: Icon(Iconsax.video_play),
              label: 'Reels',
            ),
            
            BottomNavigationBarItem(
              icon: Transform.rotate(
                angle: -45 * 3.1415926535 / 180,
                child: Icon(Iconsax.direct_right_copy)),
              activeIcon: Transform.rotate(
                angle: -45 * 3.1415926535 / 180,
                child: Icon(Iconsax.direct_right)),
              label: 'message',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Iconsax.search_normal_1_copy),
              activeIcon: Icon(Iconsax.search_normal_1),
              label: 'Search',
            ),
            
            // Profile Item - Following Instagram's trend of using an avatar
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _selectedIndex == 4 ? Colors.black : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                child:  CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=8'),
                ),
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}