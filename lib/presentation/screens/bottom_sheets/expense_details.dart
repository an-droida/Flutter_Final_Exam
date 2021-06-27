import 'dart:ui';

import 'package:final_exam/cubit/expenses_cubit.dart';
import 'package:final_exam/data/models/expenses_model.dart';
import 'package:final_exam/presentation/screens/bottom_sheets/edit_expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseDetails extends StatelessWidget {
  final Expenses expenses;

  const ExpenseDetails({Key? key, required this.expenses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 4,
          sigmaY: 4,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          color: Color(0xFFCEF7ED),
          child: Column(
            children: [
              Text(
                expenses.title,
                style: TextStyle(fontSize: 27, color: Color(0xFF707070)),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Expense Amount",
                      style: TextStyle(color: Color(0xFF707070))),
                  Text("${expenses.expenseAmount} \$",
                      style: TextStyle(color: Color(0xFF707070))),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Date:",
                      style: TextStyle(color: Color(0xFF707070))),
                  Text(
                    expenses.date,
                    style: TextStyle(color: Color(0xFF707070)),
                  ),
                ],
              ),
              SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return EditExpense(expense: expenses);
                        },
                      );
                    },
                    child: Icon(Icons.edit),
                    backgroundColor: Color(0xFF267B7B),
                    elevation: 1,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Delete Confirmation"),
                            content: const Text(
                              "Are you sure that you want to delete this expense?",
                            ),
                            actions: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(
                                        color: Color(0xFF030303),
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(Colors.red),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      BlocProvider.of<ExpensesDataCubit>(
                                              context)
                                          .deleteExpense(expenses.id);

                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "Expense successfully deleted",
                                          ),
                                          backgroundColor: Color(0xFF267b7b),
                                        ),
                                      );
                                    },
                                    child: const Text("Delete"),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Icon(Icons.delete),
                    backgroundColor: Color(0xFF267B7B),
                    elevation: 1,
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
