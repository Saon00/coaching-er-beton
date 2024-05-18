// import 'package:coachingerbeton/models/database/db_helper.dart';
// import 'package:coachingerbeton/views/pages/pd.dart';
// import 'package:flutter/material.dart';

// class StudentListScreen extends StatefulWidget {
//   final int batchId;

//   const StudentListScreen({super.key, required this.batchId});

//   @override
//   _StudentListScreenState createState() => _StudentListScreenState();
// }

// class _StudentListScreenState extends State<StudentListScreen> {
//   DatabaseHelper db = DatabaseHelper();
//   List<Map<String, dynamic>> students = [];
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchStudentsWithPayments();
//   }

//   Future<void> fetchStudentsWithPayments() async {
//     List<Map<String, dynamic>> studentList =
//         await db.getStudents(widget.batchId);

//     List<Map<String, dynamic>> updatedStudentList = [];

//     for (var student in studentList) {
//       int studentId = student['id'];
//       List<Map<String, dynamic>> payments = await db.getPayments(studentId);
//       bool isFullyPaid = payments.every((payment) => payment['ispaid'] == 1);
//       num totalDue =
//           payments.where((payment) => payment['ispaid'] == 0).length *
//               student['salary'];

//       updatedStudentList.add({
//         ...student,
//         'isFullyPaid': isFullyPaid,
//         'totalDue': totalDue,
//       });
//     }

//     setState(() {
//       students = updatedStudentList;
//       isLoading = false;
//     });
//   }

//   void showStudentDialog({Map<String, dynamic>? student}) {
//     TextEditingController nameController = TextEditingController(
//       text: student != null ? student['studentname'] : '',
//     );
//     TextEditingController phoneController = TextEditingController(
//       text: student != null ? student['phonenumber'] : '',
//     );
//     TextEditingController salaryController = TextEditingController(
//       text: student != null ? student['salary'].toString() : '',
//     );

//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(student == null ? 'Add Student' : 'Edit Student'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: nameController,
//               decoration: const InputDecoration(hintText: 'Student Name'),
//             ),
//             TextField(
//               controller: phoneController,
//               decoration: const InputDecoration(hintText: 'Phone Number'),
//             ),
//             TextField(
//               controller: salaryController,
//               decoration: const InputDecoration(hintText: 'Salary'),
//               keyboardType: TextInputType.number,
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () async {
//               if (student == null) {
//                 await db.insertStudent({
//                   'batch_id': widget.batchId,
//                   'studentname': nameController.text,
//                   'phonenumber': phoneController.text,
//                   'salary': int.parse(salaryController.text),
//                   'ispaid': 0,
//                   'paid_date': null,
//                 });
//               } else {
//                 await db.updateStudent(student['id'], {
//                   'studentname': nameController.text,
//                   'phonenumber': phoneController.text,
//                   'salary': int.parse(salaryController.text),
//                 });
//               }
//               fetchStudentsWithPayments();
//               Navigator.of(context).pop();
//             },
//             child: const Text('Save'),
//           ),
//         ],
//       ),
//     );
//   }

//   void deleteStudent(int id) async {
//     await db.deleteStudent(id);
//     fetchStudentsWithPayments();
//   }

//   void showPaymentDialog(int studentId) async {
//     List<Map<String, dynamic>> payments = await db.getPayments(studentId);

//     showDialog(
//       context: context,
//       builder: (context) => PaymentDialog(
//         studentId: studentId,
//         payments: payments,
//         onPaymentUpdated: fetchStudentsWithPayments,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Students in Batch'),
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: students.length,
//               itemBuilder: (context, index) {
//                 final student = students[index];
//                 final isFullyPaid = student['isFullyPaid'];
//                 final totalDue = student['totalDue'];

//                 return Card(
//                   color: isFullyPaid ? Colors.green : Colors.red,
//                   child: ListTile(
//                     title: Text(student['studentname']),
//                     subtitle: Text('Total Due: \$$totalDue'),
//                     onTap: () => showPaymentDialog(student['id']),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.edit),
//                           onPressed: () => showStudentDialog(student: student),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.delete),
//                           onPressed: () => deleteStudent(student['id']),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => showStudentDialog(),
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

import 'package:coachingerbeton/models/database/db_helper.dart';
import 'package:coachingerbeton/views/pages/pd.dart';
import 'package:flutter/material.dart';

class StudentListScreen extends StatefulWidget {
  final int batchId;

  const StudentListScreen({super.key, required this.batchId});

  @override
  _StudentListScreenState createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  DatabaseHelper db = DatabaseHelper();
  List<Map<String, dynamic>> students = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchStudentsWithPayments();
  }

  Future<void> fetchStudentsWithPayments() async {
    setState(() {
      isLoading = true;
    });

    List<Map<String, dynamic>> studentList =
        await db.getStudents(widget.batchId);

    List<Map<String, dynamic>> updatedStudentList = [];

    for (var student in studentList) {
      int studentId = student['id'];
      List<Map<String, dynamic>> payments = await db.getPayments(studentId);
      bool isFullyPaid = payments.every((payment) => payment['ispaid'] == 1);
      num totalDue =
          payments.where((payment) => payment['ispaid'] == 0).length *
              student['salary'];

      updatedStudentList.add({
        ...student,
        'isFullyPaid': isFullyPaid,
        'totalDue': totalDue,
      });
    }

    setState(() {
      students = updatedStudentList;
      isLoading = false;
    });
  }

  void showStudentDialog({Map<String, dynamic>? student}) {
    TextEditingController nameController = TextEditingController(
      text: student != null ? student['studentname'] : '',
    );
    TextEditingController phoneController = TextEditingController(
      text: student != null ? student['phonenumber'] : '',
    );
    TextEditingController salaryController = TextEditingController(
      text: student != null ? student['salary'].toString() : '',
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(student == null ? 'Add Student' : 'Edit Student'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: 'Student Name'),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(hintText: 'Phone Number'),
            ),
            TextField(
              controller: salaryController,
              decoration: const InputDecoration(hintText: 'Salary'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (nameController.text.isEmpty ||
                  phoneController.text.isEmpty ||
                  salaryController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please fill all fields')),
                );
                return;
              }

              if (student == null) {
                await db.insertStudent({
                  'batch_id': widget.batchId,
                  'studentname': nameController.text,
                  'phonenumber': phoneController.text,
                  'salary': int.parse(salaryController.text),
                  'ispaid': 0,
                  'paid_date': null,
                });
              } else {
                await db.updateStudent(student['id'], {
                  'studentname': nameController.text,
                  'phonenumber': phoneController.text,
                  'salary': int.parse(salaryController.text),
                });
              }
              fetchStudentsWithPayments();
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void deleteStudent(int id) async {
    await db.deleteStudent(id);
    fetchStudentsWithPayments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students in Batch'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return StudentTile(
                  student: student,
                  onUpdate: (student) => showStudentDialog(student: student),
                  onDelete: deleteStudent,
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showStudentDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
