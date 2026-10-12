import 'package:flutter/material.dart';

import '/presentation/resources/app_strings.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppStrings.notifications,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
