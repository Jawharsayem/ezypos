import 'package:firebase_database/firebase_database.dart';
import '../constant.dart';
import '../model/expense_model.dart';

class ExpenseRepo {
  final CurrentUserData currentUserData = CurrentUserData();

  Future<List<ExpenseModel>> getAllExpense() async {
    try {
      final ref = FirebaseDatabase.instance.ref('$constUserId/Expense');
      ref.keepSynced(true);

      final snapshot = await ref.orderByKey().get();

      if (snapshot.exists) {
        List<ExpenseModel> allExpense = [];

        for (var element in snapshot.children) {
          try {
            var data = ExpenseModel.fromJson(Map<String, dynamic>.from(element.value as Map));
            allExpense.add(data);
          } catch (e) {
            print('Error parsing expense: $e');
          }
        }
        return allExpense;
      } else {
        return [];
      }
    } catch (e) {
      print('Error fetching expenses: $e');
      throw e;
    }
  }
}
