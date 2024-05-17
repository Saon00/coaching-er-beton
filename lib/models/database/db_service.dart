import 'dart:async';
import 'package:coachingerbeton/models/database/student_db.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// class DatabaseHelper {
//   static late DatabaseHelper _databaseHelper;
//   static late Database _database;

//   String tableName = 'students';
//   String colId = 'id';
//   String colName = 'name';
//   String colBatch = 'batch';
//   String colSalary = 'salary';
//   String colIsPaid = 'isPaid';

//   DatabaseHelper._createInstance();

//   factory DatabaseHelper() {
//     _databaseHelper ??= DatabaseHelper._createInstance();
//     return _databaseHelper;
//   }

//   Future<Database> get database async {
//     _database ??= await initializeDatabase();
//     return _database;
//   }

//   Future<Database> initializeDatabase() async {
//     String path = join(await getDatabasesPath(), 'school.db');
//     var schoolDatabase =
//         await openDatabase(path, version: 1, onCreate: _createDb);
//     return schoolDatabase;
//   }

//   void _createDb(Database db, int newVersion) async {
//     await db.execute('''
//       CREATE TABLE $tableName(
//         $colId INTEGER PRIMARY KEY AUTOINCREMENT,
//         $colName TEXT,
//         $colBatch TEXT,
//         $colSalary INTEGER,
//         $colIsPaid BOOL
//       )
//     ''');
//   }

//   Future<int> insertStudent(Map<String, dynamic> student) async {
//     Database db = await database;
//     int result = await db.insert(tableName, student);
//     return result;
//   }

//   Future<List<Map<String, dynamic>>> getStudents() async {
//     Database db = await database;
//     var result = await db.query(tableName);
//     return result;
//   }
// }

class DatabaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initialize();
    return _database!;
  }

  Future<String> get fullPath async {
    const name = "studentdb.db";
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<Database> _initialize() async {
    final path = await fullPath;
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: create,
      singleInstance: true,
    );
    return database;
  }

  Future<void> create(Database database, int version) async {
    await StudentDatabase().createTable(database);
    
  }
}
