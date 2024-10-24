import 'package:Mohamad_Alzoubi_personal_website/core/widgets/spaces.dart';
import 'package:Mohamad_Alzoubi_personal_website/views/home/widgets/home_page_header.dart';
import 'package:Mohamad_Alzoubi_personal_website/views/home/widgets/loading_page.dart';
import 'package:Mohamad_Alzoubi_personal_website/views/home/widgets/what_they_said.dart';
import 'package:Mohamad_Alzoubi_personal_website/views/widgets/animated_footer.dart';
import 'package:Mohamad_Alzoubi_personal_website/core/widgets/page_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:Mohamad_Alzoubi_personal_website/core/values/values.dart';

class HomePage extends StatefulWidget {
  static const String homePageRoute = StringConst.HOME_PAGE;

  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  GlobalKey key = GlobalKey();
  ScrollController _scrollController = ScrollController();
  late AnimationController _viewProjectsController;
  // ignore: unused_field
  late AnimationController _recentWorksController;
  late AnimationController _slideTextController;
  late NavigationArguments _arguments;

  PageController _pageController = PageController();

  @override
  void initState() {
    _arguments = NavigationArguments();
    _viewProjectsController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _slideTextController = AnimationController(
      vsync: this,
      duration: Animations.slideAnimationDurationLong,
    );
    _recentWorksController = AnimationController(
      vsync: this,
      duration: Animations.slideAnimationDurationLong,
    );

    super.initState();
  }

  void getArguments() {
    final Object? args = ModalRoute.of(context)!.settings.arguments;
    if (args == null) {
      _arguments.showUnVeilPageAnimation = false;
    } else {
      _arguments = args as NavigationArguments;
    }
  }

  @override
  void dispose() {
    _viewProjectsController.dispose();
    _slideTextController.dispose();
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    getArguments();
    TextTheme textTheme = Theme.of(context).textTheme;

    return PageWrapper(
      selectedRoute: HomePage.homePageRoute,
      selectedPageName: StringConst.HOME,
      navBarAnimationController: _slideTextController,
      hasSideTitle: false,
      hasUnveilPageAnimation: _arguments.showUnVeilPageAnimation,
      onLoadingAnimationDone: () {
        _slideTextController.forward();
      },
      customLoadingAnimation: LoadingHomePageAnimation(
        text: StringConst.DEV_NAME,
        style: textTheme.headlineMedium!.copyWith(color: AppColors.white),
        onLoadingDone: () {
          _slideTextController.forward();
        },
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        controller: _scrollController,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: [
          HomePageHeader(
            controller: _slideTextController,
            scrollToWorksKey: key,
          ),
          SpaceH30(),
          WhatTheySaidSection(),
          AnimatedFooter(),
        ],
      ),
    );
  }
}
