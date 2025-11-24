import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jolly_podcast/core/components/utils/colors.dart';
import 'package:jolly_podcast/core/components/utils/size_config.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double widthPercent;
  final double heightPercent;
  final Color btnColor;
  final bool isLoading;
  final Color textColor;
  final double fontSize;
  final double borderRadius;
  final bool safeArea;
  final Widget? child; // ✅ NEW
  // Optional border settings
  final Color? borderColor;
  final double borderWidth;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.widthPercent = 100,
    this.heightPercent = 8,
    this.btnColor = AppColors.primary,
    this.isLoading = false,
    this.textColor = AppColors.white,
    this.fontSize = 16,
    this.borderRadius = 25,
    this.safeArea = false,
    this.child, // ✅ NEW
    this.borderColor,
    this.borderWidth = 1.5,
  });

  @override
  Widget build(BuildContext context) {
    return BoxSizer(
      widthPercent: widthPercent,
      heightPercent: heightPercent,
      safeArea: safeArea,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: borderColor != null
              ? Border.all(color: borderColor!, width: borderWidth)
              : null,
        ),
        child: _buildButton(context),
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return CupertinoButton(
      onPressed: isLoading ? null : onPressed,
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.circular(borderRadius),
      color: Colors.transparent,
      // disabledColor: isLoading ? btnColor : btnColor,
      child: isLoading
          ? SpinKitThreeBounce(
              color: isLoading ? borderColor ?? Colors.white : borderColor,
              size: 16,
            )
          : child ??
                Text(
                  // ✅ Use custom child if provided
                  text,
                  style: TextStyle(
                    fontSize: fontSize.textSize,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins",
                    color: textColor,
                  ),
                ),
    );
  }
}
