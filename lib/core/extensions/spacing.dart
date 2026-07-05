import 'package:flutter/widgets.dart';

/// Provides shorthand spacing utilities to improve readability and
/// reduce boilerplate when creating vertical or horizontal gaps.
///
/// Usage examples:
/// ```dart
/// 16.ph        // vertical space (height = 16)
/// 12.pw        // horizontal space (width = 12)
/// ```
///
/// This extension is commonly used in UI layout code where inline spacing
/// makes widget trees more concise and expressive.
extension Spacing on num {
  /// Returns a vertical spacer with height = this value.
  SizedBox get ph => SizedBox(height: toDouble());

  /// Returns a horizontal spacer with width = this value.
  SizedBox get pw => SizedBox(width: toDouble());
}

/// Adds semantic text-weight helpers to `TextStyle` for cleaner
/// and more readable typography definitions.
///
/// Instead of:
/// ```dart
/// style.copyWith(fontWeight: FontWeight.w600);
/// ```
/// you can write:
/// ```dart
/// style.semibold;
/// ```
extension TextStyleX on TextStyle {
  /// Returns the current style with a medium-bold weight.
  TextStyle get semibold => copyWith(fontWeight: FontWeight.w600);

  /// Returns the current style with a bold weight.
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);
}
