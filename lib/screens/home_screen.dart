import 'package:flutter/material.dart';
import 'expense_details_screen.dart';
import '../models/expense.dart';
import 'add_expense_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Expense> expenses = [];

  double get total {
    double sum = 0;

    for (var expense in expenses) {
      sum += expense.value;
    }

    return sum;
  }

  void addExpense(Expense expense) {
    setState(() {
      expenses.add(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Controle de Gastos'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 255, 128, 0),
        child: const Icon(Icons.add),
        onPressed: () async {
          final expense = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddExpenseScreen()),
          );

          if (expense != null) {
            addExpense(expense);
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 128, 0),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Text('Total Gasto', style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  Text(
                    'R\$ ${total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: expenses.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 80),
                        child: Text(
                          'Nenhum gasto cadastrado.',
                          style: TextStyle(
                            color: Color.fromARGB(159, 185, 185, 185),
                            fontSize: 18,
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: expenses.length,
                      itemBuilder: (context, index) {
                        final expense = expenses[index];

                        return Dismissible(
                          key: Key(expense.title + index.toString()),

                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),

                          direction: DismissDirection.endToStart,

                          onDismissed: (direction) {
                            setState(() {
                              expenses.removeAt(index);
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${expense.title} removido.',
                                  style: TextStyle(color: Colors.white),
                                ),
                                duration: Duration(seconds: 3),
                                backgroundColor: Color.fromARGB(
                                  255,
                                  255,
                                  128,
                                  0,
                                ),
                              ),
                            );
                          },

                          child: Card(
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        ExpenseDetailsScreen(expense: expense),
                                  ),
                                );
                              },
                              leading: const Icon(Icons.money_off),
                              title: Text(expense.title),
                              trailing: Text(
                                'R\$ ${expense.value.toStringAsFixed(2)}',
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
