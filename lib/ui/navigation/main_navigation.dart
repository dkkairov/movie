import 'package:flutter/material.dart';
import 'package:movie/Library/Widgets/Inherited/provider.dart';
import 'package:movie/widgets/auth/auth_model.dart';
import 'package:movie/widgets/auth/auth_widget.dart';
import 'package:movie/widgets/main_screen/main_screen_model.dart';
import 'package:movie/widgets/main_screen/main_screen_widget.dart';
import 'package:movie/widgets/movie_details/movie_details_model.dart';
import 'package:movie/widgets/movie_details/movie_details_widget.dart';
import 'package:movie/widgets/movie_trailer/movie_trailer_widget.dart';

abstract class MainNavigationRouteNames {
  static const auth = 'auth';
  static const mainScreen = '/';
  static const movieDetails = '/movie_details';
  static const movieTrailerWidget = '/movie_details/trailer';
}

class MainNavigation {
  String initialRoute(bool isAuth) => isAuth
      ? MainNavigationRouteNames.mainScreen
      : MainNavigationRouteNames.auth;
  final routes = <String, Widget Function(BuildContext)> {
    MainNavigationRouteNames.auth:  (context) => NotifierProvider(
      create: () => AuthModel(),
      child: const AuthWidget()
    ),
    MainNavigationRouteNames.mainScreen:  (context) => NotifierProvider(
        create: () => MainScreenModel(),
        child: const MainScreenWidget()
    ),
  };

  Route<Object>? onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.movieDetails:
        final arguments = settings.arguments;
        final movieId = arguments is int ? arguments : 0;
        return MaterialPageRoute(builder: (context) {
          return NotifierProvider(
              create: () => MovieDetailsModel(movieId),
              child: MovieDetailsWidget()
          );
        });
      case MainNavigationRouteNames.movieTrailerWidget:
        final arguments = settings.arguments;
        final youtubeKey = arguments is String ? arguments : '';
        return MaterialPageRoute(builder: (context) {
          return MovieTrailerWidget(youtubeKey: youtubeKey);
        });
      default:
        const widget = Text('Navigation Error');
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}