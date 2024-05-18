import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'batches.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Batches (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE Students (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        batch_id INTEGER NOT NULL,
        studentname TEXT NOT NULL,
        phonenumber TEXT NOT NULL,
        salary INTEGER NOT NULL,
        ispaid BOOLEAN NOT NULL CHECK (ispaid IN (0, 1)),
        paid_date TEXT,
        FOREIGN KEY (batch_id) REFERENCES Batches(id) ON DELETE CASCADE
      )
    ''');
    await db.execute('''
      CREATE TABLE Payments (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        student_id INTEGER NOT NULL,
        month TEXT NOT NULL,
        ispaid BOOLEAN NOT NULL CHECK (ispaid IN (0, 1)),
        FOREIGN KEY (student_id) REFERENCES Students(id) ON DELETE CASCADE
      )
    ''');
  }

  Future<int> insertBatch(Map<String, dynamic> batch) async {
    Database db = await database;
    return await db.insert('Batches', batch);
  }

  Future<int> updateBatch(int id, Map<String, dynamic> batch) async {
    Database db = await database;
    return await db.update('Batches', batch, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteBatch(int id) async {
    Database db = await database;
    return await db.delete('Batches', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> insertStudent(Map<String, dynamic> student) async {
    Database db = await database;
    return await db.insert('Students', student);
  }

  Future<int> updateStudent(int id, Map<String, dynamic> student) async {
    Database db = await database;
    return await db
        .update('Students', student, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteStudent(int id) async {
    Database db = await database;
    return await db.delete('Students', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> insertPayment(Map<String, dynamic> payment) async {
    Database db = await database;
    return await db.insert('Payments', payment);
  }

  Future<int> updatePayment(int id, Map<String, dynamic> payment) async {
    Database db = await database;
    return await db
        .update('Payments', payment, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deletePayment(int id) async {
    Database db = await database;
    return await db.delete('Payments', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getBatches() async {
    Database db = await database;
    return await db.query('Batches');
  }

  Future<List<Map<String, dynamic>>> getStudents(int batchId) async {
    Database db = await database;
    return await db
        .query('Students', where: 'batch_id = ?', whereArgs: [batchId]);
  }

  Future<List<Map<String, dynamic>>> getPayments(int studentId) async {
    Database db = await database;
    return await db
        .query('Payments', where: 'student_id = ?', whereArgs: [studentId]);
  }

  Future<List<Map<String, dynamic>>> getStudentPaymentStatus(
      int studentId) async {
    Database db = await database;
    return await db
        .query('Payments', where: 'student_id = ?', whereArgs: [studentId]);
  }

  // Future<int> getTotalSalary({required int isPaid}) async {
  //   final db = await database;
  //   var result = await db.rawQuery('''
  //     SELECT SUM(salary) as total
  //     FROM students
  //     WHERE ispaid = ?
  //   ''', [isPaid]);
  //   return Sqflite.firstIntValue(result) ?? 0;
  // }

  Future<int> getTotalSalary({required int isPaid}) async {
    final db = await database;
    var result = await db.rawQuery('''
      SELECT SUM(salary) as total 
      FROM students 
      WHERE ispaid = ?
    ''', [isPaid]);
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<void> updateStudentPaidStatus(int id, int isPaid) async {
    final db = await database;
    await db.update('students', {'ispaid': isPaid},
        where: 'id = ?', whereArgs: [id]);
  }
}

// class DatabaseService {
//   static Database? _database;

//   Future<Database> get database async {
//     if (_database != null) {
//       return _database!;
//     }
//     _database = await _initialize();
//     return _database!;
//   }

//   Future<String> get fullPath async {
//     const name = "studentdb.db";
//     final path = await getDatabasesPath();
//     return join(path, name);
//   }

//   Future<Database> _initialize() async {
//     final path = await fullPath;
//     var database = await openDatabase(
//       path,
//       version: 1,
//       onCreate: create,
//       singleInstance: true,
//     );
//     return database;
//   }

//   Future<void> create(Database database, int version) async {
//     await StudentDatabase().createTable(database);

//   }
// }
