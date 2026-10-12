import 'package:flutter/material.dart';

import '/core/utils/app_styles.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Orders", style: AppStyles.splashText(context)));
  }
}
