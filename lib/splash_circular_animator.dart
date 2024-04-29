import 'dart:math';
import 'package:flutter/material.dart';

class SplashCircularAnimator extends StatefulWidget {
  const SplashCircularAnimator({
    super.key,
    this.innerColor = const Color(0xff000080),
    this.outerColor = const Color(0xff00CED1),
    this.innerAnimation = Curves.linear,
    this.outerAnimation = Curves.linear,
    this.size = 200,
    this.innerIconsSize = 5,
    this.outerIconsSize = 5,
    this.innerAnimationSeconds = 3, // Speed
    this.outerAnimationSeconds = 3, // Speed
    this.reverse = true,
    this.showThirdCircle = true,
    this.showForthCircle = true,
  });

  final Color innerColor;
  final Color outerColor;
  final Curve innerAnimation;
  final Curve outerAnimation;
  final double innerIconsSize;
  final double size;
  final double outerIconsSize;
  final int innerAnimationSeconds;
  final int outerAnimationSeconds;
  final bool reverse, showThirdCircle, showForthCircle;

  @override
  WidgetAnimatorState createState() => WidgetAnimatorState();
}

class WidgetAnimatorState extends State<SplashCircularAnimator>
    with TickerProviderStateMixin {
  late Animation<double> animation1;
  late Animation<double> animation2;
  late AnimationController controller2;
  late AnimationController controller1;

  @override
  void initState() {
    super.initState();
    initAnimations();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        _firstArc(),
        _secondArc(),
        Visibility(visible: widget.showThirdCircle, child: _thirdArc()),
        Visibility(visible: widget.showThirdCircle, child: _fourthArc()),
      ],
    );
  }

  @override
  void dispose() {
    controller2.dispose();
    controller1.dispose();
    super.dispose();
  }

  Center _fourthArc() {
    return Center(
      child: RotationTransition(
        turns: animation2,
        child: CustomPaint(
          painter: Arc4Painter(color: widget.outerColor),
          child: SizedBox(
            width: 0.15 * widget.size,
            height: 0.15 * widget.size,
          ),
        ),
      ),
    );
  }

  Center _thirdArc() {
    return Center(
      child: RotationTransition(
        turns: animation1,
        child: CustomPaint(
          painter: Arc3Painter(color: widget.innerColor),
          child: SizedBox(
            width: 0.70 * widget.size,
            height: 0.70 * widget.size,
          ),
        ),
      ),
    );
  }

  Center _secondArc() {
    return Center(
      child: RotationTransition(
        turns: animation2,
        child: CustomPaint(
          painter: Arc2Painter(color: widget.outerColor),
          child: SizedBox(
            width: 0.85 * widget.size,
            height: 0.85 * widget.size,
          ),
        ),
      ),
    );
  }

  Center _firstArc() {
    return Center(
      child: RotationTransition(
        turns: animation1,
        child: CustomPaint(
          painter: Arc1Painter(color: widget.innerColor),
          child: SizedBox(
            width: 1.25 * widget.size,
            height: 1.25 * widget.size,
          ),
        ),
      ),
    );
  }

  void initAnimations() {
    controller1 = AnimationController(
        duration: Duration(seconds: widget.innerAnimationSeconds), vsync: this);

    controller2 = AnimationController(
        duration: Duration(seconds: widget.outerAnimationSeconds), vsync: this);

    animation1 = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller1,
        curve: Interval(0.0, 1.0, curve: widget.innerAnimation)));

    final secondAnimation = Tween<double>(begin: -1.0, end: 0.0).animate(
        CurvedAnimation(
            parent: controller2,
            curve: Interval(0.0, 1.0, curve: widget.outerAnimation)));

    // reverse or same direction animation
    widget.reverse
        ? animation2 = ReverseAnimation(secondAnimation)
        : animation2 = secondAnimation;

    controller2.repeat();
    controller1.repeat();
  }
}

class Arc2Painter extends CustomPainter {
  Arc2Painter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()
      ..color = color
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final Rect rect = Rect.fromLTWH(0.0, 0.0, size.width, size.height);

    // draw the three arcs
    canvas.drawArc(rect, 0.0, 0.67 * pi, false, p);
    canvas.drawArc(rect, 0.74 * pi, 0.65 * pi, false, p);
    canvas.drawArc(rect, 1.46 * pi, 0.47 * pi, false, p);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Arc1Painter extends CustomPainter {
  Arc1Painter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()
      ..color = color
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // canvas.drawArc(rect, 0.0, 0.67 * pi, false, p);
    // canvas.drawArc(rect, 0.74 * pi, 0.65 * pi, false, p);
    // canvas.drawArc(rect, 1.46 * pi, 0.47 * pi, false, p);

    canvas.drawArc(rect, 0.0, 0.4 * pi, false, p);
    canvas.drawArc(rect, 0.5 * pi, 0.4 * pi, false, p);
    canvas.drawArc(rect, 1.0 * pi, 0.4 * pi, false, p);
    canvas.drawArc(rect, 1.5 * pi, 0.4 * pi, false, p);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Arc3Painter extends CustomPainter {
  Arc3Painter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint p3 = Paint()
      ..color = color
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    Rect rect3 = Rect.fromLTWH(
        0.0 + (0.4 * size.width) / 2,
        0.0 + (0.4 * size.height) / 2,
        size.width - 0.4 * size.width,
        size.height - 0.4 * size.height);

    canvas.drawArc(rect3, 0.0, 0.8 * pi, false, p3);
    canvas.drawArc(rect3, 1.0 * pi, 0.8 * pi, false, p3);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Arc4Painter extends CustomPainter {
  Arc4Painter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint p = Paint()
      ..color = color
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);

    canvas.drawArc(rect, 0, 2 * pi, false, p);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
