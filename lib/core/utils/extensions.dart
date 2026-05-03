import 'package:flutter/material.dart';
import 'package:news_c18_dokki/core/providers/app_config_provider.dart';
import 'package:provider/provider.dart';

extension ContextExtensions on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  TextTheme get textTheme => Theme.of(this).textTheme;

  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;
}

extension WhiteSpace on num {
  SizedBox get verticalSpace => SizedBox(height: toDouble());

  SizedBox get horizontalSpace => SizedBox(width: toDouble());
}

extension PaddingExtension on Widget {
  Padding withHorizontalPadding(double padding) => Padding(
    padding: .symmetric(horizontal: padding),
    child: this,
  );

  Padding withVerticalPadding(double padding) => Padding(
    padding: .symmetric(vertical: padding),
    child: this,
  );

  Padding withPadding(double padding) =>
      Padding(padding: .all(padding), child: this);
}

extension StringExtension on String {
  String getImagePath(BuildContext context) =>
      "assets/images/${Provider.of<AppConfigProvider>(context).isDark ? "dark" : "light"}/$this";
}
