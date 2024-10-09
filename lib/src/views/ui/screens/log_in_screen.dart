import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/blocs/authentication/authentication_bloc.dart';
import '../../../business_logic/blocs/authentication/authentication_event.dart';
import '../../../business_logic/blocs/authentication/authentication_state.dart';
import '../../utils/color_constant.dart';
import '../../utils/dimension_constant.dart';
import '../../utils/path_constant.dart';
import '../../utils/route_constant.dart';
import '../../utils/string_constant.dart';
import '../widgets/horizontal_or_line_widget.dart';
import '../widgets/sign_in_footer_widget.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late bool _isHidePassword;
  late bool _isemailValid;
  late bool _isPasswordValid;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _isHidePassword = true;
    _checkValid();
  }

  void _checkValid() {
    _isemailValid = _validateEmail(_emailController.text);
    _isPasswordValid = _validatePassword(_passwordController.text);
  }

  bool _validateEmail(String email) {
    final RegExp emailRegExp =
        RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');
    return emailRegExp.hasMatch(email);
  }

  bool _validatePassword(String password) {
    // Quy tắc độ dài tối thiểu
    if (password.length < 8) {
      return false;
    }
    // Quy tắc phức tạp
    final bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    final bool hasNumbers = password.contains(RegExp(r'[0-9]'));
    final bool hasSpecialCharacters =
        password.contains(RegExp(r'[!@#$%^&*()_+]'));

    if (!hasUppercase ||
        !hasLowercase ||
        !hasNumbers ||
        !hasSpecialCharacters) {
      return false;
    }
    return true;
  }

  void onEmailChanged(String value) {
    setState(() {
      _isemailValid = _validateEmail(value);
    });
  }

  void onPasswordChanged(String value) {
    setState(() {
      _isPasswordValid = _validatePassword(value);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void _navigateToSocialLogInScreen() {
    Navigator.of(context).pushNamed(RouteConstant.SOCIAL_LOG_IN_SCREEN_ROUTE);
  }

  void _logIn(BuildContext context, String email, String password) {
    if (!_isemailValid) {
      _buildSnackbar(
        title: 'Log in failed',
        message: 'Email is not incorrect format. Try again.',
        contentType: ContentType.failure,
      );
      return;
    }
    if (!_isPasswordValid) {
      _buildSnackbar(
        title: 'Log in failed',
        message:
            'Password >= 8 characters, uppercase, lowercase, number, special',
        contentType: ContentType.failure,
      );
      return;
    }
    context.read<AuthenticationBloc>().add(
          SignInWithEmailAndPassword(email: email, password: password),
        );
  }

  void _buildSnackbar({
    required String title,
    required String message,
    required ContentType contentType,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: title,
            message: message,
            contentType: contentType,
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.WHITE,
        leading: GestureDetector(
          onTap: _navigateBack,
          child:
              const Icon(Icons.chevron_left_sharp, color: ColorConstant.BLACK),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: DimensionConstant.SIZE_78),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  PathConstant.INSTA_BLACK_LOGO_PATH,
                  width: DimensionConstant.SIZE_175,
                  height: DimensionConstant.SIZE_50,
                ),
                const SizedBox(height: DimensionConstant.SIZE_40),
                _buildemailTextField(context),
                const SizedBox(
                  height: DimensionConstant.SIZE_12,
                ),
                _buildPasswordTextField(context),
                const SizedBox(height: DimensionConstant.SIZE_19),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DimensionConstant.SIZE_16,
                  ),
                  child: GestureDetector(
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        StringConstant.FORGOT_PASSWORD_LABEL,
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                                  color: ColorConstant.FF3797EF,
                                  fontSize: DimensionConstant.SIZE_12,
                                ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: DimensionConstant.SIZE_30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DimensionConstant.SIZE_16,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      _logIn(
                        context,
                        _emailController.text,
                        _passwordController.text,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize:
                          const Size.fromHeight(DimensionConstant.SIZE_44),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          DimensionConstant.SIZE_16,
                        ),
                      ),
                      backgroundColor: ColorConstant.FF3797EF,
                      foregroundColor: ColorConstant.WHITE,
                      disabledBackgroundColor: ColorConstant.FF3797EF
                          .withOpacity(DimensionConstant.SIZE_0_POINT_5),
                      disabledForegroundColor: ColorConstant.WHITE
                          .withOpacity(DimensionConstant.SIZE_0_POINT_5),
                    ),
                    child:
                        BlocConsumer<AuthenticationBloc, AuthenticationState>(
                      listener:
                          (BuildContext context, AuthenticationState state) {
                        if (state is AuthenticationSuccess) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            RouteConstant.HOME_SCREEN_ROUTE,
                            arguments: state.user,
                            (Route<dynamic> route) => false,
                          );
                        }
                        if (state is AuthenticationFailed) {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content: Text(state.error),
                              ),
                            );
                        }
                      },
                      builder:
                          (BuildContext context, AuthenticationState state) {
                        if (state is AuthenticationInProgress) {
                          return const CircularProgressIndicator(
                            color: ColorConstant.WHITE,
                          );
                        }
                        return Text(
                          StringConstant.LOG_INT_LABEL,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: DimensionConstant.SIZE_14,
                                    color: ColorConstant.WHITE,
                                  ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: DimensionConstant.SIZE_37,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      PathConstant.FACEBOOK_ICON_PATH,
                      width: DimensionConstant.SIZE_17,
                      height: DimensionConstant.SIZE_17,
                    ),
                    const SizedBox(
                      width: DimensionConstant.SIZE_10,
                    ),
                    Text(
                      StringConstant.LOG_IN_WITH_FACEBOOK_TITLE,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: ColorConstant.FF3797EF,
                            fontSize: DimensionConstant.SIZE_14,
                          ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: DimensionConstant.SIZE_41_POINT_5,
                ),
                const HorizontalOrLineWidget(),
                const SizedBox(
                  height: DimensionConstant.SIZE_41_POINT_5,
                ),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: DimensionConstant.SIZE_14),
                    children: <InlineSpan>[
                      TextSpan(
                        text: StringConstant.DONT_HAVE_AN_ACCOUNT_LABEL,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: ColorConstant.BLACK.withOpacity(
                                DimensionConstant.SIZE_0_POINT_40,
                              ),
                            ),
                      ),
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () {},
                          child: Text(
                            StringConstant.SIGN_UP_LABEL,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: ColorConstant.FF3797EF,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SignInFooterWidget(
              label: '',
              actionLabel: StringConstant.GOOGLE_OR_FACEBOOK,
              actionColor: ColorConstant.BLACK
                  .withOpacity(DimensionConstant.SIZE_0_POINT_40),
              onPressed: _navigateToSocialLogInScreen,
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildPasswordTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: DimensionConstant.SIZE_16,
      ),
      child: TextField(
        onChanged: onPasswordChanged,
        obscureText: _isHidePassword,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: DimensionConstant.SIZE_14,
              color: ColorConstant.FF262626,
            ),
        cursorColor: ColorConstant.BLACK,
        controller: _passwordController,
        decoration: InputDecoration(
          prefixIcon: Image.asset(
            PathConstant.PASSWORD_LOCK_ICON_PATH,
            width: DimensionConstant.SIZE_24,
            height: DimensionConstant.SIZE_24,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DimensionConstant.SIZE_16),
            borderSide: BorderSide(
              color: ColorConstant.BLACK
                  .withOpacity(DimensionConstant.SIZE_0_POINT_10),
              width: DimensionConstant.SIZE_0_POINT_5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DimensionConstant.SIZE_16),
            borderSide: BorderSide(
              color: ColorConstant.BLACK
                  .withOpacity(DimensionConstant.SIZE_0_POINT_10),
              width: DimensionConstant.SIZE_0_POINT_5,
            ),
          ),
          filled: true,
          fillColor: ColorConstant.FAFAFA,
          hintText: StringConstant.PASSWORD_LABEL,
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: ColorConstant.C8C8C8,
                fontSize: DimensionConstant.SIZE_14,
              ),
          contentPadding: EdgeInsets.zero,
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _isHidePassword = !_isHidePassword;
              });
            },
            child: Image.asset(
              _isHidePassword
                  ? PathConstant.PASSWORD_HIDDEN_EYE_ICON_PATH
                  : PathConstant.PASSWORD_SHOWN_EYE_ICON_PATH,
              width: DimensionConstant.SIZE_20,
              height: DimensionConstant.SIZE_20,
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildemailTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: DimensionConstant.SIZE_16,
      ),
      child: TextField(
        autofocus: true,
        onChanged: onEmailChanged,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: DimensionConstant.SIZE_14,
              color: ColorConstant.FF262626,
            ),
        cursorColor: ColorConstant.BLACK,
        controller: _emailController,
        decoration: InputDecoration(
          prefixIcon: Image.asset(
            PathConstant.USER_ICON_PATH,
            width: DimensionConstant.SIZE_24,
            height: DimensionConstant.SIZE_24,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DimensionConstant.SIZE_16),
            borderSide: BorderSide(
              color: ColorConstant.BLACK
                  .withOpacity(DimensionConstant.SIZE_0_POINT_10),
              width: DimensionConstant.SIZE_0_POINT_5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DimensionConstant.SIZE_16),
            borderSide: BorderSide(
              color: ColorConstant.BLACK
                  .withOpacity(DimensionConstant.SIZE_0_POINT_10),
              width: DimensionConstant.SIZE_0_POINT_5,
            ),
          ),
          filled: true,
          fillColor: ColorConstant.FAFAFA,
          hintText: StringConstant.EMAIL_LABEL,
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: ColorConstant.C8C8C8,
                fontSize: DimensionConstant.SIZE_14,
              ),
          contentPadding: EdgeInsets.zero,
          suffixIcon: Visibility(
            visible: _isemailValid,
            child: Image.asset(
              PathConstant.GREEN_TICK_ICON_PATH,
              width: DimensionConstant.SIZE_20,
              height: DimensionConstant.SIZE_20,
            ),
          ),
        ),
      ),
    );
  }

  void _navigateBack() {
    Navigator.of(context).pop();
  }
}
