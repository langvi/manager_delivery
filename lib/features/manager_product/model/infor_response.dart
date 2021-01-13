class InforResponse {
  InforResponse({
    this.message,
    this.isSuccess,
    this.infor,
  });

  String message;
  bool isSuccess;
  InforProduct infor;

  factory InforResponse.fromJson(Map<String, dynamic> json) => InforResponse(
        message: json["message"],
        isSuccess: json["isSuccess"],
        infor: InforProduct.fromJson(json["data"]),
      );
}

class InforProduct {
  InforProduct({
    this.totalProduct = 0,
    this.totalGetting = 0,
    this.totalShipping = 0,
    this.totalShiped = 0,
  });

  int totalProduct;
  int totalGetting;
  int totalShipping;
  int totalShiped;

  factory InforProduct.fromJson(Map<String, dynamic> json) => InforProduct(
        totalProduct: json["TotalProduct"],
        totalGetting: json["TotalGetting"],
        totalShipping: json["TotalShipping"],
        totalShiped: json["TotalShiped"],
      );
}

class CustomerProductResponse {
  CustomerProductResponse({
    this.message,
    this.isSuccess,
    this.infor,
  });

  String message;
  bool isSuccess;
  CustomerProduct infor;

  factory CustomerProductResponse.fromJson(Map<String, dynamic> json) =>
      CustomerProductResponse(
        message: json["message"],
        isSuccess: json["isSuccess"],
        infor: CustomerProduct.fromJson(json["data"]),
      );
}

class CustomerProduct {
  String name;
  String phone;
  String address;
  CustomerProduct({this.address, this.name, this.phone});
  factory CustomerProduct.fromJson(Map<String, dynamic> json) =>
      CustomerProduct(
        name: json["name"],
        phone: json["phoneNumber"],
        address: json['address'],
      );
}
