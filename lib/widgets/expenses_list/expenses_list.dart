import 'package:flutter/material.dart';
import 'package:Expenses/models/expenses.dart';
import 'package:Expenses/widgets/expenses_list/expenses_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key,
  required this.expenses,
  required this.onRemoveExpense,
  });
  final List<Expense>expenses;
  final void Function(Expense expense) onRemoveExpense;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context,index)=>
      Dismissible(
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(.5),
          margin: EdgeInsets.symmetric(horizontal: Theme.of(context).cardTheme.margin!.horizontal),
        ),
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },
        key: ValueKey(expenses[index]),
         child:ExpensesItem(expenses[index]
         ),
         ),
      );

  }
}