import 'package:flutter/material.dart';
import '../utils/sizer_utils.dart';

class CustomScaffoldWidget extends StatelessWidget {
  const CustomScaffoldWidget({
    Key? key,
    required this.body,
    this.appBar,
    this.usePadding = true,
    this.useSingleScroll = true,
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
  final AppBar? appBar;
  final bool usePadding;
  final bool useSingleScroll;
  final Color? bg;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawerEnableOpenDragGesture: true,
        key: scaffoldKey,
        appBar: appBar,
        backgroundColor: bg ?? Colors.white.withOpacity(0.95),
        body: SizedBox(
          height: sizerHeight(98),
          child: useSingleScroll
              ? SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: usePadding ? sizerSp(15.0) : 0,
                    ),
                    child: body,
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: usePadding ? sizerSp(15.0) : 0,
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
