// import 'package:coachingerbeton/models/database/db_helper.dart';
// import 'package:flutter/material.dart';

// class PaymentDialog extends StatefulWidget {
//   final int studentId;
//   final List<Map<String, dynamic>> payments;
//   final Function onPaymentUpdated;

//   const PaymentDialog(
//       {super.key,
//       required this.studentId,
//       required this.payments,
//       required this.onPaymentUpdated});

//   @override
//   _PaymentDialogState createState() => _PaymentDialogState();
// }

// class _PaymentDialogState extends State<PaymentDialog> {
//   DatabaseHelper db = DatabaseHelper();

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('Manage Payments'),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: widget.payments.map((payment) {
//           return ListTile(
//             title: Text(payment['month']),
//             trailing: Checkbox(
//               value: payment['ispaid'] == 1,
//               onChanged: (value) async {
//                 await db.updatePayment(payment['id'], {
//                   'ispaid': value! ? 1 : 0,
//                 });
//                 widget.onPaymentUpdated();
//                 setState(() {
//                   payment['ispaid'] = value ? 1 : 0;
//                 });
//               },
//             ),
//           );
//         }).toList(),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.of(context).pop(),
//           child: const Text('Close'),
//         ),
//       ],
//     );
//   }
// }

import 'package:coachingerbeton/models/database/db_helper.dart';
import 'package:flutter/material.dart';

class StudentTile extends StatefulWidget {
  final Map<String, dynamic> student;
  final Function onUpdate;
  final Function onDelete;

  const StudentTile(
      {super.key,
      required this.student,
      required this.onUpdate,
      required this.onDelete});

  @override
  _StudentTileState createState() => _StudentTileState();
}

class _StudentTileState extends State<StudentTile> {
  DatabaseHelper db = DatabaseHelper();
  List<Map<String, dynamic>> payments = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPayments();
  }

  Future<void> fetchPayments() async {
    setState(() {
      isLoading = true;
    });
    payments = await db.getPayments(widget.student['id']);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.student['studentname'],
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    shrinkWrap: true,
                    itemCount: 12,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                    ),
                    itemBuilder: (context, index) {
                      if (payments.isEmpty)
                        return const CircularProgressIndicator();

                      String month = getMonthName(index);
                      bool isPaid = index < payments.length
                          ? payments[index]['ispaid'] == 1
                          : false;

                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              bool newStatus = !isPaid;
                              if (index < payments.length) {
                                await db.updatePayment(payments[index]['id'],
                                    {'ispaid': newStatus ? 1 : 0});
                              } else {
                                await db.insertPayment({
                                  'student_id': widget.student['id'],
                                  'month': month,
                                  'ispaid': newStatus ? 1 : 0,
                                  'paid_date': newStatus
                                      ? DateTime.now().toString()
                                      : null,
                                });
                              }
                              fetchPayments();
                            },
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor:
                                  isPaid ? Colors.green : Colors.red,
                              child: isPaid
                                  ? const Icon(Icons.check,
                                      color: Colors.white, size: 16)
                                  : null,
                            ),
                          ),
                          Text(month, style: const TextStyle(fontSize: 10)),
                        ],
                      );
                    },
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => widget.onUpdate(widget.student),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => widget.onDelete(widget.student['id']),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String getMonthName(int index) {
    final monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return monthNames[index];
  }
}
