import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:pizza/models/cartmodel.dart';
import 'package:pizza/models/favourite.dart';
import 'package:pizza/widgets/addbutton.dart';
import 'package:provider/provider.dart';

class Pizzacard2 extends StatelessWidget {
  const Pizzacard2({super.key, required this.pizza});
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
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: const Color(0xfff8f8f8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Hero(
              tag: pizza['id'],
              child: Image.asset(
                width: 145,
                "${pizza['image_url']}",
                fit: BoxFit.cover,
              ),
            ),

            Expanded(
              flex: 2,
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
                          fontSize: 15,
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
                            iconSize: 25,
                          );
                        },
                      ),
                    ],
                  ),
                  Text(
                    "Offer valid today only",
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff868686),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        "30min",
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff868686),
                        ),
                      ),
                      const SizedBox(width: 30),
                      Text(
                        "4.6",
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff868686),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.star, color: Colors.amber),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${pizza['price']}",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
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
                            fontSize: 10,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Consumer<CartProvider>(
                        builder: (context, cart, child) {
                          return Addbutton(
                            cart: cart,
                            pizza: pizza,
                            isboxconst: true,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
