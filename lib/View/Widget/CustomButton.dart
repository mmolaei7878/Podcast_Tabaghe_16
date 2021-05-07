import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget {
  final Function function;
  final String text;
  final Size size;
  CustomButton({
    this.function,
    this.size,
    this.text,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: TextButton(
        autofocus: false,
        onPressed: function,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text),
        ),
        style: TextButton.styleFrom(
          minimumSize: size,
          textStyle: GoogleFonts.acme(fontSize: 13.0.sp),
          primary: Colors.white,
          backgroundColor: Theme.of(context).accentColor,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
