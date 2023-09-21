import 'package:appetizer/data/core/router/intrinsic_router/intrinsic_router.dart';
import 'package:appetizer/presentation/login/bloc/login_bloc.dart';
import 'package:appetizer/utils/app_extensions/app_extensions.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChanneliButton extends StatelessWidget {
  const ChanneliButton({
    // required this.onPressed,
    Key? key,
  }) : super(key: key);

  // final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () async {
          var code = await context.router.push(OAuthWebRoute());
          if (code != null) {
            BaseApp.currentContext
                ?.read<LoginBloc>()
                .add(NewUserSignUp(code: code.toString()));
          } else {
            // TODO: throw error
          }
        },
        child: const Text("Login with Channel-i"));
  }
}
