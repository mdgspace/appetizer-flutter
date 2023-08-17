import 'package:appetizer_revamp_parts/ui/components/no_data_found_container.dart';
import 'package:appetizer_revamp_parts/ui/coupons/bloc/coupons_page_bloc.dart';
import 'package:appetizer_revamp_parts/ui/coupons/components/coupon_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CouponsPage extends StatelessWidget {
  const CouponsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: const Text(
          'Coupons',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontFamily: 'Noto Sans',
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: const Color(0xFFFFCB74),
        toolbarHeight: 120,
      ),
      body: BlocProvider(
        create: (context) => CouponsPageBloc(),
        child: BlocBuilder<CouponsPageBloc, CouponsPageState>(
          builder: (context, state) {
            if (state is CouponsPageInitialState) {
              context
                  .read<CouponsPageBloc>()
                  .add(const CouponsPageFetchEvent(coupons: []));
              // TODO: place proper widget
              return const Placeholder();
            }
            if (state is CouponsPageFailedState) {
              // TODO: throw an error, or snackbar
            }
            if (state is CouponsPageFetchedState) {
              if (state.coupons.isEmpty) {
                return const NoDataFoundContainer(
                    title: 'No coupons selected !');
              }
              return Container(
                padding: const EdgeInsets.only(left: 32, top: 40),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 39,
                  mainAxisSpacing: 27,
                  children: List.generate(
                    state.coupons.length,
                    (index) => CouponCard(coupon: state.coupons[index]),
                  ),
                ),
              );
            }
            return const NoDataFoundContainer(title: 'No coupons selected !');
          },
        ),
      ),
    );
  }
}
