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

class SendOTPScreen extends StatefulWidget {
  const SendOTPScreen({super.key});

  @override
  State<SendOTPScreen> createState() => _SendOTPScreenState();
}

class _SendOTPScreenState extends State<SendOTPScreen> {
  late TextEditingController _otpController;

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _otpController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String verificationId =
        ModalRoute.of(context)!.settings.arguments! as String;

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
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
                    _buildOTPTextField(context),
                    const SizedBox(
                      height: DimensionConstant.SIZE_30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: DimensionConstant.SIZE_16,
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          _signUp(verificationId, _otpController.text);
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
                      onPressed: _navigateToSignUpWithEmailScreen,
                      title: StringConstant.SIGN_UP_WITH_EMAIL_LABEL,
                      iconPath: '',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOTPTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: DimensionConstant.SIZE_16,
      ),
      child: TextField(
        autofocus: true,
        keyboardType: TextInputType.number,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: DimensionConstant.SIZE_14,
              color: ColorConstant.FF262626,
            ),
        cursorColor: ColorConstant.BLACK,
        controller: _otpController,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.input, color: ColorConstant.C8C8C8),
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
          hintText: StringConstant.OTP_LABEL,
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: ColorConstant.C8C8C8,
                fontSize: DimensionConstant.SIZE_14,
              ),
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }

  void _navigateToSignUpWithEmailScreen() {
    Navigator.of(context).pushNamed(RouteConstant.SIGN_UP_SCREEN_ROUTE);
  }

  void _signUp(String verificationId, String otpCode) {
    context.read<AuthenticationBloc>().add(
          SignUpWithPhoneNumber(
            otpCode: otpCode,
            verificationId: verificationId,
          ),
        );
  }

  Future<bool> _onBackPressed() async {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Sign up will be cancelled'),
        content: const Text('Are you sure you want to come back?'),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Yes'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('No'),
          ),
        ],
      ),
    );
    return false;
  }
}
