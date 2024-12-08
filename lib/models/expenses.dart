  
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
const uuid= Uuid();
enum Category {food,work,travel,leisure}

final formatter = DateFormat.yMd();
const CategoryIcons ={
  Category.food:Icons.lunch_dining,
   Category.work:Icons.work,
   Category.leisure:Icons.movie,
   Category.travel:Icons.flight_takeoff,
  
};


 class Expense 
{
  final String id;
  final DateTime data;
  final double amount;
  final String title;
  final Category category;

  Expense({
     required this.data,
      required this.amount,
       required this.title,
       required this.category,
       }):id = uuid.v4();

 String get fromattedDate{
  return formatter.format(data);
 }      
}
// new Class
class ExpenseBucket
{
  ExpenseBucket({
    required this.category,
     required this.expenses,
     });
     ExpenseBucket.forCategory(List<Expense> allExpenses,this.category):
     expenses =allExpenses . where((expense) => expense.category == category).toList();
  final Category category;
  final List<Expense>expenses;
  double get totalExpenses
  {
    double sum = 0 ;
    for(final expense in expenses)
    {
      sum += expense.amount;
    }
    return sum;
  }
}














