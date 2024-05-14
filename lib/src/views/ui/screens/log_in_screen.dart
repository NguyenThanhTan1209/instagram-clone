import 'package:flutter/material.dart';

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
  late TextEditingController _userNameController;
  late TextEditingController _passwordController;
  late bool _isHidePassword;
  final String _spacing = ' ';
  late bool _isValidLoginInfo;
  late bool _isUsernameValid;
  late bool _isPasswordValid;

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();
    _isHidePassword = true;
    _isUsernameValid = _userNameController.text.trim().isNotEmpty &&
        _userNameController.text.contains(_spacing);
    _isPasswordValid = _passwordController.text.trim().isNotEmpty;
    _isValidLoginInfo = false;
  }

  @override
  void dispose() {
    super.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
  }

  void _navigateToSocialLogInScreen() {
    Navigator.of(context).pushNamed(RouteConstant.SOCIAL_LOG_IN_SCREEN_ROUTE);
  }

  //? temp
  void _logIn(String username, String password) {
    if (username.trim().contains('tan_newc') &&
        password.trim().contains('123456@#')) {
      Navigator.of(context)
    .pushNamedAndRemoveUntil(RouteConstant.HOME_SCREEN_ROUTE, (Route<dynamic> route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Incorrect username or password'),
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
                    onPressed: _isValidLoginInfo
                        ? () {
                            _logIn(
                              _userNameController.text,
                              _passwordController.text,
                            );
                          }
                        : null,
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
                    child: Text(
                      StringConstant.LOG_INT_LABEL,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: DimensionConstant.SIZE_14,
                            color: ColorConstant.WHITE,
                          ),
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
          ),
          SignInFooterWidget(
            label: '',
            actionLabel: StringConstant.INSTAGRAM_OR_FACEBOOK,
            actionColor: ColorConstant.BLACK
                .withOpacity(DimensionConstant.SIZE_0_POINT_40),
            onPressed: _navigateToSocialLogInScreen,
          ),
        ],
      ),
    );
  }

  Padding _buildPasswordTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: DimensionConstant.SIZE_16,
      ),
      child: TextField(
        onChanged: (String value) {
          setState(() {
            _isPasswordValid = value.isNotEmpty;
            _isValidLoginInfo = _isUsernameValid && _isPasswordValid;
          });
        },
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

  Padding _buildUsernameTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: DimensionConstant.SIZE_16,
      ),
      child: TextField(
        onChanged: (String value) {
          setState(() {
            _isUsernameValid = value.isNotEmpty && !value.contains(_spacing);
            _isValidLoginInfo = _isUsernameValid && _isPasswordValid;
          });
        },
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
