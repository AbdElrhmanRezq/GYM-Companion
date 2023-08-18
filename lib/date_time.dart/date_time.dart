//returns todays date yyyyymmdd
String todaysDate() {
  var todaysDateTime = DateTime.now();
  String year = todaysDateTime.year.toString();

  String month = todaysDateTime.month.toString();
  if (month.length == 1) {
    month = "0$month";
  }

  String day = todaysDateTime.day.toString();
  if (day.length == 1) {
    day = "0$day";
  }
  String yyyymmdd = year + month + day;
  return yyyymmdd;
}

//convert yyyyymmdd to dateTime
DateTime convertToDateTime(String yyyymmdd) {
  int yyyy = int.parse(yyyymmdd.substring(0, 4));
  int mm = int.parse(yyyymmdd.substring(4, 6));
  int dd = int.parse(yyyymmdd.substring(6, 8));

  DateTime dateTimeObj = DateTime(yyyy, mm, dd);
  return dateTimeObj;
}

//vice versa
String convertDateToString(DateTime date) {
  String year = date.year.toString();

  String month = date.month.toString();
  if (month.length == 1) {
    month = "0$month";
  }

  String day = date.day.toString();
  if (day.length == 1) {
    day = "0$day";
  }
  String yyyymmdd = year + month + day;
  return yyyymmdd;
}
