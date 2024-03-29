import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:appetizer/domain/models/coupon/coupon.dart';
import 'package:appetizer/domain/repositories/coupon_repository.dart';
import 'package:appetizer/presentation/components/loading_indicator.dart';
import 'package:appetizer/presentation/components/no_data_found_container.dart';
import 'package:appetizer/presentation/coupons/bloc/coupons_page_bloc.dart';
import 'package:appetizer/presentation/coupons/components/coupon_banner.dart';
import 'package:appetizer/presentation/coupons/components/coupon_row.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CouponsScreen extends StatelessWidget {
  const CouponsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const CouponBanner(),
          BlocProvider(
            create: (context) =>
                CouponsPageBloc(repo: context.read<CouponRepository>())
                  ..add(const CouponsPageFetchEvent()),
            child: BlocBuilder<CouponsPageBloc, CouponsPageState>(
              builder: (context, state) {
                if (state is CouponsPageInitialState) {
                  return const Expanded(
                      child: Center(child: LoadingIndicator()));
                }
                if (state is CouponsPageFailedState) {
                  // TODO: add logic to handle fail
                  return const NoDataFoundContainer(
                      title: 'Oops! Could not get your coupons');
                }
                if (state is CouponsPageFetchedState &&
                    state.coupons.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: ((context, index) {
                        List<Coupon> couponsList = [];
                        if (index == (state.coupons.length - 1) ~/ 2 &&
                            state.coupons.length.isOdd) {
                          couponsList = [state.coupons.last];
                        } else {
                          couponsList = [
                            state.coupons[2 * index],
                            state.coupons[2 * index + 1]
                          ];
                        }
                        return CouponRow(coupons: couponsList);
                      }),
                      itemCount: (state.coupons.length + 1) ~/ 2,
                      padding: EdgeInsets.only(
                        left: 32.toAutoScaledWidth,
                        right: 32.toAutoScaledWidth,
                      ),
                    ),
                  );
                }
                return const NoDataFoundContainer(
                    title: 'No coupons selected!');
              },
            ),
          ),
        ],
      ),
    );
  }
}
