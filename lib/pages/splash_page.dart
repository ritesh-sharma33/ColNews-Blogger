import 'dart:async';

import 'package:college_news_blog/pages/home_page.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({this.page})
    : super(
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondayAnimation,
      ) => page,
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child
      ) => SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1.0, 0.0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      )
    );
}

class SplashPage extends StatefulWidget {

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    startTimerDuration();
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      }
    );
  }

  startTimerDuration() {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigateToHome);
  }

  void navigateToHome() {
    Navigator.pushReplacement(
      context, 
      SlideRightRoute(
        page: HomePage()
      )
    );
  }
  String _getSplashLogo() {
    return DynamicTheme.of(context).brightness == Brightness.light ? 'assets/images/logo_light.png' : 'assets/images/logo_dark.png';
  }

  Color _getBackgroundColor() {
    return DynamicTheme.of(context).brightness == Brightness.light ? Colors.white : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: _getBackgroundColor(),
      body: Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(_getSplashLogo(), height: deviceHeight * 0.50, width: deviceHeight * 0.50,),
              SizedBox(height: 10,),
              // Text(
              //   "ColNews Blogger",
              //   style: TextStyle(
              //     color: Colors.blueAccent,
              //     fontSize: 30,
              //     fontFamily: 'Baloo'
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}