import 'package:final_exam/cubit/expenses_cubit.dart';
import 'package:final_exam/cubit/expenses_state.dart';
import 'package:final_exam/data/repositories/expenses_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _uidController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage("assets/images/logo.png"),
                width: 150,
                height: 150,
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xFFA8E3E8),
                ),
                child: TextField(
                  controller: _uidController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Id",
                      contentPadding: EdgeInsets.only(left: 20)),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_uidController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Please Enter Id"),
                      ));
                    } else {
                      ExpensesRepository.userId = _uidController.text;
                      BlocProvider.of<ExpensesDataCubit>(context)
                          .emit(ExpensesDataInitial());
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        "/expenses_screen",
                        (route) => false,
                        arguments: _uidController.text,
                      );
                    }
                  },
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                      color: Color(0xFF030303),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFA8E3E8),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
