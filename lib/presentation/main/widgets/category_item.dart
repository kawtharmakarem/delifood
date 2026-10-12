import 'package:flutter/material.dart';

import '../../resources/app_values.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
  });
  final String image;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: AppSize.s50,
        width: AppSize.s150,
        margin: EdgeInsets.only(right: AppSize.s15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.r8),
          border: Border.all(color: Theme.of(context).colorScheme.primary),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              image,
              width: AppSize.s30,
              height: AppSize.s30,
              fit: BoxFit.cover,
            ),
            SizedBox(width: AppSize.s5),
            Text(title, style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
      ),
    );
  }
}
