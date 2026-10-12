import 'package:flutter/material.dart';

import '/core/responsive_services/responsive_services.dart';
import '/features/home/presentation/components/mobile_main_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobileLayout: (context) => MobileMainScreen(),
      tabletLayout: (context) => SizedBox(),
      desktopLayout: (context) => SizedBox(),
    );
  }
}
