// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';


class authtextfieldWidget extends StatefulWidget {
  final double conheight;
  final headingtext;
  final int maxlength;
  final TextEditingController authcontroller;
  final TextInputType keyboardtype;
  final String text;
  final String suffixImage;
  final bool showImage;
  final bool showsuffix;
  final String suffixIcon;
  final IconData suffixIcon2;
  final Function(String) validator;
  final VoidCallback onPwdTap;
  final bool isPasswordField;
  final bool visible;
  final bool showpassoricon;

  //final bool showSuffix;
  authtextfieldWidget(
      {this.conheight = 50,
      this.showpassoricon = false,
      this.headingtext,
      this.visible = false,
      this.isPasswordField = false,
      required this.suffixIcon2,
       this.maxlength=20,
      required this.authcontroller,
      required this.keyboardtype,
      required this.text,
      required this.suffixImage,
      required this.showsuffix,
      required this.showImage,
      required this.validator,
      required this.suffixIcon,
      required this.onPwdTap});

  @override
  _authtextfieldWidgetState createState() => _authtextfieldWidgetState();
}

class _authtextfieldWidgetState extends State<authtextfieldWidget> {
  // bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(widget.headingtext,
                style: GoogleFonts.roboto(
                    // fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w600,
                    fontSize: 16))
          ],
        ),
        SizedBox(
          height: 7,
        ),
        Container(
          height: widget.conheight,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(7)),
          child: TextFormField(
            // maxLength: widget.maxlength,
            // keyboardType: TextInputType.number,
            autocorrect: true,
            obscureText: widget.visible,

            keyboardType: widget.keyboardtype,
            controller: widget.authcontroller,
            validator: (val) => widget.validator(val!),
            decoration: InputDecoration(
              isDense: true,

              contentPadding: EdgeInsets.only(top: 14, left: 20),

              border: InputBorder.none,
              // suffix: Icon(Icons.remove_red_eye_sharp),
              errorStyle: TextStyle(
                height: 6,
                color: Colors.red,
                fontSize: 10,
              ),
              hintText: widget.text,
              hintStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.black.withOpacity(0.6),
                  fontWeight: FontWeight.w400),
              suffixIcon: widget.showpassoricon
                  ? widget.isPasswordField
                      ? InkWell(
                          onTap: () => widget.onPwdTap(),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 19.0, top: 15, bottom: 30, right: 10),
                            child: widget.visible
                                ? Icon(
                                    CupertinoIcons.eye_slash,
                                    size: 20,
                                  )
                                : Icon(
                                    CupertinoIcons.eye,
                                    size: 20,
                                  ),
                          ),
                        )
                      : null
                  : Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SvgPicture.asset(
                        widget.suffixIcon,
                        height: 15,
                        width: 15,
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
