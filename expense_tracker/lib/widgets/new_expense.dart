import 'package:expense_tracker/model/category.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense; 
  
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  } 
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  ExpensesCategory _selectedCategory = ExpensesCategory.food;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if(_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Invalid Input'),
            content: const Text('Please make sure you entered valid title, amount and date'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay'),
              )
            ],
          )
        );
       return;
    }

    var newExpense = Expense(
      title: _titleController.text,
      amount: enteredAmount,
      date: _selectedDate!,
      category: _selectedCategory
    );

    widget.onAddExpense(newExpense);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text("Title"),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixText: '\$ ',
                        label: Text("Amount"),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(_selectedDate == null ? 'No Date Selected' : formatter.format(_selectedDate!)),
                        IconButton(
                          onPressed: _presentDatePicker,
                          icon: const Icon(Icons.calendar_month),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  DropdownButton(
                    value: _selectedCategory,
                    items: ExpensesCategory.values.map((e) => 
                      DropdownMenuItem(
                        value: e,
                        child: Text(
                          e.name.toUpperCase(),
                        ),
                      ),
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        if(value == null) {
                          return;
                        }
                        _selectedCategory = value;
                      });
                    }
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: _submitExpenseData, 
                    child: const Text("Save Expense"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
