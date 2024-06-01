import 'package:coachingerbeton/models/database/db_helper.dart';
import 'package:coachingerbeton/views/components/fonts.dart';
import 'package:coachingerbeton/views/pages/student_page.dart';
import 'package:flutter/material.dart';

class BatchPage extends StatefulWidget {
  const BatchPage({super.key});

  @override
  State<BatchPage> createState() => _BatchPageState();
}

class _BatchPageState extends State<BatchPage> {
  DatabaseHelper db = DatabaseHelper();
  List<Map<String, dynamic>> batches = [];

  @override
  void initState() {
    super.initState();
    fetchBatches();
  }

  Future<void> fetchBatches() async {
    List<Map<String, dynamic>> result = await db.getBatches();
    setState(() {
      batches = result;
    });
  }

  void showBatchDialog({Map<String, dynamic>? batch}) {
    TextEditingController controller = TextEditingController(
      text: batch != null ? batch['name'] : '',
    );
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(batch == null ? 'Add Batch' : 'Edit Batch'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Batch Name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (batch == null) {
                await db.insertBatch({'name': controller.text});
              } else {
                await db.updateBatch(batch['id'], {'name': controller.text});
              }
              fetchBatches();
              if (context.mounted) Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void deleteBatch(int id) async {
    await db.deleteBatch(id);
    fetchBatches();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Batch Manager',
          style: titlePopins.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: batches.length,
        itemBuilder: (context, index) {
          final batch = batches[index];
          return Card(
            child: ListTile(
              title: Text(batch['name']),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        StudentListScreen(batchId: batch['id']),
                  ),
                );
              },
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => showBatchDialog(batch: batch),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => deleteBatch(batch['id']),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showBatchDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
