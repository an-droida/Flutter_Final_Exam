import 'package:final_exam/cubit/expenses_cubit.dart';
import 'package:final_exam/cubit/expenses_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bottom_sheets/add_expense.dart';
import 'bottom_sheets/expense_details.dart';

class ExpensesScreen extends StatefulWidget {
  final String userId;

  const ExpensesScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _ExpensesScreenState createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(
        seconds: 1,
      ),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image(
              image: AssetImage("assets/images/background_img.png"),
            ),
            Container(
              padding: EdgeInsets.only(top: 50, right: 30, left: 30),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 5,
                        child: TweenAnimationBuilder(
                          curve: Curves.easeInOut,
                          tween: Tween<double>(
                            begin: 0,
                            end: 25,
                          ),
                          duration: const Duration(
                            seconds: 1,
                          ),
                          builder: (context, double value, child) {
                            return Text(
                              "Personal Expenses",
                              style: TextStyle(
                                fontSize: value,
                                color: Color(0xFF707070),
                              ),
                            );
                          },
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return const AddExpense();
                            },
                          );
                        },
                        child: Icon(Icons.add),
                        backgroundColor: Color(0xFF267B7B),
                      )
                    ],
                  ),
                  BlocConsumer<ExpensesDataCubit, ExpensesDataState>(
                    listener: (context, state) {
                      if (state is ExpensesDataError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is ExpensesDataInitial) {
                        BlocProvider.of<ExpensesDataCubit>(context)
                            .readExpenses();
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is ExpensesDataLoaded) {
                        _animationController.forward();
                        return Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 60),
                              width: double.infinity,
                              height: 200,
                              child: Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                color: Colors.white,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "${state.expenses.fold<double>(0, (previousAmount, element) => previousAmount + element.expenseAmount).toStringAsFixed(2)} \$",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xFF707070)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0.0, 2.0),
                                end: Offset.zero,
                              ).animate(
                                CurvedAnimation(
                                  parent: _animationController,
                                  curve: Curves.easeInOutCubic,
                                ),
                              ),
                              child: Container(
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    var expenses = state.expenses[index];
                                    return Container(
                                      child: Card(
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: ListTile(
                                          title: Text(expenses.title),
                                          subtitle:
                                              Text(expenses.date.toString()),
                                          trailing: Text(
                                              "${expenses.expenseAmount} \$"),
                                          onTap: () {
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (context) {
                                                return ExpenseDetails(
                                                  expenses: expenses,
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: state.expenses.length,
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Center(
                          child: Text("Oops! Something went wrong!"),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
