import 'package:manage_delivery/utils/convert_value.dart';

class ProductResponse {
  ProductResponse({
    this.message,
    this.isSuccess,
    this.data,
  });

  String message;
  bool isSuccess;
  List<Product> data;

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      ProductResponse(
        message: json["message"],
        isSuccess: json["isSuccess"],
        data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "isSuccess": isSuccess,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Product {
  Product(
      {this.nameProduct,
      this.sendFrom,
      this.receiveBy,
      this.addressSend,
      this.costShip,
      this.costProduct,
      this.status,
      this.createdAt,
      this.id,
      this.addressReceive,
      this.enterAt,
      this.note,
      this.phoneSend,
      this.phoneReceive,
      this.shipedAt,
      this.shippingAt});

  String nameProduct;
  String note;
  String sendFrom;
  String receiveBy;
  String addressSend;
  String phoneSend;
  String phoneReceive;
  String addressReceive;
  DateTime enterAt;
  DateTime shippingAt;
  DateTime shipedAt;
  int costShip;
  int costProduct;
  int status;
  DateTime createdAt;
  String id;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      nameProduct: json["nameProduct"],
      sendFrom: json["sendFrom"],
      receiveBy: json["receiveBy"],
      addressSend: json["addressSend"],
      addressReceive: json["addressReceive"],
      costShip: json["costShip"],
      costProduct: json["costProduct"],
      phoneReceive: json['phoneReceive'],
      shipedAt: json['shipedAt'] != null
          ? convertEpochToDateTime(json['shipedAt'])
          : null,
      shippingAt: json['shippingAt'] != null
          ? convertEpochToDateTime(json['shippingAt'])
          : null,
      phoneSend: json['phoneSend'],
      status: json["status"],
      createdAt: convertEpochToDateTime(json['createAtTime']),
      enterAt: json['enterAt'] != null
          ? convertEpochToDateTime(json['enterAt'])
          : null,
      note: json['note'],
      id: convertToId(json['productId']),
    );
  }

  Map<String, dynamic> toJson() => {
        "nameProduct": nameProduct,
        "sendFrom": sendFrom,
        "receiveBy": receiveBy,
        "addressSend": addressSend,
        "addressReceive": addressReceive,
        "costShip": costShip,
        "costProduct": costProduct,
        "note": note,
        "phoneSend": phoneSend,
        "phoneReceive": phoneReceive
      };
}
