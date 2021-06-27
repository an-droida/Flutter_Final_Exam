import 'package:equatable/equatable.dart';
import 'package:final_exam/data/models/expenses_model.dart';

abstract class ExpensesDataState extends Equatable {
  const ExpensesDataState();
}

class ExpensesDataInitial extends ExpensesDataState {
  @override
  List<Object> get props => [];
}

class ExpensesDataLoaded extends ExpensesDataState {
  final List<Expenses> expenses;

  ExpensesDataLoaded({required this.expenses});

  @override
  List<Object?> get props => [expenses];
}

class ExpensesDataError extends ExpensesDataState {
  final String message;

  const ExpensesDataError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
