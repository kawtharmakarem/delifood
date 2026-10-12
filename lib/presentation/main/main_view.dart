import 'package:flutter/material.dart';

import '/app/constants.dart';
import '/app/di.dart';
import '/presentation/common/state_renderer/state_listener.dart';
import '/presentation/main/main_view_model/main_view_model.dart';
import '/presentation/main/pages/home_page.dart';
import '/presentation/main/pages/notification_page.dart';
import '/presentation/main/pages/search_page.dart';
import '/presentation/main/pages/settings_page.dart';
import '/presentation/resources/app_values.dart';

import '../resources/app_colors.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<IconData> icons = [
    Icons.home,
    Icons.search,
    Icons.notifications,
    Icons.settings,
  ];

  @override
  void dispose() {
    super.dispose();
    _viewModel.dispose();
  }

  final _viewModel = instance<MainViewModel>();
  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: StateListener(
        stream: _viewModel.outputState,
        child: _getContentWidget(),
      ),
    );
  }

  Widget _getContentWidget() {
    return SafeArea(
      bottom: false,
      child: StreamBuilder<int>(
        stream: _viewModel.outputSelectedNavIndexStream,
        builder: (context, snapshot) {
          int selectedIndex = snapshot.data ?? Constants.zero;

          List<Widget> pages = [
            HomePage(viewModel: _viewModel),
            SearchPage(),
            NotificationPage(),
            SettingsPage(),
          ];
          return Stack(
            children: [
              pages[selectedIndex],
              _customNavBar(context, selectedIndex),
            ],
          );
        },
      ),
    );
  }

  Positioned _customNavBar(BuildContext context, int selectedIndex) {
    Size size = MediaQuery.of(context).size;
    return Positioned(
      bottom: 0,
      left: 0,
      child: Container(
        width: size.width,
        height: 80,
        color: Colors.white,
        clipBehavior: Clip.none,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            CustomPaint(
              size: Size(size.width, 80),

              painter: BottomNavBarCustomPainter(),
            ),

            SizedBox(
              height: 80,
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _navIcon(0, selectedIndex),
                  _navIcon(1, selectedIndex),
                  Transform.translate(
                    offset: Offset(0, -20),
                    child: FloatingActionButton(
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.r50),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      elevation: 2,
                      child: Icon(
                        Icons.shopping_bag_outlined,
                        size: 30,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  _navIcon(2, selectedIndex),
                  _navIcon(3, selectedIndex),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navIcon(int index, int selectedIndex) {
    final isSelected = index == selectedIndex;
    return IconButton(
      onPressed: () => _viewModel.changeNavIndex(index),
      icon: Icon(
        icons[index],
        size: 28,
        color: isSelected
            ? Theme.of(context).colorScheme.primary
            : AppColors.lightGrey,
      ),
    );
  }
}

class BottomNavBarCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColors.white
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 20);
    path.quadraticBezierTo(size.width * 0.2, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.4, 0, size.width * 0.4, 20);
    path.arcToPoint(
      Offset(size.width * 0.6, 20),
      radius: const Radius.circular(10),
      clockwise: false,
    );
    path.quadraticBezierTo(size.width * 0.6, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.8, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawShadow(path, AppColors.black, 2, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class TestCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.amber
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 40);
    path.quadraticBezierTo(
      size.width * 0.1,
      0,
      size.width * 0.2,
      size.height / 2,
    );

    path.quadraticBezierTo(
      size.width * 0.3,
      size.height,
      size.width * 0.4,
      size.height / 2,
    );
    path.quadraticBezierTo(
      size.width * 0.5,
      0,
      size.width * 0.6,
      size.height / 2,
    );
    path.quadraticBezierTo(
      size.width * 0.7,
      size.height,
      size.width * 0.8,
      size.height / 2,
    );
    path.quadraticBezierTo(size.width * 0.9, 0, size.width, size.height / 2);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
