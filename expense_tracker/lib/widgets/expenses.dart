import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/model/category.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  // ignore: prefer_final_fields
  List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course', 
      amount: 10, 
      date: DateTime.now(), 
      category: ExpensesCategory.work
    ),
    Expense(
      title: 'Latte Frappe', 
      amount: 2, 
      date: DateTime.now(), 
      category: ExpensesCategory.food
    ),
    Expense(
      title: 'Ticket to Germany', 
      amount: 10, 
      date: DateTime.now(), 
      category: ExpensesCategory.travel
    ),
  ];

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _openAddExpensesOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      useSafeArea: true,
      builder: (ctx) {
        return NewExpense(onAddExpense: _addExpense,);
      }
    );
  }

  void removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          }
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!')
    );

    if(_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses, 
        onRemoveExpense: removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Expense Tracker"),
        actions: [
          IconButton(
            onPressed: _openAddExpensesOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width < height ? Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(
            child: mainContent,
          ),
        ],
      ) 
      : Row(
        children: [
          Expanded(
            child: Chart(expenses: _registeredExpenses),
          ),
          Expanded(
            child: mainContent,
          ),
        ],
      )
    );
    }

}