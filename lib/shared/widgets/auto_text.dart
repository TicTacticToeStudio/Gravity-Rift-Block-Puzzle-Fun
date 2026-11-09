import 'package:flutter/material.dart';

/// A drop-in replacement for [Text] that never overflows its constraints.
///
/// Two modes:
/// - [AutoText.singleLine]: keeps the text on one line, shrinking it down
///   with [FittedBox] if it doesn't fit. Use for titles, labels, buttons,
///   badges — anything that must stay on one line regardless of language
///   length (French, German, etc.).
/// - [AutoText.multiline]: regular wrapping text. Use for body copy
///   (dialog descriptions, hints) where multiple lines are acceptable.
///
/// Note for [AutoText.singleLine]: the parent must provide a width
/// constraint (via [Expanded], [SizedBox], [Container] with width,
/// [Positioned] with left+right, etc.). Otherwise [FittedBox] has nothing
/// to scale against and the text will simply render at its natural size.
class AutoText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final bool multiline;
  final int? maxLines;
  final Alignment alignment;

  /// Single-line text that scales down to fit its parent's width.
  /// Never wraps. Use for labels, buttons, titles, badges.
  const AutoText.singleLine(
      this.text, {
        super.key,
        this.style,
        this.textAlign,
        this.alignment = Alignment.center,
      })  : multiline = false,
        maxLines = 1;

  /// Multi-line text that wraps naturally. Use for body copy.
  /// If [maxLines] is provided, overflow ellipsis is applied.
  const AutoText.multiline(
      this.text, {
        super.key,
        this.style,
        this.textAlign,
        this.maxLines,
      })  : multiline = true,
        alignment = Alignment.center;

  @override
  Widget build(BuildContext context) {
    if (multiline) {
      return Text(
        text,
        style: style,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: maxLines != null ? TextOverflow.ellipsis : null,
      );
    }

    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: alignment,
      child: Text(
        text,
        style: style,
        textAlign: textAlign,
        maxLines: 1,
        softWrap: false,
      ),
    );
  }
}