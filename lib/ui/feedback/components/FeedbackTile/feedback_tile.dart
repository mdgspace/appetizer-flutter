import 'package:appetizer_revamp_parts/ui/feedback/components/FeedbackTile/bloc/feedback_tile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedbackTile extends StatelessWidget {
  const FeedbackTile({
    required this.title,
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.left,
          style: const TextStyle(
            color: Color(0xFF111111),
            fontSize: 20,
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
                    iconSize: 27,
                    onPressed: () => context
                        .read<FeedbackTileBloc>()
                        .add(FeedbackRatingChangedEvent(newRating: index + 1)),
                    icon: index < state.rating
                        ? Image.asset(
                            'lib/presentation/assets/images/filledStar.png')
                        : Image.asset(
                            'lib/presentation/assets/images/emptyStar.png'),
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
