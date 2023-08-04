import 'package:appetizer/app_theme.dart';
import 'package:appetizer/ui/menu/components/DayDateBar/day_date_bar.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: Container(
            color: AppTheme.green,
            child: const DayDateBar(
                startDate: 1, startDay: "Monday", endDate: 7, currDate: 3)),
      ),
    );
  }
}
