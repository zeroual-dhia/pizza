import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Textinput extends StatefulWidget {
  final String hint_text, label;
  final bool password;
  final String? selector; // can be: 'email', 'password', 'name'
  final TextEditingController? controller;
  final TextEditingController? compareController;

  const Textinput({
    super.key,
    this.hint_text = "",
    this.label = "",
    this.password = false,
    this.selector,
    this.controller,
    this.compareController,
  });

  @override
  State<Textinput> createState() => _TextinputState();
}

class _TextinputState extends State<Textinput> {
  bool isObscured = true;
  double opacity = 0.5;

  /// 🔍 Select validator based on selector
  String? Function(String?)? getValidator() {
    switch (widget.selector) {
      case "email":
        return validateEmail;
      case "password":
        return validatePass;
      case "name":
        return validateName;
      case "password2":
        return (val) => validateSecondPass(val, widget.compareController);
      default:
        return null;
    }
  }

  String? validateEmail(String? email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return (email != null && emailRegex.hasMatch(email))
        ? null
        : "Invalid email";
  }

  String? validatePass(String? pass) {
    if (pass == null || pass.length < 8) {
      return "Password must be at least 8 characters";
    }
    return null;
  }

  String? validateName(String? name) {
    if (name == null || name.trim().isEmpty) {
      return "Enter your name";
    }
    return null;
  }

  String? validateSecondPass(
    String? pass,
    TextEditingController? compareController,
  ) {
    final originalPass = compareController?.text;
    if (pass == null || pass.isEmpty) {
      return "Please re-enter your password";
    }
    if (pass != originalPass) {
      return "Passwords do not match";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.montserrat(
            color: Colors.black,
            letterSpacing: 0.5,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: widget.controller,
          validator: getValidator(),
          cursorColor: Colors.black,
          obscuringCharacter: '*',
          obscureText: widget.password ? isObscured : false,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            suffixIcon: widget.password
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isObscured = !isObscured;
                        opacity = isObscured ? 0.5 : 1;
                      });
                    },
                    icon: Icon(
                      isObscured ? Icons.visibility : Icons.visibility_off,
                      color: const Color(0xFFEF1C26),
                    ),
                  )
                : null,
            hintText: widget.hint_text,
            hintStyle: TextStyle(
              color: Colors.black.withValues(alpha: 0.6),
              fontSize: 15,
              letterSpacing: 0.5,
            ),
            filled: true,
            fillColor: const Color(0xffF2F2F2),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 17,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(17),
              borderSide: BorderSide(
                color: Color(0xffEF1C26).withValues(alpha: 0.5),
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(17),
              borderSide: BorderSide(
                color: Color(0xffEF1C26).withValues(alpha: 0.5),
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
