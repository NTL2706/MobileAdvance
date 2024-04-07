int calculateTimeDifference(DateTime timeStart, DateTime timeEnd) {
  // Tính thời gian giữa hai thời điểm trong phút
  Duration difference = timeEnd.difference(timeStart);

  // Trả về tổng số phút
  return difference.inMinutes;
}
