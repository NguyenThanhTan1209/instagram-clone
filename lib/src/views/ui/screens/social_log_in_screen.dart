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
import '../widgets/outline_sign_in_button_widget.dart';
import '../widgets/sign_in_button_widget.dart';
import '../widgets/sign_in_footer_widget.dart';

class SocialLogInScreen extends StatelessWidget {
  const SocialLogInScreen({super.key});

  @override
  Widget build(BuildContext context) {

    void signInWithGoogle() {
      context.read<AuthenticationBloc>().add(SignInWithGoogle());
    }

    void signInWithFacebook() {
      context.read<AuthenticationBloc>().add(SignInWithFacebook());
    }
    
    return Scaffold(
      body: SafeArea(
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (BuildContext context, AuthenticationState state) {
            if (state is AuthenticationInProgress) {
              showDialog(
                context: context,
                builder: (BuildContext context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (state is AuthenticationSuccess) {
              Navigator.of(context).pop();
              final SnackBar snackBar = SnackBar(
                elevation: 0,
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Success',
                  message: 'Login successfully',
                  contentType: ContentType.success,
                ),
              );
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(snackBar);
              Navigator.of(context).pushNamedAndRemoveUntil(
                RouteConstant.HOME_SCREEN_ROUTE,
                (Route<dynamic> route) => false,
              );
            }
            if (state is AuthenticationFailed) {
              Navigator.of(context).pop();
              final SnackBar snackBar = SnackBar(
                elevation: 0,
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Failed',
                  message: 'Login with failed. Please try again.',
                  contentType: ContentType.failure,
                ),
              );
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(snackBar);
            }
          },
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
                      height: DimensionConstant.SIZE_113,
                    ),
                    SignInButtonWidget(
                      onPressed: signInWithFacebook,
                      iconPath: PathConstant.FACEBOOK_ICON_PATH,
                      title: StringConstant.LOG_IN_WITH_FACEBOOK_TITLE,
                      backgroundColor: ColorConstant.FF3797EF,
                      textColor: ColorConstant.WHITE,
                    ),
                    const SizedBox(height: DimensionConstant.SIZE_26),
                    const HorizontalOrLineWidget(),
                    const SizedBox(height: DimensionConstant.SIZE_26),
                    OutlineSignInButtonWidget(
                      onPressed: signInWithGoogle,
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
        ),
      ),
    );
  }
}
