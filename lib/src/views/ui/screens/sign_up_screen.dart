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
import '../widgets/outline_sign_in_button_widget.dart';
import '../widgets/sign_in_footer_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _repasswordController;
  late bool _isHidePassword;
  late bool _isemailValid;
  late bool _isPasswordValid;
  late bool _isRePasswordValid;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _repasswordController = TextEditingController();
    _isHidePassword = true;
    checkValid();
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

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _repasswordController.dispose();
  }

  void navigateToSocialLogInScreeen() {
    Navigator.of(context).pushNamed(RouteConstant.LOG_IN_SCREEN_ROUTE);
  }

  void checkValid() {
    _isemailValid = _validateEmail(_emailController.text);
    _isPasswordValid = _validatePassword(_passwordController.text);
    _isRePasswordValid = (_repasswordController.text.trim().length ==
            _passwordController.text.trim().length) &&
        (_repasswordController.text
            .trim()
            .contains(_passwordController.text.trim()));
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

  void onRePasswordChanged(String value) {
    setState(() {
      _isRePasswordValid =
          _repasswordController.text.trim() == _passwordController.text.trim();
    });
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

  void signUpEvent(String email, String password) {
    if (!_isemailValid) {
      _buildSnackbar(
        title: 'Sign up failed',
        message: 'Email is not incorrect format. Try again.',
        contentType: ContentType.failure,
      );
      return;
    }
    if (!_isPasswordValid) {
      _buildSnackbar(
        title: 'Sign up failed',
        message:
            'Password >= 8 characters, uppercase, lowercase, number, special',
        contentType: ContentType.failure,
      );
      return;
    }
    if (!_isRePasswordValid) {
      _buildSnackbar(
        title: 'Sign up failed',
        message: 'Re-enter the password incorrectly. Try again.',
        contentType: ContentType.failure,
      );
      return;
    }
    context.read<AuthenticationBloc>().add(
          SignUpWithEmailAndPassword(email: email, password: password),
        );
  }

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: deviceHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const Spacer(),
                Column(
                  mainAxisSize: MainAxisSize.min,
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
                    _buildPasswordTextField(
                      context,
                      StringConstant.PASSWORD_LABEL,
                      _passwordController,
                      onPasswordChanged,
                    ),
                    const SizedBox(
                      height: DimensionConstant.SIZE_12,
                    ),
                    _buildPasswordTextField(
                      context,
                      StringConstant.REPASSWORD_LABEL,
                      _repasswordController,
                      onRePasswordChanged,
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
                          signUpEvent(
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
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
                        child: BlocConsumer<AuthenticationBloc,
                            AuthenticationState>(
                          listener: (
                            BuildContext context,
                            AuthenticationState state,
                          ) {
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
                          builder: (
                            BuildContext context,
                            AuthenticationState state,
                          ) {
                            if (state is AuthenticationInProgress) {
                              return const CircularProgressIndicator(
                                color: ColorConstant.WHITE,
                              );
                            }
                            return Text(
                              StringConstant.SIGN_UP_LABEL,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: DimensionConstant.SIZE_14,
                                    color: ColorConstant.WHITE,
                                  ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: DimensionConstant.SIZE_26,
                    ),
                    OutlineSignInButtonWidget(
                      onPressed: _navigateToSignUpWithPhoneScreen,
                      title: StringConstant.SIGN_UP_WITH_PHONE_LABEL,
                      iconPath: '',
                    ),
                  ],
                ),
                const Spacer(),
                SignInFooterWidget(
                  label: StringConstant.ALREADY_HAVE_AN_ACCOUNT_LABEL,
                  actionLabel: StringConstant.SIGN_IN_LABEL,
                  actionColor: ColorConstant.FF262626,
                  onPressed: navigateToSocialLogInScreeen,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordTextField(
    BuildContext context,
    String label,
    TextEditingController controller,
    Function(String)? onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: DimensionConstant.SIZE_16,
      ),
      child: TextField(
        onChanged: onChanged,
        obscureText: _isHidePassword,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: DimensionConstant.SIZE_14,
              color: ColorConstant.FF262626,
            ),
        cursorColor: ColorConstant.BLACK,
        controller: controller,
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
          hintText: label,
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

  Widget _buildemailTextField(BuildContext context) {
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

  void _navigateToSignUpWithPhoneScreen() {
    Navigator.of(context).pop();
  }
}
