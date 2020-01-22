import 'package:appetizer/models/multimessing/meal_switch_from_your_meals.dart';
import 'package:http/http.dart' as http;

String url = "https://appetizer-mdg.herokuapp.com";
http.Client client = new http.Client();

Future<List<SwitchableMealsForYourMeal>> listSwitchableMeals(
    int id, String token) async {
  String endpoint = "/api/menu/switch_meal/$id";
  String uri = url + endpoint;
  var tokenAuth = {"Authorization": "Token $token"};
  try {
    final response = await client.get(uri, headers: tokenAuth);
    List<SwitchableMealsForYourMeal> switchableMeals =
        switchableMealsForYourMealFromJson(response.body);
    return switchableMeals;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
