import 'package:amorra/core/utils/app_fonts/app_fonts.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle headline(BuildContext context) => TextStyle(
    fontSize: MediaQuery.of(context).size.width * 0.08,
    fontFamily: AppFonts.primaryFont,
    color: Theme.of(context).textTheme.bodyLarge?.color,
  );

  static TextStyle heading(BuildContext context) => TextStyle(
    fontSize: MediaQuery.of(context).size.width * 0.06,
    fontFamily: AppFonts.primaryFont,
    color: Theme.of(context).textTheme.bodyLarge?.color,
  );

  static TextStyle bodyText(BuildContext context) => TextStyle(
    fontSize: MediaQuery.of(context).size.width * 0.04,
    fontFamily: AppFonts.secondaryFont,
    color: Theme.of(context).textTheme.bodyLarge?.color,
  );

  static TextStyle hintText(BuildContext context) => TextStyle(
    fontSize: MediaQuery.of(context).size.width * 0.04,
    fontFamily: AppFonts.secondaryFont,
    color: Theme.of(context).hintColor,
  );

  static TextStyle buttonText(BuildContext context) => TextStyle(
    fontSize: MediaQuery.of(context).size.width * 0.045,
    fontFamily: AppFonts.secondaryFont,
    color: Colors.white,
  );
}
