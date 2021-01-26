class EmployeeResponse {
  EmployeeResponse({
    this.message,
    this.isSuccess,
    this.data,
  });

  String message;
  bool isSuccess;
  Data data;

  factory EmployeeResponse.fromJson(Map<String, dynamic> json) =>
      EmployeeResponse(
        message: json["message"],
        isSuccess: json["isSuccess"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "isSuccess": isSuccess,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.employees,
    this.totalShipper,
  });

  List<Employee> employees;
  int totalShipper;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        employees: List<Employee>.from(
            json["employees"].map((x) => Employee.fromJson(x))),
        totalShipper: json["totalShipper"],
      );

  Map<String, dynamic> toJson() => {
        "employees": List<dynamic>.from(employees.map((x) => x.toJson())),
        "totalShipper": totalShipper,
      };
}

class Employee {
  Employee({
    this.name,
    this.phoneNumber,
    this.avatarUrl,
    this.shipArea,
    this.dayWork,
    this.id,
  });

  String name;
  String phoneNumber;
  String shipArea;
  String avatarUrl;
  int dayWork;
  String id;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        avatarUrl: json["avatarUrl"],
        shipArea: json["shipArea"],
        dayWork: json["dayWork"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phoneNumber": phoneNumber,
        "avatarUrl": avatarUrl,
      };
}
