import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Configurations/Colors.dart';

class AppButton extends StatelessWidget {
  final double containerheight;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
  final bool showborder;

  final String text;
  final VoidCallback onTap;

  AppButton(
      {this.containerheight = 48,
      this.textColor = Colors.white,
      this.backgroundColor = MyAppColors.appColor,
      this.borderColor = MyAppColors.appColor,
      this.showborder = false,
      required this.onTap,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: containerheight,
        width: 305,
        decoration: BoxDecoration(
            border: Border.all(
                color: showborder ? borderColor : MyAppColors.whitecolor,
                width: 2),
            color: backgroundColor,
            borderRadius: BorderRadius.circular(13)),
        child: Center(
          child: Text(text,
              style: GoogleFonts.roboto(
                  // fontFamily: 'Gilroy',
                  color: textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16)),
        ),
      ),
    );
  }
}
