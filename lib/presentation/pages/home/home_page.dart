import 'package:Mohamad_Alzoubi_personal_website/core/layout/adaptive.dart';
import 'package:Mohamad_Alzoubi_personal_website/core/utils/functions.dart';
import 'package:Mohamad_Alzoubi_personal_website/presentation/pages/home/widgets/home_page_header.dart';
import 'package:Mohamad_Alzoubi_personal_website/presentation/pages/home/widgets/loading_page.dart';
import 'package:Mohamad_Alzoubi_personal_website/presentation/pages/widgets/animated_footer.dart';
import 'package:Mohamad_Alzoubi_personal_website/presentation/widgets/animated_positioned_text.dart';
import 'package:Mohamad_Alzoubi_personal_website/presentation/widgets/animated_text_slide_box_transition.dart';
import 'package:Mohamad_Alzoubi_personal_website/presentation/widgets/custom_spacer.dart';
import 'package:Mohamad_Alzoubi_personal_website/presentation/widgets/page_wrapper.dart';
import 'package:Mohamad_Alzoubi_personal_website/presentation/widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:Mohamad_Alzoubi_personal_website/values/values.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:visibility_detector/visibility_detector.dart';

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
  late AnimationController _recentWorksController;
  late AnimationController _slideTextController;
  late NavigationArguments _arguments;

  // Define common padding and margin
  final EdgeInsets _commonPadding = EdgeInsets.all(16.0);
  final EdgeInsets _commonMargin = EdgeInsets.symmetric(horizontal: 16.0);

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getArguments();
    double projectItemHeight = assignHeight(context, 0.4);
    double subHeight = (3 / 4) * projectItemHeight;
    double extra = projectItemHeight - subHeight;
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
          CustomSpacer(heightFactor: 0.1),
          CustomSpacer(heightFactor: 0.05),
          AnimatedFooter(),
        ],
      ),
    );
  }
}
