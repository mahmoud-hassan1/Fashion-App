String getDate(DateTime date, [bool showMonth = true]) {
  List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

  return "${date.day}-${showMonth ? months[date.month - 1] : date.month}-${date.year}";
}
