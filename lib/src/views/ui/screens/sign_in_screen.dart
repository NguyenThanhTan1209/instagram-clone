import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/color_constant.dart';
import '../../utils/dimension_constant.dart';
import '../../utils/path_constant.dart';
import '../../utils/route_constant.dart';
import '../../utils/string_constant.dart';
import '../widgets/horizontal_or_line_widget.dart';
import '../widgets/sign_in_button_widget.dart';
import '../widgets/sign_up_button_widget.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToSocialLogInScreeen(){
      Navigator.of(context).pushNamed(RouteConstant.SOCIAL_LOG_IN_SCREEN_ROUTE);
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
                SignUpButtonWidget(
                  onPressed: () {},
                  title: StringConstant.SIGN_UP_WITH_PHONE_AND_EMAIL_TITLE,
                ),
                const SizedBox(
                  height: DimensionConstant.SIZE_53,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: ColorConstant.WHITE,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        offset: const Offset(
                          DimensionConstant.SIZE_0,
                          DimensionConstant.SIZE_NEGATIVE_0_POINT_33,
                        ),
                        color: ColorConstant.FF3C3C43.withOpacity(
                          DimensionConstant.SIZE_0_POINT_29,
                        ),
                      ),
                    ],
                  ),
                  height: DimensionConstant.SIZE_84,
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: DimensionConstant.SIZE_18,
                      ),
                      RichText(
                        text: TextSpan(
                          children: <InlineSpan>[
                            TextSpan(
                              text:
                                  StringConstant.ALREADY_HAVE_AN_ACCOUNT_LABEL,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: ColorConstant.BLACK.withOpacity(
                                      DimensionConstant.SIZE_0_POINT_40,
                                    ),
                                  ),
                            ),
                            WidgetSpan(
                              child: InkWell(
                                onTap: () {
                                  navigateToSocialLogInScreeen();
                                },
                                child: Text(
                                  StringConstant.SIGN_IN_LABEL,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: ColorConstant.FF262626,
                                        fontSize: DimensionConstant.SIZE_12,
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
