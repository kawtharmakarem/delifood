import '/core/resources/app_colors.dart';
import '/features/home/cubit/home_cubit.dart';
import '/features/home/presentation/widgets/custom_icon_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/home_state.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            bottom: false,
            child: Stack(
              children: [
                _customNavBar(context, cubit),
                cubit.pages[cubit.selectedNavIndex],
              ],
            ),
          ),
        );
      },
    );
  }

  Positioned _customNavBar(BuildContext context, HomeCubit cubit) {
    Size size = MediaQuery.of(context).size;
    return Positioned(
      bottom: 0,
      left: 0,
      child: Container(
        width: size.width,
        height: 80,
        color: Colors.white,
        child: Stack(
          children: [
            CustomPaint(
              size: Size(size.width, 80),

              painter: BottomNavBarCustomPainter(),
            ),
            Center(
              heightFactor: 0.6,
              child: FloatingActionButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                backgroundColor: AppColors.primaryColor,
                elevation: 2,
                child: const Icon(
                  Icons.shopping_bag_outlined,
                  size: 30,
                  color: AppColors.black,
                ),
              ),
            ),
            SizedBox(
              height: 80,
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomIconButton(
                    iconData: cubit.icons[0],
                    buttonIndex: 0,
                    onPressed: () {
                      cubit.changeNavIndex(0);
                    },
                    selectedIndex: cubit.selectedNavIndex,
                  ),
                  CustomIconButton(
                    iconData: cubit.icons[1],
                    buttonIndex: 1,
                    onPressed: () {
                      cubit.changeNavIndex(1);
                    },
                    selectedIndex: cubit.selectedNavIndex,
                  ),
                  Container(width: size.width * 0.2),
                  CustomIconButton(
                    iconData: cubit.icons[2],
                    buttonIndex: 2,
                    onPressed: () {
                      cubit.changeNavIndex(2);
                    },
                    selectedIndex: cubit.selectedNavIndex,
                  ),
                  CustomIconButton(
                    iconData: cubit.icons[3],
                    buttonIndex: 3,
                    onPressed: () {
                      cubit.changeNavIndex(3);
                    },
                    selectedIndex: cubit.selectedNavIndex,
                  ),
                ],
              ),
            ),
          ],
        ),
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
