import 'package:manage_delivery/features/manager_product/model/product_response.dart';

class ProductCusResponse {
  ProductCusResponse({
    this.message,
    this.isSuccess,
    this.data,
  });

  String message;
  bool isSuccess;
  Data data;

  factory ProductCusResponse.fromJson(Map<String, dynamic> json) =>
      ProductCusResponse(
        message: json["message"],
        isSuccess: json["isSuccess"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.products,
    this.totalCreate,
    this.totalGetting,
    this.totalShipping,
    this.totalShiped,
  });

  List<Product> products;
  int totalCreate;
  int totalGetting;
  int totalShipping;
  int totalShiped;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        totalCreate: json["totalCreate"],
        totalGetting: json["totalGetting"],
        totalShipping: json["totalShipping"],
        totalShiped: json["totalShiped"],
      );
}
