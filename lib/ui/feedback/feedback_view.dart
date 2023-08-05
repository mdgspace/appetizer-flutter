import 'package:appetizer_revamp_parts/ui/feedback/bloc/feedback_page_bloc.dart';
import 'package:appetizer_revamp_parts/ui/feedback/components/FeedbackTile/feedback_tile.dart';
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
        toolbarHeight: 120,
      ),
      body: BlocProvider(
        create: (context) => FeedbackPageBloc(),
        child: BlocBuilder<FeedbackPageBloc, FeedbackPageState>(
          builder: (context, state) {
            if (state.submitted) {
              // TODO: Add success screen or navigate back
              return const Placeholder();
            }
            return Column(
              children: [
                const FeedbackTile(title: 'Rating 1'),
                const FeedbackTile(title: 'Rating 2'),
                const FeedbackTile(title: 'Rating 3'),
                const FeedbackTile(title: 'Rating 4'),
                const FeedbackTile(title: 'Rating 5'),
                TextField(
                  controller: textController,
                  onChanged: (value) => context
                      .read<FeedbackPageBloc>()
                      .add(FeedbackPageDescriptionChangedEvent(description: value)),
                ),
                Positioned(
                  bottom: 43,
                  right: 24,
                  child: TextButton(
                    onPressed: () => context.read<FeedbackPageBloc>().add(
                        FeedbackPageSubmitEvent(
                            rating1: state.rating1,
                            rating2: state.rating2,
                            rating3: state.rating3,
                            rating4: state.rating4,
                            rating5: state.rating5,
                            description: state.description)),
                    child: const Text('Submit'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
