import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences studentInformationDb;

String studentName = "";
String studentClass = "";
String studentPhoneNumber = "";
String studentAddress = "";
String displayName = "";

saveStudentInfoPref(String key, String value) async {
  SharedPreferences studentInformationDb =
      await SharedPreferences.getInstance();
  studentInformationDb.setString(key, value);
}

getStudentInfoPref() async {
  studentInformationDb = await SharedPreferences.getInstance();
  studentName = studentInformationDb.getString('studentName') ?? "null";
  studentClass = studentInformationDb.getString('studentClass') ?? "null";
  studentPhoneNumber =
      studentInformationDb.getString('studentPhoneNumber') ?? "null";
  studentAddress = studentInformationDb.getString('studentAddress') ?? "null";
  displayName = studentInformationDb.getString('displayName') ?? "null";
}
