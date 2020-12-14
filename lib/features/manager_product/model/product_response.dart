class ProductResponse {
    ProductResponse({
        this.message,
        this.isSuccess,
        this.data,
    });

    String message;
    bool isSuccess;
    List<Product> data;

    factory ProductResponse.fromJson(Map<String, dynamic> json) => ProductResponse(
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
    Product({
        this.nameProduct,
        this.sendFrom,
        this.receiveBy,
        this.address,
        this.costShip,
        this.costProduct,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.id,
    });

    String nameProduct;
    String sendFrom;
    String receiveBy;
    String address;
    int costShip;
    double costProduct;
    int status;
    String createdAt;
    String updatedAt;
    String id;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        nameProduct: json["nameProduct"],
        sendFrom: json["sendFrom"],
        receiveBy: json["receiveBy"],
        address: json["address"],
        costShip: json["costShip"],
        costProduct: json["costProduct"].toDouble(),
        status: json["status"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "nameProduct": nameProduct,
        "sendFrom": sendFrom,
        "receiveBy": receiveBy,
        "address": address,
        "costShip": costShip,
        "costProduct": costProduct,
        "status": status,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "id": id,
    };
}