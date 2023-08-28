import 'package:appetizer/app_theme.dart';
import 'package:appetizer/data/core/router/intrinsic_router/intrinsic_router.gr.dart';
import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:appetizer/presentation/app/bloc/app_bloc.dart';
import 'package:appetizer/presentation/components/app_banner.dart';
import 'package:appetizer/utils/app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CouponBanner extends StatelessWidget {
  const CouponBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBanner(
      height: 120.toAutoScaledHeight,
      child: Row(
        children: [
          IconButton(
            onPressed: () => BaseApp.router.navigateToPage(
                ProfileRoute(data: context.read<AppState>().user!)),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          Text(
            "Coupons",
            style: AppTheme.headline1,
          ),
        ],
      ),
    );
  }
}
