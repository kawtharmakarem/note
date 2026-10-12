import 'package:flutter/material.dart';

import '/core/responsive_services/responsive_services.dart';
import '/features/splash/presentation/components/mobile_splash_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobileLayout: (context) => MobileSplashScreen(),
      tabletLayout: (context) => SizedBox(), //todolater
      desktopLayout: (context) => SizedBox(), //todo later
    );
  }
}
