import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Offer extends StatelessWidget {
  const Offer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 8, 2, 8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xfff8f8f8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Special offer",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  textAlign: TextAlign.left,
                  "Discount 20% off aplied at checkout",
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff868686),
                  ),
                ),

                SizedBox(height: 12),

                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(
                    20,
                  ), // ripple matches shape
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xffED8E92),
                          spreadRadius: 1,
                          blurRadius: 12,
                          offset: const Offset(1, 4),
                        ),
                      ],
                      color: Color(0xffEF1C26), // background color
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Order Now",
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Image.asset(
              "assets/images/Main image 1.png",
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
