// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/settings/subtitle_settings_provider.dart';
import 'package:fladder/providers/settings/video_player_settings_provider.dart';

class SubtitleSettingsModel {
  final double fontSize;
  final FontWeight fontWeight;
  final double verticalOffset;
  final Color color;
  final Color outlineColor;
  final double outlineSize;
  final Color backGroundColor;
  final double shadow;
  const SubtitleSettingsModel({
    this.fontSize = 60,
    this.fontWeight = FontWeight.normal,
    this.verticalOffset = 0.10,
    this.color = Colors.white,
    this.outlineColor = const Color.fromRGBO(0, 0, 0, 0.85),
    this.outlineSize = 4,
    this.backGroundColor = const Color.fromARGB(0, 0, 0, 0),
    this.shadow = 0.5,
  });

  SubtitleSettingsModel copyWith({
    double? fontSize,
    FontWeight? fontWeight,
    double? verticalOffset,
    Color? color,
    Color? outlineColor,
    double? outlineSize,
    Color? backGroundColor,
    double? shadow,
  }) {
    return SubtitleSettingsModel(
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      verticalOffset: verticalOffset ?? this.verticalOffset,
      color: color ?? this.color,
      outlineColor: outlineColor ?? this.outlineColor,
      outlineSize: outlineSize ?? this.outlineSize,
      backGroundColor: backGroundColor ?? this.backGroundColor,
      shadow: shadow ?? this.shadow,
    );
  }

  TextStyle get backGroundStyle {
    return style.copyWith(
      shadows: (shadow > 0.01)
          ? [
              Shadow(
                blurRadius: 16,
                color: Colors.black.withOpacity(shadow),
              ),
              Shadow(
                blurRadius: 8,
                color: Colors.black.withOpacity(shadow),
              ),
            ]
          : null,
      foreground: Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = outlineSize * (fontSize / 30)
        ..color = outlineColor
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  TextStyle get style {
    return TextStyle(
      height: 1.4,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFamily: 'OpenSans',
      letterSpacing: 0.0,
      wordSpacing: 0.0,
      color: color,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fontSize': fontSize,
      'fontWeight': fontWeight.value,
      'verticalOffset': verticalOffset,
      'color': color.value,
      'outlineColor': outlineColor.value,
      'outlineSize': outlineSize,
      'backGroundColor': backGroundColor.value,
      'shadow': shadow,
    };
  }

  String toJson() => json.encode(toMap());

  factory SubtitleSettingsModel.fromJson(String source) => SubtitleSettingsModel.fromMap(json.decode(source));

  factory SubtitleSettingsModel.fromMap(Map<String, dynamic> map) {
    return const SubtitleSettingsModel().copyWith(
      fontSize: map['fontSize'] as double?,
      fontWeight: FontWeight.values.firstWhereOrNull((element) => element.index == map['fontWeight'] as int?),
      verticalOffset: map['verticalOffset'] as double?,
      color: map['color'] != null ? Color(map['color'] as int) : null,
      outlineColor: map['outlineColor'] != null ? Color(map['outlineColor'] as int) : null,
      outlineSize: map['outlineSize'] as double?,
      backGroundColor: map['backGroundColor'] != null ? Color(map['backGroundColor'] as int) : null,
      shadow: map['shadow'] as double?,
    );
  }

  @override
  String toString() {
    return 'SubtitleSettingsModel(fontSize: $fontSize, fontWeight: $fontWeight, verticalOffset: $verticalOffset, color: $color, outlineColor: $outlineColor, outlineSize: $outlineSize, backGroundColor: $backGroundColor, shadow: $shadow)';
  }

  @override
  bool operator ==(covariant SubtitleSettingsModel other) {
    if (identical(this, other)) return true;

    return other.fontSize == fontSize &&
        other.fontWeight == fontWeight &&
        other.verticalOffset == verticalOffset &&
        other.color == color &&
        other.outlineColor == outlineColor &&
        other.outlineSize == outlineSize &&
        other.backGroundColor == backGroundColor &&
        other.shadow == shadow;
  }

  @override
  int get hashCode {
    return fontSize.hashCode ^
        fontWeight.hashCode ^
        verticalOffset.hashCode ^
        color.hashCode ^
        outlineColor.hashCode ^
        outlineSize.hashCode ^
        backGroundColor.hashCode ^
        shadow.hashCode;
  }
}

class SubtitleText extends ConsumerWidget {
  final SubtitleSettingsModel subModel;
  final EdgeInsets padding;
  final String text;
  final double offset;
  const SubtitleText({
    required this.subModel,
    required this.padding,
    required this.offset,
    required this.text,
    super.key,
  });

  // The reference width for calculating the visible text scale factor.
  static const kTextScaleFactorReferenceWidth = 1920.0;
  // The reference height for calculating the visible text scale factor.
  static const kTextScaleFactorReferenceHeight = 1080.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fillScreen = ref.watch(videoPlayerSettingsProvider.select((value) => value.fillScreen));
    return Padding(
      padding: (fillScreen ? EdgeInsets.zero : EdgeInsets.only(left: padding.left, right: padding.right))
          .add(const EdgeInsets.all(16)),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final textScale = MediaQuery.textScalerOf(context)
              .scale((ref.read(subtitleSettingsProvider.select((value) => value.fontSize)) *
                  math.sqrt(
                    ((constraints.maxWidth * constraints.maxHeight) /
                            (kTextScaleFactorReferenceWidth * kTextScaleFactorReferenceHeight))
                        .clamp(0.0, 1.0),
                  )));

          // Function to calculate the height of the text
          double getTextHeight(BuildContext context, String text, TextStyle style) {
            final TextPainter textPainter = TextPainter(
              text: TextSpan(text: text, style: style),
              textDirection: TextDirection.ltr,
              textScaler: MediaQuery.textScalerOf(context),
            )..layout(minWidth: 0, maxWidth: double.infinity);

            return textPainter.height;
          }

          // Calculate the available height for the text alignment
          double availableHeight = constraints.maxHeight;

          // Calculate the desired position based on the percentage
          double desiredPosition = availableHeight * offset;

          // Get the height of the Text widget with the current font style
          double textHeight = getTextHeight(context, text, subModel.style);

          // Calculate the position to keep the text within visible bounds
          double position = desiredPosition - textHeight / 2;

          // Ensure the text doesn't go off-screen
          position = position.clamp(0, availableHeight - textHeight);

          return IgnorePointer(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned(
                  bottom: position,
                  child: Container(
                    constraints: BoxConstraints(maxWidth: constraints.maxWidth, maxHeight: constraints.maxHeight),
                    decoration: BoxDecoration(
                      color: subModel.backGroundColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        text,
                        style: subModel.backGroundStyle.copyWith(fontSize: textScale),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: position,
                  child: Container(
                    constraints: BoxConstraints(maxWidth: constraints.maxWidth, maxHeight: constraints.maxHeight),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        text,
                        style: subModel.style.copyWith(fontSize: textScale),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
