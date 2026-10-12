import 'package:flutter/material.dart';

import '/app/di.dart';
import '/domain/models/home_models.dart';
import '/presentation/main/details/details_view_model.dart';
import '/presentation/resources/app_strings.dart';
import '/presentation/resources/app_values.dart';

import '../../resources/app_assets.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final _viewModel = instance<DetailsViewModel>();
  bool _isInitialized = false;

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  void _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInitialized) return;
    _isInitialized = true;
    final id = ModalRoute.of(context)?.settings.arguments as int?;
    if (id != null) {
      _viewModel.getDetailsById(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<Recipe>(
        stream: _viewModel.outputGetDetails,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text(
                AppStrings.noDetails,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            );
          }
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,

                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    snapshot.data!.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: AppPadding.p20,
                    right: AppPadding.p20,
                    left: AppPadding.p20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data!.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: AppSize.s10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${snapshot.data!.cuisine} cuisine',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                AppAssets.fire,
                                height: 20,
                                width: 20,
                                fit: BoxFit.cover,
                              ),
                              Text(
                                '${snapshot.data!.caloriesPerServing} Calories',
                                style: Theme.of(context).textTheme.labelSmall
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .error,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: AppSize.s20),
                      Text(
                        '🍔 Ingredients :',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      for (
                        int i = 0;
                        i < snapshot.data!.ingredients.length;
                        i++
                      ) ...[
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: Text(
                            "${i + 1} * ",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          title: Text(
                            snapshot.data!.ingredients[i],
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ],
                      SizedBox(height: AppSize.s20),
                      Text(
                        '🍜 Instructions :',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      for (
                        int i = 0;
                        i < snapshot.data!.instructions.length;
                        i++
                      )
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: Text(
                            "${i + 1} * ",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          title: Text(
                            snapshot.data!.instructions[i],
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
