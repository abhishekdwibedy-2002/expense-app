import 'package:flutter/material.dart';
import 'package:expenseapp/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final totalcontroller = TextEditingController();
  final amountcontroller = TextEditingController();
  DateTime? selectedDate;
  Category selectCatagory = Category.food;

  void selectDate() async {
    final date = DateTime.now();
    final firstDate = DateTime(date.year - 1, date.month, date.day);
    final choosedate = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: firstDate,
      lastDate: date,
    );
    setState(() {
      selectedDate = choosedate;
    });
  }

  void submitData() {
    final enteredAmount = double.tryParse(amountcontroller.text);
    final amountInvalid = enteredAmount == null || enteredAmount <= 0;
    if (totalcontroller.text.trim().isEmpty ||
        amountInvalid ||
        selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'Please Enter The Required Value of Title, Amount and Category'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }
    widget.onAddExpense(
      Expense(
          title: totalcontroller.text,
          amount: enteredAmount,
          date: selectedDate!,
          category: selectCatagory),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    totalcontroller.dispose();
    amountcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboard = MediaQuery.of(context).viewInsets.bottom;
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, keyboard + 16),
          child: Column(
            children: [
              TextField(
                controller: totalcontroller,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
              ),
              Row(
                //mainAxisAlignment: MainAxisAlignment.start,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: amountcontroller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixText: '\$',
                        label: Text('Amount'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(selectedDate == null
                            ? 'No Date Selected'
                            : format.format(selectedDate!)),
                        IconButton(
                          onPressed: selectDate,
                          icon: const Icon(Icons.calendar_month),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  DropdownButton(
                    value: selectCatagory,
                    items: Category.values
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(
                              category.name.toUpperCase(),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      setState(() {
                        selectCatagory = value;
                      });
                    },
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        submitData();
                      },
                      child: const Text('Save Expenses'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
