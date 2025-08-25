import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobilebuild/screens/welcome_screen.dart';
import 'package:mobilebuild/theme/theme.dart';
import 'package:mobilebuild/widgets/shared_widgets.dart';

class ProfileBody extends StatefulWidget {
  final ValueNotifier<ThemeMode> themeModeNotifier;

  const ProfileBody({super.key, required this.themeModeNotifier});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  String? fullName;
  String? email;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      setState(() {
        fullName = doc.data()?['fullName'] ?? 'User';
        email = user.email ?? '';
      });
    }
  }

  @override
Widget build(BuildContext context) {
  final themeData = Theme.of(context); 
  final colorScheme = themeData.colorScheme;
  final isDark = widget.themeModeNotifier.value == ThemeMode.dark;

  return SingleChildScrollView(
    child: Column(
      children: [
        // Header
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
          
          decoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Profile", style: themeData.textTheme.headlineMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text("Manage your account and settings", style: themeData.textTheme.bodyMedium?.copyWith(color: const Color.fromARGB(179, 255, 255, 255))),
            ],
          ),
        ),

        const SizedBox(height: 16),
        sectionTitle("Account Info"),
        budgetItemRow("Full Name", fullName ?? "Loading..."),
        budgetItemRow("Email", email ?? "Loading..."),
        addLink("Edit Profile"),

        const SizedBox(height: 16),
        sectionTitle("Theme"),
        ListTile(
          title: const Text("Dark Mode"),
          trailing: Switch(
            value: isDark,
            onChanged: (val) {
              widget.themeModeNotifier.value = val ? ThemeMode.dark : ThemeMode.light;
            },
          ),
        ),

        const SizedBox(height: 16),
        sectionTitle("Account"),
        ListTile(
          title: const Text("Log Out"),
          leading: const Icon(Icons.logout),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Log out?"),
                content: const Text("Are you sure you want to log out?"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(), // Cancel
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      if (context.mounted) {
                        Navigator.of(context).pop(); // Close dialog
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => WelcomeScreen(
                              themeModeNotifier: widget.themeModeNotifier,
                            ),
                          ),
                          (route) => false,
                        );
                      }
                    },
                    child: const Text("Log Out"),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    ),
  );
}
}