class BaseResponse {
  BaseResponse({
    this.message,
    this.isSuccess,
    this.data,
  });

  String message;
  bool isSuccess;
  dynamic data;

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
        message: json["message"],
        isSuccess: json["isSuccess"],
        data: json["data"],
      );
}
