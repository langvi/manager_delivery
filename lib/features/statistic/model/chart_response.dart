class ChartResponse {
  ChartResponse({
    this.message,
    this.isSuccess,
    this.data,
  });

  String message;
  bool isSuccess;
  DataChart data;

  factory ChartResponse.fromJson(Map<String, dynamic> json) => ChartResponse(
        message: json["message"],
        isSuccess: json["isSuccess"],
        data: DataChart.fromJson(json["data"]),
      );
}

class DataChart {
  DataChart({
    this.percentGetting = 0,
    this.percentShipping = 0,
    this.percentShiped = 0,
  });

  double percentGetting;
  double percentShipping;
  double percentShiped;

  factory DataChart.fromJson(Map<String, dynamic> json) {
    int getting = json['countGetting'];
    int shipping = json['countShipping'];
    int shiped = json['countShiped'];
    int total = getting + shipping + shiped;
    if (total == 0) {
      return DataChart();
    }
    return DataChart(
        percentGetting: getting / total * 100,
        percentShipping: shipping / total * 100,
        percentShiped: shiped / total * 100);
  }
}
