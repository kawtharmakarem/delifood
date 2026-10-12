import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import '/app/app_preferences.dart';
import '/app/di.dart';
import '/domain/models/auth_models.dart';
import '/presentation/auth/auth_view/auth_animation/auth_staggers_animation.dart';
import '/presentation/auth/auth_view/auth_widget/custom_text_feild.dart';
import '/presentation/auth/auth_view_model/auth_view_model.dart';
import '/presentation/common/state_renderer/state_listener.dart';
import '/presentation/resources/app_colors.dart';
import '/presentation/resources/app_constants.dart';
import '/presentation/resources/app_routes.dart';

import '../../resources/app_assets.dart';
import '../../resources/app_fonts.dart';
import '../../resources/app_strings.dart';
import '../../resources/app_values.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late AuthStaggersAnimation _animation;

  Size size = Size.zero;
  final _loginKey = GlobalKey<FormState>();
  final _signupKey = GlobalKey<FormState>();
  final AuthViewModel _viewModel = instance<AuthViewModel>();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  void _bind() {
    _viewModel.start();
    _viewModel.logEmailController.addListener(
      () => _viewModel.setLogEmail(_viewModel.logEmailController.text),
    );
    _viewModel.logPasswordController.addListener(
      () => _viewModel.setLogPassword(_viewModel.logPasswordController.text),
    );
    _viewModel.isUserLoggedInSuccessfulyStreamController.stream.listen((
      isLoggedIn,
    ) async {
      if (!isLoggedIn) return;
      await _appPreferences.setUserLoggedIn();
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
    });
    //register
    _viewModel.regUserNameController.addListener(
      () => _viewModel.setRegUserName(_viewModel.regUserNameController.text),
    );
    _viewModel.regMobileNumberController.addListener(
      () => _viewModel.setRegMobileNumber(
        _viewModel.regMobileNumberController.text,
      ),
    );
    _viewModel.regEmailController.addListener(
      () => _viewModel.setRegEmail(_viewModel.regEmailController.text),
    );
    _viewModel.regPasswordController.addListener(
      () => _viewModel.setRegPassword(_viewModel.regPasswordController.text),
    );
    _viewModel.regIsUserRegisteredSuccessfully.stream.listen((
      isRegistered,
    ) async {
      if (!isRegistered) return;
      await _appPreferences.setUserLoggedIn();
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
    });
  }

  @override
  void initState() {
    super.initState();
    _bind();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: AppConstants.authDuration),
    );
    _animation = AuthStaggersAnimation(_controller);
    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _viewModel.dispose();

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    return StateListener(
      stream: _viewModel.outputState,
      child: Scaffold(body: _getContentWidget()),
    );
  }

  Widget _getContentWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _stickersPart(),
          _logoPart(),
          SizedBox(height: size.height * 0.05),
          _signPart(_viewModel),
        ],
      ),
    );
  }

  Widget _logoPart() {
    return ScaleTransition(
      scale: _animation.logoScale,
      child: FadeTransition(
        opacity: _animation.logoFade,
        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            Image.asset(
              AppAssets.logo,
              height: size.height * 0.1,
              width: size.width * 0.25,
              fit: BoxFit.fill,
            ),
            SizedBox(height: AppSize.s5),
            Text(
              AppStrings.logoText,
              style: Theme.of(
                context,
              ).textTheme.headlineLarge?.copyWith(fontSize: FontSize.f28),
            ),
            SizedBox(height: AppSize.s10),
            Text(
              AppStrings.logoText1,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: AppColors.lightGrey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _signPart(AuthViewModel viewModel) {
    return StreamBuilder<int>(
      stream: viewModel.outputSelectedTab,
      initialData: 0,
      builder: (context, snapshot) {
        return Column(
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _animation.tabsSlide.value),
                  child: FadeTransition(
                    opacity: _animation.tabsFade,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buidTab(
                          context,
                          snapshot,
                          title: AppStrings.login,
                          index: 0,
                        ),
                        _buidTab(
                          context,
                          snapshot,
                          title: AppStrings.signUp,
                          index: 1,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            if (snapshot.data == 0) ...[
              SizedBox(height: size.height * 0.05),
              _loginWidget(),
            ],
            if (snapshot.data == 1) ...[
              SizedBox(height: size.height * 0.02),
              _signUpWidget(),
            ],
          ],
        );
      },
    );
  }

  Widget _buidTab(
    BuildContext context,
    AsyncSnapshot<int> snapshot, {
    required String title,
    required int index,
  }) {
    return GestureDetector(
      onTap: () {
        _viewModel.selectTab(index);
        _controller.reset();
        _controller.forward(from: 0);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          if (index == snapshot.data) ...[
            SizedBox(height: AppSize.s5),
            Container(
              height: AppSize.s3,
              width: AppSize.s50,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(AppRadius.r12),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _loginWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: Form(
        key: _loginKey,
        child: Column(
          children: [
            StreamBuilder<bool>(
              stream: _viewModel.outputIsLogEmailValid,
              builder: (context, snapshot) {
                return CustomTextFeild(
                  hint: AppStrings.email,
                  label: AppStrings.email,
                  animationController: _controller,
                  animationValue: _animation.logEmailSlide.value,
                  animationOpacity: _animation.logEmailFade,
                  controller: _viewModel.logEmailController,
                  errorText: (snapshot.data ?? true)
                      ? null
                      : AppStrings.emailRequired,
                );
              },
            ),
            SizedBox(height: size.height * 0.05),
            StreamBuilder<bool>(
              stream: _viewModel.outputIsLogPasswordValid,
              builder: (context, snapshot) {
                return StreamBuilder<bool>(
                  stream: _viewModel.outputLogPasswordVisibility,
                  builder: (context, vsnapshot) {
                    bool visible = vsnapshot.data ?? false;
                    return CustomTextFeild(
                      animationController: _controller,
                      animationValue: _animation.logPasswordSlide.value,
                      animationOpacity: _animation.logPasswordFade,
                      hint: AppStrings.password,
                      label: AppStrings.password,
                      obscureText: !visible,
                      controller: _viewModel.logPasswordController,
                      errorText: (snapshot.data ?? true)
                          ? null
                          : AppStrings.passwordRequired,

                      suffixIcon: IconButton(
                        onPressed: () {
                          _viewModel.toggleLogPasswordVisibility();
                        },
                        icon: Icon(
                          visible ? Icons.visibility_off : Icons.visibility,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            SizedBox(height: size.height * 0.01),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _animation.forgotSlide.value),
                  child: FadeTransition(
                    opacity: _animation.forgotFade,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(
                            context,
                          ).pushNamed(Routes.forgotpassword);
                        },
                        child: Text(AppStrings.forgotPassword),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.02),
            StreamBuilder<bool>(
              stream: _viewModel.outputAreAllLogInputsValid,
              builder: (context, snapshot) {
                return StreamBuilder<bool>(
                  stream: _viewModel.outputIsLoading,
                  initialData: false,
                  builder: (context, loadingSnapshot) {
                    final isLoading = loadingSnapshot.data ?? false;
                    final isValid = snapshot.data ?? false;
                    return AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, _animation.logButtonSlide.value),
                          child: FadeTransition(
                            opacity: _animation.logButtonFade,
                            child: SizedBox(
                              width: size.width * 0.8,
                              height: AppSize.s50,
                              child: ElevatedButton(
                                onPressed: (isValid && !isLoading)
                                    ? () {
                                        _viewModel.login();
                                      }
                                    : null,
                                child: Text(AppStrings.login),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _signUpWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: Form(
        key: _signupKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: StreamBuilder<String?>(
                    stream: _viewModel.outputRegErrorMobileNumber,
                    builder: (context, snapshot) {
                      return CustomTextFeild(
                        hint: AppStrings.phoneNumber,
                        label: AppStrings.phoneNumber,
                        controller: _viewModel.regMobileNumberController,
                        prefixIcon: CountryCodePicker(
                          hideMainText: true,
                          flagWidth: 25,
                          //initialSelection: "+966",
                          onChanged: (countryCode) {
                            _viewModel.setCountryCode(
                              countryCode.dialCode ?? "",
                            );
                          },
                          padding: EdgeInsets.zero,
                          margin: EdgeInsets.zero,
                        ),
                        animationController: _controller,
                        animationValue: _animation.regUserNameSlide.value,
                        animationOpacity: _animation.regUserNameFade,
                        errorText: snapshot.data,
                      );
                    },
                  ),
                ),
                SizedBox(width: AppSize.s10),
                Expanded(
                  flex: 2,
                  child: StreamBuilder<String?>(
                    stream: _viewModel.outputRegErrorUserName,
                    builder: (context, snapshot) {
                      return CustomTextFeild(
                        animationController: _controller,
                        animationValue: _animation.regUserNameSlide.value,
                        animationOpacity: _animation.regUserNameFade,
                        hint: AppStrings.userName,
                        label: AppStrings.userName,
                        controller: _viewModel.regUserNameController,
                        errorText: snapshot.data,
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.01),
            StreamBuilder<String?>(
              stream: _viewModel.outputRegErrorEmail,
              builder: (context, snapshot) {
                return CustomTextFeild(
                  animationController: _controller,
                  animationOpacity: _animation.regEmailFade,
                  animationValue: _animation.regEmailSlide.value,
                  hint: AppStrings.email,
                  label: AppStrings.email,
                  controller: _viewModel.regEmailController,
                  errorText: snapshot.data,
                );
              },
            ),
            SizedBox(height: size.height * 0.01),
            StreamBuilder<String?>(
              stream: _viewModel.outputRegErrorPassword,
              builder: (context, snapshot) {
                return CustomTextFeild(
                  animationController: _controller,
                  animationOpacity: _animation.regPasswordFade,
                  animationValue: _animation.regPasswordSlide.value,
                  hint: AppStrings.password,
                  label: AppStrings.password,
                  controller: _viewModel.regPasswordController,
                  errorText: snapshot.data,
                );
              },
            ),
            SizedBox(height: size.height * 0.01),
            StreamBuilder<File>(
              stream: _viewModel.outputRegProfilePicture,
              builder: (context, snapshot) {
                return CustomTextFeild(
                  readOnly: true,

                  onTap: _viewModel.pickImage,
                  suffixIcon: snapshot.hasData
                      ? Padding(
                          padding: EdgeInsets.all(AppSize.s5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(AppRadius.r8),
                            child: Image.file(
                              File(snapshot.data!.path),
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : null,
                  animationController: _controller,
                  animationOpacity: _animation.regProfileFade,
                  animationValue: _animation.regProfileSlide.value,
                  hint: AppStrings.profile,
                  label: AppStrings.profile,
                  controller: _viewModel.regProfileController,
                );
              },
            ),
            SizedBox(height: size.height * 0.02),
            StreamBuilder<bool>(
              stream: _viewModel.outputRegIsAllInputsValid,
              builder: (context, snapshot) {
                return AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _animation.regButtonSlide.value),
                      child: FadeTransition(
                        opacity: _animation.regButtonFade,
                        child: SizedBox(
                          width: size.width * 0.8,
                          height: AppSize.s50,
                          child: ElevatedButton(
                            onPressed: (snapshot.data ?? false)
                                ? () {
                                    _viewModel.register();
                                  }
                                : null,
                            child: Text(AppStrings.signUp),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _stickersPart() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.stickerSlide.value),
          child: FadeTransition(
            opacity: _animation.stickerFade,
            child: SizedBox(
              height: size.height * 0.3,
              child: StreamBuilder<Sticker>(
                stream: _viewModel.outputStickers,
                builder: (context, snapshot) {
                  Sticker? sticker = snapshot.data;
                  if (sticker == null) return Container();
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      final width = constraints.maxWidth;
                      final height = constraints.maxHeight;
                      return Stack(
                        children: sticker.items.map((item) {
                          return Positioned(
                            left: item.x * width - item.size / 2,
                            top: item.y * height - item.size / 2,
                            child: Transform.rotate(
                              angle: item.rotation,
                              child: Image.asset(
                                item.image,
                                width: item.size,
                                height: item.size,
                                fit: BoxFit.contain,
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
