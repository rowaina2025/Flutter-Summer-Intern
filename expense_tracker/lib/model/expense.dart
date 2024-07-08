
import 'package:expense_tracker/model/category.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

class Expense {
  Expense({
    required this.title, 
    required this.amount, 
    required this.date,
    required this.category
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final ExpensesCategory category;
  
 String get formattedDate {
    return formatter.format(date);
 }
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses
  });

  ExpenseBucket.forCategory(
    List<Expense> allExpenses,
    this.category
  ) : expenses = allExpenses.where((element) => element.category == category).toList();

  final ExpensesCategory category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;
    
    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}