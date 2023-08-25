import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:appetizer/presentation/components/black_button.dart';
import 'package:appetizer/presentation/feedback/bloc/feedback_page_bloc.dart';
import 'package:appetizer/presentation/feedback/components/FeedbackTile/feedback_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedbackPage extends StatelessWidget {
  FeedbackPage({super.key});
  final TextEditingController textController = TextEditingController();
  static const List<String> feedbackHeadings = [
    "Ambience",
    "Hygiene and Cleanliness",
    "Weekly Menu",
    "Worker and Services",
    "Diet and Nutrition",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: const Text(
          'Feedback',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontFamily: 'Noto Sans',
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: const Color(0xFFFFCB74),
        toolbarHeight: 120.toAutoScaledHeight,
      ),
      body: BlocProvider(
        create: (context) => FeedbackPageBloc(),
        child: BlocBuilder<FeedbackPageBloc, FeedbackPageState>(
          builder: (context, state) {
            // if (state.submitted) {
            //   // TODO: Add success screen or navigate back
            //   return const Placeholder();
            // }
            return SingleChildScrollView(
              padding: const EdgeInsets.only(left: 24, right: 26),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 9.toAutoScaledHeight),
                  Text(
                    'Kindly provide us with your feedback to improve your mess experienWeekly Menuce.',
                    style: TextStyle(
                      color: const Color(0xFF5A5A5A),
                      fontSize: 14.toAutoScaledFont,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 6.toAutoScaledHeight),
                  ...List.generate(feedbackHeadings.length, (ind) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 2.toAutoScaledHeight),
                      child: FeedbackTile(
                        parentState: state,
                        title: feedbackHeadings[ind],
                        index: ind,
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    'If any other feeback, please describe below',
                    style: TextStyle(
                      color: const Color(0xFF111111),
                      fontSize: 16.toAutoScaledFont,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Description',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5400000214576721),
                      fontSize: 12.toAutoScaledFont,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextField(
                    controller: textController,
                    onChanged: (value) => context.read<FeedbackPageBloc>().add(
                        FeedbackPageDescriptionChangedEvent(
                            description: value)),
                    maxLength: 200,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 0.5.toAutoScaledWidth,
                          color: const Color.fromARGB(37, 0, 0, 0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 19),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: BlackIconButton(
                      onTap: () => context.read<FeedbackPageBloc>().add(
                          FeedbackPageSubmitEvent(
                              rating: state.rating,
                              description: state.description)),
                      title: "SUBMIT",
                      width: 102,
                      icon: Icons.keyboard_double_arrow_right_sharp,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
