import 'package:flutter/material.dart';
import 'package:movie/theme/app_colors.dart';
import 'package:movie/widgets/auth/auth_model.dart';
import 'package:movie/widgets/auth/auth_widget.dart';
import 'package:movie/widgets/main_screen/main_screen_widget.dart';
import 'package:movie/widgets/movie_details/movie_details_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            backgroundColor: AppColors.mainDarkBlue,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.mainDarkBlue,
          selectedItemColor: AppColors.mainWhite,
          unselectedItemColor: AppColors.mainLightBlue,
        ),
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/auth': (context) => AuthProvider(
            model: AuthModel(),
            child: AuthWidget()
        ),
        '/main_screen': (context) => MainScreenWidget(),
        '/main_screen/movie_details': (context) {

          final arguments = ModalRoute.of(context)?.settings.arguments;
          if (arguments is int) {
            return MovieDetailsWidget(movieId: arguments);
          } else {
            return MovieDetailsWidget(movieId: 1);
          }
        },
      },
      initialRoute: '/auth',
      // onGenerateRoute: (RouteSettings settings) {
      //   return MaterialPageRoute<void>(builder: (context) {
      //     return Scaffold(
      //       body: Center(
      //           child: Text('Error 404')
      //       )
      //     );
      //   });
      // },
    );
  }
}