import 'package:flutter/material.dart';

enum ExpensesCategory {
  food,
  travel,
  leisure,
  work
}

const categoryIcons = {
  ExpensesCategory.food: Icons.lunch_dining,
  ExpensesCategory.travel: Icons.flight_takeoff,
  ExpensesCategory.leisure: Icons.movie,
  ExpensesCategory.work: Icons.work,
};