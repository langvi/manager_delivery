class CustomerResponse {
  CustomerResponse({
    this.message,
    this.isSuccess,
    this.data,
  });

  String message;
  bool isSuccess;
  Data data;

  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      CustomerResponse(
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
    this.customer,
    this.totalCustomer,
  });

  List<Customer> customer;
  int totalCustomer;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        customer: List<Customer>.from(
            json["customer"].map((x) => Customer.fromJson(x))),
        totalCustomer: json["totalCustomer"],
      );

  Map<String, dynamic> toJson() => {
        "customer": List<dynamic>.from(customer.map((x) => x.toJson())),
        "totalCustomer": totalCustomer,
      };
}

class Customer {
  Customer({
    this.name,
    this.phoneNumber,
    this.address,
    this.avatarUrl,
    this.id,
  });

  String name;
  String phoneNumber;
  String address;
  String avatarUrl;
  String id;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        avatarUrl: json["avatarUrl"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phoneNumber": phoneNumber,
        "address": address,
        "avatarUrl": avatarUrl,
        "id": id,
      };
}
