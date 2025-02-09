import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/Provider/userprofile_provider.dart';
import '../Utils/constants.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    String userInitial = userProvider.initial;
    String userName = userProvider.name;
    String userEmail = userProvider.email;

    print("$userEmail , $userName , $userInitial");

    return Scaffold(
      backgroundColor: kbackgroundColor,
      appBar: AppBar(
        backgroundColor: kbackgroundColor,
        centerTitle: true,
        title: const Text(
          "Settings",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          // Profile Section
          ListTile(
            leading: CircleAvatar(
              radius: 25,
              child: Text(userInitial),
            ),
            title: Text(
              userName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Text(userEmail), // Fixed the email display
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Iconsax.user, color: Colors.grey),
            title: const Text("Account Settings"),
            onTap: () {},
          ),

          // Notifications
          ListTile(
            leading: const Icon(Iconsax.notification, color: Colors.grey),
            title: const Text("Notifications"),
            onTap: () {
            },
          ),

          ListTile(
            leading: const Icon(Iconsax.lock, color: Colors.grey),
            title: const Text("Privacy & Security"),
            onTap: () {},
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Iconsax.logout, color: Colors.red),
            title: const Text(
              "Logout",
              style: TextStyle(color: Colors.red),
            ),
            onTap: () async {
              bool? confirm = await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Sign Out"),
                  content: const Text("Are you sure you want to sign out?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text("Sign Out"),
                    ),
                  ],
                ),
              );

              if (confirm ?? false) {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacementNamed('/login'); // Navigate to login screen
              }
            },
          ),
        ],
      ),
    );
  }
}




