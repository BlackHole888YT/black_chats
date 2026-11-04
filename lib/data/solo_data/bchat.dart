import 'package:flutter/material.dart';

class BChat {

  static Widget getName({required double fontSize}) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "B",
            style: TextStyle(
              color: const Color(0xFF00E5FF),
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
            text: "Chat",
            style: TextStyle(
              color: const Color(0xFFF5F5F5),
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

}