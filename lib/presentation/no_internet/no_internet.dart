import 'package:appetizer/presentation/components/no_data_found_container.dart';
import 'package:appetizer/presentation/no_internet/components/no_internet_banner.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class NoInternetWrapper extends StatelessWidget {
  const NoInternetWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}

@RoutePage()
class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Column(
        children: [
          NoInternetBanner(),
          NoDataFoundContainer(title: "No Internet Connection"),
        ],
      ),
    );
  }
}
