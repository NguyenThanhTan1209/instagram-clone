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
import '../widgets/sign_in_footer_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController _userNameController;
  late TextEditingController _passwordController;
  late TextEditingController _repasswordController;
  late bool _isHidePassword;
  late bool _isUsernameValid;
  late bool _isPasswordValid;
  late bool _isRePasswordValid;

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();
    _repasswordController = TextEditingController();
    _isHidePassword = true;
    _isUsernameValid = _userNameController.text.trim().contains('@') &&
        _userNameController.text.trim().contains('.');
    _isPasswordValid = _passwordController.text.trim().length >= 6;
    _isRePasswordValid =
        _repasswordController.text.trim() == _passwordController.text.trim();
  }

  @override
  void dispose() {
    super.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    _repasswordController.dispose();
  }

  void navigateToSocialLogInScreeen() {
    Navigator.of(context).pushNamed(RouteConstant.LOG_IN_SCREEN_ROUTE);
  }

  void checkValid() {
    _isUsernameValid = _userNameController.text.trim().isNotEmpty &&
        _userNameController.text.trim().contains('@') &&
        _userNameController.text.trim().contains('.');
    _isPasswordValid = _passwordController.text.trim().isNotEmpty &&
        _passwordController.text.trim().length >= 6;
    _isRePasswordValid =
        _repasswordController.text.trim() == _passwordController.text.trim();
  }

  void onUsernameChanged(String value) {
    setState(() {
      checkValid();
    });
  }

  void onPasswordChanged(String value) {
    setState(() {
      checkValid();
    });
  }

  void onRePasswordChanged(String value) {
    setState(() {
      checkValid();
    });
  }

  void signUpEvent(String username, String password) {
    if (_isUsernameValid && _isPasswordValid && _isRePasswordValid) {
      context.read<AuthenticationBloc>().add(
            SignUpWithEmailAndPassword(username: username, password: password),
          );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(StringConstant.SIGN_UP_INFO_NOT_VALID_MESSAGE),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  PathConstant.INSTA_BLACK_LOGO_PATH,
                  width: DimensionConstant.SIZE_175,
                  height: DimensionConstant.SIZE_50,
                ),
                const SizedBox(height: DimensionConstant.SIZE_40),
                _buildUsernameTextField(context),
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
                        _userNameController.text.trim(),
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
                          ScaffoldMessenger.of(context).showSnackBar(
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
                          StringConstant.SIGN_UP_LABEL,
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
              ],
            ),
          ),
          SignInFooterWidget(
            label: StringConstant.ALREADY_HAVE_AN_ACCOUNT_LABEL,
            actionLabel: StringConstant.SIGN_IN_LABEL,
            actionColor: ColorConstant.FF262626,
            onPressed: navigateToSocialLogInScreeen,
          ),
        ],
      ),
    );
  }

  Padding _buildPasswordTextField(
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

  Padding _buildUsernameTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: DimensionConstant.SIZE_16,
      ),
      child: TextField(
        autofocus: true,
        onChanged: onUsernameChanged,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: DimensionConstant.SIZE_14,
              color: ColorConstant.FF262626,
            ),
        cursorColor: ColorConstant.BLACK,
        controller: _userNameController,
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
          hintText: StringConstant.USERNAME_LABEL,
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: ColorConstant.C8C8C8,
                fontSize: DimensionConstant.SIZE_14,
              ),
          contentPadding: EdgeInsets.zero,
          suffixIcon: Visibility(
            visible: _isUsernameValid,
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
}
