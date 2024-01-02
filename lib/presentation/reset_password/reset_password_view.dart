import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:appetizer/presentation/components/loading_indicator.dart';
import 'package:appetizer/presentation/login/components/login_button.dart';
import 'package:appetizer/presentation/reset_password/bloc/reset_password_bloc.dart';
import 'package:appetizer/presentation/reset_password/components/reset_password_banner.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

@RoutePage()
class ResetPasswordScreen extends StatelessWidget {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordBloc(userRepository: context.read()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
          listener: (context, state) {
            if (state is ResetPassword && state.error != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error!),
                  backgroundColor: Colors.red,
                ),
              );
            }
            if (state is ResetPasswordSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Password reset successfully!'),
                backgroundColor: Colors.green,
              ));
              context.router.pop();
            }
          },
          builder: (context, state) {
            if (state is ResetPassword) {
              return Column(
                children: [
                  const ResetPasswordBanner(),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: 24.toHorizontalPadding,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Enter your old password',
                            style: GoogleFonts.notoSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          20.toVerticalSizedBox,
                          TextField(
                            controller: _oldPasswordController,
                            obscureText: !state.showOldPassword,
                            decoration: InputDecoration(
                              hintText: 'Old Password',
                              hintStyle: GoogleFonts.lato(
                                fontSize: 12.toAutoScaledFont,
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
                              suffixIcon: IconButton(
                                onPressed: () {
                                  BlocProvider.of<ResetPasswordBloc>(context)
                                      .add(
                                    ToggleObscureResetPassword(
                                        showOldPassword: !state.showOldPassword,
                                        showNewPassword: state.showNewPassword,
                                        showConfirmPassword:
                                            state.showConfirmPassword),
                                  );
                                },
                                icon: state.showOldPassword
                                    ? const Icon(Icons.visibility,
                                        color: Color(0xFF757575))
                                    : const Icon(Icons.visibility_off,
                                        color: Color(0xFF757575)),
                              ),
                            ),
                          ),
                          20.toVerticalSizedBox,
                          Text(
                            'Enter your new password',
                            style: GoogleFonts.notoSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          20.toVerticalSizedBox,
                          TextField(
                            controller: _newPasswordController,
                            obscureText: !state.showNewPassword,
                            decoration: InputDecoration(
                              hintText: 'New Password',
                              hintStyle: GoogleFonts.lato(
                                fontSize: 12.toAutoScaledFont,
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
                              suffixIcon: IconButton(
                                onPressed: () {
                                  BlocProvider.of<ResetPasswordBloc>(context)
                                      .add(
                                    ToggleObscureResetPassword(
                                        showNewPassword: !state.showNewPassword,
                                        showOldPassword: state.showOldPassword,
                                        showConfirmPassword:
                                            state.showConfirmPassword),
                                  );
                                },
                                icon: state.showNewPassword
                                    ? const Icon(Icons.visibility,
                                        color: Color(0xFF757575))
                                    : const Icon(Icons.visibility_off,
                                        color: Color(0xFF757575)),
                              ),
                            ),
                          ),
                          20.toVerticalSizedBox,
                          Text(
                            'Confirm your new password',
                            style: GoogleFonts.notoSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          20.toVerticalSizedBox,
                          TextField(
                            controller: _confirmPasswordController,
                            obscureText: !state.showConfirmPassword,
                            decoration: InputDecoration(
                              hintText: 'Confirm Password',
                              hintStyle: GoogleFonts.lato(
                                fontSize: 12.toAutoScaledFont,
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
                              suffixIcon: IconButton(
                                onPressed: () {
                                  BlocProvider.of<ResetPasswordBloc>(context)
                                      .add(
                                    ToggleObscureResetPassword(
                                        showConfirmPassword:
                                            !state.showConfirmPassword,
                                        showOldPassword: state.showOldPassword,
                                        showNewPassword: state.showNewPassword),
                                  );
                                },
                                icon: state.showConfirmPassword
                                    ? const Icon(Icons.visibility,
                                        color: Color(0xFF757575))
                                    : const Icon(Icons.visibility_off,
                                        color: Color(0xFF757575)),
                              ),
                            ),
                          ),
                          20.toVerticalSizedBox,
                          Center(
                            child: LoginButton(
                              text: "Reset Password",
                              onPressed: () {
                                context.read<ResetPasswordBloc>().add(
                                    ResetPasswordPressed(
                                        _oldPasswordController.text,
                                        _newPasswordController.text,
                                        _confirmPasswordController.text));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return const Center(child: LoadingIndicator());
          },
        ),
      ),
    );
  }
}
