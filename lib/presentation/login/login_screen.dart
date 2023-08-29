import 'package:appetizer/data/constants/constants.dart';
import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:appetizer/presentation/components/made_by_mdg.dart';
import 'package:appetizer/domain/repositories/user_repository.dart';
import 'package:appetizer/presentation/login/components/login_button.dart';
import 'package:appetizer/presentation/login/bloc/login_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class LoginWrapper extends StatelessWidget {
  const LoginWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LoginBloc(userRepository: context.read<UserRepository>()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SvgPicture.asset('assets/images/login.svg'),
              20.toVerticalSizedBox,
              Container(
                width: 168.toAutoScaledWidth,
                height: 63.toAutoScaledHeight,
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/images/logo.png',
                  // scale: 1.5,
                ),
              ),
              30.toVerticalSizedBox,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.toAutoScaledWidth),
                child: BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is EnterPassword) {
                      _controller.clear();
                    }
                  },
                  builder: (context, state) {
                    if (state is Loading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is CreatePassword) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Set Password',
                            style: GoogleFonts.notoSans(
                              fontSize: 18.toAutoScaledFont,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          20.toVerticalSizedBox,
                          TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: 'Create Password',
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
                          10.toVerticalSizedBox,
                          TextField(
                            controller: _controller,
                            obscureText: true,
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
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                            ),
                          ),
                          SizedBox(
                            height: 30.toAutoScaledHeight,
                            child: Text(
                              state.error ?? '',
                              style: GoogleFonts.lato(
                                fontSize: 10.toAutoScaledFont,
                                color: const Color(0xFF2F2F2F),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Center(
                            child: LoginButton(
                              text: 'Login',
                              onPressed: () {
                                context.read<LoginBloc>().add(
                                      LoginPressed(
                                          _controller.text, state.enrollmentNo),
                                    );
                              },
                            ),
                          ),
                        ],
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state is ForgotPasswordState
                              ? 'Forgot Password'
                              : 'Login/SignUp',
                          style: GoogleFonts.notoSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        20.toVerticalSizedBox,
                        TextField(
                          controller: _controller,
                          obscureText: state is EnterPassword
                              ? !state.showPassword
                              : false,
                          decoration: InputDecoration(
                            hintText: state is EnterPassword
                                ? "Password"
                                : state is ForgotPasswordState
                                    ? "Email id"
                                    : 'Enrollment No.',
                            hintStyle: GoogleFonts.lato(
                              fontSize: 12.toAutoScaledFont,
                              color: const Color(0xFF111111),
                              fontWeight: FontWeight.w600,
                            ),
                            suffixIcon: state is EnterPassword
                                ? IconButton(
                                    onPressed: () {
                                      BlocProvider.of<LoginBloc>(context).add(
                                        ShowPasswordPressed(),
                                      );
                                    },
                                    icon: state.showPassword
                                        ? const Icon(Icons.visibility,
                                            color: Color(0xFF757575))
                                        : const Icon(Icons.visibility_off,
                                            color: Color(0xFF757575)))
                                : null,
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
                        state is EnterPassword
                            ? SizedBox(
                                height: 30.toAutoScaledHeight,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      state.error ?? '',
                                      style: GoogleFonts.lato(
                                        fontSize: 10.toAutoScaledFont,
                                        color: const Color(0xFF2F2F2F),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    if (state is! ForgotPasswordState)
                                      TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          'Forgot Password?',
                                          style: GoogleFonts.lato(
                                            fontSize: 10.toAutoScaledFont,
                                            color: const Color(0xFF2F2F2F),
                                            fontWeight: FontWeight.w400,
                                            textStyle: const TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              )
                            : 20.toVerticalSizedBox,
                        Center(
                          child: LoginButton(
                            text: state is EnterPassword ? 'Login' : 'Next',
                            onPressed: () {
                              state is EnterPassword
                                  ? context.read<LoginBloc>().add(LoginPressed(
                                      _controller.text, state.enrollmentNo))
                                  : state is ForgotPasswordState
                                      ? context.read<LoginBloc>().add(
                                          SendPasswordResetInstructions(
                                              emailId: state.emailID))
                                      : context
                                          .read<LoginBloc>()
                                          .add(NextPressed(_controller.text));
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              TextButton(
                onPressed: () async {
                  final Uri url = Uri.parse(AppConstants.issueUrl);
                  if (!await launchUrl(url)) {
                    // TODO: show dialog box
                  }
                },
                child: Text(
                  'Raise a Query',
                  style: GoogleFonts.inter(
                    fontSize: 12.toAutoScaledFont,
                    color: const Color(0xFF008BFF),
                    fontWeight: FontWeight.w400,
                    textStyle: const TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              const MadeByMDG(),
            ],
          ),
        ),
      ),
    );
  }
}
