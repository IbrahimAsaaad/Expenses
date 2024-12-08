

import 'package:flutter/material.dart';
import 'package:title/models/expenses.dart';
import 'package:title/widgets/chart/chart.dart';
import 'package:title/widgets/expenses_list/expenses_list.dart';
import 'package:title/widgets/new_expense.dart';

class ExpensesWidget extends StatefulWidget {
  const ExpensesWidget ({super.key});

  @override
  State<ExpensesWidget> createState() => _ExpensesState();
}

class _ExpensesState extends State<ExpensesWidget> {
  final List <Expense> _registeredExpenses =
  [
    Expense
    (
      data: DateTime.now(),
     amount: 19.99,
      title: "Flutter Course",
       category: Category.work,
     ),
      Expense
    (
      data: DateTime.now(),
     amount: 15.9,
      title: "Cinema",
       category: Category.leisure,
     ),
  ];
  
  void _openAddExpensesOverlay(){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
       builder: (context)=> NweExpense(OnAddExpense: _addExpenses,),
       );     
  }
  void _addExpenses(Expense expense)
  {
    setState(() {
      
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense)
  {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:const Text("Expense Deleted.."), 
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: "Undo",
          textColor: Colors.white, 
          onPressed: (){
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
          ),
        ),
      );
  }
  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(child: Text("No expense found.Start adding some!",
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: Colors.black26,
    ),
    ),
    );
    if(_registeredExpenses.isNotEmpty)
    {
      mainContent= ExpensesList(
              expenses:_registeredExpenses ,
              onRemoveExpense: _removeExpense,
              );
    }

    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Flutter Expense Tracker",style: TextStyle(
          color: Colors.white,
        ),),
        actions: [
          IconButton(
            onPressed: _openAddExpensesOverlay,
             icon: const Icon(Icons.add),
             color: Colors.white,
             ),
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses),
          const SizedBox(height: 15),
          Expanded(
            child:mainContent,
            ),
        ],
      ),
    );
  }
}