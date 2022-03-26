import 'package:flutter/material.dart';

import '../utils/sizer_utils.dart';

class CustomScaffoldWidget extends StatelessWidget {
  const CustomScaffoldWidget({
    Key? key,
    required this.body,
    this.appBar,
    this.usePadding = true,
    this.useSingleScroll = true,
    this.useSafeArea = true,
    this.bg,
    this.scaffoldKey,
    this.drawer,
    this.bottomNav,
    this.floatingActionButton,
  }) : super(key: key);

  final Widget? drawer;
  final Widget? bottomNav;
  final Widget? floatingActionButton;
  final Widget body;
  final Widget? appBar;
  final bool usePadding;
  final bool useSingleScroll;
  final bool useSafeArea;
  final Color? bg;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: useSafeArea,
      child: Scaffold(
        drawerEnableOpenDragGesture: true,
        key: scaffoldKey,
        appBar: appBar == null
            ? null
            : PreferredSize(
                child: appBar!,
                preferredSize: const Size(double.infinity, kToolbarHeight),
              ),
        backgroundColor: bg ?? Colors.white.withOpacity(0.95),
        body: SizedBox(
          height: sh(98),
          child: useSingleScroll
              ? SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: usePadding ? sp(15.0) : 0,
                    ),
                    child: body,
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: usePadding ? sp(15.0) : 0,
                  ),
                  child: body,
                ),
        ),
        drawer: drawer,
        bottomNavigationBar: bottomNav,
        floatingActionButton: floatingActionButton,
      ),
    );
  }
}
