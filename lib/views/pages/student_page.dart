import 'package:coachingerbeton/models/database/db_helper.dart';
import 'package:coachingerbeton/views/components/fonts.dart';
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

  int totalPaid = 0;
  int totalUnpaid = 0;

  @override
  void initState() {
    super.initState();
    fetchStudents();
    fetchTotals();
  }

  Future<void> fetchStudents() async {
    students = await db.getStudents(widget.batchId);
    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchTotals() async {
    int paid = await db.getTotalSalary(isPaid: 1);
    int unpaid = await db.getTotalSalary(isPaid: 0);
    setState(() {
      totalPaid = paid;
      totalUnpaid = unpaid;
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
    bool isPaid = student != null ? student['ispaid'] == 1 : false;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          student == null ? 'Add Student' : 'Edit Student',
          style: titlePopins,
        ),
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
            // Row(
            //   children: [
            //     const Text('Paid'),
            //     Checkbox(
            //       value: isPaid,
            //       onChanged: (value) {
            //         setState(() {
            //           isPaid = value!;
            //         });
            //       },
            //     ),
            //   ],
            // ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: titlePopins,
            ),
          ),
          TextButton(
            onPressed: () async {
              if (nameController.text.isEmpty ||
                  phoneController.text.isEmpty ||
                  salaryController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                    'Please fill all fields',
                    style: titlePopins,
                  )),
                );
                return;
              }

              if (student == null) {
                await db.insertStudent({
                  'batch_id': widget.batchId,
                  'studentname': nameController.text,
                  'phonenumber': phoneController.text,
                  'salary': int.parse(salaryController.text),
                  'ispaid': isPaid ? 1 : 0,
                });
              } else {
                await db.updateStudent(student['id'], {
                  'studentname': nameController.text,
                  'phonenumber': phoneController.text,
                  'salary': int.parse(salaryController.text),
                  'ispaid': isPaid ? 1 : 0,
                });
              }
              fetchStudents();
              fetchTotals();
              if (context.mounted) Navigator.of(context).pop();
            },
            child: Text(
              'Save',
              style: titlePopins,
            ),
          ),
        ],
      ),
    );
  }

  void deleteStudent(int id) async {
    await db.deleteStudent(id);
    fetchStudents();
    fetchTotals();
  }

  void togglePaidStatus(int id, bool isPaid) async {
    await db.updateStudentPaidStatus(id, isPaid ? 1 : 0);
    fetchStudents();
    fetchTotals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Students in Batch',
          style: titlePopins.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                ListTile(
                  title: Text('Total Paid: \$$totalPaid'),
                  subtitle: Text('Total Unpaid: \$$totalUnpaid'),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      final student = students[index];
                      bool isPaid = student['ispaid'] == 1;
                      return Card(
                        color: isPaid ? Colors.green : Colors.red,
                        child: ListTile(
                          leading: Image.asset(
                            'assets/images/boy.png',
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                student['studentname'],
                                style: titlePopins,
                              ),
                              Text('📞 ${student['phonenumber']}'),
                              Text('💵 ${student['salary']}'),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                value: isPaid,
                                onChanged: (value) {
                                  togglePaidStatus(student['id'], value!);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () =>
                                    showStudentDialog(student: student),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => deleteStudent(student['id']),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showStudentDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
