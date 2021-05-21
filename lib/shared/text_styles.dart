import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

TextStyle kSubTitleStyle = GoogleFonts.nunitoSans(
  fontWeight: FontWeight.w700,
  color: titleColor,
  fontSize: 35,
);

TextStyle kTitleStyle = GoogleFonts.nunitoSans(
  fontWeight: FontWeight.w700,
  color: titleColor,
  fontSize: 45,
);

TextStyle kTabTextStyleSelected = GoogleFonts.nunitoSans(
  color: titleColor,
  fontSize: 24,
  fontWeight: FontWeight.w700,
);

TextStyle kTabTextStyleUnSelected = GoogleFonts.nunitoSans(
  color: titleColor.withOpacity(0.5),
  fontSize: 24,
  fontWeight: FontWeight.w300,
);
