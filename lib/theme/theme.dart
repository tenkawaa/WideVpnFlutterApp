import 'package:flutter/cupertino.dart';

const lightTheme = CupertinoThemeData(
  brightness: Brightness.light,
  barBackgroundColor: CupertinoDynamicColor.withBrightness(
      color: CupertinoColors.white,
      darkColor: CupertinoColors.tertiarySystemFill
  ),

  scaffoldBackgroundColor: CupertinoDynamicColor.withBrightness(
      color: CupertinoColors.white,
      darkColor: CupertinoColors.tertiarySystemFill
  ),

  textTheme: CupertinoTextThemeData(
    textStyle: TextStyle(
      color: CupertinoDynamicColor.withBrightness(
          color: CupertinoColors.black,
          darkColor: CupertinoColors.white
      ),
      fontSize: 18
    )
  )
);