import 'package:flutter/material.dart';

import '/domain/models/home_models.dart';
import '/presentation/resources/app_assets.dart';
import '/presentation/resources/app_colors.dart';

import '../../resources/app_values.dart';

class GridItem extends StatelessWidget {
  const GridItem({super.key, required this.recipe, required this.onTap});
  final Recipe recipe;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        elevation: 0.5,
        borderRadius: BorderRadius.circular(AppRadius.r8),
        child: Container(
          //height: height,
          decoration: BoxDecoration(
            //color: Theme.of(context).colorScheme.surfaceContainer,
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(AppRadius.r8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.r8),
                child: Image.network(
                  recipe.image,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Image.asset(
                      AppAssets.logo,
                      color: AppColors.error.withValues(alpha: 0.5),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      AppAssets.logo,
                      color: AppColors.error.withValues(alpha: 0.5),
                    );
                  },
                ),
              ),
              SizedBox(height: AppSize.s10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.p5),
                child: Text(
                  recipe.name,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: AppSize.s10),
              Text(
                "${recipe.cuisine} Cuisine",
                style: Theme.of(context).textTheme.labelSmall,
              ),
              SizedBox(height: AppSize.s5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppAssets.fire,
                    height: 20,
                    width: 20,
                    fit: BoxFit.cover,
                  ),
                  Text(
                    '${recipe.caloriesPerServing} Calories',
                    style: Theme.of(context).textTheme.labelSmall
                        ?.copyWith(color: Theme.of(context).colorScheme.error),
                  ),
                ],
              ),
              SizedBox(height: AppSize.s10),
            ],
          ),
        ),
      ),
    );
  }
}
