import 'package:flutter/material.dart';
import 'package:qtec_video_app/model/trending_model.dart';
import 'package:qtec_video_app/utils/route/routes_name.dart';
import 'package:qtec_video_app/view/details_screen.dart';
import 'package:qtec_video_app/view/home_screen.dart';


class Routes {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case RoutesName.detailsScreen:
        final  model = settings.arguments as Result;
        return MaterialPageRoute(
          builder: (context) =>   DetailsScreen(model: model),
        );
      
      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text("No page route define"),
            ),
          );
        });
    }
  }
}
