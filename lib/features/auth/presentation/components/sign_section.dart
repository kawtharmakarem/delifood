import 'package:mydelifood/features/home/cubit/home_cubit.dart';

import '/core/services/service_locator.dart';
import '/features/auth/cubit/auth_cubit.dart';
import '/features/auth/data/staggerd_auth_animation.dart';
import '/core/resources/app_colors.dart';
import '/core/resources/app_strings.dart';
import '/core/resources/app_styles.dart';
import '/features/auth/presentation/components/custom_button.dart';
import '/features/home/presentation/main_screen.dart';
import '/features/splash/presentation/widgets/ripple_page_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/auth_state.dart';

class SignSection extends StatefulWidget {
  const SignSection({
    super.key,
    required this.controller,
    required this.animation,
  });
  final AnimationController controller;
  final StaggerdAuthAnimation animation;

  @override
  State<SignSection> createState() => _SignSectionState();
}

class _SignSectionState extends State<SignSection> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = context.read<AuthCubit>();
        return Column(
          children: [
            AnimatedBuilder(
              animation: widget.controller,
              builder: (_, _) {
                return Transform.translate(
                  offset: Offset(0, widget.animation.tabsSlide.value),
                  child: Opacity(
                    opacity: widget.animation.tabsFade.value,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildTab(AppStrings.login, 0, cubit),
                        _buildTab(AppStrings.register, 1, cubit),
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.025),

            if (cubit.selectedTab == 0)
              Form(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: AnimatedBuilder(
                    animation: widget.controller,
                    builder: (_, _) {
                      return Column(
                        children: [
                          AnimatedBuilder(
                            animation: widget.controller,
                            builder: (_, _) {
                              return Transform.translate(
                                offset: Offset(
                                  0,
                                  widget.animation.emailSlide.value,
                                ),
                                child: Opacity(
                                  opacity: widget.animation.emailFade.value,
                                  child: _buildTextFeild(
                                    label: AppStrings.email,
                                    hintText: AppStrings.email,
                                    controller: cubit.loginEmailController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return AppStrings.emailRequired;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: size.height * 0.05),
                          AnimatedBuilder(
                            animation: widget.controller,
                            builder: (_, _) {
                              return Transform.translate(
                                offset: Offset(
                                  0,
                                  widget.animation.passwordSlide.value,
                                ),
                                child: Opacity(
                                  opacity: widget.animation.passwordFade.value,
                                  child: _buildTextFeild(
                                    label: AppStrings.password,
                                    hintText: AppStrings.password,
                                    controller: cubit.loginPasswordController,
                                    obsecureText: cubit.obsecureText,
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        cubit.changeLogObsecure();
                                      },
                                      icon: cubit.obsecureText
                                          ? const Icon(Icons.visibility_off)
                                          : const Icon(Icons.visibility),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return AppStrings.passwordRequired;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 5),
                          AnimatedBuilder(
                            animation: widget.controller,
                            builder: (_, _) {
                              return Transform.translate(
                                offset: Offset(
                                  0,
                                  widget.animation.forgotSlide.value,
                                ),
                                child: Opacity(
                                  opacity: widget.animation.forgotFade.value,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        AppStrings.forgotPassword,
                                        style: AppStyles.medium(
                                          16,
                                        ).copyWith(color: AppColors.lightRed),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: size.height * 0.05),
                          AnimatedBuilder(
                            animation: widget.controller,
                            builder: (_, _) {
                              return Transform.translate(
                                offset: Offset(
                                  0,
                                  widget.animation.buttonSlide.value,
                                ),
                                child: Opacity(
                                  opacity: widget.animation.buttonFade.value,
                                  child: CustomButton(
                                    title: AppStrings.login,
                                    onTap: () {
                                      Navigator.of(context).pushReplacement(
                                        RipplePageRoute(
                                          page: BlocProvider(
                                            create: (context) =>
                                                instance<HomeCubit>(),
                                            child: MainScreen(),
                                          ),
                                          tapPosition: Offset(
                                            size.width / 2,
                                            size.height,
                                          ),
                                          rippleColor: AppColors.white,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              )
            else
              Form(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      AnimatedBuilder(
                        animation: widget.controller,
                        builder: (_, _) {
                          return Transform.translate(
                            offset: Offset(
                              0,
                              widget.animation.regUserNameSlide.value,
                            ),
                            child: Opacity(
                              opacity: widget.animation.regUserNameFade.value,
                              child: _buildTextFeild(
                                label: AppStrings.userName,
                                hintText: AppStrings.userName,
                                controller: cubit.registerUserNameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return AppStrings.userNameRequired;
                                  }
                                  return null;
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: size.height * 0.02),
                      AnimatedBuilder(
                        animation: widget.controller,
                        builder: (_, _) {
                          return Transform.translate(
                            offset: Offset(
                              0,
                              widget.animation.regEmailSlide.value,
                            ),
                            child: Opacity(
                              opacity: widget.animation.regEmailFade.value,
                              child: _buildTextFeild(
                                label: AppStrings.email,
                                hintText: AppStrings.email,
                                controller: cubit.registerEmailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return AppStrings.emailRequired;
                                  }
                                  return null;
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: size.height * 0.02),
                      AnimatedBuilder(
                        animation: widget.controller,
                        builder: (_, _) {
                          return Transform.translate(
                            offset: Offset(
                              0,
                              widget.animation.regPasswordSlide.value,
                            ),
                            child: Opacity(
                              opacity: widget.animation.regPasswordFade.value,
                              child: _buildTextFeild(
                                label: AppStrings.password,
                                hintText: AppStrings.password,
                                controller: cubit.registerPasswordController,
                                obsecureText: cubit.regObsecureText,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    cubit.changRegObsecure();
                                  },
                                  icon: Icon(
                                    cubit.regObsecureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return AppStrings.password;
                                  }
                                  return null;
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: size.height * 0.02),
                      AnimatedBuilder(
                        animation: widget.controller,
                        builder: (_, _) {
                          return Transform.translate(
                            offset: Offset(
                              0,
                              widget.animation.regConfirmSlide.value,
                            ),
                            child: Opacity(
                              opacity: widget.animation.regConfirmFade.value,
                              child: _buildTextFeild(
                                label: AppStrings.confirmPassword,
                                hintText: AppStrings.confirmPassword,
                                controller: cubit.registerConfirmController,
                                obsecureText: cubit.regObsecureText,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    cubit.changRegObsecure();
                                  },
                                  icon: Icon(
                                    cubit.regObsecureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return AppStrings.confirmPassword;
                                  }
                                  if (cubit.registerPasswordController.text
                                          .trim() !=
                                      cubit.registerConfirmController.text
                                          .trim()) {
                                    return AppStrings.confirmRequired;
                                  }
                                  return null;
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: size.height * 0.02),
                      AnimatedBuilder(
                        animation: widget.controller,
                        builder: (_, _) {
                          return Transform.translate(
                            offset: Offset(
                              0,
                              widget.animation.regButtonSlide.value,
                            ),
                            child: Opacity(
                              opacity: widget.animation.regButtonFade.value,
                              child: CustomButton(
                                title: AppStrings.register,
                                onTap: () {},
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  GestureDetector _buildTab(String label, int index, AuthCubit cubit) {
    return GestureDetector(
      onTap: () {
        cubit.changeTab(index);
        widget.controller.reset();
        widget.controller.forward(from: 0);
      },
      child: Column(
        children: [
          Text(
            label,
            style: AppStyles.medium(20).copyWith(color: AppColors.darkGrey),
          ),

          if (index == cubit.selectedTab) ...[
            const SizedBox(height: 10),
            Container(
              height: 3,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ],
      ),
    );
  }

  TextFormField _buildTextFeild({
    required String label,
    required String hintText,
    required TextEditingController controller,
    bool obsecureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obsecureText,
      validator: validator,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.grey),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.grey),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightBlack),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightRed),
        ),
        hint: Text(hintText),
        label: Text(label),
        suffixIcon: suffixIcon,
        labelStyle: AppStyles.regular(16).copyWith(color: AppColors.grey),
        hintStyle: AppStyles.regular(16).copyWith(color: AppColors.lightBlack),
      ),
    );
  }
}
