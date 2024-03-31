import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      // decoration: BoxDecoration(
      //   image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      // ),
      color: Colors.white,
      child: Center(
        child: child,
      ),
    );
  }
}
