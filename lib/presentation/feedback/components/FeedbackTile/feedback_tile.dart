import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:appetizer/presentation/feedback/bloc/feedback_page_bloc.dart';
import 'package:appetizer/presentation/feedback/components/FeedbackTile/bloc/feedback_tile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedbackTile extends StatelessWidget {
  const FeedbackTile({
    required this.title,
    required this.parentState,
    required this.index,
    Key? key,
  }) : super(key: key);

  final String title;
  final FeedbackPageState parentState;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Color(0xFF111111),
            fontSize: 20.toAutoScaledFont,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w400,
          ),
        ),
        BlocProvider(
          create: (context) => FeedbackTileBloc(),
          child: BlocBuilder<FeedbackTileBloc, FeedbackTileState>(
            builder: (context, state) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(5, (index) {
                  return IconButton(
                    iconSize: 27.toAutoScaledWidth,
                    onPressed: () {
                      context.read<FeedbackTileBloc>().add(
                          FeedbackRatingChangedEvent(newRating: index + 1));
                      parentState.rating[this.index] = index + 1;
                    },
                    icon: index < state.rating
                        ? Image.asset('assets/images/filledStar.png')
                        : Image.asset('assets/images/emptyStar.png'),
                  );
                }),
              );
            },
          ),
        ),
      ],
    );
  }
}
