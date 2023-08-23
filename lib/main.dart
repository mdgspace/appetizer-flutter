import 'package:appetizer/domain/models/leaves/paginated_leaves.dart';
import 'package:appetizer/domain/models/transaction/paginated_yearly_rebate.dart';
import 'package:appetizer/presentation/leaves_and_rebate/leaves_and_rebate.dart';
import 'package:appetizer/utils/local_storage.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    PaginatedLeaves dummyLeaves = PaginatedLeaves.fromJson({
      "count": 1,
      "has_next": false,
      "has_previous": false,
      "results": [
        {
          "id": 51,
          "date_created": 1675078095318,
          "start_meal_type": "Dinner",
          "start_datetime": 1675260000000,
          "status": "P",
          "meal_count": 1,
          "end_meal_type": "Dinner",
          "end_datetime": 1675260000000
        }
      ]
    });
    PaginatedYearlyRebate dummyRebate = PaginatedYearlyRebate.fromJson({
      "count": 3,
      "has_next": false,
      "has_previous": false,
      "results": [
        {
          "month_id": 8,
          "year": 2023,
          "bill": null,
          "expenses": 0,
          "rebate": 0,
          "start_date": 1690828200000
        },
        {
          "month_id": 2,
          "year": 2023,
          "bill": null,
          "expenses": 0,
          "rebate": 0,
          "start_date": 1675189800000
        },
        {
          "month_id": 1,
          "year": 2023,
          "bill": null,
          "expenses": 0,
          "rebate": 0,
          "start_date": 1672511400000
        }
      ]
    });
    int mealsSkipped = 1, remainingLeaves = 104;
    return MaterialApp(
      home: Scaffold(
        body: LeavesAndRebate(
          isCheckedOut: false,
          initialYearlyRebates: dummyRebate,
          mealsSkipped: mealsSkipped,
          remainingLeaves: remainingLeaves,
          currYearLeaves: dummyLeaves,
        ),
      ),
    );
  }
}
