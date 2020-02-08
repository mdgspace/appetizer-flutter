import 'package:appetizer/models/menu/week.dart';

getDailyItemsMap(DailyItems dailyItems) {
  Map<MealType, String> dailyItemsMap = {
    MealType.B: _dataToJoinedString(dailyItems.breakfast),
    MealType.L: _dataToJoinedString(dailyItems.lunch),
    MealType.S: _dataToJoinedString(dailyItems.snack),
    MealType.D: _dataToJoinedString(dailyItems.dinner)
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
