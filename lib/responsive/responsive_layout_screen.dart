import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/providers/user_provider.dart';
import 'package:social_app/utils/dimensions.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget webscreenlayout;
  final Widget mobileScreenLayout;
  const ResponsiveLayout({
    Key? key,
    required this.webscreenlayout,
    required this.mobileScreenLayout,
  }) : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webScreen) {
          return widget.webscreenlayout;
        }
        return widget.mobileScreenLayout;
      },
    );
  }
}
