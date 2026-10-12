import '/core/resources/app_assets.dart';
import '/core/resources/app_colors.dart';
import '/core/resources/app_strings.dart';
import '/core/resources/app_styles.dart';
import '/features/home/cubit/home_cubit.dart';
import '/features/home/presentation/widgets/category_item.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/home_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _customAppBar(),
            ),
            SizedBox(height: size.height * 0.03),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(AppStrings.homeTitle, style: AppStyles.bold(32)),
            ),
            SizedBox(height: size.height * 0.03),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _searchBar(),
            ),
            SizedBox(height: size.height * 0.03),
            SizedBox(
              height: 60,
              child: ListView.builder(
                padding: const EdgeInsets.only(left: 20),
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return CategoryItem(
                    onTap: () {
                      context.read<HomeCubit>().changeCategoryIndex(index);
                    },
                    categoryModel: context.read<HomeCubit>().categories[index],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Row _searchBar() {
    return Row(
      children: [
        Expanded(child: _customTextFeild()),
        const SizedBox(width: 10),
        Container(
          alignment: Alignment.center,
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.primaryColor,
          ),
          child: const Icon(Icons.tune, color: AppColors.darkGrey),
        ),
      ],
    );
  }

  TextFormField _customTextFeild() {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12),
          child: Image.asset(
            AppAssets.search,
            height: 10,
            width: 10,
            fit: BoxFit.contain,
            color: AppColors.grey,
          ),
        ),
        hint: Text(
          AppStrings.search,
          style: AppStyles.regular(16).copyWith(color: AppColors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          // ignore: prefer_const_constructors
          borderSide: BorderSide(color: AppColors.grey),
        ),
      ),
    );
  }

  Row _customAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {},
          style: IconButton.styleFrom(padding: EdgeInsets.zero),
          icon: const Icon(Icons.menu, size: 30, color: AppColors.black),
        ),
        Container(
          alignment: Alignment.center,
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.primaryColor,
          ),
          child: const Icon(
            Icons.person_outline,
            size: 30,
            color: AppColors.darkRed,
          ),
        ),
      ],
    );
  }
}
