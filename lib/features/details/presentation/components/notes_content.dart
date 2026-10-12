import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/details/cubit/details_cubit.dart';
import '/features/details/presentation/components/note_item.dart';

class NotesContent extends StatefulWidget {
  const NotesContent({super.key});

  @override
  State<NotesContent> createState() => _NotesContentState();
}

class _NotesContentState extends State<NotesContent>
    with SingleTickerProviderStateMixin {
  final Random random = Random();
  double randomAngle() {
    return (random.nextDouble() - 0.5) * 0.2; //this is making small rotation
  }

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DetailsCubit>();
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: cubit.notes.length < 2
          ? size.height * 0.4
          : cubit.notes.length * 220, //130
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          ...List.generate(cubit.notes.length, (index) {
            return Positioned(
              left: index % 2 == 0 ? 10 : 200,
              top: index % 2 == 0
                  ? 40 + index * 120
                  : index * 120 - 50, //120 220
              child: Transform.rotate(
                angle: randomAngle(),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: NoteItem(noteModel: cubit.notes[index]),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
