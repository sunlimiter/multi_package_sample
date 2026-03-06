import 'dart:async';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:auth_api/auth_api.dart';
import 'package:home_api/home_api.dart';
import '../localization/splash_localizations.dart';

class SplashScreen extends HookWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final countdown = useState(3);

    useEffect(() {
      final timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (!context.mounted) {
          timer.cancel();
          return;
        }
        if (countdown.value > 1) {
          countdown.value--;
        } else {
          timer.cancel();
          final isLoggedIn = SessionManager.defaultManager.isLogin();
          // Navigate to Home or Auth respectively based on login state
          if (isLoggedIn) {
            context.go(HomeRoutes.root);
          } else {
            context.go(AuthRoutes.root);
          }
        }
      });
      return timer.cancel;
    }, const []);

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.orange.shade900,
              Colors.orange.shade800,
              Colors.orange.shade400,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(seconds: 1),
              curve: Curves.elasticOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: child,
                );
              },
              child: const Icon(
                Icons.flash_on_rounded,
                size: 120,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 32),
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 1500),
              curve: Curves.easeIn,
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: child,
                );
              },
              child: Text(
                AppLocalizations.of(context)?.splash_welcome ?? 'WELCOME',
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 8,
                ),
              ),
            ),
            const SizedBox(height: 48),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                AppLocalizations.of(context)?.splash_starting_in(countdown.value) ?? 'Starting in ${countdown.value}s...',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
