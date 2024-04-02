String getTimeFromDateTime(DateTime time) {
  String hour = time.hour
      .toString()
      .padLeft(2, '0'); // Chuyển giờ thành chuỗi và thêm '0' nếu cần
  String minute = time.minute
      .toString()
      .padLeft(2, '0'); // Chuyển phút thành chuỗi và thêm '0' nếu cần
  return '$hour:$minute';
}
