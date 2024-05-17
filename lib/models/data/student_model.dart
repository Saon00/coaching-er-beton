class StudentModel {
  int? id;
  String? name;
  String? batch;
  String? phoneNumber;
  int? salary;
  bool? isPaid;
  DateTime? dateTime;

  StudentModel({
    this.id,
    this.name,
    this.batch,
    this.phoneNumber,
    this.salary,
    this.isPaid,
    this.dateTime,
  });

  StudentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    batch = json['batch'];
    phoneNumber = json['phoneNumber'];
    salary = json['salary'];
    isPaid = json['isPaid'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['batch'] = batch;
    data['phoneNumber'] = phoneNumber;
    data['salary'] = salary;
    data['isPaid'] = isPaid;
    data['dateTime'] = dateTime;
    return data;
  }
}
