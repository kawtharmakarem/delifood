import '/core/resources/app_styles.dart';

import 'package:flutter/material.dart';

class BookMarkPage extends StatelessWidget {
  const BookMarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("BookMark", style: AppStyles.bold(25)));
  }
}
