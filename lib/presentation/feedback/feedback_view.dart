import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:appetizer/presentation/feedback/bloc/feedback_page_bloc.dart';
import 'package:appetizer/presentation/feedback/components/FeedbackTile/feedback_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedbackPage extends StatelessWidget {
  FeedbackPage({super.key});
  final TextEditingController textController = TextEditingController();

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
                    'Kindly provide us with your feedback to improve your mess experience.',
                    style: TextStyle(
                      color: Color(0xFF5A5A5A),
                      fontSize: 14.toAutoScaledFont,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 8.toAutoScaledHeight),
                  FeedbackTile(title: 'Ambience', parentState: state, index: 0),
                  SizedBox(height: 4.toAutoScaledHeight),
                  FeedbackTile(
                      title: 'Hygiene and Cleanliness',
                      parentState: state,
                      index: 1),
                  SizedBox(height: 4.toAutoScaledHeight),
                  FeedbackTile(
                      title: 'Weekly Menu', parentState: state, index: 2),
                  SizedBox(height: 4.toAutoScaledHeight),
                  FeedbackTile(
                      title: 'Worker and Services',
                      parentState: state,
                      index: 3),
                  SizedBox(height: 4.toAutoScaledHeight),
                  FeedbackTile(
                      title: 'Diet and Nutrition',
                      parentState: state,
                      index: 4),
                  SizedBox(height: 4.toAutoScaledHeight),
                  Text(
                    'If any other feeback, please describe below',
                    style: TextStyle(
                      color: Color(0xFF111111),
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
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 0.5.toAutoScaledWidth,
                          color: Color.fromARGB(37, 0, 0, 0),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    // TODO: decoration for Button
                    onPressed: () => context.read<FeedbackPageBloc>().add(
                        FeedbackPageSubmitEvent(
                            rating: state.rating,
                            description: state.description)),
                    child: const Text('Submit'),
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
