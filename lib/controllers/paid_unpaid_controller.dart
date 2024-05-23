import 'package:coachingerbeton/models/database/db_helper.dart';
import 'package:flutter/material.dart';

class PaidUnpaidController extends ChangeNotifier {
  int _totalPaid = 0;
  int _totalUnpaid = 0;
  DatabaseHelper db = DatabaseHelper();

  int get totalPaid => _totalPaid;
  int get totalUnpaid => _totalUnpaid;

  void fetchTotals() async {
    int tp = await db.getTotalSalary(isPaid: 1);
    int tup = await db.getTotalSalary(isPaid: 0);
    _totalPaid = tp;
    _totalUnpaid = tup;
    notifyListeners();
  }
}
