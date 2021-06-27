import 'dart:ui';

import 'package:final_exam/cubit/expenses_cubit.dart';
import 'package:final_exam/data/models/expenses_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({Key? key}) : super(key: key);

  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController expenseAmount = TextEditingController();
  final TextEditingController title = TextEditingController();
  final TextEditingController date = TextEditingController(text: "Pick Date");

  @override
  void dispose() {
    title.dispose();
    expenseAmount.dispose();
    date.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 4,
        sigmaY: 4,
      ),
      child: Container(
        color: Color(0xFFcbefef),
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Card(
                  shadowColor: Colors.transparent,
                  color: Colors.transparent,
                  child: SizedBox(
                    child: TextFormField(
                      cursorColor: Color(0xFF030303),
                      cursorWidth: 1.0,
                      textAlign: TextAlign.center,
                      controller: expenseAmount,
                      decoration: const InputDecoration(
                        hintText: "Please enter expense amount",
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF030303),
                          ),
                        ),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            double.parse(value) < 0) {
                          return "Please enter amount!";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Card(
                  color: Colors.transparent,
                  shadowColor: Colors.transparent,
                  child: SizedBox(
                    child: TextFormField(
                      cursorColor: Color(0xFF030303),
                      cursorWidth: 1.0,
                      textAlign: TextAlign.center,
                      controller: title,
                      decoration: const InputDecoration(
                        hintText: "Please enter expense title",
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF030303),
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter title!";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 40,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(date.text),
                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(0),
                              lastDate: DateTime.now(),
                            ).then((value) {
                              if (value != null) {
                                date.text = value
                                    .toString()
                                    .substring(0, 10)
                                    .split("-")
                                    .reversed
                                    .join("/");
                                setState(() {});
                              }
                            });
                          },
                          child: const Text("Pick Date"),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF267b7b),
                            ),
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shadowColor: MaterialStateProperty.all<Color>(
                            Colors.transparent,
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFF267b7b),
                          ),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<ExpensesDataCubit>(context)
                                .addExpense(
                              Expenses(
                                title: title.text,
                                expenseAmount: double.parse(expenseAmount.text),
                                date: date.text != "Pick Date"
                                    ? date.text
                                    : DateTime.now()
                                        .toString()
                                        .substring(0, 10)
                                        .split("-")
                                        .reversed
                                        .join("/"),
                              ),
                            );
                            Navigator.pop(context);
                          }
                        },
                        child: const Text("ADD"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
