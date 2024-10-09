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

class SignUpWithPhoneScreen extends StatefulWidget {
  const SignUpWithPhoneScreen({super.key});

  @override
  State<SignUpWithPhoneScreen> createState() => _SignUpWithPhoneScreenState();
}

class _SignUpWithPhoneScreenState extends State<SignUpWithPhoneScreen> {
  late TextEditingController _phoneNumberController;

  bool _isPhoneNumberValid() {
    final String phoneNumber = _phoneNumberController.text;
    if (phoneNumber.length != 10) {
      return false;
    }
    if (phoneNumber.contains(RegExp(r'^(?:[+0]9)?[0-9]{10}$'))) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    _phoneNumberController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _phoneNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                  const SizedBox(height: DimensionConstant.SIZE_40),
                  _buildPhoneNumberTextField(context),
                  const SizedBox(
                    height: DimensionConstant.SIZE_30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimensionConstant.SIZE_16,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        _signUp(_phoneNumberController.text);
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
                          if (state is VerifyPhoneNumberSucess) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              RouteConstant.SEND_OTP_SCREEN_ROUTE,
                              arguments: state.verificationId,
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
                            StringConstant.SIGN_IN_LABEL,
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
                    height: DimensionConstant.SIZE_26,
                  ),
                  OutlineSignInButtonWidget(
                    onPressed: _navigateToSignUpWithEmailScreen,
                    title: StringConstant.SIGN_UP_WITH_EMAIL_LABEL,
                    iconPath: '',
                  ),
                ],
              ),
            ),
            SignInFooterWidget(
              label: StringConstant.ALREADY_HAVE_AN_ACCOUNT_LABEL,
              actionLabel: StringConstant.SIGN_IN_LABEL,
              actionColor: ColorConstant.FF262626,
              onPressed: _navigateToSocialLogInScreeen,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToSocialLogInScreeen() {
    Navigator.of(context).pushNamed(RouteConstant.LOG_IN_SCREEN_ROUTE);
  }

  Widget _buildPhoneNumberTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: DimensionConstant.SIZE_16,
      ),
      child: TextField(
        autofocus: true,
        keyboardType: TextInputType.phone,
        onChanged: onPhoneNumberChanged,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: DimensionConstant.SIZE_14,
              color: ColorConstant.FF262626,
            ),
        cursorColor: ColorConstant.BLACK,
        controller: _phoneNumberController,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.phone, color: ColorConstant.C8C8C8),
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
          hintText: StringConstant.PHONE_NUMBER_LABEL,
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: ColorConstant.C8C8C8,
                fontSize: DimensionConstant.SIZE_14,
              ),
          contentPadding: EdgeInsets.zero,
          suffixIcon: Visibility(
            visible: _isPhoneNumberValid(),
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

  void _navigateToSignUpWithEmailScreen() {
    Navigator.of(context).pushNamed(RouteConstant.SIGN_UP_SCREEN_ROUTE);
  }

  void onPhoneNumberChanged(String value) {
    setState(() {
      _isPhoneNumberValid();
    });
  }

  void _signUp(String phoneNumber) {
    String standardPhoneNumber = phoneNumber;
    if (standardPhoneNumber.startsWith('0')) {
      standardPhoneNumber =
          standardPhoneNumber.replaceFirst(RegExp(r'0'), '+84');
    }
    context
        .read<AuthenticationBloc>()
        .add(VerifyWithPhoneNumber(phoneNumber: standardPhoneNumber));
  }
}
