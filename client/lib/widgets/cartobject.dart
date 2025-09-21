import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza/models/cartmodel.dart';
import 'package:provider/provider.dart';

class Cartobject extends StatelessWidget {
  const Cartobject({super.key, required this.pizza});
  final Map<String, dynamic> pizza;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 7,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(pizza['image_url'], width: 100),

          Expanded(
            child: Text(
              pizza['name'],
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          SizedBox(height: 10),

          Column(
            children: [
              Consumer<CartProvider>(
                builder: (context, cart, child) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          cart.minusItem(pizza);
                        },
                        icon: Icon(Icons.remove, color: Colors.black),
                        style: IconButton.styleFrom(
                          padding: EdgeInsets.all(0),
                          backgroundColor: Color(0xffF8F8F8),
                          iconSize: 20,
                        ),
                      ),
                      Text(
                        "${pizza['quantity']}",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      IconButton(
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          cart.addPizza(pizza);
                        },
                        icon: Icon(Icons.add, color: Colors.white),
                        style: IconButton.styleFrom(
                          padding: EdgeInsets.all(0),
                          backgroundColor: Color(0xffEF1C26),
                          iconSize: 20,
                        ),
                      ),
                    ],
                  );
                },
              ),
              Row(
                children: [
                  Text(
                    '\$',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      color: Color(0xffEF1C26),

                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(width: 2),
                  Text(
                    "${pizza['price']}",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,

                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ],
          ),

          Container(
            height: 90,
            clipBehavior: Clip.none,
            decoration: BoxDecoration(
              color: Color(0xffF8F8F8).withAlpha(255),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(80),
                bottomLeft: Radius.circular(80),
              ),
            ),
            child: Consumer<CartProvider>(
              builder: (context, cart, child) {
                return IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    cart.removePizza(pizza);
                  },
                  icon: Icon(Icons.delete_outline),
                  color: Color(0xffEF1C26),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
