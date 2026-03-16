import 'package:assignment_zrex_instagram/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Settings and activity',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Search Bar ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ),

            _buildSectionHeader("Your account"),
            _buildSettingsTile(
              Iconsax.user_copy,
              "Accounts Center",
              subtitle: "Password, security, personal details, ad preferences",
            ),

            const Divider(height: 30, thickness: 0.5),

            _buildSectionHeader("How you use Instagram"),
            _buildSettingsTile(Iconsax.notification_copy, "Notifications"),
            _buildSettingsTile(Iconsax.timer_1_copy, "Time spent"),

            _buildSectionHeader("Who can see your content"),
            _buildSettingsTile(
              Iconsax.lock_copy,
              "Account privacy",
              trailing: "Public",
            ),
            _buildSettingsTile(Iconsax.star_copy, "Close Friends"),
            _buildSettingsTile(Iconsax.user_remove_copy, "Blocked"),
            _buildSettingsTile(Iconsax.story_copy, "Hide story and live"),

            _buildSectionHeader("How others can interact with you"),
            _buildSettingsTile(
              Iconsax.message_copy,
              "Messages and story replies",
            ),
            _buildSettingsTile(Iconsax.tag_copy, "Tags and mentions"),
            _buildSettingsTile(Iconsax.message_notif_copy, "Comments"),
            _buildSettingsTile(Iconsax.send_2_copy, "Sharing and remixes"),

            _buildSectionHeader("Login"),
            _buildSettingsTile(
              null,
              "Add account",
              color: Colors.blue,
              showTrailing: false,
            ),
            TextButton(
              onPressed: () {
                AuthController().signOutUser(context: context, ref: ref);
              },
              child: Text('Log out',style: TextStyle(color: Colors.red),),
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

// --- UI Helpers ---

Widget _buildSectionHeader(String title) {
  return Padding(
    padding: const EdgeInsets.only(left: 16, top: 20, bottom: 8),
    child: Text(
      title,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 13,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _buildSettingsTile(
  IconData? icon,
  String title, {
  String? subtitle,
  String? trailing,
  Color color = Colors.black,
  bool showTrailing = true,
}) {
  return ListTile(
    leading: icon != null ? Icon(icon, color: color, size: 24) : null,
    title: Text(
      title,
      style: TextStyle(color: color, fontSize: 15, fontWeight: FontWeight.w400),
    ),
    subtitle: subtitle != null
        ? Text(
            subtitle,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          )
        : null,
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (trailing != null)
          Text(
            trailing,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
        if (showTrailing)
          const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
      ],
    ),
    onTap: () {},
  );
}
