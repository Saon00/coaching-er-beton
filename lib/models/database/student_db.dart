import 'package:sqflite/sqflite.dart';

class StudentDatabase {
  final tableName = "studentdb";

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXIST $tableName(
      "id" INTEGER ,
      "name" TEXT  ,
      "batch" TEXT  ,
      "phoneNumber" TEXT ,
      "salary" INTEGER ,
      "isPaid" BOOLEAN,
      "dateTime" INTEGER DEFAULT (cast(strftime('%s', 'now')as int)),
      PRIMARY KEY ("id" AUTOINCREMENT)
    );""");
  }
}
