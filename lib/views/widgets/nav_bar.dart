import 'package:Mohamad_Alzoubi_personal_website/core/layout/adaptive.dart';
import 'package:Mohamad_Alzoubi_personal_website/core/utils/functions.dart';
import 'package:Mohamad_Alzoubi_personal_website/core/widgets/custombutton.dart';
import 'package:Mohamad_Alzoubi_personal_website/core/widgets/animated_text_slide_box_transition.dart';
import 'package:Mohamad_Alzoubi_personal_website/core/widgets/app_logo.dart';
import 'package:Mohamad_Alzoubi_personal_website/core/widgets/empty.dart';
import 'package:Mohamad_Alzoubi_personal_website/core/widgets/nav_item.dart';
import 'package:Mohamad_Alzoubi_personal_website/core/widgets/spaces.dart';
import 'package:Mohamad_Alzoubi_personal_website/core/values/values.dart';
import 'package:control_style/control_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:responsive_builder/responsive_builder.dart';

class NavBar extends StatelessWidget {
  NavBar({
    Key? key,
    required this.selectedRouteTitle,
    required this.selectedRouteName,
    required this.controller,
    this.selectedRouteTitleStyle,
    this.onMenuTap,
    this.onNavItemWebTap,
    this.hasSideTitle = true,
    this.selectedTitleColor = AppColors.black,
    this.titleColor = AppColors.grey600,
    this.appLogoColor = AppColors.black,
  }) : super(key: key);

  final String selectedRouteTitle;
  final String selectedRouteName;
  final AnimationController controller;
  final TextStyle? selectedRouteTitleStyle;
  final GestureTapCallback? onMenuTap;
  final bool hasSideTitle;
  final Color titleColor;
  final Color selectedTitleColor;
  final Color appLogoColor;
  final Function(String)? onNavItemWebTap;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      double screenWidth = sizingInformation.screenSize.width;

      return screenWidth <= RefinedBreakpoints().tabletNormal
          ? mobileNavBar(context)
          : webNavBar(context);
    });
  }

  Widget mobileNavBar(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: widthOfScreen(context),
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.PADDING_30,
            vertical: Sizes.PADDING_24,
          ),
          child: Row(
            children: [
              AppLogo(
                fontSize: Sizes.TEXT_SIZE_30,
                titleColor: appLogoColor,
              ),
              Spacer(),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => _buildMobileNavDrawer(context),
                );
              },
              backgroundColor: Colors.lightBlue,
              child: Icon(
                FeatherIcons.menu,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileNavDrawer(BuildContext context) {
    return Container(
      width: double.infinity,
      height: heightOfScreen(context) / 2.2,
      padding: const EdgeInsets.symmetric(vertical: Sizes.PADDING_10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(90), // More pronounced rounding
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ..._buildmobileNavItems(context, menuList: Data.menuItems),
          SizedBox(
            height: 15,
          ),
          Container(height: 50, width: 140, child: AnimatedShadowButton()),
        ],
      ),
    );
  }

  List<Widget> _buildmobileNavItems(
    BuildContext context, {
    required List<NavItemData> menuList,
  }) {
    List<Widget> items = [];
    for (int index = 0; index < menuList.length; index++) {
      items.add(
        MobileNavItem(
          controller: controller,
          title: menuList[index].name,
          route: menuList[index].route,
          titleColor: titleColor,
          selectedColor: selectedTitleColor,
          index: index + 1,
          isSelected: menuList[index].route == selectedRouteName,
          onTap: () {
            if (onNavItemWebTap != null) {
              onNavItemWebTap!(menuList[index].route);
            }
          },
        ),
      );
    }
    return items;
  }

  Widget webNavBar(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle? style = selectedRouteTitleStyle ??
        textTheme.bodyLarge?.copyWith(
          color: AppColors.black,
          fontWeight: FontWeight.w400,
          fontSize: Sizes.TEXT_SIZE_12,
        );
    return Container(
      width: widthOfScreen(context),
      height: heightOfScreen(context),
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.PADDING_40,
        vertical: Sizes.PADDING_24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppLogo(titleColor: appLogoColor),
              Spacer(),
              ..._buildNavItems(context, menuList: Data.menuItems),
              Container(height: 50, width: 140, child: AnimatedShadowButton()),
            ],
          ),
          Spacer(),
          hasSideTitle
              ? RotatedBox(
                  quarterTurns: 3,
                  child: AnimatedTextSlideBoxTransition(
                    controller: controller,
                    text: selectedRouteTitle.toUpperCase(),
                    textStyle: style,
                  ),
                )
              : Empty(),
          Spacer(),
        ],
      ),
    );
  }

  List<Widget> _buildNavItems(
    BuildContext context, {
    required List<NavItemData> menuList,
  }) {
    List<Widget> items = [];
    for (int index = 0; index < menuList.length; index++) {
      items.add(
        NavItem(
          controller: controller,
          title: menuList[index].name,
          route: menuList[index].route,
          titleColor: titleColor,
          selectedColor: selectedTitleColor,
          index: index + 1,
          isSelected: menuList[index].route == selectedRouteName,
          onTap: () {
            if (onNavItemWebTap != null) {
              onNavItemWebTap!(menuList[index].route);
            }
          },
        ),
      );
      items.add(SpaceW24()); // Maintain spacing consistency
    }
    return items;
  }
}

class MobileNavItem extends StatefulWidget {
  const MobileNavItem({
    super.key,
    required this.title,
    required this.route,
    required this.index,
    required this.controller,
    this.titleColor = AppColors.grey600,
    this.selectedColor = AppColors.black,
    this.isSelected = false,
    this.titleStyle,
    this.onTap,
  });

  final String title;
  final int index;
  final String route;
  final TextStyle? titleStyle;
  final Color titleColor;
  final Color selectedColor;
  final bool isSelected;
  final AnimationController controller;
  final GestureTapCallback? onTap;

  @override
  _MobileNavItemState createState() => _MobileNavItemState();
}

class _MobileNavItemState extends State<MobileNavItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: widget.isSelected
              ? widget.selectedColor.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          widget.title,
          style: widget.titleStyle?.copyWith(
                color: widget.isSelected
                    ? widget.selectedColor
                    : widget.titleColor,
              ) ??
              TextStyle(
                color: widget.isSelected
                    ? widget.selectedColor
                    : widget.titleColor,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}

class AnimatedShadowButton extends StatefulWidget {
  const AnimatedShadowButton({super.key});

  @override
  State<AnimatedShadowButton> createState() => _AnimatedShadowButtonState();
}

class _AnimatedShadowButtonState extends State<AnimatedShadowButton>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Tween<double> tween;
  late Animation<double> animation;

  @override
  void initState() {
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    tween = Tween<double>(begin: 0, end: 359);
    animation = controller.drive(tween);

    controller.forward();
    controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return TextButton(
                onPressed: () {
                  Functions.launchUrl(DocumentPath.CV);
                },
                style: TextButton.styleFrom(
                  fixedSize: const Size(300, 50),
                  shape: DecoratedOutlinedBorder(
                    shadow: [
                      GradientShadow(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.topRight,
                            colors: _generateGradientColors(animation.value),
                            stops: _generateGradientStops(),
                          ),
                          offset: const Offset(-4, 4),
                          blurRadius: 12,
                          spreadRadius: 2)
                    ],
                    child: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                child: const Text(
                  "Download CV",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Colors.black),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  List<Color> _generateGradientColors(double offset) {
    List<Color> colors = [];
    const int divisions = 10;
    for (int i = 0; i < divisions; i++) {
      double hue = (360 / divisions) * i;
      hue += offset;
      if (hue > 360) {
        hue -= 360;
      }
      final Color color = HSVColor.fromAHSV(1.0, hue, 1.0, 1.0).toColor();
      colors.add(color);
    }
    colors.add(colors[0]);
    return colors;
  }

  List<double> _generateGradientStops() {
    const int divisions = 10;
    List<double> stops = [];
    for (int i = 0; i <= divisions; i++) {
      stops.add(i / divisions);
    }
    return stops;
  }
}
