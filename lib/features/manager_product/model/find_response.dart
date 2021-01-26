import 'package:manage_delivery/features/manager_product/model/product_response.dart';

class FindResponse {
  FindResponse({
    this.message,
    this.isSuccess,
    this.data,
  });

  String message;
  bool isSuccess;
  Product data;

  factory FindResponse.fromJson(Map<String, dynamic> json) => FindResponse(
      message: json["message"],
      isSuccess: json["isSuccess"],
      data: json['data'] == null ? Product() : Product.fromJson(json['data']));
}
