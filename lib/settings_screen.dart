import 'package:flutter/material.dart';
import 'package:gomedserv/widgets/bottomnavigation.dart';
import 'package:gomedserv/notification_settings.dart';
import 'package:gomedserv/widgets/topbar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              TopBar(
                title: 'Settings Screen',
                onBackPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 20),
              SettingsTile(
                title: 'Profile Settings',
                onTap: () {
                  // Handle Profile Settings action
                },
              ),
              SettingsTile(
                title: 'Payment History',
                onTap: () {
                  // Handle Payment History action
                },
              ),
              SettingsTile(
                title: 'Notification Settings',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationSettings(),
                    ),
                  );
                },
              ),
              SettingsTile(
                title: 'Wallet',
                onTap: () {
                  // Handle Wallet action
                },
              ),
              SettingsTile(
                title: 'Logout',
                onTap: () {
                  // Handle Logout action
                },
              ),
              ListTile(
                title: const Text(
                  'Leave a Review',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2A9D8F),
                    // decoration: TextDecoration.underline,
                  ),
                ),
                onTap: () {
                  // Handle Leave a Review action
                },
              ),
              const SizedBox(height: 200),
              ListTile(
                title: const Text(
                  'Delete Account',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    // decoration: TextDecoration.underline,
                  ),
                ),
                onTap: () {
                  // Handle Delete Account action
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: 3,
          onTap: (index) {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final TextStyle? textStyle;

  const SettingsTile({super.key, 
    required this.title,
    required this.onTap,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: textStyle ??
            const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      onTap: onTap,
    );
  }
}
