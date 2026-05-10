import 'package:flutter/material.dart';
import '../models/expense.dart';
import "package:intl/intl.dart";

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final formatDateTime = DateFormat('dd/MM/yyyy');
  String selectedCategory = 'Alimentação';

  static const categories = [
    'Alimentação',
    'Transporte',
    'Lazer',
    'Saúde',
    'Outros',
  ];

  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void saveExpense() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text);

    if (title.isEmpty || value == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Preencha todos os campos!",
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 3),
          backgroundColor: Color.fromARGB(255, 255, 128, 0),
        ),
      );
      return;
    }

    final expense = Expense(
      title: title,
      date: selectedDate,
      value: value,
      category: selectedCategory,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$title adicionado com sucesso!',
          style: TextStyle(color: Colors.white),
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: const Color.fromARGB(255, 255, 128, 0),
      ),
    );

    Navigator.pop(context, expense);
  }

  InputDecoration customInput({required String label, required IconData icon}) {
    return InputDecoration(
      labelText: label,

      labelStyle: const TextStyle(color: Colors.white70),

      prefixIcon: Icon(icon, color: const Color.fromARGB(255, 255, 128, 0)),

      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.05),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 255, 128, 0),
          width: 2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Gasto'), centerTitle: true),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.03),
                borderRadius: BorderRadius.circular(24),
              ),

              child: Column(
                children: [
                  TextField(
                    controller: titleController,
                    style: const TextStyle(color: Colors.white),

                    decoration: customInput(
                      label: 'Descrição',
                      icon: Icons.description,
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextField(
                    controller: valueController,
                    keyboardType: TextInputType.number,

                    style: const TextStyle(color: Colors.white),

                    decoration: customInput(
                      label: 'Valor',
                      icon: Icons.attach_money,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 18,
                    ),

                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(16),
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month,
                              color: Color.fromARGB(255, 255, 128, 0),
                            ),

                            const SizedBox(width: 10),

                            Text(
                              formatDateTime.format(selectedDate),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),

                        TextButton(
                          onPressed: pickDate,
                          child: const Text('Selecionar'),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  DropdownButtonFormField<String>(
                    initialValue: selectedCategory,

                    dropdownColor: const Color.fromARGB(255, 35, 35, 35),

                    style: const TextStyle(color: Colors.white),

                    decoration: customInput(
                      label: 'Categoria',
                      icon: Icons.category,
                    ),

                    items: categories
                        .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                        .toList(),

                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value!;
                      });
                    },
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 55,

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 255, 128, 0),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),

                      onPressed: saveExpense,

                      child: const Text(
                        'Salvar',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
