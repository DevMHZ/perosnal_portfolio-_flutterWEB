import 'package:Mohamad_Alzoubi_personal_website/values/values.dart';
import 'package:flutter/material.dart';
import 'package:Mohamad_Alzoubi_personal_website/app_theme.dart';
import 'package:Mohamad_Alzoubi_personal_website/presentation/pages/home/home_page.dart';
import 'package:Mohamad_Alzoubi_personal_website/presentation/routes/routes.dart';
import 'package:layout/layout.dart';
import 'configure_web.dart';

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
