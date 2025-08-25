import 'package:flutter/material.dart';
import 'package:mobilebuild/theme/theme.dart';
import 'package:mobilebuild/widgets/shared_widgets.dart';

class WalletBody extends StatelessWidget {
  const WalletBody({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = darkColorScheme;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
            decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
            child: const Text("Wallet", style: TextStyle(fontSize: 24, color: Colors.white)),
          ),
          const SizedBox(height: 16),
          sectionTitle("Accounts"),
          budgetItemRow("Cash", "0.00"),
          budgetItemRow("Chime", "0.00"),
          addLink("Add Account"),
        ],
      ),
    );
  }
}
