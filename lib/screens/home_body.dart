import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobilebuild/theme/theme.dart';


class HomeBody extends StatefulWidget {
  const HomeBody({super.key});
  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  String? fullName;

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  Future<void> fetchUserName() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      setState(() {
        fullName = doc['fullName'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorScheme = lightColorScheme;
    final String today = DateFormat('EEEE, MMMM d, y').format(DateTime.now());

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
                Text("FlashBudget", style: themeData.textTheme.headlineMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(today, style: themeData.textTheme.bodyMedium?.copyWith(color: Colors.white70)),
                const SizedBox(height: 8),
                Text(
                    fullName != null ? "Hello, $fullName" : "Hello!",
                    style: themeData.textTheme.titleMedium?.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            const _BudgetTabs(),
            const SizedBox(height: 16),
            const _SpendCardRow(),
            sectionTitle("Income"),
            budgetItemRow("Paycheck 1", "0.00"),
            budgetItemRow("Paycheck 2", "0.00"),
            addLink("Add Income"),
            sectionTitle("Food"),
            budgetItemRow("Groceries", "0.00"),
            addLink("Add Expense"),
          ],
        ),
      );
  }
}

class _BudgetTabs extends StatelessWidget {
  const _BudgetTabs();

  @override
  Widget build(BuildContext context) {
    final lightColorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: lightColorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const TabBarSection(),
    );
  }
}

class TabBarSection extends StatefulWidget {
  const TabBarSection({super.key});

  @override
  State<TabBarSection> createState() => _TabBarSectionState();
}

class _TabBarSectionState extends State<TabBarSection>
    with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _controller,
          labelColor: lightColorScheme.primary,
          unselectedLabelColor: lightColorScheme.outlineVariant,
          indicatorColor: lightColorScheme.primary,
          tabs: const [
            Tab(text: "Planned"),
            Tab(text: "Spent"),
            Tab(text: "Remaining"),
          ],
        ),
        Container(
          height: 60,
          alignment: Alignment.center,
          child: Text(
            "will be added", 
            style: TextStyle(color: lightColorScheme.secondary),
          ),
        )
      ],
    );
  }
}

class _SpendCardRow extends StatelessWidget {
  const _SpendCardRow();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: const [
          _SpendCard(percent: "0%", label: "Food & drink", icon: Icons.fastfood),
          _SpendCard(percent: "0%", label: "Entertainment", icon: Icons.movie),
          _SpendCard(percent: "0%", label: "Shopping", icon: Icons.shopping_cart),
        ],
      ),
    );
  }
}

class _SpendCard extends StatelessWidget {
  final String percent;
  final String label;
  final IconData icon;

  const _SpendCard({required this.percent, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: lightColorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, size: 32, color: lightColorScheme.primary),
          const SizedBox(height: 8),
          Text(percent, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 4),
          Text(label, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

Widget sectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );
}

Widget budgetItemRow(String label, String value) {
  return ListTile(
    title: Text(label),
    trailing: Text(
      value,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}

Widget addLink(String label) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: GestureDetector(
      onTap: () {},
      child: Text(label, style: const TextStyle(color: Colors.blue)),
    ),
  );
}