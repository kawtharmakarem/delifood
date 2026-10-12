import '/core/resources/app_styles.dart';

import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("NotificationPage", style: AppStyles.bold(25)));
  }
}
