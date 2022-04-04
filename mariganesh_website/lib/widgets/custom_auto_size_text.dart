import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mariganesh_website/utils/font.dart';

class CustomAutoSizeText extends StatefulWidget {
  final String text;
  final double fontSize;
  final Font font;
  final Color color;
  final double lineHeight;
  final TextAlign textAlign;
  final GestureTapCallback? onTap;
  final bool isUnderLine;
  final bool isSingleLine;
  final int? maxLines;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;

  CustomAutoSizeText(String text,
      {this.fontWeight = FontWeight.w400,
      this.fontStyle,
      this.fontSize = 14,
      this.font = Font.fontSpringRegular,
      this.color = Colors.black,
      this.lineHeight = 1.5, // Line Height - 24
      this.textAlign = TextAlign.left,
      this.onTap,
      this.isUnderLine = false,
      this.isSingleLine = false,
      this.maxLines})
      // ignore: prefer_initializing_formals
      : text = text;

  @override
  _CustomAutoSizeTextState createState() => _CustomAutoSizeTextState();
}

class _CustomAutoSizeTextState extends State<CustomAutoSizeText> {
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_this
    final AutoSizeText textWidget = AutoSizeText(
      widget.text,

      // ignore: unnecessary_this
      textAlign: this.widget.textAlign,
      overflow: widget.isSingleLine ? TextOverflow.ellipsis : null,
      maxLines: widget.maxLines,
      style: GoogleFonts.sourceSansPro(
          decoration: widget.isUnderLine
              ? TextDecoration.underline
              : TextDecoration.none,
          color: widget.color,
          // fontFamily: widget.font.value,
          fontSize: widget.fontSize,
          height: widget.lineHeight,
          fontStyle: widget.fontStyle,
          fontWeight: widget.fontWeight),
      // TextStyle(
      //     decoration: widget.isUnderLine
      //         ? TextDecoration.underline
      //         : TextDecoration.none,
      //     color: widget.color,
      //     // fontFamily: widget.font.value,
      //     fontSize: widget.fontSize,
      //     height: widget.lineHeight,
      //     fontStyle: widget.fontStyle,
      //     fontWeight: widget.fontWeight),
      softWrap: true,
    );

    if (widget.onTap != null) {
      return GestureDetector(
        onTap: widget.onTap,
        child: textWidget,
      );
    } else {
      return textWidget;
    }
  }
}
