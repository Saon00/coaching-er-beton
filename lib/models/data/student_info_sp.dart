import 'package:shared_preferences/shared_preferences.dart';

class StudentInfoUtils {
  static String? studentName,
      studentBatch,
      studentPhoneNumber,
      studentAddress,
      displayName;

  static Future<void> saveStudentInfoPref(
      String saveStudentName,
      String saveStudentBatch,
      String saveStudentPhoneNumber,
      String saveStudentAddress) async {
    SharedPreferences studentInformationDb =
        await SharedPreferences.getInstance();
    await studentInformationDb.setString('studentName', saveStudentName);
    await studentInformationDb.setString('studentBatch', saveStudentBatch);
    await studentInformationDb.setString(
        'studentPhoneNumber', saveStudentPhoneNumber);
    await studentInformationDb.setString('studentAddress', saveStudentAddress);

    studentName = saveStudentName;
    studentBatch = saveStudentBatch;
    studentPhoneNumber = saveStudentPhoneNumber;
    studentAddress = saveStudentAddress;
  }

  static Future<void> saveStudentDisplayNamePref(String saveDisplayName) async {
    SharedPreferences displayNameDb = await SharedPreferences.getInstance();
    await displayNameDb.setString('displayName', saveDisplayName);

    displayName = saveDisplayName;
  }

  static Future<bool> checkExistingUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    displayName = sharedPreferences.getString('displayName');

    if (displayName == null) {
      return false;
    } else {
      return true;
    }
  }

  static Future<void> getStudentInfo() async {
    SharedPreferences studentInformationDb =
        await SharedPreferences.getInstance();
    studentName = studentInformationDb.getString('studentName');
    studentBatch = studentInformationDb.getString('studentBatch');
    studentPhoneNumber = studentInformationDb.getString('studentPhoneNumber');
    studentAddress = studentInformationDb.getString('studentAddress');
    displayName = studentInformationDb.getString('displayName');
  }

  // static Future<bool> setThemeColor(bool saveIsDark) async {
  //   SharedPreferences themeInfoDB =
  //       await SharedPreferences.getInstance();
  //      isDark = themeInfoDB.setBool('isDark', saveIsDark);
  // }

  // getStudentInfoPref() async {
  //   SharedPreferences studentInformationDb = await SharedPreferences.getInstance();
  //   studentName = studentInformationDb.getString('studentName') ?? "null";
  //   studentClass = studentInformationDb.getString('studentClass') ?? "null";
  //   studentPhoneNumber =
  //       studentInformationDb.getString('studentPhoneNumber') ?? "null";
  //   studentAddress = studentInformationDb.getString('studentAddress') ?? "null";
  //   displayName = studentInformationDb.getString('displayName') ?? "null";
  // }
}
