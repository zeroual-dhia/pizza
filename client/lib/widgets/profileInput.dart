import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profileinput extends StatefulWidget {
  const Profileinput({
    super.key,
    // ignore: non_constant_identifier_names
    required this.label,
    required this.readOnly,
    required this.icon,
    required this.controller,
    required this.selector,
  });

  // ignore: non_constant_identifier_names
  final String label;
  final bool readOnly;
  final Icon icon;
  final TextEditingController controller;
  final String selector;
  @override
  State<Profileinput> createState() => _ProfileinputState();
}

class _ProfileinputState extends State<Profileinput> {
  String? _validator(String? value) {
    final selector = widget.selector;

    if (selector == 'name') {
      if (value == null || value.trim().isEmpty) {
        return 'Name cannot be empty';
      }
    }

    if (selector == 'phone') {
      if (value == null || value.trim().isEmpty) {
        return null;
      }

      final pattern = RegExp(r'^(05|06|07)[0-9]{8}$');
      if (!pattern.hasMatch(value.trim())) {
        return 'Enter a valid Algerian number (05, 06, or 07)';
      }
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
          style: GoogleFonts.inter(letterSpacing: 0.5, fontSize: 16),
        ),
        const SizedBox(height: 10),
        TextFormField(
          validator: _validator,
          controller: widget.controller,
          readOnly: widget.readOnly,
          cursorColor: Colors.black,
          obscuringCharacter: '*',
          style: TextStyle(color: Colors.black.withValues(alpha: 0.6)),

          decoration: InputDecoration(
            prefixIconColor: Color(0xffEF1C26),
            prefixIcon: widget.icon,
            filled: true,
            fillColor: const Color(0xffF2F2F2),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 17,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(17),
              borderSide: BorderSide(color: Colors.transparent, width: 0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(17),
              borderSide: BorderSide(color: Colors.transparent, width: 0),
            ),
          ),
        ),
      ],
    );
  }
}
