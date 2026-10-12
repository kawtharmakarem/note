import 'package:flutter/material.dart';

import '/core/responsive_services/responsive_services.dart';
import '/features/auth/presentation/components/mobile_auth_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobileLayout: (context) => MobileAuthScreen(),
      tabletLayout: (context) => SizedBox(),
      desktopLayout: (context) => SizedBox(),
    );
  }
}
