import 'package:flutter/material.dart';

import '../../../business_logic/models/user.dart';
import '../../utils/color_constant.dart';
import '../../utils/dimension_constant.dart';
import '../../utils/string_constant.dart';
import '../widgets/edit_profile_text_field_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _usernameController;
  late final TextEditingController _websiteController;
  late final TextEditingController _bioController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _genderController;
  final List<String> _genders = <String>[
    'Male',
    'Female',
    'Other',
  ];
  String _currentSelectedGenderValue = '';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _usernameController = TextEditingController();
    _websiteController = TextEditingController();
    _bioController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _genderController = TextEditingController();
    // _userProfile =
    //     ModalRoute.of(context)!.settings.arguments! as User;
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _usernameController.dispose();
    _websiteController.dispose();
    _bioController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _genderController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserModel userProfile =
        ModalRoute.of(context)!.settings.arguments! as UserModel;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorConstant.FAFAFA,
        title: Text(
          StringConstant.EDIT_PROFILE_BUTTON_LABEL,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: DimensionConstant.SIZE_16,
              ),
        ),
        leading: InkWell(
          onTap: () {},
          child: Center(
            child: Text(
              StringConstant.CANCEL_LABEL,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: DimensionConstant.SIZE_16,
                  ),
            ),
          ),
        ),
        actions: <Widget>[
          InkWell(
            onTap: () {},
            child: Text(
              StringConstant.COMPLETE_LABEL,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: DimensionConstant.SIZE_16,
                    color: ColorConstant.FF3897F0,
                  ),
            ),
          ),
        ],
      ),
      body: Form(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: DimensionConstant.SIZE_18_POINT_5,
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CircleAvatar(
                      radius: DimensionConstant.SIZE_95,
                      foregroundImage: NetworkImage(userProfile.avatarPath),
                    ),
                    const SizedBox(
                      height: DimensionConstant.SIZE_12_POINT_5,
                    ),
                    InkWell(
                      child: Text(
                        StringConstant.CHANGE_PROFILE_PHOTO_LABEL,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: DimensionConstant.SIZE_13,
                              color: ColorConstant.FF3897F0,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: DimensionConstant.SIZE_12_POINT_5,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: DimensionConstant.SIZE_16,
                ),
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: ColorConstant.FF3C3C43.withOpacity(
                        DimensionConstant.SIZE_0_POINT_30,
                      ),
                    ),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    EditProfileTextFieldWidget(
                      label: StringConstant.EDIT_NAME_LABEL,
                      placeholder: StringConstant.EDIT_NAME_PLACEHOLDER,
                      controller: _nameController,
                    ),
                    EditProfileTextFieldWidget(
                      label: StringConstant.EDIT_USERNAME_LABEL,
                      placeholder: StringConstant.EDIT_USERNAME_PLACEHOLDER,
                      controller: _usernameController,
                    ),
                    EditProfileTextFieldWidget(
                      label: StringConstant.EDIT_WEBSITE_LABEL,
                      placeholder: StringConstant.EDIT_WEBSITE_PLACEHOLDER,
                      controller: _websiteController,
                    ),
                    EditProfileTextFieldWidget(
                      label: StringConstant.EDIT_BIO_LABEL,
                      placeholder: StringConstant.EDIT_BIO_PLACEHOLDER,
                      controller: _bioController,
                      isExpand: true,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: DimensionConstant.SIZE_16,
                ),
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: ColorConstant.FF3C3C43.withOpacity(
                        DimensionConstant.SIZE_0_POINT_30,
                      ),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(
                      height: DimensionConstant.SIZE_16,
                    ),
                    Text(
                      StringConstant.SWITCH_PRO_ACCOUNT_LABEL,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: DimensionConstant.SIZE_15,
                            color: ColorConstant.FF3897F0,
                          ),
                    ),
                    const SizedBox(
                      height: DimensionConstant.SIZE_29,
                    ),
                    Text(
                      StringConstant.PRIVATE_INFO_LABEL,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: DimensionConstant.SIZE_15,
                          ),
                    ),
                    const SizedBox(
                      height: DimensionConstant.SIZE_14,
                    ),
                    EditProfileTextFieldWidget(
                      label: StringConstant.EDIT_EMAIL_LABEL,
                      placeholder: StringConstant.EDIT_EMAIL_PLACEHOLDER,
                      controller: _emailController,
                    ),
                    EditProfileTextFieldWidget(
                      label: StringConstant.EDIT_PHONE_LABEL,
                      placeholder: StringConstant.EDIT_PHONE_PLACEHOLDER,
                      controller: _phoneController,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: DimensionConstant.SIZE_96,
                          child: Text(
                            StringConstant.EDIT_GENDER_LABEL,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: DimensionConstant.SIZE_15),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: DimensionConstant.SIZE_16,
                            ),
                            child: Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  // ignore: require_trailing_commas
                                  bottom: BorderSide(
                                    width: DimensionConstant.SIZE_1_POINT_5,
                                    color: ColorConstant.C5C5C7,
                                  ),
                                ),
                              ),
                              child: DropdownButton<String>(
                                iconSize: DimensionConstant.SIZE_0,
                                items: _genders.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                hint: _currentSelectedGenderValue.isEmpty
                                    ? Text(
                                        StringConstant.EDIT_GENDER_PLACEHOLDER,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              fontSize:
                                                  DimensionConstant.SIZE_16,
                                              color: ColorConstant.C5C5C7,
                                            ),
                                      )
                                    : Text(
                                        _currentSelectedGenderValue,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              fontSize:
                                                  DimensionConstant.SIZE_16,
                                            ),
                                      ),
                                underline: const SizedBox(),
                                isExpanded: true,
                                onChanged: (String? value) {
                                  if (value != null) {
                                    setState(() {
                                      _currentSelectedGenderValue = value;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: DimensionConstant.SIZE_80_POINT_5,
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
}
