import 'package:coachingerbeton/models/database/db_helper.dart';
import 'package:flutter/material.dart';

class PaidUnpaidController extends ChangeNotifier {
  int _totalPaid = 0;
  int _totalUnpaid = 0;
  DatabaseHelper db = DatabaseHelper();

  int get totalPaid => _totalPaid;
  int get totalUnpaid => _totalUnpaid;

  void fetchTotals(int newTotalPaid, int newTotalUnpaid) async {
    // totalPaid = await db.getTotalSalary(isPaid: 1);
    // totalUnpaid = await db.getTotalSalary(isPaid: 0);
    _totalPaid = newTotalPaid;
    _totalUnpaid = newTotalUnpaid;
    notifyListeners();
  }
}
