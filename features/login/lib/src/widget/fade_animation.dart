// ignore_for_file: prefer_int_literals

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

///author: lty
////Time: 2022/10/26
////Description:
class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  const FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final MovieTween tween = MovieTween()
      ..tween(
        'opacity',
        Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 500),
      )
      ..tween(
        'translateY',
        Tween(begin: -30.0, end: 0.0),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );

    return PlayAnimationBuilder<Movie>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, value, child) {
        return Opacity(
          opacity: value.get('opacity'),
          child: Transform.translate(
            offset: Offset(0, value.get('translateY')),
            child: child,
          ),
        );
      },
    );
  }
}
