import 'package:Mohamad_Alzoubi_personal_website/configure_web.dart';
import 'package:Mohamad_Alzoubi_personal_website/core/values/values.dart';
import 'package:flutter/material.dart';
import 'package:Mohamad_Alzoubi_personal_website/core/theme/app_theme.dart';
import 'package:Mohamad_Alzoubi_personal_website/views/home/home_page.dart';
import 'package:Mohamad_Alzoubi_personal_website/core/routes/routes.dart';
import 'package:layout/layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: MaterialApp(
        title: StringConst.APP_TITLE,
        theme: AppTheme.lightThemeData,
        debugShowCheckedModeBanner: false,
        initialRoute: HomePage.homePageRoute,
        onGenerateRoute: RouteConfiguration.onGenerateRoute,
      ),
    );
  }
}
