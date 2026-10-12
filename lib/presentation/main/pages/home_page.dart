import 'package:flutter/material.dart';

import '/domain/models/home_models.dart';
import '/presentation/main/main_view_model/main_view_model.dart';
import '/presentation/main/widgets/category_item.dart';
import '/presentation/main/widgets/grid_item.dart';
import '/presentation/resources/app_assets.dart';
import '/presentation/resources/app_routes.dart';
import '/presentation/resources/app_strings.dart';
import '/presentation/resources/app_values.dart';

import '../widgets/custom_staggerd_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.viewModel});
  final MainViewModel viewModel;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Size size = Size.zero;
  List<String> categories = ["Easy", "Medium", "Breakfast", "Dinner", "Lunch"];
  List<String> categoryImages = [
    AppAssets.pizza,
    AppAssets.burger,
    AppAssets.bread,
    AppAssets.potato,
    AppAssets.onion,
  ];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<RecipesModel>(
      stream: widget.viewModel.outputHomeData,
      builder: (context, snapshot) {
        return _getContentWidget(context, snapshot.data);
      },
    );
  }

  Widget _getContentWidget(BuildContext context, RecipesModel? recipe) {
    if (recipe == null) return Container();
    return Padding(
      padding: EdgeInsets.only(left: AppPadding.p10, right: AppPadding.p10),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _customAppBar(),
                SizedBox(height: AppSize.s10),
                Text(
                  AppStrings.welcomeText,
                  style: Theme.of(context).textTheme.displaySmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: AppSize.s30),
                _searchBar(context),
                SizedBox(height: AppSize.s30),
                SizedBox(
                  height: AppSize.s50,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return CategoryItem(
                        image: categoryImages[index],
                        title: categories[index],
                        onTap: () {},
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          SliverFillRemaining(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: AppPadding.p10),
              child: CustomStaggerdView(
                itemCount: recipe.recipes.length,
                itemBuilder: (context, index) {
                  //final height = 100.0 + (index % 5) * 40;
                  return GridItem(
                    recipe: recipe.recipes[index],
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        Routes.detailsRoute,
                        arguments: recipe.recipes[index].id,
                      );
                    },
                  );
                },
                spacing: 20,
              ),
            ),
          ),
        ],
      ),
    );
    // Center(
    //   child: Text(
    //     'Recipes: ${recipe?.recipes.length ?? 0}',
    //     style: Theme.of(context).textTheme.titleLarge,
    //   ),
    // );
  }

  Widget _customAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        Container(
          width: AppSize.s50,
          height: AppSize.s50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.r8),
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }

  Widget _searchBar(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: AppSize.s50,
            child: SearchBar(
              hintText: AppStrings.searchForFood,

              leading: Image.asset(
                AppAssets.search,
                width: 20,
                height: 20,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(width: AppSize.s20),
        Container(
          width: AppSize.s50,
          height: AppSize.s50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.r8),
            color: Theme.of(context).colorScheme.primary,
          ),
          child: Icon(
            Icons.tune,
            size: 28,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ],
    );
  }
}
