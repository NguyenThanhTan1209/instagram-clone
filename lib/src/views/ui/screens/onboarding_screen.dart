import 'package:flutter/material.dart';
import 'package:steps_indicator/steps_indicator.dart';

import '../../../business_logic/models/onboarding_content.dart';
import '../../utils/color_constant.dart';
import '../../utils/dimension_constant.dart';
import '../../utils/string_constant.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<OnboardingContent> _onboardingContents = <OnboardingContent>[
    OnboardingContent(
      imagePath: 'assets/images/onboarding_image_1.png',
      content: 'Create your Profile',
    ),
    OnboardingContent(
      imagePath: 'assets/images/onboarding_image_2.png',
      content: 'Upload Photos & Videos',
    ),
    OnboardingContent(
      imagePath: 'assets/images/onboarding_image_3.png',
      content: 'Explore & Connect',
    ),
    OnboardingContent(
      imagePath: 'assets/images/onboarding_image_4.png',
      content: 'Connect With Friends & Socialize',
    ),
  ];
  int _currentIndex = 0;
  late PageController _onboardingController;

  bool _isLastCurrent() => _currentIndex == _onboardingContents.length - 1;

  @override
  void initState() {
    super.initState();
    _onboardingController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _onboardingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: DimensionConstant.SIZE_256,
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: PageView.builder(
                controller: _onboardingController,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      Image.asset(_onboardingContents[index].imagePath),
                      const SizedBox(height: DimensionConstant.SIZE_50),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: DimensionConstant.SIZE_51,
                        ),
                        child: Text(
                          _onboardingContents[index].content,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: DimensionConstant.SIZE_24),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                },
                itemCount: _onboardingContents.length,
                onPageChanged: (int value) {
                  // print(value);
                  setState(() {
                    _currentIndex = value;
                  });
                },
              ),
            ),
            StepsIndicator(
              undoneLineColor: ColorConstant.C4C4C4,
              doneLineThickness: DimensionConstant.SIZE_2,
              undoneLineThickness: DimensionConstant.SIZE_2,
              doneLineColor: ColorConstant.F50057,
              nbSteps: _onboardingContents.length,
              doneStepColor: ColorConstant.F50057,
              selectedStepColorIn: ColorConstant.F50057,
              selectedStepColorOut: ColorConstant.F50057,
              unselectedStepColorIn: ColorConstant.C8C8C8,
              unselectedStepColorOut: ColorConstant.C8C8C8,
              unselectedStepSize: DimensionConstant.SIZE_8,
              selectedStepSize: DimensionConstant.SIZE_8,
              selectedStep: _currentIndex,
            ),
            const SizedBox(
              height: DimensionConstant.SIZE_28,
            ),
            Container(
              height: DimensionConstant.SIZE_44,
              width: DimensionConstant.SIZE_178, // height of the button
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(DimensionConstant.SIZE_16),
                // shape makes the circular button
                gradient: LinearGradient(
                  // gives the Gradient color
                  colors: _isLastCurrent()
                      ? <Color>[
                          ColorConstant.FF833AB4,
                          ColorConstant.FD1D1D,
                          ColorConstant.FCB045,
                        ]
                      : <Color>[
                          ColorConstant.BC4E9C,
                          ColorConstant.F80759,
                        ],
                ),
              ),
              child: ElevatedButton(
                onPressed: () {
                  if (_currentIndex < _onboardingContents.length) {
                    setState(() {
                      _onboardingController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.linear,
                      );
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: DimensionConstant.SIZE_16,
                    vertical: DimensionConstant.SIZE_10,
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    const Spacer(),
                    Text(
                      _isLastCurrent()
                          ? StringConstant.GET_STARTED_LABEL
                          : StringConstant.NEXT_LABEL,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: ColorConstant.WHITE),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward,
                      size: DimensionConstant.SIZE_18,
                      color: ColorConstant.WHITE,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: DimensionConstant.SIZE_36),
            Opacity(
              opacity: _isLastCurrent()
                  ? DimensionConstant.SIZE_1
                  : DimensionConstant.SIZE_0,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorConstant.WHITE,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: ColorConstant.FF3C3C43
                          .withOpacity(DimensionConstant.SIZE_0_POINT_29),
                      offset: const Offset(
                        DimensionConstant.SIZE_0,
                        DimensionConstant.SIZE_NEGATIVE_0_POINT_33,
                      ),
                    ),
                  ],
                ),
                padding: const EdgeInsets.only(top: DimensionConstant.SIZE_18, bottom: DimensionConstant.SIZE_30),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: <InlineSpan>[
                      TextSpan(
                        text: StringConstant
                            .AGREE_TO_OUR_TERM_AND_PRIVACY_POLICY_CTA_LABEL,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: DimensionConstant.SIZE_10,
                              color: ColorConstant.BLACK.withOpacity(
                                DimensionConstant.SIZE_0_POINT_40,
                              ),
                            ),
                      ),
                      const TextSpan(text: '\n'),
                      TextSpan(
                        text: StringConstant.TERM_AND_PRIVACY_POLICY_LABEL,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: DimensionConstant.SIZE_10,
                              fontWeight: FontWeight.w600,
                              color: ColorConstant.BLACK.withOpacity(
                                DimensionConstant.SIZE_0_POINT_40,
                              ),
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
