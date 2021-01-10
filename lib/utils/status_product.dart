import 'package:flutter/material.dart';
import 'package:manage_delivery/base/consts/colors.dart';

String getStatusOfProduct(int statusShip, bool isSuccess, bool isEnter) {
  String title = 'Đang lấy';
  if (statusShip == 0) {
    if (isSuccess && !isEnter) {
      title = 'Lấy thành công';
    } else if (!isSuccess && !isEnter) {
      title = 'Lấy thất bại';
    }
  } else if (statusShip == 1) {
    title = 'Đang giao';
    if (isSuccess && !isEnter) {
      title = 'Đã giao';
    } else if (!isSuccess && !isEnter) {
      title = 'Giao thất bại';
    }
  }
  return title;
}

List<Color> getGradient(int type, bool isSuccess) {
  if (type == 1 && !isSuccess) {
    return AppColors.gradientShipping;
  } else if (type == 1 && isSuccess) {
    return AppColors.gradientShipped;
  }
  return AppColors.gradientGetProduct;
}

Color getColor(int statusShip, bool isSuccess, bool isEnter) {
  Color color = Colors.orange;
  if (statusShip == 0) {
    color = Colors.orange;
    if (!isSuccess && !isEnter) {
      color = Colors.red;
    }
  } else if (statusShip == 1) {
    color = Colors.green;
    if (isSuccess && !isEnter) {
      color = Colors.blue;
    } else if (!isSuccess && !isEnter) {
      color = Colors.red;
    }
  }
  return color;
}
