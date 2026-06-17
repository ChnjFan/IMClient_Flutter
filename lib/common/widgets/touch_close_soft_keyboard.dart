import 'package:flutter/material.dart';

import '../styles/colors.dart';

/// Wraps [child] so that tapping outside text fields dismisses the keyboard.
/// Optionally adds a gradient background.
class TouchCloseSoftKeyboard extends StatelessWidget {
  const TouchCloseSoftKeyboard({
    super.key,
    required this.child,
    this.isGradientBg = false,
  });

  final Widget child;
  final bool isGradientBg;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        decoration: isGradientBg
            ? const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.c_0089FF_opacity10,
                    AppColors.c_FFFFFF_opacity0,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              )
            : null,
        child: child,
      ),
    );
  }
}
