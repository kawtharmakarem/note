import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../features/home/presentation/components/draggable_widget.dart';

class InfiniteSlider extends StatefulWidget {
  const InfiniteSlider({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
    this.index = 0,
  });
  final Function(BuildContext context, int index) itemBuilder;
  final int itemCount;
  final int index;

  @override
  State<InfiniteSlider> createState() => _InfiniteSliderState();
}

class _InfiniteSliderState extends State<InfiniteSlider>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late int index;
  SlideDirection slideDirection = SlideDirection.left;

  double defaultAngleDgree = pi * 0.1;
  Offset getOffser(int stackIndex) {
    return {
          0: Offset(lerpDouble(0, -70, controller.value)!, 30),
          1: Offset(lerpDouble(-70, 70, controller.value)!, 30),
          2: Offset(70, 30) * (1 - controller.value),
        }[stackIndex] ??
        Offset(
          MediaQuery.of(context).size.width *
              controller.value *
              (slideDirection == SlideDirection.left ? -1 : 1),
          0,
        );
  }

  double getAngle(int stackIndex) {
    return {
          0: lerpDouble(0, -defaultAngleDgree, controller.value),
          1: lerpDouble(
            -defaultAngleDgree,
            defaultAngleDgree,
            controller.value,
          ),
          2: lerpDouble(defaultAngleDgree, 0, controller.value),
        }[stackIndex] ??
        0.0;
  }

  double getScale(int stackIndex) {
    return {
          0: lerpDouble(0.6, 0.9, controller.value),
          1: lerpDouble(0.9, 0.95, controller.value),
          2: lerpDouble(0.95, 1, controller.value),
        }[stackIndex] ??
        1.0;
  }

  void animationListener() {
    if (controller.isCompleted) {
      setState(() {
        if (widget.itemCount == ++index) {
          index = 0;
        }
      });
      controller.reset();
    }
  }

  void onSlideOut(SlideDirection direction) {
    slideDirection = direction;
    controller.forward();
  }

  @override
  void initState() {
    super.initState();
    index = widget.index;
    controller = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
    )..addListener(animationListener);
  }

  @override
  void dispose() {
    controller
      ..removeListener(animationListener)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Stack(
          children: List.generate(4, (stackIndex) {
            final modIndex = (index + 3 - stackIndex) % widget.itemCount;
            return Transform.translate(
              offset: getOffser(stackIndex),
              child: Transform.scale(
                scale: getScale(stackIndex),
                child: Transform.rotate(
                  angle: getAngle(stackIndex),
                  child: DraggableWidget(
                    child: widget.itemBuilder(context, modIndex),
                    onSlideOut: onSlideOut,
                    isEnableDrag: stackIndex == 3,
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
