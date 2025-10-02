import 'package:assignment/theme/ThemeController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OTPVerification extends StatefulWidget {
  final int length;
  final ValueChanged<String> onCompleted;
  final bool obscureText;

  const OTPVerification({
    super.key,
    this.length = 4,
    required this.onCompleted,
    this.obscureText = true,
  });

  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  final List<TextEditingController> _controllers = [];
  final List<FocusNode> _focusNodes = [];
  String _otp = '';

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    for (int i = 0; i < widget.length; i++) {
      _controllers.add(TextEditingController());
      _focusNodes.add(FocusNode());
    }
  }

  void _onTextChanged(String value, int index) {
    if (value.isNotEmpty) {
      // Move to next field if current field has value
      if (index < widget.length - 1) {
        _focusNodes[index + 1].requestFocus();
      }
    } else {
      // Move to previous field on backspace
      if (index > 0) {
        _focusNodes[index - 1].requestFocus();
      }
    }

    _updateOTP();
  }

  void _updateOTP() {
    String otp = '';
    for (var controller in _controllers) {
      otp += controller.text;
    }

    setState(() {
      _otp = otp;
    });

    // Call onCompleted when all fields are filled
    if (otp.length == widget.length) {
      widget.onCompleted(otp);
    }
  }

  void _onPaste(String value) {
    // Handle paste functionality
    if (value.length == widget.length) {
      for (int i = 0; i < widget.length; i++) {
        _controllers[i].text = value[i];
      }
      _updateOTP();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Get.find<ThemeController>();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(widget.length, (index) {
            return _buildOTPBox(index, theme);
          }),
        ),

        SizedBox(height: 10.h),
      ],
    );
  }

  Widget _buildOTPBox(int index, ThemeController theme) {
    return Container(
      width: 0.15.sw,
      height:0.15.sw,
      decoration: BoxDecoration(
        color: theme.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: _focusNodes[index].hasFocus ? theme.blue : theme.iconColor,
          width: _focusNodes[index].hasFocus ? 2 : 1,
        ),
      ),
      child: Center(
        child: TextFormField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(1),
          ],
          obscureText: widget.obscureText,
          obscuringCharacter: '•',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: theme.textColor,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            counterText: '',
            contentPadding: EdgeInsets.zero,
          ),
          onChanged: (value) => _onTextChanged(value, index),
          onTap: () {
            _controllers[index].selection = TextSelection(
              baseOffset: 0,
              extentOffset: _controllers[index].text.length,
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }
}