import 'package:flutter/cupertino.dart';
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
    this.onChanged,
    this.fillColor,
  }) : super(key: key);

  final TextEditingController? textEditingController;
  final bool autoCorrect;
  final String hintText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputType textInputType;
  final bool isPassword;
  final bool enabled;
  final int? maxLine;
  final IconData? suffix;
  final Color? fillColor;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final ValueNotifier<bool> obscureText = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: obscureText,
      builder: (BuildContext context, bool value, dynamic child) {
        return TextFormField(
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
            fillColor: widget.fillColor ?? Colors.grey.shade100,
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
                    icon: Icon(
                      value
                          ? CupertinoIcons.eye_slash_fill
                          : CupertinoIcons.eye_fill,
                    ),
                    onPressed: () => obscureText.value = !obscureText.value,
                  )
                : widget.suffix != null
                    ? Icon(widget.suffix)
                    : const SizedBox(),
          ),
          keyboardType: widget.textInputType,
          obscureText: value && widget.isPassword,
          validator: (String? val) => widget.validator!(val?.trim()),
          onChanged: (String val) {
            if (widget.onChanged == null) return;

            widget.onChanged!(val.trim());
          },
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
