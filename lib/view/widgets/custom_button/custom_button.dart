import 'package:flutter/material.dart';
import 'package:redops_app/utils/extensions/extensions.dart';

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
  final bool? makeBorder;
  final double? height;
  final double? width;
  final double? borderWidth;
  final Color? borderColor;

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
    this.makeBorder,
    this.borderWidth,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            border: makeBorder == true
                ? Border.all(width: borderWidth ?? 0, color: borderColor ?? Colors.white)
                : null,
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
    );
  }
}
