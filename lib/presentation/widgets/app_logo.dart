import 'package:Mohamad_Alzoubi_personal_website/values/values.dart';
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    Key? key,
    this.title = "MHZ",
    this.titleColor = AppColors.black,
    this.titleStyle,
    this.fontSize = 60,
  }) : super(key: key);

  final String title;
  final TextStyle? titleStyle;
  final Color titleColor;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Text(
      title,
      style: titleStyle ??
          textTheme.displayMedium?.copyWith(
            color: titleColor,
            fontSize: fontSize,
          ),
    );
  }
}
