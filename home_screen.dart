import 'package:flutter/material.dart';
import 'package:mobilebuild/screens/budgetanalytics_screen.dart';
import 'package:mobilebuild/screens/transactions_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget App Home'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildNavigationButton(
                context, 
                'Report and Analytics', 
                 BudgetAnalyticsScreen(),
              ),
              const SizedBox(height: 20),
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

  Widget _buildNavigationButton(BuildContext context, String label, Widget screen) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
