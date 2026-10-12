import '/features/home/cubit/home_cubit.dart';
import '/features/home/data/category_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/app_colors.dart';
import '../../../../core/resources/app_styles.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.onTap,
    required this.categoryModel,
  });
  final CategoryModel categoryModel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        height: 50,
        width: 150,
        alignment: Alignment.center,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.primaryColor),
          color:
              cubit.selectedCategoryIndex ==
                  cubit.categories.indexOf(categoryModel)
              ? AppColors.primaryColor
              : AppColors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              categoryModel.image,
              height: 30,
              width: 30,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 10),
            Text(categoryModel.title, style: AppStyles.medium(18)),
          ],
        ),
      ),
    );
  }
}
