import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:appetizer/presentation/components/no_data_found_container.dart';
import 'package:appetizer/presentation/coupons/bloc/coupons_page_bloc.dart';
import 'package:appetizer/presentation/coupons/components/coupon_banner.dart';
import 'package:appetizer/presentation/coupons/components/coupon_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CouponsPage extends StatelessWidget {
  const CouponsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => CouponsPageBloc(),
        child: BlocBuilder<CouponsPageBloc, CouponsPageState>(
          builder: (context, state) {
            if (state is CouponsPageInitialState) {
              context
                  .read<CouponsPageBloc>()
                  .add(const CouponsPageFetchEvent(coupons: []));
              return const Column(
                children: [
                  CouponBanner(),
                  NoDataFoundContainer(title: 'Coupons vanished into space !'),
                ],
              );
            }
            if (state is CouponsPageFetchedState && state.coupons.isNotEmpty) {
              return Column(
                children: [
                  const CouponBanner(),
                  Expanded(
                    // TODO: remove extra size of gridview children
                    child: GridView.count(
                      crossAxisCount: 2,
                      padding: EdgeInsets.only(left: 32.toAutoScaledWidth),
                      shrinkWrap: true,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: List.generate(
                        state.coupons.length,
                        (index) => CouponCard(
                          coupon: state.coupons[index],
                        ),
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
