import 'package:flutter/material.dart';

class CustomCircularLoadingIndicator extends StatefulWidget {
  final String imagePath;
  final Curve curveName;
  final int relativeSize;
  final int relativeSpeed;

  /// reverse the animation after reaching the end
  final bool reverseAnimationAtEnd;

  final Color? backgroundColor;

  CustomCircularLoadingIndicator({
    required this.imagePath,
    this.curveName = Curves.ease,
    this.relativeSize = 2,
    this.relativeSpeed = 2,
    this.reverseAnimationAtEnd = false,
    this.backgroundColor,
  }) : assert(relativeSize >= 1 &&
            relativeSize <= 6 &&
            relativeSpeed >= 1 &&
            relativeSpeed <= 6);
  @override
  _CustomCircularLoadingIndicatorState createState() =>
      _CustomCircularLoadingIndicatorState();
}

class _CustomCircularLoadingIndicatorState
    extends State<CustomCircularLoadingIndicator>
    with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;
  late CurvedAnimation _curve;
  late String _imagePath;
  late int _relativeSize;
  late int _relativeSpeed;

  List<double> relativeSizesList = [30, 45, 60, 80, 100, 120];
  List<int> relativeSpeedsList = [4000, 3000, 2000, 1000, 500, 200, 100];

  @override
  void initState() {
    super.initState();
    _imagePath = widget.imagePath;
    _relativeSize = widget.relativeSize;
    _relativeSpeed = widget.relativeSpeed;
    _controller = AnimationController(
        vsync: this,
        duration:
            Duration(milliseconds: relativeSpeedsList[_relativeSpeed - 1]))
      ..addListener(() => setState(() {}))
      ..repeat(
        reverse: widget.reverseAnimationAtEnd,
      );

    _curve = CurvedAnimation(parent: _controller, curve: widget.curveName);

    _animation = new Tween(begin: 0.0, end: 6.0).animate(_curve);
  }

  @override
  Widget build(BuildContext build) {
    return RotationTransition(
      turns: _animation,
      child: Center(
        child: Container(
          alignment: Alignment.center,
          child: CircleAvatar(
            backgroundColor: widget.backgroundColor,
            backgroundImage: AssetImage(_imagePath),
            radius: relativeSizesList[_relativeSize - 1],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
