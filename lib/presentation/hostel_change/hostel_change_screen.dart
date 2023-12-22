import 'package:appetizer/presentation/hostel_change/components/hostel_change_banner.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HostelChangeScreen extends StatelessWidget{
  const HostelChangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HostelChangeBanner(),
          Text("Hostel Change")
        ],
      )
    );
  }
}