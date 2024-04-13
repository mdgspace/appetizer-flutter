import 'package:appetizer/app_theme.dart';
import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:appetizer/domain/repositories/user/user_repository.dart';
import 'package:appetizer/presentation/app/bloc/app_bloc.dart';
import 'package:appetizer/presentation/components/loading_indicator.dart';
import 'package:appetizer/presentation/components/no_data_found_container.dart';
import 'package:appetizer/presentation/no_internet/bloc/no_internet_bloc.dart';
import 'package:appetizer/presentation/no_internet/components/no_internet_banner.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocProvider(
        create: (context) =>
            NoInternetBloc(repo: context.read<UserRepository>()),
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const NoInternetBanner(),
              BlocBuilder<NoInternetBloc, NoInternetState>(
                  builder: (context, state) {
                if (state is ReloadSuccess) {
                  context.read<AppBloc>().add(const GetUser());
                }
                if (state is NoInternetInitial) {
                  return Column(
                    children: [
                      const NoDataFoundContainer(
                          title: "No Internet Connectivity!"),
                      SizedBox(
                        height: 20.toAutoScaledHeight,
                      ),
                      GestureDetector(
                          onTap: () => context
                              .read<NoInternetBloc>()
                              .add(const ReloadPressed()),
                          child: Container(
                            height: 24.toAutoScaledHeight,
                            width: 72.toAutoScaledWidth,
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.toAutoScaledWidth,
                            ),
                            decoration: ShapeDecoration(
                              color: AppTheme.primary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                            ),
                            child: Center(
                              child: Text(
                                'Reload',
                                style: AppTheme.bodyText1.copyWith(
                                    color: AppTheme.white,
                                    fontSize: 14.toAutoScaledFont,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.none),
                              ),
                            ),
                          )),
                    ],
                  );
                }
                return SizedBox(
                  height: 200.toAutoScaledHeight,
                  child: const Align(
                    alignment: Alignment.bottomCenter,
                    child: LoadingIndicator(),
                  ),
                );
              }),
              SizedBox(
                height: 100.toAutoScaledHeight,
              )
            ],
          ),
        ));
  }
}
// Container(
//   color: Colors.white,
//   child: const Column(
//     children: [
//       NoInternetBanner(),
//       NoDataFoundContainer(title: "No Internet Connection"),
//     ],
//   ),
// ),
