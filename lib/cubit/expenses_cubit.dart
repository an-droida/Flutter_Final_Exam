import 'package:final_exam/cubit/expenses_state.dart';
import 'package:final_exam/data/models/expenses_model.dart';
import 'package:final_exam/data/repositories/expenses_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpensesDataCubit extends Cubit<ExpensesDataState> {
  ExpensesDataCubit() : super(ExpensesDataInitial());

  final expensesRepository = ExpensesRepository();

  Future<void> addExpense(Expenses expenses) async {
    emit(ExpensesDataInitial());
    try {
      await expensesRepository.addExpense(expenses);
    } catch (e) {
      emit(ExpensesDataError(
        message: e.toString(),
      ));
    }
  }

  Future<void> readExpenses() async {
    emit(ExpensesDataInitial());
    try {
      var expenses = await expensesRepository.readAll();
      await expensesRepository.readAll();
      emit(ExpensesDataLoaded(
        expenses: expenses,
      ));
    } catch (e) {
      emit(ExpensesDataError(
        message: e.toString(),
      ));
    }
  }

  Future<void> editExpense(Expenses expenses, String docId) async {
    emit(ExpensesDataInitial());
    try {
      await expensesRepository.update(docId,expenses);
    } catch (e) {
      emit(ExpensesDataError(
        message: e.toString(),
      ));
    }
  }


  Future<void> deleteExpense(String docId) async {
    emit(ExpensesDataInitial());
    try {
      await expensesRepository.delete(docId);
    } catch (e) {
      emit(ExpensesDataError(
        message: e.toString(),
      ));
    }
  }

}
