import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/color_constant.dart';
import '../../utils/dimension_constant.dart';
import '../../utils/path_constant.dart';
import '../../utils/route_constant.dart';
import '../../utils/string_constant.dart';
import '../widgets/horizontal_or_line_widget.dart';
import '../widgets/outline_sign_in_button_widget.dart';
import '../widgets/sign_in_button_widget.dart';
import '../widgets/sign_in_footer_widget.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToSocialLogInScreeen() {
      Navigator.of(context).pushNamed(RouteConstant.LOG_IN_SCREEN_ROUTE);
    }

    void navigateToSignUpScreen(){
      Navigator.of(context).pushNamed(RouteConstant.SIGN_UP_SCREEN_ROUTE);
    }

    return Scaffold(
      body: Center(
        child: Column(
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
                  const SizedBox(
                    height: DimensionConstant.SIZE_20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimensionConstant.SIZE_20,
                    ),
                    child: Text(
                      StringConstant.SIGN_IN_INTRODUCE_LABEL,
                      style: GoogleFonts.montserrat(
                        color: ColorConstant.FF8E8E93,
                        fontSize: DimensionConstant.SIZE_14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                SignInButtonWidget(
                  onPressed: () {},
                  iconPath: PathConstant.FACEBOOK_ICON_PATH,
                  title: StringConstant.LOG_IN_WITH_FACEBOOK_TITLE,
                  backgroundColor: ColorConstant.FF3797EF,
                  textColor: ColorConstant.WHITE,
                ),
                const SizedBox(
                  height: DimensionConstant.SIZE_26,
                ),
                const HorizontalOrLineWidget(),
                const SizedBox(
                  height: DimensionConstant.SIZE_26,
                ),
                OutlineSignInButtonWidget(
                  title: StringConstant.SIGN_UP_WITH_PHONE_AND_EMAIL_TITLE,
                  iconPath: '',
                  onPressed: navigateToSignUpScreen,
                ),
                const SizedBox(
                  height: DimensionConstant.SIZE_53,
                ),
                SignInFooterWidget(
                  label: StringConstant.ALREADY_HAVE_AN_ACCOUNT_LABEL,
                  actionLabel: StringConstant.SIGN_IN_LABEL,
                  actionColor: ColorConstant.FF262626,
                  onPressed: navigateToSocialLogInScreeen,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
