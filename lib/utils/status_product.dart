String getStatusOfProduct(int status) {
  String title = '';
  switch (status) {
    case 0:
      title = 'Đang lấy';
      break;
    case 1:
      title = 'Đang giao';
      break;
    case 2:
      title = 'Đã giao';
      break;
    default:
  }
  return title;
}