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
      this.statusShip,
      this.createdAt,
      this.id,
      this.addressReceive,
      this.enterAt,
      this.isSuccess,
      this.note,
      this.isEnter,
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
  double costShip;
  bool isSuccess;
  bool isEnter;
  double costProduct;
  int statusShip;
  DateTime createdAt;
  String id;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        nameProduct: json["nameProduct"],
        sendFrom: json["sendFrom"],
        receiveBy: json["receiveBy"],
        isSuccess: json['isSuccess'],
        addressSend: json["addressSend"],
        addressReceive: json["addressSend"],
        isEnter: json["isEnter"],
        costShip: json["costShip"].toDouble(),
        costProduct: json["costProduct"].toDouble(),
        phoneReceive: json['phoneReceive'],
        shipedAt:
            json['shipedAt'] != null ? DateTime.parse(json['shipedAt']) : null,
        shippingAt: json['shippingAt'] != null
            ? DateTime.parse(json['shippingAt'])
            : null,
        phoneSend: json['phoneSend'],
        statusShip: json["statusShip"],
        createdAt: DateTime.parse(json["createdAt"]),
        enterAt:
            json['enterAt'] != null ? DateTime.parse(json['enterAt']) : null,
        note: json['note'],
        id: json["id"],
      );

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
