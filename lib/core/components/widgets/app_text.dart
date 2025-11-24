import 'package:flutter/material.dart';
import 'package:jolly_podcast/core/components/utils/colors.dart';
import 'package:jolly_podcast/core/components/utils/size_config.dart';

class AppText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final double? linHeight;
  final double? letterSpacing;
  final Color? color;
  final Color? decorationColor;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final TextAlign? textAlign;
  final TextDecoration? decoration;
  final TextOverflow? overflow;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final int? maxLines;
  final bool? softWrap;
  final bool isBody;
  final String? fontFamily;

  const AppText({
    required this.text,
    super.key,
    required this.fontSize,
    this.linHeight,
    this.letterSpacing,
    this.color,
    this.decorationColor,
    this.fontWeight,
    this.fontStyle,
    this.textAlign,
    this.decoration,
    this.overflow,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.maxLines,
    this.softWrap,
    required this.isBody,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize?.textSize ?? 14.textSize,
        letterSpacing: letterSpacing ?? 1,
        color: color ?? AppColors.black,
        fontStyle: fontStyle ?? FontStyle.normal,
        fontWeight: fontWeight ?? FontWeight.w400,
        decoration: decoration ?? TextDecoration.none,
        height: linHeight ?? 1.5,
        fontFamily: fontFamily ?? (isBody ? "Poppins" : "Poppins"),
        decorationColor: decorationColor ?? AppColors.black,
      ),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
    );
  }
}
