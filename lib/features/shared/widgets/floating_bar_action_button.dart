import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:motor/motor.dart';
import 'package:ourdeen/features/memorizing/presentation/viewmodels/memorization_verse_viewmodel.dart';
import 'package:provider/provider.dart';

class FloatingBarActionButton extends StatefulWidget {
  const FloatingBarActionButton({super.key});

  @override
  State<FloatingBarActionButton> createState() =>
      _FloatingBarActionButtonState();
}

class _FloatingBarActionButtonState extends State<FloatingBarActionButton> {
  ValueNotifier<double> targetValue = ValueNotifier(1.5);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      child: IntrinsicWidth(
        child: SizedBox(
          height: 96,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 16, left: 16),
                  child: _ToolbarFloatingAnimated(targetNotifier: targetValue)),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: _MenuFloatingAnimated(
                  onPressed: () {
                    setState(() {
                      HapticFeedback.selectionClick();
                      if (targetValue.value == 0.0) {
                        targetValue.value = 1.5;
                      } else {
                        targetValue.value = 0.0;
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuFloatingAnimated extends StatefulWidget {
  const _MenuFloatingAnimated({required this.onPressed});

  final VoidCallback onPressed;

  @override
  State<_MenuFloatingAnimated> createState() => _MenuFloatingAnimatedState();
}

class _MenuFloatingAnimatedState extends State<_MenuFloatingAnimated>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    final springDescription = SpringDescription(
      mass: 1.0,
      stiffness: 10.0,
      damping: 1.0,
    );

    var springSimulation = SpringSimulation(
      springDescription,
      0.0, // initial position
      1.0, // end position
      0.0, // initial velocity
    );

    // create the animation using the springSimulation
    _iconAnimation = _controller.drive(
      Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).chain(CurveTween(curve: _SpringCurve(springSimulation))),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      elevation: 4.0,
      onPressed: () {
        if (_controller.value == 1.0) {
          _controller.reverse();
        } else if (_controller.value == 0.0) {
          _controller.forward();
        }
        widget.onPressed();
      },
      child: AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        progress: _iconAnimation,
      ),
    );
  }
}

// Custom Curve class to integrate SpringSimulation
class _SpringCurve extends Curve {
  final SpringSimulation simulation;

  const _SpringCurve(this.simulation);

  @override
  double transform(double t) {
    // t is normalized time from 0 to 1 based on the AnimationController's duration

    // Estimate a reasonable simulation time based on spring parameters
    // A very rough heuristic: simulate for a fixed time or until velocity is low
    // For simplicity here, we'll map t=0->simTime=0 and t=1->simTime=1.5 (adjust as needed)
    // A better way would be to solve for when the simulation settles, but that's complex.
    // Using a fixed time window that covers most of the spring motion works for many cases.
    final maxSimTime =
        1.0; // Adjust this value to fit how long your spring typically takes
    final simTime = t * maxSimTime;

    // Get the spring's position at the calculated simulation time
    double value = simulation.x(simTime);

    // Ensure the value is clamped between 0 and 1 as expected by AnimatedIcon
    // This is important because the simulation might overshoot slightly due to physics
    return value.clamp(0.0, 1.0);
  }
}

class _ToolbarFloatingAnimated extends StatefulWidget {
  const _ToolbarFloatingAnimated({required this.targetNotifier});

  final ValueNotifier<double> targetNotifier;

  @override
  State<_ToolbarFloatingAnimated> createState() =>
      _ToolbarFloatingAnimatedState();
}

class _ToolbarFloatingAnimatedState extends State<_ToolbarFloatingAnimated> {
  final spring = MaterialSpringMotion.expressiveSpatialDefault();

  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
      valueListenable: widget.targetNotifier,
      builder: (context, value, child) => SingleMotionBuilder(
        motion: spring,
        value: value,
        // builder: (context, value, child) =>
        //     Transform.scale(scaleX: value, child: child!),
        builder: (context, value, child) => SlideTransition(
          position: Animation.fromValueListenable(ValueNotifier<Offset>(Offset(value, 0.0))),
          // axis: Axis.horizontal,
          // axisAlignment: 1.0,
          child: child!,
        ),
        child: const _ToolbarFloating(),
      ),
    );
  }
}

class _ToolbarFloating extends StatelessWidget {
  const _ToolbarFloating();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surfaceContainerHigh,
      borderRadius: BorderRadius.circular(32.0),
      elevation: 4.0,
      child: SizedBox(
        height: 64,
        width: 272,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            IconButton(
              onPressed: () {
                PreviousButtonNotification().dispatch(context);
              },
              icon: Icon(Icons.navigate_before),
              tooltip: 'Tap to Previous',
            ),
            IconButton(
              onPressed: () {
                NextButtonNotification().dispatch(context);
              },
              icon: Icon(Icons.navigate_next),
              tooltip: 'Tap to Next',
            ),
            IconButton(
              onPressed: () {
                ReciteButtonNotification().dispatch(context);
              },
              icon: Icon(Icons.auto_stories_outlined),
              tooltip: 'Tap to Count',
            ),
          ],
        ),
      ),
    );
  }
}

sealed class FloatingBarActionNotification extends Notification {
  void handle(BuildContext context);
}
class PreviousButtonNotification extends FloatingBarActionNotification {
  @override
  void handle(BuildContext context) {
    context.read<MemorizationVerseViewModel>().previousVerse();
  }
}
class NextButtonNotification extends FloatingBarActionNotification {
  @override
  void handle(BuildContext context) {
    context.read<MemorizationVerseViewModel>().nextVerse();
  }
}
class ReciteButtonNotification extends FloatingBarActionNotification {
  @override
  void handle(BuildContext context) {
    context.read<MemorizationVerseViewModel>().onFullScreen();
  }
}