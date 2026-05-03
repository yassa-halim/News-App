
import 'package:flutter/material.dart';

abstract class AppColors{
  Brightness get brightness;

  Color get primary;
  Color get onPrimary;
  Color get secondary;
  Color get onSecondary;
  Color get error;
  Color get onError;
  Color get surface;
  Color get onSurface;

}


class DarkAppColors extends AppColors{
  @override
  Color get error => Colors.red;

  @override
  Color get onError => Colors.white;

  @override
  Color get onPrimary => Color(0xFF171717);

  @override
  Color get onSecondary =>  Color(0xFFFFFFFF);

  @override
  Color get onSurface =>  Color(0xFFFFFFFF);

  @override
  Color get primary => Color(0xffffffff);

  @override
  Color get secondary =>  Color(0xFF171717);

  @override
  Color get surface =>  Color(0xFF171717);

  @override
  Brightness get brightness => Brightness.dark;

}

class LightAppColors extends AppColors{
  @override
  Color get error => Colors.red;

  @override
  Color get onError => Colors.white;

  @override
  Color get onPrimary => Color(0xFFFFFFFF);

  @override
  Color get onSecondary =>  Color(0xFF171717);

  @override
  Color get onSurface =>  Color(0xFF171717);

  @override
  Color get primary => Color(0xFF171717);

  @override
  Color get secondary =>  Color(0xFFFFFFFF);

  @override
  Color get surface =>  Color(0xFFFFFFFF);


  @override
  Brightness get brightness => Brightness.light;

}