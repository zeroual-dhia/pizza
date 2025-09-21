import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza/models/favourite.dart';
import 'package:pizza/models/navigation.dart';
import 'package:pizza/models/pizza.dart';
import 'package:pizza/routes/Profile.dart';
import 'package:pizza/routes/cart.dart';
import 'package:pizza/routes/favourites.dart';
import 'package:pizza/server/auth.dart';
import 'package:pizza/widgets/navigatorBar.dart';
import 'package:pizza/widgets/offer.dart';
import 'package:pizza/widgets/pizzacard.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final _auth = Auth();
  final pages = [HomeBody(), Cart(), Favourites(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, navigation, child) {
        return Scaffold(
          body: pages[navigation.selectedIndex],
          bottomNavigationBar: Navigatorbar(navigation: navigation),
        );
      },
    );
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  String? token;

  bool isloading = true;
  @override
  // didChangeDependencies is called after initState and whenever an inherited widget (like Provider) changes.
  // We use it here instead of initState because context is guaranteed to be available,
  // allowing us to safely access the token from Provider and trigger the initial pizza fetch.
  void didChangeDependencies() {
    super.didChangeDependencies();
    token = Provider.of<String?>(context);

    if (token != null) {
      _loadPizzas();
    }
  }

  Future<void> _loadPizzas() async {
    final pizzaProvidre = Provider.of<Pizza>(context, listen: false);
    if (pizzaProvidre.lastToken == token) {
      setState(() {
        isloading = false;
      });
      return;
    }
    final favProvider = Provider.of<Favourite>(context, listen: false);

    await pizzaProvidre.fetchPizza(token);
    await favProvider.fetchFavs(token ?? '');
    await await Future.delayed(Duration(seconds: 1));
    setState(() {
      isloading = false;
    });
  }

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return isloading
        ? Center(child: CircularProgressIndicator(color: Color(0xffEF1C26)))
        : Padding(
            padding: EdgeInsetsGeometry.fromLTRB(20, 50, 20, 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Color(0xffEF1C26)),
                        SizedBox(width: 10),
                        Text(
                          "Algiers",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),

                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.keyboard_arrow_down_sharp),
                        ),
                      ],
                    ),

                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.settings),
                      style: IconButton.styleFrom(
                        backgroundColor: Color(0xffF8F8F8),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Offer(),
                SizedBox(height: 25),
                Offer(),
                SizedBox(height: 13),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Popular pizza",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      InkWell(
                        focusColor: Colors.white,
                        highlightColor: Colors.white,
                        splashColor: Colors.white,
                        child: Text(
                          "See All",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color(0xffEF1C26),
                          ),
                        ),
                        onTap: () {
                          context.push('/home/seeAll');
                        },
                      ),
                    ],
                  ),
                ),
                Consumer<Pizza>(
                  builder: (context, pizza, child) {
                    final chosen = [
                      pizza.pizzas[0],
                      pizza.pizzas[5],
                      pizza.pizzas[1],
                    ];
                    return Column(
                      children: [
                        CarouselSlider(
                          items: chosen
                              .map((piza) => Pizzacard(pizza: piza))
                              .toList(),
                          options: CarouselOptions(
                            clipBehavior: Clip.none,
                            autoPlay: false,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration: Duration(
                              milliseconds: 800,
                            ),
                            enlargeCenterPage: false,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.85,
                            height: 270,
                            onPageChanged: (i, reason) {
                              setState(() {
                                index = i;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: chosen
                              .map((piza) => Pizzacard(pizza: piza))
                              .toList()
                              .asMap()
                              .entries
                              .map(
                                (item) => Container(
                                  height: 8,
                                  width: 8,
                                  margin: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: index == item.key
                                        ? Colors.black
                                        : Colors.grey.withAlpha(100),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
  }
}
