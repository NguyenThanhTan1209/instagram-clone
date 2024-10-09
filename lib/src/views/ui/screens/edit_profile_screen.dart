import 'dart:developer';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../../business_logic/blocs/user/user_bloc.dart';
import '../../../business_logic/blocs/user/user_event.dart';
import '../../../business_logic/blocs/user/user_state.dart';
import '../../../business_logic/models/user.dart';
import '../../utils/color_constant.dart';
import '../../utils/dimension_constant.dart';
import '../../utils/path_constant.dart';
import '../../utils/string_constant.dart';
import '../widgets/edit_profile_text_field_widget.dart';

const String REGEX_CHECK_EMAIL =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+(.[a-zA-Z]+)?$";

const String REGEX_CHECK_WEBSITE =
    r'^(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$';

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
  final List<String> _genders = <String>[
    'Male',
    'Female',
    'Other',
  ];
  final ValueNotifier<String> _currentSelectedGenderValue =
      ValueNotifier<String>('');
  late bool _isNameEditValid;
  late bool _isUsernameEditValid;
  late bool _isWebsiteValid;
  late bool _isEmailValid;
  late bool _isPhoneValid;
  File? _avatarPicker;
  UserModel? userProfile;
  ImageCropper? _imageCropper;

  final Map<String, String> _inputValues = <String, String>{};

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _usernameController = TextEditingController();
    _websiteController = TextEditingController();
    _bioController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _imageCropper = ImageCropper();
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
  }

  void _checkValidInformation() {
    _checkNameValid(_nameController.text);
    _checkUsernameValid(_usernameController.text);
    _checkWebsiteValid(_websiteController.text);
    _checkEmailVailid(_emailController.text);
    _checkPhoneValid(_phoneController.text);
  }

  void _checkNameValid(String text) {
    _isNameEditValid = text.trim().isNotEmpty;
  }

  void _checkUsernameValid(String text) {
    _isUsernameEditValid = text.trim().isNotEmpty && !text.trim().contains(' ');
  }

  void _checkEmailVailid(String text) {
    _isEmailValid =
        text.trim().isEmpty || RegExp(REGEX_CHECK_EMAIL).hasMatch(text.trim());
  }

  void _checkWebsiteValid(String text) {
    _isWebsiteValid = text.trim().isEmpty ||
        RegExp(REGEX_CHECK_WEBSITE).hasMatch(text.trim());
  }

  void _checkPhoneValid(String text) {
    _isPhoneValid = text.trim().isEmpty ||
        (text.trim().length == 10 && text.trim().startsWith('0'));
  }

  void _backToUserProfileScreen() {
    Navigator.of(context).pop();
  }

  void _showSnackBar({
    required BuildContext context,
    required String title,
    required String message,
    required ContentType contentType,
  }) {
    //close keyboard
    if (FocusManager.instance.primaryFocus != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          elevation: 0,
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: title,
            message: message,
            contentType: contentType,
          ),
        ),
      );
  }

  void _updateUserProfile(BuildContext context) {
    if (!_isNameEditValid) {
      _showSnackBar(
        context: context,
        title: 'Update failed',
        message: 'Name cannot empty',
        contentType: ContentType.failure,
      );
      return;
    }
    if (!_isUsernameEditValid) {
      _showSnackBar(
        context: context,
        title: 'Update failed',
        message: 'Username cannot contain spaces',
        contentType: ContentType.failure,
      );
      return;
    }
    if (!_isWebsiteValid) {
      _showSnackBar(
        context: context,
        title: 'Update failed',
        message: 'The format of the website is incorrect',
        contentType: ContentType.failure,
      );
      return;
    }
    if (!_isEmailValid) {
      _showSnackBar(
        context: context,
        title: 'Update failed',
        message: 'The format of the email is incorrect',
        contentType: ContentType.failure,
      );
      return;
    }
    if (!_isPhoneValid) {
      _showSnackBar(
        context: context,
        title: 'Update failed',
        message: 'The format of the phone is incorrect',
        contentType: ContentType.failure,
      );
      return;
    } else {
      _inputValues['userID'] = UserModel.instance.userID;
      _inputValues['userName'] = _usernameController.text;
      _inputValues['name'] = _nameController.text;
      _inputValues['website'] = _websiteController.text;
      _inputValues['bio'] = _bioController.text;
      _inputValues['email'] = _emailController.text;
      _inputValues['phone'] = _phoneController.text;
      _inputValues['gender'] = _currentSelectedGenderValue.value;
      context.read<UserBloc>().add(
            UpdateUserInformation(
              updateUser: _inputValues,
              avatarPicker: _avatarPicker,
            ),
          );
    }
  }

  Future<void> _openFilePicker() async {
    try {
      final FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);

      if (result == null) {
        return;
      }
      final CroppedFile? cropper = await _imageCropper!.cropImage(
        sourcePath: result.files.first.path!,
        cropStyle: CropStyle.circle,
        compressQuality: 100,
        uiSettings: <PlatformUiSettings>[
          IOSUiSettings(),
          AndroidUiSettings(),
        ],
      );
      setState(() {
        _avatarPicker = File(cropper!.path);
      });
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    userProfile = ModalRoute.of(context)!.settings.arguments! as UserModel;

    _nameController.text = userProfile!.name;
    _usernameController.text = userProfile!.userName;
    _websiteController.text = userProfile!.website;
    _bioController.text = userProfile!.bio;
    _emailController.text = userProfile!.email;
    _phoneController.text = userProfile!.phone;
    _currentSelectedGenderValue.value = userProfile!.gender;
    _checkValidInformation();

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
          onTap: _backToUserProfileScreen,
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
          BlocConsumer<UserBloc, UserState>(
            listener: (BuildContext context, UserState state) {
              if (state is UserSuccessState) {
                Navigator.of(context).pop();
              }
              if (state is UserFailedState) {
                _showSnackBar(
                  context: context,
                  title: 'Failure',
                  message: state.error,
                  contentType: ContentType.failure,
                );
              }
            },
            builder: (BuildContext context, UserState state) {
              if (state is UserLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: ColorConstant.FF3897F0,
                  ),
                );
              }
              return InkWell(
                onTap: () {
                  _updateUserProfile(context);
                },
                child: Text(
                  StringConstant.COMPLETE_LABEL,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: DimensionConstant.SIZE_16,
                        color: ColorConstant.FF3897F0,
                      ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
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
                    backgroundImage: _avatarPicker != null
                        ? Image.file(
                            File(_avatarPicker!.path),
                          ).image
                        : userProfile!.avatarPath.isEmpty
                            ? const AssetImage(
                                PathConstant.DEFAULT_AVATAR_IMAGE_PATH,
                              ) as ImageProvider
                            : NetworkImage(
                                userProfile!.avatarPath,
                              ),
                  ),
                  const SizedBox(
                    height: DimensionConstant.SIZE_12_POINT_5,
                  ),
                  InkWell(
                    onTap: _openFilePicker,
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
                    onChanged: (String value) {
                      _checkNameValid(value);
                    },
                  ),
                  EditProfileTextFieldWidget(
                    label: StringConstant.EDIT_USERNAME_LABEL,
                    placeholder: StringConstant.EDIT_USERNAME_PLACEHOLDER,
                    controller: _usernameController,
                    onChanged: (String value) {
                      _checkUsernameValid(value);
                    },
                  ),
                  EditProfileTextFieldWidget(
                    label: StringConstant.EDIT_WEBSITE_LABEL,
                    placeholder: StringConstant.EDIT_WEBSITE_PLACEHOLDER,
                    controller: _websiteController,
                    onChanged: (String value) {
                      _checkWebsiteValid(value);
                    },
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
                    onChanged: (String value) {
                      _checkEmailVailid(value);
                    },
                  ),
                  EditProfileTextFieldWidget(
                    label: StringConstant.EDIT_PHONE_LABEL,
                    placeholder: StringConstant.EDIT_PHONE_PLACEHOLDER,
                    controller: _phoneController,
                    onChanged: (String value) {
                      _checkPhoneValid(value);
                    },
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
                            child: ValueListenableBuilder<String>(
                              valueListenable: _currentSelectedGenderValue,
                              builder: (
                                BuildContext context,
                                String value,
                                Widget? child,
                              ) {
                                return DropdownButton<String>(
                                  iconSize: DimensionConstant.SIZE_0,
                                  items: _genders.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  hint: value.isEmpty
                                      ? Text(
                                          StringConstant
                                              .EDIT_GENDER_PLACEHOLDER,
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
                                          value,
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
                                      _currentSelectedGenderValue.value = value;
                                    }
                                  },
                                );
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
    );
  }
}
