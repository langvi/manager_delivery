import 'package:flutter/material.dart';
import 'package:manage_delivery/base/consts/colors.dart';

String getStatusOfProduct(int statusShip) {
  String title = 'Đang lấy';
  switch (statusShip) {
    case 0:
      title = 'Chờ lấy';
      break;
    case 2:
      title = 'Lấy thành công';
      break;
    case 3:
      title = 'Lấy thất bại';
      break;
    case 4:
      title = 'Đang giao';
      break;
    case 5:
      title = 'Giao thất bại';
      break;
    case 6:
      title = 'Đã giao';
      break;
    case 7:
      title = 'Đã nhập';
      break;
    default:
  }
  return title;
}

List<Color> getGradient(int type) {
  switch (type) {
    case 0:
    case 1:
    case 2:
    case 3:
      return AppColors.gradientGetProduct;
    case 4:
    case 5:
    case 7:
      return AppColors.gradientShipping;
      break;
    default:
  }
  return AppColors.gradientShipped;
}
Color getColor(int status) {
  Color color = Colors.orange;
  switch (status) {
    case 2:
    case 4:
      color = Colors.green;
      break;
    case 3:
    case 5:
      color = Colors.red;
      break;
    case 6:
      color = Colors.blue;
      break;
    case 7:
      color = Colors.purple;
      break;
    default:
  }
  return color;
}
