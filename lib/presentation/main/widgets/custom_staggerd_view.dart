import 'package:flutter/material.dart';

class CustomStaggerdView extends StatelessWidget {
  final int itemCount;
  final int crossAxisCount;
  final double spacing;
  final Widget Function(BuildContext context, int index) itemBuilder;
  const CustomStaggerdView({
    super.key,
    required this.itemCount,
    this.crossAxisCount = 2,
    this.spacing = 8,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    List<List<Widget>> columns = List.generate(
      crossAxisCount,
      (_) => <Widget>[],
    );
    for (int i = 0; i < itemCount; i++) {
      final columnIndex = i % crossAxisCount;
      columns[columnIndex].add(
        Padding(
          padding: EdgeInsets.only(bottom: spacing),
          child: itemBuilder(context, i),
        ),
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(crossAxisCount, (colIndex) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: spacing / 2),
            child: Column(children: columns[colIndex]),
          ),
        );
      }),
    );
  }
}
