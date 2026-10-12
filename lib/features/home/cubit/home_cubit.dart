import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/resources/app_assets.dart';
import '/core/resources/app_strings.dart';
import '/features/home/data/category_model.dart';
import '/features/home/presentation/pages/book_mark_page.dart';
import '/features/home/presentation/pages/home_page.dart';
import '/features/home/presentation/pages/menu_book_page.dart';
import '/features/home/presentation/pages/notification_page.dart';

import 'package:flutter/material.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  int selectedNavIndex = 0;
  int selectedCategoryIndex = 0;
  List<CategoryModel> categories = [
    CategoryModel(image: AppAssets.banana, title: AppStrings.fruit),
    CategoryModel(image: AppAssets.potato, title: AppStrings.vegetables),
    CategoryModel(image: AppAssets.pizza, title: AppStrings.fastFood),
    CategoryModel(image: AppAssets.chili, title: AppStrings.spicyFood),
    CategoryModel(image: AppAssets.cupCake, title: AppStrings.sweet),
  ];

  List<IconData> icons = [
    Icons.home_outlined,
    Icons.menu_book_outlined,
    Icons.bookmark_outline,
    Icons.notifications_outlined,
  ];
  List<Widget> pages = [
    HomePage(),
    const MenuBookPage(),
    const BookMarkPage(),
    const NotificationPage(),
  ];
  void changeNavIndex(int index) {
    selectedNavIndex = index;
    emit(ChangeNavIndex());
  }

  void changeCategoryIndex(int index) {
    selectedCategoryIndex = index;
    emit(ChangeCategoryIndex());
  }
}
