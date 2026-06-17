import 'package:flutter/material.dart';
import '../styles/colors.dart';

/// Primary action button with a gradient background.
/// When [enabled] is false, the button appears greyed out and is non-interactive.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    required this.onTap,
    this.enabled = true,
    this.width,
    this.height = 48,
    this.borderRadius = 8,
  });

  final String text;
  final VoidCallback? onTap;
  final bool enabled;
  final double? width;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          gradient: enabled
              ? const LinearGradient(
                  colors: [AppColors.c_0089FF, AppColors.c_418AE5],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : const LinearGradient(
                  colors: [AppColors.c_8E9AB0, AppColors.c_8E9AB0],
                ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(borderRadius),
            onTap: enabled ? onTap : null,
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
