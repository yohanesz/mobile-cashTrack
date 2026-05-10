import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';

class ExpenseDetailsScreen extends StatelessWidget {
  final Expense expense;
  static final formatDateTime = DateFormat('dd/MM/yyyy');

  const ExpenseDetailsScreen({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes do Gasto'), centerTitle: true),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),

          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(24),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Icon(
                  Icons.account_balance_wallet,
                  size: 80,
                  color: Color.fromARGB(255, 255, 128, 0),
                ),
              ),

              const SizedBox(height: 30),

              buildInfo('Descrição', expense.title),

              const SizedBox(height: 20),

              buildInfo('Valor', 'R\$ ${expense.value.toStringAsFixed(2)}'),

              const SizedBox(height: 20),

              buildInfo('Categoria', expense.category),

              const SizedBox(height: 20),

              buildInfo('Data', formatDateTime.format(expense.date)),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfo(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white70, fontSize: 16),
        ),

        const SizedBox(height: 8),

        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
