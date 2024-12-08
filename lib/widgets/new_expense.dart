// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:title/models/expenses.dart';

class NweExpense extends StatefulWidget {
   const NweExpense({super.key,required this.OnAddExpense});
  final void Function (Expense expense) OnAddExpense;
  @override
  State<NweExpense> createState() => _NweExpenseState();
}

class _NweExpenseState extends State<NweExpense> {
  final _TitleController = TextEditingController();
  final _NumberController = TextEditingController();
  DateTime ?_selectedDate;
  Category _selectedCategory = Category.leisure;

// ignore: unused_element
void _presentDatePicker()async{
  final now = DateTime.now();
  final fristDate = DateTime(now.year-1,now.month,now.day);
   final pickedDate = await  showDatePicker(
    context: context,
     firstDate: fristDate,
      lastDate: now,
      initialDate: now,
      );
      setState(() {
        _selectedDate = pickedDate;
      });
}

void _submitExpensesDate ()
{
  final enteredAmount = double.tryParse(_NumberController.text);//tryParse ("1.12"=>1.12)
  final amountIsinvalid = enteredAmount== null || enteredAmount <=0;
  if(_TitleController.text.trim().isEmpty||amountIsinvalid ||_selectedDate == null)
  {
    //show Error massage
    showDialog(context: context,
     builder: (cxt)=>AlertDialog(
      title: const Text("Invalid input"),
      content: const Text("please make sure a valid title , amount , date and Categary was Entered .."),
      actions: [
        TextButton(
          onPressed: (){
          Navigator.pop(cxt);
        }, child: const Text("Okey"),
        ),
      ],
     ),
     );
     return;
  }
  //...
  widget.OnAddExpense(Expense(
    data: _selectedDate!,
     amount: enteredAmount, 
     title: _TitleController.text,
      category: _selectedCategory,
      ),
      );
      Navigator.pop(context);
}


  @override
  void dispose() {
    _TitleController.dispose();
    _NumberController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  const EdgeInsets.fromLTRB(16,48,16,16),
      child:  Column(
        children: [
          TextField(
            controller: _TitleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text("Title"),
            ),
          ),
           Row(
            children: [
               Expanded(
                 child: TextField(
                 controller: _NumberController,
                 keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                 prefixText: "\$ ",
                 label: Text("Amount"),
               ),
               ),
               ),
          const SizedBox(width: 16),
           Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Text( _selectedDate == null?"No date Selected":formatter.format(_selectedDate!),),
               IconButton(onPressed:_presentDatePicker,
               icon: const Icon( Icons.calendar_month),
               ),
              ],
            ),
             ),
            ],
           ),
           const SizedBox(height: 16),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values.map((Category)=>DropdownMenuItem(
                  value: Category,
                  child: Text(Category.name.toLowerCase(),))).toList(),
                 onChanged:(value){
                  setState(() {
                    if(value==null){
                      return;
                    }
                    _selectedCategory =value;
                  });
                 },
                  ),
                  const Spacer(),
              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                 child: const Text("Cancel"),
                 ),
              ElevatedButton(
                onPressed: _submitExpensesDate,
                 child: const Text("Save Expense"),
                 ),
            ],
          ),
        ],
      ),
    );
  }
}