import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle appStyle(double size, Color color, FontWeight fontweig) {
  return GoogleFonts.poppins(
    fontSize: size.sp,
    color: color,
    fontWeight: fontweig,
  );
}

TextStyle appStyleWithHt(
    double size, Color color, FontWeight fontweig, double ht) {
  return GoogleFonts.poppins(
    fontSize: size.sp,
    color: color,
    fontWeight: fontweig,
    height: ht,
  );
}
