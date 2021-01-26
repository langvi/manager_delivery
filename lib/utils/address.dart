class Address {
  String district;
  List<String> villages;
  Address({this.district, this.villages});
  factory Address.fromJson(String name) {
    switch (name) {
      case 'Đống Đa':
        return Address(
            district: name,
            villages: ["Cát Linh", "Kim Liên", "Nam Đồng", "Phương Mai"]);
      case 'Thanh Xuân':
        return Address(district: name, villages: [
          "Phương Liệt",
          "Kim Giang",
          "Thanh Xuân Bắc",
          "Thượng Đình"
        ]);
      case 'Nam Từ Liêm':
        return Address(
            district: name,
            villages: ["Trung Văn", "Đại Mỗ", "Tây Mỗ", "Phương Canh"]);
      case 'Cầu Giấy':
        return Address(
            district: name,
            villages: ["Dịch Vọng", "Mai Dịch", "Trung Hòa", "Quan Hoa"]);
      case 'Hai Bà Trưng':
        return Address(
            district: name,
            villages: ["Bách Khoa", "Bạch Mai", "Đồng Tâm", "Thanh Nhàn"]);
      default:
        return Address(
            district: name,
            villages: ["Đại Kim", "Hoàng Văn Thụ", "Tân Mai", "Mai Động"]);
    }
  }
}
