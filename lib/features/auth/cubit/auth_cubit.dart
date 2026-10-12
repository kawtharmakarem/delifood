import 'dart:math';

import '/core/resources/app_assets.dart';
import '/features/auth/cubit/auth_state.dart';
import '/features/auth/data/food_item_data.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial()) {
    items = _generateFoodItems();
  }
  int selectedTab = 0;
  //login
  bool obsecureText = true;
  bool regObsecureText = true;
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  //register
  TextEditingController registerUserNameController = TextEditingController();
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();
  TextEditingController registerConfirmController = TextEditingController();

  //stickerSection
  final Random random = Random(42);
  List<String> images = [
    AppAssets.banana,
    AppAssets.broccoli,
    AppAssets.ginger,
    AppAssets.leaf,
    AppAssets.onion,
    AppAssets.pizza,
    AppAssets.potato,
    AppAssets.potato,
  ];
  List<FoodItemData> items = [];
  List<FoodItemData> _generateFoodItems() {
    return images.map((image) {
      return FoodItemData(
        image: image,
        startX: 0.5 + (random.nextDouble() - 0.5) * 0.08,
        startY: 0.55 + (random.nextDouble() - 0.5) * 0.08,
        endX: 0.05 + random.nextDouble() * 0.8,
        endy: 0.05 + random.nextDouble() * 0.8,
        delay: random.nextDouble() * 0.25,
        arcHeight: random.nextDouble() * 0.08 - 0.04,
        rotation: (random.nextDouble() - 0.5) * 0.9,
        rotationSpeed: random.nextDouble() * 0.6 - 0.3,
        size: 45,
      );
    }).toList();
  }

  void changeTab(int index) {
    selectedTab = index;
    emit(AuthChangeSelectedTab());
  }

  void changeLogObsecure() {
    obsecureText = !obsecureText;
    emit(AuthLoginObsecure());
  }

  void changRegObsecure() {
    regObsecureText = !regObsecureText;
    emit(AuthRegisterObsecure());
  }
}
