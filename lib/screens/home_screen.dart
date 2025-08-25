import 'package:flutter/material.dart';
import 'package:mobilebuild/theme/theme.dart';
import 'package:mobilebuild/screens/home_body.dart';
import 'package:mobilebuild/screens/wallet_body.dart';
import 'package:mobilebuild/screens/budget_body.dart';
import 'package:mobilebuild/screens/profile_body.dart';

class HomeScreen extends StatefulWidget {
   final ValueNotifier<ThemeMode> themeModeNotifier;
  const HomeScreen({super.key, required this.themeModeNotifier});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
   late final List<Widget> _pages;

   @override
  void initState() {
    super.initState();
    _pages = [
      const HomeBody(),
      const WalletBody(),
      const BudgetBody(),
      ProfileBody(themeModeNotifier: widget.themeModeNotifier),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = lightColorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.outlineVariant,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.wallet), label: "Wallet"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Budget"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      body: _pages[_selectedIndex],
      
    );
  }
}
