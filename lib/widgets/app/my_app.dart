import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movie/Library/Widgets/Inherited/provider.dart';
import 'package:movie/theme/app_colors.dart';
import 'package:movie/ui/navigation/main_navigation.dart';
import 'package:movie/widgets/app/my_app_model.dart';

class MyApp extends StatelessWidget {
  // final MyAppModel model;
  static final mainNavigation = MainNavigation();
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.read<MyAppModel>(context);
    return MaterialApp(
      title: 'TMDB',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.mainDarkBlue,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.mainDarkBlue,
          selectedItemColor: AppColors.mainWhite,
          unselectedItemColor: AppColors.mainLightBlue,
        ),
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', 'US'),
        Locale('ru', 'RU'),
      ],
      routes: mainNavigation.routes,
      initialRoute: mainNavigation.initialRoute(model?.isAuth == true),
      onGenerateRoute: mainNavigation.onGeneratedRoute,
    );
  }
}