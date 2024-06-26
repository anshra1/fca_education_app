import 'dart:async';

import 'package:fca_education_app/core/extensions/time_ago_extension.dart';
import 'package:fca_education_app/core/res/colors.dart';
import 'package:flutter/material.dart';

class TimeText extends StatefulWidget {
  const TimeText(
    this.time, {
    super.key,
    this.prefixText,
    this.style,
    this.maxLines,
    this.overflow,
  });

  final DateTime time;
  final String? prefixText;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  State<TimeText> createState() => _TimeTextState();
}

class _TimeTextState extends State<TimeText> {
  Timer? timer;
  late String timeAgos;

  @override
  void initState() {
    super.initState();
    timeAgos = widget.time.timeAgo;
    timer = Timer.periodic(const Duration(seconds: 59), (_) {
      if (mounted) {
        if (timeAgos != widget.time.timeAgo) {
          setState(() {
            timeAgos = widget.time.timeAgo;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '${widget.prefixText != null ? '${widget.prefixText}' : ''} $timeAgos',
      maxLines: widget.maxLines,
      overflow: widget.overflow,
      style: widget.style ??
          const TextStyle(
            fontSize: 12,
            color: Colours.neutralTextColour,
          ),
    );
  }
}
