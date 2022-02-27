import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../cores/constants/color.dart';
import '../../cores/utils/sizer_utils.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    this.textEditingController,
    this.autoCorrect = true,
    required this.hintText,
    this.validator,
    this.textInputType = TextInputType.text,
    this.isPassword = false,
    this.enabled = true,
    this.maxLine = 1,
    this.suffix,
  }) : super(key: key);

  final TextEditingController? textEditingController;
  final bool autoCorrect;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType textInputType;
  final bool isPassword;
  final bool enabled;
  final int? maxLine;
  final IconData? suffix;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final ValueNotifier<bool> obscureText = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: obscureText,
      builder: (BuildContext context, bool value, dynamic child) {
        return Card(
          child: TextFormField(
            maxLines: widget.maxLine,
            enabled: widget.enabled,
            cursorColor: kcPrimaryColor,
            style: GoogleFonts.poppins(fontSize: sp(11)),
            controller: widget.textEditingController,
            autocorrect: widget.autoCorrect,
            autovalidateMode: widget.validator != null
                ? AutovalidateMode.onUserInteraction
                : null,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(sp(5.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(sp(5.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(sp(5.0)),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(sp(5.0)),
              ),
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w400,
                fontSize: sp(11),
              ),
              suffixIcon: widget.isPassword == true
                  ? IconButton(
                      icon: const Icon(Icons.remove_red_eye_outlined),
                      onPressed: () => obscureText.value = !obscureText.value,
                    )
                  : widget.suffix != null
                      ? Icon(widget.suffix)
                      : const SizedBox(),
            ),
            keyboardType: widget.textInputType,
            obscureText: value,
            validator: (String? val) => widget.validator!(val?.trim()),
          ),
        );
      },
    );
  }
}

class CommentFormField extends StatelessWidget {
  const CommentFormField({
    Key? key,
    this.textEditingController,
    this.autoCorrect = true,
    required this.hintText,
    this.validator,
    this.textInputType = TextInputType.text,
    this.isPassword = false,
    this.enabled = true,
    this.maxLine = 1,
    this.suffix,
  }) : super(key: key);

  final TextEditingController? textEditingController;
  final bool autoCorrect;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType textInputType;
  final bool isPassword;
  final bool enabled;
  final int? maxLine;
  final IconData? suffix;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sp(35),
      child: TextFormField(
        maxLines: maxLine,
        enabled: enabled,
        cursorColor: kcPrimaryColor,
        style: GoogleFonts.poppins(),
        controller: textEditingController,
        autocorrect: autoCorrect,
        autovalidateMode:
            validator != null ? AutovalidateMode.onUserInteraction : null,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(sp(20)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(sp(20)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(sp(20)),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(sp(20)),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w600,
          ),
        ),
        keyboardType: textInputType,
        validator: (String? val) => validator!(val?.trim()),
      ),
    );
  }
}
