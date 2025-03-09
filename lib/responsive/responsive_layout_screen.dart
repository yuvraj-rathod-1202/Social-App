import 'package:flutter/material.dart';
import 'package:social_app/utils/dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget webscreenlayout;
  final Widget mobileScreenLayout;
  const ResponsiveLayout({
    Key? key,
    required this.webscreenlayout,
    required this.mobileScreenLayout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webScreen) {
          return webscreenlayout;
        }
        return mobileScreenLayout;
      },
    );
  }
}
