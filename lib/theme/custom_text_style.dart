import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body style
  static get bodyLargeInter => theme.textTheme.bodyLarge!.inter;
  static get bodyLargeInter_1 => theme.textTheme.bodyLarge!.inter;
  static get bodyLargePrimaryContainer => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.primaryContainer,
      );
  static get bodyLargeRobotoGray700 =>
      theme.textTheme.bodyLarge!.roboto.copyWith(
        color: appTheme.gray700,
      );
  static get bodyMediumBlack900 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.black900,
      );
  static get bodyMediumBlack900_1 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.black900,
      );
  static get bodyMediumGray500 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray500,
      );
  static get bodySmallBlack900 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.black900,
      );
  static get bodySmallPrimaryContainer => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.primaryContainer,
      );
  // Title text style
  static get titleMedium18 => theme.textTheme.titleMedium!.copyWith(
        fontSize: 18.fSize,
      );
  static get titleMediumHelvetica => theme.textTheme.titleMedium!.helvetica;
  static get titleMediumHelvetica18 =>
      theme.textTheme.titleMedium!.helvetica.copyWith(
        fontSize: 18.fSize,
      );
  static get titleMediumHelveticaOnPrimaryContainer =>
      theme.textTheme.titleMedium!.helvetica.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
        fontSize: 18.fSize,
      );
  static get titleMediumHelveticaOnPrimaryContainer_1 =>
      theme.textTheme.titleMedium!.helvetica.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
      );
  static get titleMediumHelveticaYellowA200 =>
      theme.textTheme.titleMedium!.helvetica.copyWith(
        color: appTheme.yellowA200,
      );
  static get titleSmallBlack900 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.black900,
      );
  static get titleSmallRobotoBlack900 =>
      theme.textTheme.titleSmall!.roboto.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w600,
      );
}

extension on TextStyle {
  TextStyle get roboto {
    return copyWith(
      fontFamily: 'Roboto',
    );
  }

  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }

  TextStyle get helvetica {
    return copyWith(
      fontFamily: 'Helvetica',
    );
  }
}
