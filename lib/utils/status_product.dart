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
  // if (statusShip == 0) {
  //   if (isSuccess && !isEnter) {
  //     title = 'Lấy thành công';
  //   } else if (!isSuccess && !isEnter) {
  //     title = 'Lấy thất bại';
  //   }
  // } else if (statusShip == 1) {
  //   title = 'Đang giao';
  //   if (isSuccess && !isEnter) {
  //     title = 'Đã giao';
  //   } else if (!isSuccess && !isEnter) {
  //     title = 'Giao thất bại';
  //   }
  // }
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
  // if (type == 1 && !isSuccess) {
  //   return AppColors.gradientShipping;
  // } else if (type == 1 && isSuccess) {
  //   return AppColors.gradientShipped;
  // }
  // return AppColors.gradientGetProduct;
}

// Color getColor(int status) {
//   Color color = Colors.orange;
//   if (statusShip == 0) {
//     color = Colors.orange;
//     if (!isSuccess && !isEnter) {
//       color = Colors.red;
//     }
//   } else if (statusShip == 1) {
//     color = Colors.green;
//     if (isSuccess && !isEnter) {
//       color = Colors.blue;
//     } else if (!isSuccess && !isEnter) {
//       color = Colors.red;
//     }
//   }
//   return color;
// }
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
