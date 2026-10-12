import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/home/cubit/home_cubit.dart';
import '/features/home/cubit/home_state.dart';
import '/features/home/presentation/components/bottom_navigation_bar_widget.dart';

class MobileMainScreen extends StatelessWidget {
  const MobileMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is InsertFolderSuccess) {
          final cubit = context.read<HomeCubit>();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            cubit.folderController.animateTo(
              cubit.folderController.position.maxScrollExtent,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          });
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        return Scaffold(
          body: cubit.getPage(cubit.bottomBarIndex),
          bottomNavigationBar: BottomNavigationBarWidget(),
        );
      },
    );
  }
}
