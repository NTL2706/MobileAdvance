String getTimeFromDateTime(DateTime time) {
  String hour = time.hour
      .toString()
      .padLeft(2, '0'); // Chuyển giờ thành chuỗi và thêm '0' nếu cần
  String minute = time.minute
      .toString()
      .padLeft(2, '0'); // Chuyển phút thành chuỗi và thêm '0' nếu cần
  return '$hour:$minute';
}

String getDateTime(DateTime dateTime) {
  String day = dateTime.day.toString().padLeft(2, '0'); // Ngày
  String month = dateTime.month.toString().padLeft(2, '0'); // Tháng
  String year = dateTime.year.toString(); // Năm
  String hour = dateTime.hour.toString().padLeft(2, '0'); // Giờ
  String minute = dateTime.minute.toString().padLeft(2, '0'); // Phút

  return '$day/$month/$year $hour:$minute';
}
