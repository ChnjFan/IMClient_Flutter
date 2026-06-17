import 'package:flutter/material.dart';
import '../styles/colors.dart';

/// Reusable input field components for the login page.
class InputBox {
  InputBox._();

  /// Account input (phone / email / username).
  static Widget account({
    required String label,
    required String hintText,
    required TextEditingController controller,
    required FocusNode? focusNode,
    TextInputType keyBoardType = TextInputType.text,
    String? code,
    VoidCallback? onAreaCode,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.c_333333,
              ),
            ),
          ),
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.c_F0F2F6,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              if (code != null) ...[
                GestureDetector(
                  onTap: onAreaCode,
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          code,
                          style: const TextStyle(
                            fontSize: 15,
                            color: AppColors.c_333333,
                          ),
                        ),
                        if (onAreaCode != null) ...[
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.arrow_drop_down,
                            size: 18,
                            color: AppColors.c_999999,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 24,
                  color: AppColors.c_E8EAEF,
                ),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: TextField(
                  controller: controller,
                  focusNode: focusNode,
                  keyboardType: keyBoardType,
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppColors.c_333333,
                  ),
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: const TextStyle(
                      fontSize: 15,
                      color: AppColors.c_999999,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Password input.
  static Widget password({
    required String label,
    required String hintText,
    required TextEditingController controller,
    required FocusNode? focusNode,
    bool obscureText = true,
    VoidCallback? onToggleObscure,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.c_333333,
              ),
            ),
          ),
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.c_F0F2F6,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  focusNode: focusNode,
                  obscureText: obscureText,
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppColors.c_333333,
                  ),
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: const TextStyle(
                      fontSize: 15,
                      color: AppColors.c_999999,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
              if (onToggleObscure != null)
                GestureDetector(
                  onTap: onToggleObscure,
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      size: 20,
                      color: AppColors.c_999999,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  /// Verification code input with a "send code" button.
  static Widget verificationCode({
    required String label,
    required String hintText,
    required TextEditingController controller,
    required Future<bool> Function() onSendVerificationCode,
    int countdownSeconds = 60,
  }) {
    return _VerificationCodeInput(
      label: label,
      hintText: hintText,
      controller: controller,
      onSendVerificationCode: onSendVerificationCode,
      countdownSeconds: countdownSeconds,
    );
  }
}

class _VerificationCodeInput extends StatefulWidget {
  const _VerificationCodeInput({
    required this.label,
    required this.hintText,
    required this.controller,
    required this.onSendVerificationCode,
    this.countdownSeconds = 60,
  });

  final String label;
  final String hintText;
  final TextEditingController controller;
  final Future<bool> Function() onSendVerificationCode;
  final int countdownSeconds;

  @override
  State<_VerificationCodeInput> createState() => _VerificationCodeInputState();
}

class _VerificationCodeInputState extends State<_VerificationCodeInput> {
  int _countdown = 0;
  bool _isSending = false;

  bool get _isCountingDown => _countdown > 0;

  Future<void> _onSend() async {
    if (_isCountingDown || _isSending) return;
    setState(() => _isSending = true);
    try {
      final success = await widget.onSendVerificationCode();
      if (success && mounted) {
        setState(() => _countdown = widget.countdownSeconds);
        _startCountdown();
      }
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  void _startCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        if (_countdown > 0) _countdown--;
      });
      if (_countdown > 0) _startCountdown();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              widget.label,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.c_333333,
              ),
            ),
          ),
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.c_F0F2F6,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppColors.c_333333,
                  ),
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: const TextStyle(
                      fontSize: 15,
                      color: AppColors.c_999999,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: _isCountingDown || _isSending ? null : _onSend,
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: _isSending
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(
                          _isCountingDown
                              ? '${_countdown}s'
                              : '发送验证码',
                          style: TextStyle(
                            fontSize: 13,
                            color: _isCountingDown
                                ? AppColors.c_999999
                                : AppColors.c_0089FF,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
