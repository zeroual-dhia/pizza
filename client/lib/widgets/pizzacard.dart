import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza/models/cartmodel.dart';
import 'package:pizza/models/favourite.dart';
import 'package:pizza/widgets/addbutton.dart';
import 'package:provider/provider.dart';

class Pizzacard extends StatelessWidget {
  const Pizzacard({super.key, required this.pizza});
  final Map<String, dynamic> pizza;
  @override
  Widget build(BuildContext context) {
    final idToken = Provider.of<String?>(context);
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        context.push('/home/pizzaInfo/${pizza['id']}');
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 70, 10, 0),
            padding: const EdgeInsets.fromLTRB(15, 25, 15, 0),
            decoration: BoxDecoration(
              color: const Color(0xfff8f8f8),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${pizza['name']}",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Consumer<Favourite>(
                      builder: (context, fav, child) {
                        return IconButton(
                          onPressed: () {
                            fav.triggerFav(pizza['id'], idToken ?? '');
                          },
                          icon: fav.favs.contains(pizza['id'])
                              ? Icon(Icons.favorite)
                              : Icon(Icons.favorite_border),
                          iconSize: 30,
                        );
                      },
                    ),
                  ],
                ),
                Text(
                  "Offer valid today only",
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff868686),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "30min",
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff868686),
                      ),
                    ),
                    const SizedBox(width: 30),
                    Text(
                      "4.6",
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff868686),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.star, color: Colors.amber),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$ ${pizza['price']}",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xffEF1C26),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "20% off",
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Consumer<CartProvider>(
                      builder: (context, cart, child) {
                        return Addbutton(cart: cart,pizza: pizza,);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: -2,
            left: 0,
            right: 0,
            child: Center(
              child: Hero(
                tag: pizza['id'],
                child: Image.asset("${pizza['image_url']}", width: 120),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
