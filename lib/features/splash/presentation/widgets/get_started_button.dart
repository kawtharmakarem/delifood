import '../../../auth/presentation/auth_screen.dart';
import '/core/resources/app_colors.dart';
import '/core/resources/app_strings.dart';
import '/core/resources/app_styles.dart';
import '/features/splash/presentation/widgets/ripple_page_route.dart';
import 'package:flutter/material.dart';

class GetStartedButton extends StatefulWidget {
  const GetStartedButton({super.key});

  @override
  State<GetStartedButton> createState() => _GetStartedButtonState();
}

class _GetStartedButtonState extends State<GetStartedButton> {
  //Offset _tapPosition = Offset.zero;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // void _onTapDown(TapDownDetails details) {
  //   setState(() {
  //     _tapPosition = details.globalPosition;
  //   });
  // }

  void _onTap() {
    Size size = MediaQuery.of(context).size;
    Navigator.of(context).push(
      RipplePageRoute(
        page: AuthScreen(),
        tapPosition: Offset(
          size.width / 2,
          size.height,
        ), //_tapPosition,//ripple center
        rippleColor: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //onTapDown: _onTapDown,
      onTap: _onTap,
      child: Container(
        height: 54,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: AppColors.primaryColor.withValues(alpha: 0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          AppStrings.started,
          style: AppStyles.bold(16).copyWith(color: AppColors.lightRed),
        ),
      ),
    );
  }
}
