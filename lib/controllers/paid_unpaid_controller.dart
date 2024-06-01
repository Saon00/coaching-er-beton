import 'package:coachingerbeton/models/database/db_helper.dart';
import 'package:flutter/material.dart';

class PaidUnpaidController extends ChangeNotifier {
  int totalPaid = 0;
  int totalUnpaid = 0;
  DatabaseHelper db = DatabaseHelper();

  Future<void> fetchTotals() async {
    int tp = await db.getTotalSalary(isPaid: 1);
    int tup = await db.getTotalSalary(isPaid: 0);
    totalPaid = tp;
    totalUnpaid = tup;
    notifyListeners();
  }
}
