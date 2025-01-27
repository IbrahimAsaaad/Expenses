import 'package:flutter/material.dart';
import 'package:title/models/expenses.dart';

class ExpensesItem extends StatelessWidget {
  const ExpensesItem(this.expense,{super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return  Card(
      elevation: 4,
      child:  Padding(
        padding:  const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expense.title,
            style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text('\$${expense.amount.toStringAsFixed(2)}'),
                const Spacer(),
                Row(
                  children: [
                     Icon(CategoryIcons[expense.category]),
                    const SizedBox(width: 8),
                    Text(expense.fromattedDate),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}