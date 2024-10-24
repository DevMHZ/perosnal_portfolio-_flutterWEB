import 'package:Mohamad_Alzoubi_personal_website/core/layout/adaptive.dart';
import 'package:Mohamad_Alzoubi_personal_website/core/utils/functions.dart';
import 'package:Mohamad_Alzoubi_personal_website/views/widgets/socials.dart';
import 'package:Mohamad_Alzoubi_personal_website/views/works/works_page.dart';
import 'package:Mohamad_Alzoubi_personal_website/core/widgets/animated_bubble_button.dart';
import 'package:Mohamad_Alzoubi_personal_website/core/widgets/animated_line_through_text.dart';
import 'package:Mohamad_Alzoubi_personal_website/core/widgets/animated_positioned_widget.dart';
import 'package:Mohamad_Alzoubi_personal_website/core/widgets/animated_text_slide_box_transition.dart';
import 'package:Mohamad_Alzoubi_personal_website/core/widgets/spaces.dart';
import 'package:Mohamad_Alzoubi_personal_website/core/values/values.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

const kDuration = Duration(milliseconds: 700);

class HomePageHeader extends StatefulWidget {
  const HomePageHeader({
    Key? key,
    required this.scrollToWorksKey,
    required this.controller,
  }) : super(key: key);

  final GlobalKey scrollToWorksKey;
  final AnimationController controller;
  @override
  _HomePageHeaderState createState() => _HomePageHeaderState();
}

class _HomePageHeaderState extends State<HomePageHeader>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController rotationController;
  late AnimationController scrollDownButtonController;
  late Animation<Offset> animation;
  late Animation<Offset> scrollDownBtnAnimation;

  @override
  void initState() {
    scrollDownButtonController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    rotationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    )..repeat();
    animation = Tween<Offset>(
      begin: Offset(0, 0.05),
      end: Offset(0, -0.05),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    rotationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        rotationController.reset();
        rotationController.forward();
      }
    });
    controller.forward();
    rotationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    scrollDownButtonController.dispose();
    rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = widthOfScreen(context);
    final double screenHeight = heightOfScreen(context);

    final EdgeInsets textMargin = EdgeInsets.only(
      left: responsiveSize(
        context,
        10,
        screenWidth * 0.15,
        sm: screenWidth * 0.10,
      ),
      top: responsiveSize(
        context,
        60,
        screenHeight * 0.35,
        sm: screenHeight * 0.25,
      ),
      bottom: responsiveSize(context, 10, 20),
    );

    final EdgeInsets padding = EdgeInsets.symmetric(
      horizontal: responsiveSize(
          context, 10, 40), // Reduced padding for smaller screens
      vertical: responsiveSize(context, 20, screenHeight * 0.5),
    );

    final EdgeInsets imageMargin = EdgeInsets.only(
      right: responsiveSize(
        context,
        10,
        screenWidth * 0.05,
        sm: screenWidth * 0.03, // Adjusted margin for better fit on mobile
      ),
      top: responsiveSize(
        context,
        20, // Reduced top margin for mobile
        screenHeight * 0.15,
        sm: screenHeight * 0.20,
      ),
      bottom: responsiveSize(context, 10, 20),
    );

    return Container(
      width: screenWidth,
      color: AppColors.accentColor2.withOpacity(0.35),
      child: Stack(
        children: [
          ResponsiveBuilder(builder: (context, sizingInformation) {
            double screenWidth = sizingInformation.screenSize.width;

            // Mobile layout adjustments
            if (screenWidth < RefinedBreakpoints().tabletNormal) {
              return Column(
                children: [
                  Container(
                    padding: padding,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: screenWidth,
                        ),
                        CircleAvatar(
                          radius: screenWidth / 3.5,
                          backgroundColor: Colors.white,
                          child: ClipOval(
                            child: Image.asset(
                              ImagePath.DEV_MEDITATE,
                              width: screenWidth * 0.6,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: padding.copyWith(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .center, // Center align text for mobile
                      children: [
                        AboutDev(
                          controller: widget.controller,
                          width: screenWidth *
                              0.9, // Adjust width for mobile layout
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              // Original desktop/tablet layout remains unchanged
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: textMargin,
                    child: Container(
                      width: screenWidth * 0.40,
                      child: AboutDev(
                        controller: widget.controller,
                        width: screenWidth * 0.40,
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.05),
                  Container(
                    margin: imageMargin,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          ImagePath.DEV_SKILLS_2,
                          width: screenWidth * 0.35,
                        ),
                        CircleAvatar(
                          radius: screenWidth *
                              0.115, // Adjusted for desktop/tablet
                          child: ClipOval(
                            child: Image.asset(
                              ImagePath.DEV_MEDITATE,
                              width: screenWidth * 0.25,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          }),
        ],
      ),
    );
  }
}

class WhiteCircle extends StatelessWidget {
  const WhiteCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widthOfCircle = responsiveSize(
      context,
      widthOfScreen(context) / 2.5,
      widthOfScreen(context) / 3.5,
    );
    return Container(
      width: widthOfCircle,
      height: widthOfCircle,
      decoration: BoxDecoration(
        color: const Color(0xFF027dfe),
        borderRadius: BorderRadius.all(
          Radius.circular(widthOfCircle / 2),
        ),
      ),
    );
  }
}

class AboutDev extends StatefulWidget {
  const AboutDev({
    Key? key,
    required this.controller,
    required this.width,
  }) : super(key: key);

  final AnimationController controller;
  final double width;

  @override
  _AboutDevState createState() => _AboutDevState();
}

class _AboutDevState extends State<AboutDev> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    EdgeInsetsGeometry margin = const EdgeInsets.only(left: 16);
    final CurvedAnimation curvedAnimation = CurvedAnimation(
      parent: widget.controller,
      curve: Interval(0.6, 1.0, curve: Curves.fastOutSlowIn),
    );
    double headerFontSize = responsiveSize(context, 28, 48, md: 36, sm: 32);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: margin,
          child: AnimatedTextSlideBoxTransition(
            controller: widget.controller,
            text: StringConst.HI,
            width: widget.width,
            maxLines: 3,
            textStyle: textTheme.displayMedium?.copyWith(
              color: AppColors.black,
              fontSize: headerFontSize,
            ),
          ),
        ),
        SpaceH12(),
        Container(
          margin: margin,
          child: AnimatedTextSlideBoxTransition(
            controller: widget.controller,
            text: StringConst.DEV_INTRO,
            width: widget.width,
            maxLines: 3,
            textStyle: textTheme.displayMedium?.copyWith(
              color: AppColors.black,
              fontSize: headerFontSize,
            ),
          ),
        ),
        SpaceH12(),
        Container(
          margin: margin,
          child: AnimatedTextSlideBoxTransition(
            controller: widget.controller,
            text: StringConst.DEV_TITLE,
            width: responsiveSize(
              context,
              widget.width * 0.75,
              widget.width,
              md: widget.width,
              sm: widget.width,
            ),
            maxLines: 3,
            textStyle: textTheme.displayMedium?.copyWith(
              color: AppColors.black,
              fontSize: headerFontSize,
            ),
          ),
        ),
        SpaceH30(),
        AnimatedPositionedWidget(
          controller: curvedAnimation,
          width: 200,
          height: 60,
          child: AnimatedBubbleButton(
            color: AppColors.grey100,
            imageColor: AppColors.black,
            startOffset: Offset(0, 0),
            targetOffset: Offset(0.1, 0),
            targetWidth: 200,
            startBorderRadius: const BorderRadius.all(
              Radius.circular(100.0),
            ),
            title: StringConst.SEE_MY_WORKS.toUpperCase(),
            titleStyle: textTheme.bodyLarge?.copyWith(
              color: AppColors.black,
              fontSize: responsiveSize(
                context,
                Sizes.TEXT_SIZE_14,
                Sizes.TEXT_SIZE_16,
                sm: Sizes.TEXT_SIZE_15,
              ),
              fontWeight: FontWeight.w500,
            ),
            onTap: () {
              Navigator.pushNamed(context, WorksPage.worksPageRoute);
            },
          ),
        ),
        SpaceH40(),
        Container(
          margin: margin,
          child: Wrap(
            spacing: 20,
            runSpacing: 20,
            children: _buildSocials(
              context: context,
              data: Data.socialData1,
            ),
          ),
        )
      ],
    );
  }

  List<Widget> _buildSocials({
    required BuildContext context,
    required List<SocialData> data,
  }) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle? style = textTheme.bodyLarge?.copyWith(color: AppColors.grey750);
    TextStyle? slashStyle = textTheme.bodyLarge?.copyWith(
      color: AppColors.grey750,
      fontWeight: FontWeight.w400,
      fontSize: 18,
    );
    List<Widget> items = [];

    for (int index = 0; index < data.length; index++) {
      items.add(
        AnimatedLineThroughText(
          text: data[index].name,
          isUnderlinedByDefault: false,
          controller: widget.controller,
          hasSlideBoxAnimation: true,
          hasOffsetAnimation: true,
          isUnderlinedOnHover: false,
          onTap: () {
            Functions.launchUrl(data[index].url);
          },
          textStyle: style,
        ),
      );

      if (index < data.length - 1) {
        items.add(
          Text('/', style: slashStyle),
        );
      }
    }

    return items;
  }
}
