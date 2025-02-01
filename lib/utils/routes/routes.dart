import 'package:flutter/material.dart';
import 'package:internship_task/utils/routes/routes_name.dart';
import 'package:internship_task/view/auth/login_screen.dart';
import 'package:internship_task/view/auth/signup_screen.dart';
import 'package:internship_task/view/screens/bottom_navigation.dart';
import 'package:internship_task/view/screens/profile_screen.dart';
import 'package:internship_task/view/splash_screen.dart';

// class for managing routes
class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // if route name is splash then navigate to SplashScreen
      case RoutesName.splash:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
        );
      case RoutesName.login:
        return MaterialPageRoute(
          builder: (context) => LoginScreen(),
        );
      case RoutesName.signUpScreen:
        return MaterialPageRoute(
          builder: (context) => SignupScreen(),
        );
      case RoutesName.bottomNav:
        return MaterialPageRoute(
          builder: (context) => BottomNavigation(),
        );
      case RoutesName.profileScreen:
        // taking arguments as Map and assign to args variable
        dynamic args = settings.arguments as Map<String, String?>;

        return MaterialPageRoute(
          builder: (context) => CustomerProfileScreen(
            imageUrl: args["imageUrl"],
            name: args["name"],
            mobileNo: args["mobileNo"],
            about: args["about"],
            address: args["address"],
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              body: Center(child: Text("No Route Found")),
            );
          },
        );
    }
  }
}
