import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:appetizer/domain/models/coupon/coupon.dart';
import 'package:appetizer/domain/repositories/coupon_repository.dart';
import 'package:appetizer/presentation/app/bloc/app_bloc.dart';
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
      body: BlocProvider(
        create: (context) =>
            CouponsPageBloc(repo: context.read<CouponRepository>()),
        child: BlocBuilder<CouponsPageBloc, CouponsPageState>(
          builder: (context, state) {
            if (state is CouponsPageInitialState) {
              context.read<CouponsPageBloc>().add(CouponsPageFetchEvent(
                  coupons: const [], user: context.read<AppState>().user!));
              return const NoDataFoundContainer(
                  title: 'Cannot find the user !');
            }
            if (state is CouponsPageFailedState) {
              // TODO: add logic to handle fail
              // context.read<CouponsPageBloc>().add(CouponsPageFetchEvent(
              //     coupons: state.coupons,
              //     user: context.read<AppState>().user!));
              return const NoDataFoundContainer(
                  title: 'Oops! Could not get your coupons');
            }
            if (state is CouponsPageFetchedState && state.coupons.isNotEmpty) {
              return Column(
                children: [
                  const CouponBanner(),
                  Expanded(
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
                  ),
                ],
              );
            }
            return const Column(
              children: [
                CouponBanner(),
                NoDataFoundContainer(title: 'No coupons selected !'),
              ],
            );
          },
        ),
      ),
    );
  }
}
