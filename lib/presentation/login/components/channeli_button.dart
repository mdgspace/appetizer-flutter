import 'package:appetizer/data/core/router/intrinsic_router/intrinsic_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class ChanneliButton extends StatelessWidget {
  const ChanneliButton({this.callback, super.key});

  final Function(String)? callback;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        var code = await context.router.push<String>(OAuthWebRoute());
        if (code != null) {
          callback?.call(code);
        } else {
          // TODO: throw error
        }
      },
      child: const Text("Login with Channel-i"),
    );
  }
}
