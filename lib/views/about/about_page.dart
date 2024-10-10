import 'package:Mohamad_Alzoubi_personal_website/core/layout/adaptive.dart';
import 'package:Mohamad_Alzoubi_personal_website/core/utils/functions.dart';
import 'package:Mohamad_Alzoubi_personal_website/views/about/widgets/about_header.dart';
import 'package:Mohamad_Alzoubi_personal_website/views/about/widgets/technology_section.dart';
import 'package:Mohamad_Alzoubi_personal_website/views/widgets/animated_footer.dart';
import 'package:Mohamad_Alzoubi_personal_website/views/widgets/socials.dart';
import 'package:Mohamad_Alzoubi_personal_website/core/widgets/animated_line_through_text.dart';
import 'package:Mohamad_Alzoubi_personal_website/core/widgets/animated_positioned_text.dart';
import 'package:Mohamad_Alzoubi_personal_website/core/widgets/animated_text_slide_box_transition.dart';
import 'package:Mohamad_Alzoubi_personal_website/core/widgets/content_area.dart';
import 'package:Mohamad_Alzoubi_personal_website/core/widgets/custom_spacer.dart';
import 'package:Mohamad_Alzoubi_personal_website/core/widgets/page_wrapper.dart';
import 'package:Mohamad_Alzoubi_personal_website/core/widgets/spaces.dart';
import 'package:Mohamad_Alzoubi_personal_website/core/values/values.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../core/widgets/content_builder.dart';

class AboutPage extends StatefulWidget {
  static const String aboutPageRoute = StringConst.ABOUT_PAGE;
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _storyController;
  late AnimationController _technologyController;
  late AnimationController _contactController;
  late AnimationController _technologyListController;
  late AnimationController _quoteController;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _storyController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _technologyController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _technologyListController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _contactController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _quoteController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _storyController.dispose();
    _technologyController.dispose();
    _technologyListController.dispose();
    _contactController.dispose();
    _quoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double contentAreaWidth = responsiveSize(
      context,
      assignWidth(context, 0.8),
      assignWidth(context, 0.75),
      sm: assignWidth(context, 0.8),
    );
    EdgeInsetsGeometry padding = EdgeInsets.only(
      left: responsiveSize(
        context,
        assignWidth(context, 0.10),
        assignWidth(context, 0.15),
      ),
      right: responsiveSize(
        context,
        assignWidth(context, 0.10),
        assignWidth(context, 0.10),
        // sm: assignWidth(context, 0.10),
      ),
      top: responsiveSize(
        context,
        assignHeight(context, 0.15),
        assignHeight(context, 0.15),
        // sm: assignWidth(context, 0.10),
      ),
    );

    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle? bodyLargeStyle = textTheme.bodyLarge?.copyWith(
      fontSize: Sizes.TEXT_SIZE_18,
      color: AppColors.grey750,
      fontWeight: FontWeight.w400,
      height: 2.0,
      // letterSpacing: 2,
    );
    TextStyle? bodyText2Style =
        textTheme.bodyLarge?.copyWith(color: AppColors.grey750);
    TextStyle? titleStyle = textTheme.titleMedium?.copyWith(
      color: AppColors.black,
      fontSize: responsiveSize(
        context,
        Sizes.TEXT_SIZE_16,
        Sizes.TEXT_SIZE_20,
      ),
    );
    CurvedAnimation _storySectionAnimation = CurvedAnimation(
      parent: _storyController,
      curve: Interval(0.6, 1.0, curve: Curves.ease),
    );
    CurvedAnimation _technologySectionAnimation = CurvedAnimation(
      parent: _technologyController,
      curve: Interval(0.6, 1.0, curve: Curves.fastOutSlowIn),
    );
    double widthOfBody = responsiveSize(
      context,
      assignWidth(context, 0.75),
      assignWidth(context, 0.5),
    );
    return PageWrapper(
      selectedRoute: AboutPage.aboutPageRoute,
      selectedPageName: StringConst.ABOUT,
      navBarAnimationController: _controller,
      onLoadingAnimationDone: () {
        _controller.forward();
      },
      child: ListView(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: [
          Padding(
            padding: padding,
            child: ContentArea(
              width: contentAreaWidth,
              child: Column(
                children: [
                  AboutHeader(
                    width: contentAreaWidth,
                    controller: _controller,
                  ),
                  CustomSpacer(heightFactor: 0.1),
                  VisibilityDetector(
                    key: Key('story-section'),
                    onVisibilityChanged: (visibilityInfo) {
                      double visiblePercentage =
                          visibilityInfo.visibleFraction * 100;
                      if (visiblePercentage >
                          responsiveSize(context, 40, 70, md: 50)) {
                        _storyController.forward();
                      }
                    },
                    child: ContentBuilder(
                      controller: _storyController,
                      number: "/01 ",
                      width: contentAreaWidth,
                      section: StringConst.ABOUT_DEV_STORY.toUpperCase(),
                      title: StringConst.ABOUT_DEV_STORY_TITLE,
                      body: Column(
                        children: [
                          AnimatedPositionedText(
                            controller: _storySectionAnimation,
                            width: widthOfBody,
                            maxLines: 30,
                            // factor: 1.25,
                            text: StringConst.ABOUT_DEV_STORY_CONTENT_1,
                            textStyle: bodyLargeStyle,
                          ),
                          AnimatedPositionedText(
                            controller: _storySectionAnimation,
                            width: widthOfBody,
                            maxLines: 30,
                            text: StringConst.ABOUT_DEV_STORY_CONTENT_2,
                            textStyle: bodyLargeStyle,
                          ),
                          AnimatedPositionedText(
                            controller: _storySectionAnimation,
                            width: widthOfBody,
                            maxLines: 30,
                            text: StringConst.ABOUT_DEV_STORY_CONTENT_3,
                            textStyle: bodyLargeStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomSpacer(heightFactor: 0.1),
                  VisibilityDetector(
                    key: Key('contact-section'),
                    onVisibilityChanged: (visibilityInfo) {
                      double visiblePercentage =
                          visibilityInfo.visibleFraction * 100;
                      if (visiblePercentage > 50) {
                        _contactController.forward();
                      }
                    },
                    child: ContentBuilder(
                      controller: _contactController,
                      number: "/02 ",
                      width: contentAreaWidth,
                      section: StringConst.ABOUT_DEV_CONTACT.toUpperCase(),
                      title: StringConst.ABOUT_DEV_CONTACT_SOCIAL,
                      body: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SpaceH20(),
                          Wrap(
                            spacing: 20,
                            runSpacing: 20,
                            children: _buildSocials(Data.socialData2),
                          ),
                        ],
                      ),
                      footer: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SpaceH40(),
                          AnimatedTextSlideBoxTransition(
                            controller: _contactController,
                            text: StringConst.ABOUT_DEV_CONTACT_EMAIL,
                            textStyle: titleStyle,
                          ),
                          SpaceH40(),
                          AnimatedLineThroughText(
                            text: StringConst.DEV_EMAIL,
                            hasSlideBoxAnimation: true,
                            controller: _contactController,
                            onTap: () {
                              Functions.launchUrl(StringConst.EMAIL_URL);
                            },
                            textStyle: bodyText2Style,
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomSpacer(heightFactor: 0.1),
                  VisibilityDetector(
                    key: Key('quote-section'),
                    onVisibilityChanged: (visibilityInfo) {
                      double visiblePercentage =
                          visibilityInfo.visibleFraction * 100;
                      if (visiblePercentage > 50) {
                        _quoteController.forward();
                      }
                    },
                    child: Column(
                      children: [
                        AnimatedTextSlideBoxTransition(
                          controller: _quoteController,
                          text: StringConst.FAMOUS_QUOTE,
                          maxLines: 5,
                          width: contentAreaWidth,
                          textAlign: TextAlign.center,
                          textStyle: titleStyle?.copyWith(
                            fontSize: responsiveSize(
                              context,
                              Sizes.TEXT_SIZE_24,
                              Sizes.TEXT_SIZE_36,
                              md: Sizes.TEXT_SIZE_28,
                            ),
                            height: 2.0,
                          ),
                        ),
                        SpaceH20(),
                        Align(
                          alignment: Alignment.centerRight,
                          child: AnimatedTextSlideBoxTransition(
                            controller: _quoteController,
                            text: "— ${StringConst.FAMOUS_QUOTE_AUTHOR}",
                            textStyle: textTheme.bodyLarge?.copyWith(
                              fontSize: responsiveSize(
                                context,
                                Sizes.TEXT_SIZE_16,
                                Sizes.TEXT_SIZE_18,
                                md: Sizes.TEXT_SIZE_16,
                              ),
                              fontWeight: FontWeight.w400,
                              color: AppColors.grey600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomSpacer(heightFactor: 0.2),
                ],
              ),
            ),
          ),
          // SlidingBanner(),
          AnimatedFooter()
        ],
      ),
    );
  }

  List<Widget> _buildSocials(List<SocialData> data) {
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
          isUnderlinedByDefault: true,
          controller: _contactController,
          hasSlideBoxAnimation: true,
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