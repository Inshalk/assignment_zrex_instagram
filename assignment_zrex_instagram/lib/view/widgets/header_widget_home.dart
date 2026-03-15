import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';


class HeaderWidgetHome extends StatelessWidget implements PreferredSizeWidget {
  const HeaderWidgetHome({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white, // Matching your screenshot's dark theme
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.add, color: Colors.black, size: 28),
        onPressed: () {},
      ),
      title: Image.network(
        // Using a standard Instagram logo white version
        'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Instagram_logo.svg/1200px-Instagram_logo.svg.png',
        height: 35,
        color: Colors.black,
      ),
      actions: [
        IconButton(
          icon: const Icon(Iconsax.heart_copy, color: Colors.black, size: 26),
          onPressed: () {},
        ),
        
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}