import 'package:flutter/material.dart';
import 'package:mobilebuild/theme/theme.dart';
import 'package:mobilebuild/widgets/shared_widgets.dart';

class BudgetBody extends StatelessWidget {
  const BudgetBody({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Budget Overview",
                    style: themeData.textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 8),
                Text("See your planned vs actual spending",
                    style: themeData.textTheme.bodyMedium?.copyWith(color: Colors.white70)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          sectionTitle("Monthly Budget"),
          budgetItemRow("Rent", "0.00"),
          budgetItemRow("Utilities", "0.00"),
          budgetItemRow("Transportation", "0.00"),
          addLink("Add Category"),
        ],
      ),
    );
  }
}
