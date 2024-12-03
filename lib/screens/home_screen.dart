import 'package:flutter/material.dart';
import 'package:mobilebuild/screens/budgetanalytics_screen.dart';
import 'package:mobilebuild/screens/transactions_screen.dart';
import 'package:mobilebuild/screens/welcome_screen.dart';

/// Provides quick access to the "Report and Analytics" and "Transaction and Tracking" screens.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use endDrawer to place the drawer on the right side
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Padding to move the list items down a bit
            SizedBox(height: 50), // Adjust this value to move items lower
            // User Account section
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('User Account'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            // Settings section
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                
              },
            ),
            // Sign Out section
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Sign Out'),
              onTap: () {
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WelcomeScreen()));
              },
            ),
          ],
        ),
      ),
      // AppBar at the top of the screen
      appBar: AppBar(
        title: const Text('Budget App Home'), // Title of the screen
        backgroundColor: Colors.blueAccent, // Background color of the AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the body content
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centers content vertically
            children: [
              // Navigation button to "Report and Analytics" screen
              _buildNavigationButton(
                context,
                'Report and Analytics',
                BudgetAnalyticsScreen(),
              ),
              const SizedBox(height: 20), // Spacing between buttons
              // Navigation button to "Transaction and Tracking" screen
              _buildNavigationButton(
                context,
                'Transaction and Tracking',
                const TransactionTrackingScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a reusable navigation button.
  Widget _buildNavigationButton(BuildContext context, String label, Widget screen) {
    return SizedBox(
      width: double.infinity, // Button spans the full width of the container
      child: ElevatedButton(
        onPressed: () {
          // Navigates to the specified screen when pressed
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16), // Vertical padding for the button
        ),
        child: Text(
          label, // Button text
          style: const TextStyle(fontSize: 18), // Font size for the button text
        ),
      ),
    );
  }
}
