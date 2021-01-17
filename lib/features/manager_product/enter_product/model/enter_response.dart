import 'package:manage_delivery/features/manager_product/model/product_response.dart';

class EnterResponse {
  EnterResponse({
    this.message,
    this.isSuccess,
    this.data,
  });

  String message;
  bool isSuccess;
  Product data;

  factory EnterResponse.fromJson(Map<String, dynamic> json) => EnterResponse(
        message: json["message"],
        isSuccess: json["isSuccess"],
        data: json['data'] != null ? Product.fromJson(json['data']) : Product(),
      );
}
