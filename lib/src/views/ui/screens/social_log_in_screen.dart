import 'package:flutter/material.dart';

import '../../utils/color_constant.dart';
import '../../utils/dimension_constant.dart';
import '../../utils/path_constant.dart';
import '../../utils/string_constant.dart';
import '../widgets/horizontal_or_line_widget.dart';
import '../widgets/outline_sign_in_button_widget.dart';
import '../widgets/sign_in_button_widget.dart';
import '../widgets/sign_in_footer_widget.dart';

class SocialLogInScreen extends StatelessWidget {
  const SocialLogInScreen({super.key});

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
                const SizedBox(
                  height: DimensionConstant.SIZE_113,
                ),
                SignInButtonWidget(
                  onPressed: () {},
                  iconPath: PathConstant.FACEBOOK_ICON_PATH,
                  title: StringConstant.LOG_IN_WITH_FACEBOOK_TITLE,
                  backgroundColor: ColorConstant.FF3797EF,
                  textColor: ColorConstant.WHITE,
                ),
                const SizedBox(height: DimensionConstant.SIZE_26),
                const HorizontalOrLineWidget(),
                const SizedBox(height: DimensionConstant.SIZE_26),
                OutlineSignInButtonWidget(
                  onPressed: () {},
                  title: StringConstant.SIGN_IN_WITH_GOOGLE_TITLE,
                  iconPath: PathConstant.GOOGLE_ICON_PATH,
                ),
              ],
            ),
          ),
          SignInFooterWidget(
            label: StringConstant.DONT_HAVE_AN_ACCOUNT_LABEL,
            actionLabel: StringConstant.SIGN_UP_LABEL,
            actionColor: ColorConstant.FF3797EF,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
