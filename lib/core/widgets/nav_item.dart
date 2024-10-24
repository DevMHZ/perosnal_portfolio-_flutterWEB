import 'package:Mohamad_Alzoubi_personal_website/core/layout/adaptive.dart';
import 'package:Mohamad_Alzoubi_personal_website/core/values/values.dart';
import 'package:flutter/material.dart';

import 'animated_line_through_text.dart';

const double indicatorWidth = Sizes.WIDTH_60;

class NavItemData {
  final String name;
  final String route;

  NavItemData({
    required this.name,
    required this.route,
  });
}

class NavItem extends StatefulWidget {
  NavItem({
    required this.title,
    required this.route,
    required this.index,
    required this.controller,
    this.titleColor = AppColors.grey600,
    this.selectedColor = AppColors.black,
    this.isSelected = false,
    this.isMobile = false,
    this.titleStyle,
    this.onTap,
  });

  final String title;
  // final AnimationController controller;
  final int index;
  final String route;
  final TextStyle? titleStyle;
  final Color titleColor;
  final Color selectedColor;
  final bool isSelected;
  final bool isMobile;
  final AnimationController controller;
  final GestureTapCallback? onTap;

  @override
  _NavItemState createState() => _NavItemState();
}

class _NavItemState extends State<NavItem> {
  bool _hovering = false;
  bool _hoveringUnselectedNavItemMobile = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (e) => _mouseEnter(true),
      onExit: (e) => _mouseEnter(false),
      child: InkWell(
        onTap: widget.onTap,
        hoverColor: Colors.transparent,
        child: _buildNavItem(),
      ),
    );
  }

  void _mouseEnter(bool hovering) {
    setState(() {
      _hovering = hovering;
    });
  }

  void _onMouseEnterUnselectedNavItemMobile(bool hovering) {
    setState(() {
      _hoveringUnselectedNavItemMobile = hovering;
    });
  }

  Widget _buildNavItem() {
    return widget.isMobile ? mobileText() : desktopText();
  }

  Widget mobileText() {
    TextTheme textTheme = Theme.of(context).textTheme;
    double indexTextSize = 80;
    double selectedTextSize = 36;
    double unselectedTextSize = 36;
    return widget.isSelected
        ? Stack(
            children: [
              _buildNavItemIndex(
                index: widget.index,
                indexTextSize: indexTextSize,
              ),
              Container(
                margin: EdgeInsets.only(
                    top: (indexTextSize - selectedTextSize) / 3),
                child: Align(
                  alignment: Alignment.center,
                  child: AnimatedLineThroughText(
                    text: widget.title.toUpperCase(),
                    isUnderlinedOnHover: false,
                    textStyle: widget.titleStyle ??
                        widget.titleStyle ??
                        textTheme.titleLarge?.copyWith(
                          fontSize: selectedTextSize,
                          color: AppColors.accentColor,
                          fontWeight: FontWeight.w400,
                        ),
                    hoverColor: AppColors.accentColor,
                    coverColor: AppColors.black,
                    lineThickness: 4,
                    onHoverTextStyle: textTheme.titleLarge?.copyWith(
                      fontSize: selectedTextSize,
                      color: AppColors.accentColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          )
        : MouseRegion(
            onEnter: (e) => _onMouseEnterUnselectedNavItemMobile(true),
            onExit: (e) => _onMouseEnterUnselectedNavItemMobile(false),
            child: Stack(
              children: [
                AnimatedOpacity(
                  opacity: _hoveringUnselectedNavItemMobile ? 1 : 0,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.ease,
                  child: _buildNavItemIndex(
                    index: widget.index,
                    indexTextSize: indexTextSize,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: (indexTextSize - selectedTextSize) / 3),
                  child: Align(
                    alignment: Alignment.center,
                    child: AnimatedLineThroughText(
                      text: widget.title.toUpperCase(),
                      isUnderlinedOnHover: false,
                      textStyle: widget.titleStyle ??
                          textTheme.bodyLarge?.copyWith(
                            fontSize: unselectedTextSize,
                            fontWeight: FontWeight.w400,
                          ),
                      hoverColor: AppColors.accentColor,
                      coverColor: AppColors.black,
                      lineThickness: 4,
                      onHoverTextStyle: textTheme.bodyLarge?.copyWith(
                        fontSize: unselectedTextSize,
                        color: AppColors.accentColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  Widget desktopText() {
    TextTheme textTheme = Theme.of(context).textTheme;

    double textSize = responsiveSize(
      context,
      Sizes.TEXT_SIZE_14,
      Sizes.TEXT_SIZE_16,
      md: Sizes.TEXT_SIZE_15,
    );
    TextStyle? defaultSelectedItemStyle = textTheme.bodyLarge?.copyWith(
      fontSize: textSize,
      color: widget.selectedColor,
      fontWeight: FontWeight.w400,
    );
    TextStyle? defaultUnselectedItemStyle = textTheme.bodyLarge?.copyWith(
      fontSize: textSize,
      color: widget.titleColor,
    );

    return widget.isSelected
        ? AnimatedLineThroughText(
            text: widget.title,
            isUnderlinedOnHover: false,
            hasOffsetAnimation: true,
            hasSlideBoxAnimation: true,
            controller: widget.controller,
            textStyle: widget.titleStyle ?? defaultSelectedItemStyle,
          )
        : AnimatedLineThroughText(
            text: widget.title,
            isUnderlinedOnHover: false,
            hasOffsetAnimation: true,
            textStyle: widget.titleStyle ?? defaultUnselectedItemStyle,
            onHoverTextStyle: defaultUnselectedItemStyle?.copyWith(
              color: widget.selectedColor,
              fontWeight: FontWeight.w400,
            ),
          );
  }

  Widget _buildNavItemIndex({required int index, double? indexTextSize}) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Align(
      alignment: Alignment.center,
      child: Text(
        '0$index',
        style: widget.titleStyle ??
            textTheme.displayMedium?.copyWith(
              fontSize: indexTextSize,
              color: AppColors.grey800,
              // fontWeight: FontWeight.w400,
            ),
      ),
    );
  }
}
