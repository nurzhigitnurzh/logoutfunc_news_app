import 'package:flutter/material.dart';
import 'package:home1/core/di/injection.dart';
import 'package:home1/core/service/storage_service/storage_service.dart';
import 'package:home1/features/auth/ui/presentation/auth_page.dart';
import 'package:home1/features/navigation/ui/presentation/main_page.dart';
import 'package:home1/features/onboarding/ui/presentation/onboarding_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    final storage = getIt<StorageService>();

    final results = await Future.wait([
      storage.isOnboardingSeen(),
      storage.isAuthorized(),
      Future.delayed(const Duration(milliseconds: 1500)),
    ]);
    if (!mounted) return;

    final onboardingSeen = results[0] as bool;
    final authorized = results[1] as bool;

    final Widget next;
    if (!onboardingSeen) {
      next = const OnboardingPage();
    } else if (authorized) {
      next = const MainPage();
    } else {
      next = const AuthPage();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => next),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.newspaper, size: 72),
            SizedBox(height: 16),
            Text(
              'News App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
            ),
            SizedBox(height: 32),
            CircularProgressIndicator(strokeWidth: 2),
          ],
        ),
      ),
    );
  }
}