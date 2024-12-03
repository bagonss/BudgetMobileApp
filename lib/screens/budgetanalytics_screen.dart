import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';


class BudgetAnalyticsScreen extends StatelessWidget {
   BudgetAnalyticsScreen({super.key});

  final List<Map<String, dynamic>> monthlyData = [
    {'month': 'Jan', 'income': 5000, 'expenses': 4200},
    {'month': 'Feb', 'income': 5200, 'expenses': 4000},
    {'month': 'Mar', 'income': 4800, 'expenses': 4300},
    {'month': 'Apr', 'income': 5500, 'expenses': 4100},
    {'month': 'May', 'income': 5300, 'expenses': 4400},
    {'month': 'Jun', 'income': 5800, 'expenses': 4200},
  ];

  final List<Map<String, dynamic>> categories = [
    {'name': 'Housing', 'amount': 2000, 'percentage': 45},
    {'name': 'Food', 'amount': 800, 'percentage': 18},
    {'name': 'Transport', 'amount': 600, 'percentage': 14},
    {'name': 'Utilities', 'amount': 400, 'percentage': 9},
    {'name': 'Others', 'amount': 600, 'percentage': 14},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report and Analytics'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSummaryCards(),
            const SizedBox(height: 16),
            _buildLineChart(),
            const SizedBox(height: 16),
            _buildCategoryBreakdown(),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCards() {
    final currentMonth = monthlyData.last;
    final previousMonth = monthlyData[monthlyData.length - 2];

    final incomeChange = ((currentMonth['income'] - previousMonth['income']) /
            previousMonth['income']) *
        100;
    final expenseChange = ((currentMonth['expenses'] - previousMonth['expenses']) /
            previousMonth['expenses']) *
        100;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSummaryCard(
          'Monthly Income',
          currentMonth['income'].toString(),
          incomeChange,
          Colors.green,
        ),
        _buildSummaryCard(
          'Monthly Expenses',
          currentMonth['expenses'].toString(),
          expenseChange,
          Colors.red,
        ),
      ],
    );
  }

  Widget _buildSummaryCard(
      String title, String amount, double change, Color color) {
    return Expanded(
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Text(
                '\$$amount',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    change >= 0 ? Icons.arrow_upward : Icons.arrow_downward,
                    color: color,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${change.abs().toStringAsFixed(1)}%',
                    style: TextStyle(color: color),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLineChart() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Income vs Expenses',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: true),
                  titlesData: const FlTitlesData(show: true),
                  borderData: FlBorderData(
                    show: true,
                    border: const Border(
                      left: BorderSide(color: Colors.black),
                      bottom: BorderSide(color: Colors.black),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: monthlyData
                          .asMap()
                          .entries
                          .map((e) => FlSpot(
                              e.key.toDouble(), e.value['income'].toDouble()))
                          .toList(),
                      isCurved: true,
                      color: Colors.blue,
                    ),
                    LineChartBarData(
                      spots: monthlyData
                          .asMap()
                          .entries
                          .map((e) => FlSpot(
                              e.key.toDouble(), e.value['expenses'].toDouble()))
                          .toList(),
                      isCurved: true,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryBreakdown() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Expense Breakdown',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...categories.map((category) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(category['name']),
                      Text('\$${category['amount']}'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: category['percentage'] / 100,
                    color: Colors.blue,
                    backgroundColor: Colors.grey[300],
                  ),
                  const SizedBox(height: 16),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}