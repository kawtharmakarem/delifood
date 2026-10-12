import '/core/resources/app_styles.dart';

import 'package:flutter/material.dart';

class MenuBookPage extends StatelessWidget {
  const MenuBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("MenuBookPage", style: AppStyles.bold(25)));
  }
}
