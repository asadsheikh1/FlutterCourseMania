import 'package:flutter/material.dart';

import 'package:course_mania/constants/constant.dart';

class UnicornOutlineButton extends StatelessWidget {
  final String buttontext;
  final VoidCallback onPressed;

  const UnicornOutlineButton({
    super.key,
    required this.buttontext,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return CustomPaint(
      painter: _GradientPainter(),
      child: InkWell(
        borderRadius: BorderRadius.circular(40),
        onTap: onPressed,
        child: SizedBox(
          height: size.width * 0.11,
          width: size.width * 0.81,
          child: Center(
            child: Text(
              buttontext,
              style: kTextStyle.copyWith(
                fontSize: 20.0,
                color: kTextColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GradientPainter extends CustomPainter {
  final Paint _paint = Paint();
  Gradient gradient = LinearGradient(
    colors: [
      kCyanColor,
      kGreenAccentColor,
    ],
  );
  double radius = 40;
  double strokeWidth = 2;

  @override
  void paint(Canvas canvas, Size size) {
    Rect outerRect = Offset.zero & size;
    var outerRRect =
        RRect.fromRectAndRadius(outerRect, Radius.circular(radius));

    Rect innerRect = Rect.fromLTWH(strokeWidth, strokeWidth,
        size.width - strokeWidth * 2, size.height - strokeWidth * 2);
    var innerRRect = RRect.fromRectAndRadius(
        innerRect, Radius.circular(radius - strokeWidth));

    _paint.shader = gradient.createShader(outerRect);

    Path path1 = Path()..addRRect(outerRRect);
    Path path2 = Path()..addRRect(innerRRect);
    var path = Path.combine(PathOperation.difference, path1, path2);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}
