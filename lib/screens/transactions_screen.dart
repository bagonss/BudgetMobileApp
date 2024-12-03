import 'package:flutter/material.dart';

class TransactionTrackingScreen extends StatefulWidget {
  const TransactionTrackingScreen({super.key});

  @override
  State<TransactionTrackingScreen> createState() =>
      _TransactionTrackingScreenState();
}

class _TransactionTrackingScreenState extends State<TransactionTrackingScreen> {
  final List<Map<String, dynamic>> _transactions = [
    {'title': 'Groceries', 'amount': 50.0, 'type': 'Expense', 'date': 'Oct 18'},
    {'title': 'Salary', 'amount': 1500.0, 'type': 'Income', 'date': 'Oct 15'},
    {'title': 'Gym Membership', 'amount': 30.0, 'type': 'Expense', 'date': 'Oct 10'},
  ];

  double get totalIncome => _transactions
      .where((t) => t['type'] == 'Income')
      .fold(0.0, (sum, t) => sum + t['amount']);

  double get totalExpenses => _transactions
      .where((t) => t['type'] == 'Expense')
      .fold(0.0, (sum, t) => sum + t['amount']);

  void _addTransaction(String title, double amount, String type) {
    setState(() {
      _transactions.add({
        'title': title,
        'amount': amount,
        'type': type,
        'date': DateTime.now().toString().substring(5, 10),
      });
    });
  }

  void _showAddTransactionDialog() {
    final titleController = TextEditingController();
    final amountController = TextEditingController();
    String selectedType = 'Expense';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Transaction'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedType,
              items: const [
                DropdownMenuItem(value: 'Expense', child: Text('Expense')),
                DropdownMenuItem(value: 'Income', child: Text('Income')),
              ],
              onChanged: (value) {
                setState(() {
                  selectedType = value!;
                });
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final title = titleController.text;
              final amount = double.tryParse(amountController.text) ?? 0.0;
              if (title.isNotEmpty && amount > 0) {
                _addTransaction(title, amount, selectedType);
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction and Tracking'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSummaryCard(),
            const SizedBox(height: 16),
            Expanded(child: _buildTransactionList()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTransactionDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildSummaryItem('Total Income', totalIncome, Colors.green),
            _buildSummaryItem('Total Expenses', totalExpenses, Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String label, double amount, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }

  Widget _buildTransactionList() {
    return ListView.builder(
      itemCount: _transactions.length,
      itemBuilder: (context, index) {
        final transaction = _transactions[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text(transaction['title']),
            subtitle: Text('Date: ${transaction['date']}'),
            trailing: Text(
              '\$${transaction['amount'].toStringAsFixed(2)}',
              style: TextStyle(
                color: transaction['type'] == 'Income' ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}