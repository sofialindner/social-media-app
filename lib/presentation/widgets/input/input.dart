import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:social_media_app/presentation/widgets/input/outline_border.dart';

class Input extends StatefulWidget {
  final String label;
  final IconData? prefixIcon;
  final Color? foregroundColor;
  final Color? fillColor;
  final Color? focusColor;
  final bool? isPassword;
  final bool? outlined;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final AutovalidateMode autovalidateMode;

  const Input({
    super.key,
    required this.label,
    this.prefixIcon,
    this.foregroundColor,
    this.fillColor,
    this.focusColor,
    this.isPassword = false,
    this.outlined = false,
    this.minLines,
    this.maxLines = 1,
    this.maxLength,
    this.inputFormatters,
    required this.controller,
    required this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  bool passwordVisible = false;
  late FocusNode _focusNode;
  String? validationMessage;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    // Listener to change state on focus change
    _focusNode.addListener(() {
      setState(() {}); // Rebuild to update border color based on focus
    });

    // Listener on controller to validate input without using setState in validator
    widget.controller.addListener(() {
      final result = widget.validator(widget.controller.text);
      if (validationMessage != result) {
        setState(() {
          validationMessage = result;
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    widget.controller.removeListener(() {}); // Remove controller listener
    super.dispose();
  }

  // Alterna a visibilidade da senha e estado do icon
  void _handlePasswordVisibility(bool value) {
    setState(() {
      passwordVisible = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isPassword = widget.isPassword ?? false;

    return TextFormField(
      cursorColor: Theme.of(context).hintColor,
      focusNode: _focusNode,
      controller: widget.controller,
      obscureText: isPassword ? !passwordVisible : false,
      autovalidateMode: widget.autovalidateMode,
      validator: widget.validator,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        hoverColor: Colors.transparent,
        filled: true,
        fillColor: widget.outlined == true
            ? Theme.of(context).brightness == Brightness.light
                  ? Colors.transparent
                  : Theme.of(
                      context,
                    ).textTheme.bodyMedium!.color!.withOpacity(0.1)
            : Theme.of(context).brightness == Brightness.light
            ? Colors.grey.shade200
            : Colors.grey.shade900,
        errorStyle: TextStyle(color: Colors.red.shade400),
        focusedErrorBorder: CustomOutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(
            color: Colors.red.shade400,
            width: 1.3,
            style: BorderStyle.solid,
          ),
        ),
        errorBorder: CustomOutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(
            color: Colors.red.shade400,
            width: 1.3,
            style: BorderStyle.solid,
          ),
        ),
        labelText: widget.label,
        labelStyle: TextStyle(
          fontSize: 15,
          color: _focusNode.hasFocus
              ? widget.focusColor
              : widget.foregroundColor ??
                    (Theme.of(context).brightness == Brightness.light
                        ? Colors.grey.shade700
                        : Colors.grey.shade500),
        ),
        prefixIcon: widget.prefixIcon != null
            ? Icon(
                widget.prefixIcon,
                color:
                    widget.foregroundColor ??
                    (Theme.of(context).brightness == Brightness.light
                        ? Colors.grey.shade400
                        : Colors.grey.shade800),
                size: 18,
              )
            : null,
        enabledBorder: CustomOutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          borderSide: widget.outlined == true
              ? BorderSide(
                  color: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.color!.withOpacity(0.15),
                  width: 1.3,
                  style: BorderStyle.solid,
                )
              : BorderSide.none,
        ),
        focusedBorder: CustomOutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1.3,
            style: BorderStyle.solid,
          ),
        ),
        suffixIcon: isPassword
            ? IconButton(
                onPressed: () {
                  _handlePasswordVisibility(!passwordVisible);
                },
                icon: Icon(
                  passwordVisible ? Ionicons.eye : Ionicons.eye_off,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.grey.shade900
                      : Colors.grey.shade400,
                ),
              )
            : _focusNode.hasFocus
            ? IconButton(
                onPressed: widget.controller.clear,
                icon: Icon(
                  Ionicons.close,
                  color: (Theme.of(context).brightness == Brightness.light
                      ? Colors.grey.shade900
                      : Colors.grey.shade400),
                ),
              )
            : null,
      ),
      inputFormatters: widget.inputFormatters,
    );
  }
}
