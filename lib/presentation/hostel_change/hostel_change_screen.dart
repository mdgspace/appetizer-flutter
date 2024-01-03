import 'package:appetizer/data/core/router/intrinsic_router/intrinsic_router.gr.dart';
import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:appetizer/domain/repositories/user/user_repository.dart';
import 'package:appetizer/presentation/components/black_button.dart';
import 'package:appetizer/presentation/components/loading_indicator.dart';
import 'package:appetizer/presentation/hostel_change/bloc/hostel_change_bloc.dart';
import 'package:appetizer/presentation/hostel_change/components/hostel_change_banner.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

@RoutePage()
class HostelChangeScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _roomNoController = TextEditingController();
  HostelChangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, String> hostelMap = {
      'ANK': 'A.N. Khosla House',
      'AW': 'Azad Wing',
      'AZ': 'Azad Bhawan',
      'CB': 'Cautley Bhawan',
      'GA': 'Ganga Bhawan',
      'GB': 'Govind Bhawan',
      'GP': 'Ghananand Pande Bhawan',
      'IB': 'Indira Bhawan',
      'JB': 'Jawahar Bhawan',
      'KB': 'Kasturba Bhawan',
      'KIH': 'Khosla International House',
      'MB': 'Malviya Bhawan',
      'MR': 'M.R. Chopra Bhawan',
      'RKB': 'Radhakrishnan Bhawan',
      'RJB': 'Rajendra Bhawan',
      'RB': 'Rajiv Bhawan',
      'RV': 'Ravindra Bhawan',
      'SB': 'Sarojini Bhawan',
      'VK': 'Vigyan Kunj',
      'VKJ': 'Vikash Kunj',
      'DVG': 'Development Government',
      'DVP': 'Development Private',
    };
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          const HostelChangeBanner(),
          BlocProvider(
            create: (context) =>
                HostelChangeBloc(repo: context.read<UserRepository>()),
            child: BlocConsumer<HostelChangeBloc, HostelChangeState>(
              listener: (BuildContext context, HostelChangeState state) {
                if (state is HostelChangeSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Hostel change request sent successfully'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  context.router.pushAndPopUntil(const ProfileRoute(),
                      predicate: ModalRoute.withName(ProfileRoute.name));
                }
                if (state is HostelChangeInitial && state.error != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error!),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (BuildContext context, HostelChangeState state) {
                if (state is Loading) {
                  return const Center(child: LoadingIndicator());
                }
                if (state is HostelChangeInitial ||
                    state is HostelQueryChanged) {
                  return Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(
                        horizontal: 24.toAutoScaledWidth,
                        vertical: 32.toAutoScaledHeight),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select New Hostel',
                          style: TextStyle(
                            color: const Color(0xFF111111),
                            fontSize: 20.toAutoScaledFont,
                            fontFamily: 'Noto Sans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        12.toVerticalSizedBox,
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.toAutoScaledWidth,
                              vertical: 16.toAutoScaledHeight),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFFEFEFEF),
                              width: 1,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(24, 24, 28, 0.07),
                                offset: Offset(0, 2),
                                blurRadius: 3,
                                spreadRadius: 1.5,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              TextField(
                                controller: _searchController,
                                onChanged: (value) {
                                  context.read<HostelChangeBloc>().add(
                                      HostelSearchQueryChanged(query: value));
                                },
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xFFF1F1F1),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 0.toAutoScaledWidth,
                                        vertical: 0.toAutoScaledHeight),
                                    hintText: 'Search',
                                    hintStyle: TextStyle(
                                      color: const Color(0xFF5F5F61),
                                      fontSize: 14.toAutoScaledFont,
                                      fontFamily: 'Lato',
                                      fontWeight: FontWeight.w500,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          8.toAutoScaledWidth),
                                      borderSide: BorderSide.none,
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.search_sharp,
                                      color: Color(0xFF5F5F61),
                                      size: 20,
                                    )),
                              ),
                              if (state is HostelChangeInitial)
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: hostelMap.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(
                                        hostelMap.values.elementAt(index),
                                        style: TextStyle(
                                          color: const Color(0xFF111111),
                                          fontSize: 14.toAutoScaledFont,
                                          fontFamily: 'Lato',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      onTap: () {
                                        _searchController.text =
                                            hostelMap.values.elementAt(index);
                                        context.read<HostelChangeBloc>().add(
                                            HostelSearchQueryChanged(
                                                query: hostelMap.values
                                                    .elementAt(index)));
                                      },
                                    );
                                  },
                                ),
                              if (state is HostelQueryChanged)
                                SingleChildScrollView(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: hostelMap.length,
                                    itemBuilder: (context, index) {
                                      if (hostelMap.values
                                              .elementAt(index)
                                              .toLowerCase()
                                              .contains(
                                                  state.query.toLowerCase()) ||
                                          hostelMap.keys
                                              .elementAt(index)
                                              .toLowerCase()
                                              .contains(
                                                  state.query.toLowerCase())) {
                                        return ListTile(
                                          title: Text(
                                            hostelMap.values.elementAt(index),
                                            style: TextStyle(
                                              color: const Color(0xFF111111),
                                              fontSize: 14.toAutoScaledFont,
                                              fontFamily: 'Lato',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          onTap: () {
                                            _searchController.text = hostelMap
                                                .values
                                                .elementAt(index);
                                            context
                                                .read<HostelChangeBloc>()
                                                .add(HostelSearchQueryChanged(
                                                    query: hostelMap.values
                                                        .elementAt(index)));
                                          },
                                        );
                                      }
                                      return const SizedBox(
                                        height: 0,
                                      );
                                    },
                                  ),
                                ),
                              const Divider(),
                              10.toVerticalSizedBox,
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'New Room Number',
                                  style: GoogleFonts.notoSans(
                                    fontSize: 14.toAutoScaledFont,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              6.toVerticalSizedBox,
                              TextField(
                                controller: _roomNoController,
                                decoration: InputDecoration(
                                  hintText: 'Enter new Room Number',
                                  hintStyle: GoogleFonts.lato(
                                    fontSize: 12,
                                    color: const Color(0xFF111111),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: const Color(0xFF111111)
                                            .withOpacity(0.25)),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20.toAutoScaledWidth),
                                ),
                              ),
                              20.toVerticalSizedBox,
                              const Divider(),
                              10.toVerticalSizedBox,
                              BlackButton(
                                title: 'Submit',
                                onTap: () {
                                  int index = hostelMap.values
                                      .toList()
                                      .indexOf(_searchController.text);
                                  String hostelId = index != -1
                                      ? hostelMap.keys.elementAt(index)
                                      : "";
                                  String roomNo = _roomNoController.text;
                                  context.read<HostelChangeBloc>().add(
                                      HostelChangePressed(
                                          hostel: hostelId, roomNo: roomNo));
                                },
                                width: 100,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
                if (state is HostelSearchQueryChanged) {
                  return Container();
                }
                return Container();
              },
            ),
          )
        ],
      ),
    ));
  }
}
