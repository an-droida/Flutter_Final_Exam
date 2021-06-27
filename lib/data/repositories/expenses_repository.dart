import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_exam/data/models/expenses_model.dart';

final CollectionReference _collectionReference =
    FirebaseFirestore.instance.collection('expenses');

class ExpensesRepository {
  static String? userId;

  Future<void> addExpense(Expenses expenses) async {
    DocumentReference expenseDocumentReference =
        _collectionReference.doc(userId).collection("user_expenses").doc();

    var data = <String, dynamic>{
      "title": expenses.title,
      "expenseAmount": expenses.expenseAmount,
      "date": expenses.date,
    };

    await expenseDocumentReference
        .set(data)
        .whenComplete(() => print("Expenses Successfully added"))
        .catchError((errorMessage) => throw Exception(errorMessage));
  }

  Future<List<Expenses>> readAll() async {
    List<Expenses> expenses = [];
    CollectionReference expenseCollectionReference =
        _collectionReference.doc(userId).collection("user_expenses");

    final userExpenses = await expenseCollectionReference
        .orderBy('date', descending: true)
        .get();

    for (var doc in userExpenses.docs) {
      var expense = Expenses(
        title: doc["title"],
        expenseAmount: doc["expenseAmount"],
        date: doc["date"],
      );

      expense.id = doc.id;
      expenses.add(expense);
    }

    return expenses;
  }

  Future<void> update(String docId, Expenses expenses) async {
    DocumentReference documentReference =
        _collectionReference.doc(userId).collection("user_expenses").doc(docId);

    var data = <String, dynamic>{
      "title": expenses.title,
      "expenseAmount": expenses.expenseAmount,
      "date": expenses.date,
    };

    await documentReference
        .update(data)
        .whenComplete(() => print("Expenses has Edited!"))
        .catchError((errorMessage) => throw Exception(errorMessage));
  }

  Future<void> delete(String docId) async {
    DocumentReference documentReference =
        _collectionReference.doc(userId).collection('user_expenses').doc(docId);

    await documentReference
        .delete()
        .whenComplete(() => print("Expenses has deleted!"))
        .catchError((errorMessage) => throw Exception(errorMessage));
  }
}
