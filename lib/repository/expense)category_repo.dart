import 'package:firebase_database/firebase_database.dart';
import '../constant.dart';
import '../model/expense_category_model.dart';

class ExpenseCategoryRepo {
  final CurrentUserData currentUserData = CurrentUserData();

  Future<List<ExpenseCategoryModel>> getAllExpenseCategory() async {
    try {
      final ref = FirebaseDatabase.instance.ref('$constUserId/Expense Category');
      ref.keepSynced(true);

      final snapshot = await ref.orderByKey().get();

      if (snapshot.exists) {
        List<ExpenseCategoryModel> allExpenseCategoryList = [];

        for (var element in snapshot.children) {
          try {
            var data = ExpenseCategoryModel.fromJson(Map<String, dynamic>.from(element.value as Map));
            allExpenseCategoryList.add(data);
          } catch (e) {
            print('Error parsing category: $e');
          }
        }

        return allExpenseCategoryList;
      } else {
        return [];
      }
    } catch (e) {
      print('Error fetching categories: $e');
      throw e; // Re-throw to let the provider handle the error
    }
  }
}
