import 'package:flutter/widgets.dart';

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;
  CustomPageRoute({required this.child})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return RotationTransition(
              turns: Tween(begin: 0.0, end: 1.0).animate(
                animation,
              ),
              child: child,
            );
            return FadeTransition(
              opacity: animation,
              child: child,
            );
            // Slide
            {
              // var begin = Offset(1.0, 0.0);
              // var end = Offset.zero;
              // var curve = Curves.easeInOut;

              // var tween =
              //     Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              // return SlideTransition(
              //   position: animation.drive(tween),
              //   child: child,
              // );
            }
          },
        );
}
