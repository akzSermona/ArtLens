import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:artlens/main.dart';

class HomeCircleButton extends StatelessWidget {
  final BuildContext context;
  final IconData icon;
  final Widget destinationPage;
  final double padding;
  final double iconSize;

  const HomeCircleButton({
    super.key,
    required this.context,
    required this.icon,
    required this.destinationPage,
    required this.padding,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext _) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationPage),
        );
      },
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: EdgeInsets.all(padding).r,
        backgroundColor: customColorScheme.primary,
      ),
      child: Icon(icon, size: iconSize.r, color: customColorScheme.onPrimary),
    );
  }
}
