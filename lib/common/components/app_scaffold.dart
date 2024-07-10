import 'package:flutter/material.dart';

import '../style/app_colors.dart';
import '../style/app_style.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.child,
    this.bottomNavigationBar,
    this.bottom,
    this.appBarTitle,
    this.floatingActionButton,
    this.actions,
    this.withAppBar = false,
    this.isScrollable = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
  });

  final Widget child;
  final bool withAppBar;
  final bool isScrollable;
  final EdgeInsets padding;
  final Widget? bottomNavigationBar;
  final PreferredSizeWidget? bottom;
  final String? appBarTitle;
  final Widget? floatingActionButton;
  final List<Widget>? actions;

  Widget getBody(bool isScrollable, BuildContext context) => isScrollable
      ? SingleChildScrollView(
          child: SafeArea(
            child: Container(
              color: AppColor.background,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: padding,
              child: child,
            ),
          ),
        )
      : SafeArea(
          child: Container(
            color: AppColor.background,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: padding,
            child: child,
          ),
        );

  @override
  Widget build(BuildContext context) {
    return withAppBar
        ? Scaffold(
            appBar: AppBar(
              actions: actions,
              backgroundColor: AppColor.background,
              title: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  appBarTitle!,
                  style: AppTextStyle.black(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              bottom: bottom,
            ),
            bottomNavigationBar: bottomNavigationBar,
            body: getBody(isScrollable, context),
            floatingActionButton: floatingActionButton,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          )
        : Scaffold(
            backgroundColor: AppColor.background,
            bottomNavigationBar: bottomNavigationBar,
            body: getBody(isScrollable, context),
            floatingActionButton: floatingActionButton,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
  }
}
