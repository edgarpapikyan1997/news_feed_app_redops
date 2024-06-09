import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color? buttonColor;
  final Color? shadowColor;
  final double? bordersAllRadius;
  final double topLeftRadius;
  final double topRightRadius;
  final double bottomLeftRadius;
  final double bottomRightRadius;

  final double? height;
  final double? width;

  const CustomButton({
    super.key,
    required this.child,
    this.buttonColor,
    this.shadowColor,
    this.onTap,
    this.height,
    this.width,
    this.topLeftRadius = 0,
    this.topRightRadius = 0,
    this.bottomLeftRadius = 0,
    this.bottomRightRadius = 0,
    this.bordersAllRadius,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: bordersAllRadius != null
                ? BorderRadius.circular(bordersAllRadius!)
                : BorderRadius.only(
                    topLeft: Radius.circular(topLeftRadius),
                    topRight: Radius.circular(topRightRadius),
                    bottomLeft: Radius.circular(bottomLeftRadius),
                    bottomRight: Radius.circular(bottomRightRadius),
                  ),
          ),
          child: child),
      onTap: onTap,
    );
  }
}
