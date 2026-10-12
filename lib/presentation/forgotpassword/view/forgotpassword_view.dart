import 'package:flutter/material.dart';

import '/app/di.dart';
import '/presentation/auth/auth_view/auth_widget/custom_text_feild.dart';
import '/presentation/common/state_renderer/state_listener.dart';
import '/presentation/forgotpassword/view/forgotpassword_animation/forgotpassword_staggerd_animation.dart';
import '/presentation/forgotpassword/view_model/forgotpassword_viewmodel.dart';
import '/presentation/resources/app_constants.dart';

import '../../resources/app_assets.dart';
import '../../resources/app_colors.dart';
import '../../resources/app_fonts.dart';
import '../../resources/app_strings.dart';
import '../../resources/app_values.dart';

class ForgotpasswordView extends StatefulWidget {
  const ForgotpasswordView({super.key});

  @override
  State<ForgotpasswordView> createState() => _ForgotpasswordViewState();
}

class _ForgotpasswordViewState extends State<ForgotpasswordView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late ForgotpasswordStaggerdAnimation _animation;
  Size size = Size.zero;
  final _forgotpasswordKey = GlobalKey<FormState>();
  final _viewModel = instance<ForgotpasswordViewmodel>();
  void _bind() {
    _viewModel.start();
    _viewModel.emailController.addListener(
      () => _viewModel.setEmail(_viewModel.emailController.text),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _viewModel.dispose();
  }

  @override
  void initState() {
    super.initState();
    _bind();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: AppConstants.forgorDuration),
    );
    _animation = ForgotpasswordStaggerdAnimation(_controller);
    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });
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
    return Column(
      children: [
        _stickersPart(),
        _logoPart(),
        SizedBox(height: size.height * 0.05),
        _forgotpasswordPart(),
      ],
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
              style: Theme.of(context).textTheme.headlineLarge
                  ?.copyWith(fontSize: FontSize.f28),
            ),
            SizedBox(height: AppSize.s10),
            Text(
              AppStrings.logoText1,
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(color: AppColors.lightGrey),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedBuilder _stickersPart() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.stickersSlide.value),
          child: FadeTransition(
            opacity: _animation.stickersFade,
            child: SizedBox(
              height: size.height * 0.3,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  final height = constraints.maxHeight;
                  return Stack(
                    children: _viewModel.items.map((item) {
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
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _forgotpasswordPart() {
    return Form(
      key: _forgotpasswordKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
        child: Column(
          children: [
            StreamBuilder<bool>(
              stream: _viewModel.outputIsEmailValid,
              builder: (context, snapshot) {
                return CustomTextFeild(
                  hint: AppStrings.email,
                  label: AppStrings.email,
                  controller: _viewModel.emailController,
                  animationController: _controller,
                  animationValue: _animation.emailSlide.value,
                  animationOpacity: _animation.emailFade,
                  errorText: (snapshot.data ?? true)
                      ? null
                      : AppStrings.emailRequired,
                );
              },
            ),
            SizedBox(height: size.height * 0.1),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _animation.buttonSlide.value),
                  child: FadeTransition(
                    opacity: _animation.buttonFade,
                    child: SizedBox(
                      height: AppSize.s50,
                      width: size.width * 0.8,
                      child: StreamBuilder<bool>(
                        stream: _viewModel.outputIsAllInputsValid,
                        builder: (context, snapshot) {
                          return ElevatedButton(
                            onPressed: (snapshot.data ?? false)
                                ? () {
                                    _viewModel.forgotpassword();
                                  }
                                : null,
                            child: Text(AppStrings.sendEmail),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
