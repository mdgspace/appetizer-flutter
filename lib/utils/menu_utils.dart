import 'package:appetizer/models/menu/week.dart';

getDailyItemsMap(Week weekMenuData) {
  Map<String, String> dailyItemsMap = {
    "breakfast": _dataToJoinedString(weekMenuData.dailyItems.breakfast),
    "lunch": _dataToJoinedString(weekMenuData.dailyItems.lunch),
    "snacks": _dataToJoinedString(weekMenuData.dailyItems.snack),
    "dinner": _dataToJoinedString(weekMenuData.dailyItems.dinner)
  };
  return dailyItemsMap;
}

String _dataToJoinedString(final data) {
  List<String> dailyItemsList = [];
  String dailyItems = "";
  for (var i = 0; i < data.length; i++) {
    var name = data[i].name;
    dailyItemsList.add(name);
    dailyItems = dailyItemsList.join(" , ");
  }
  return dailyItems;
}
