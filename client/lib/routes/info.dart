import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza/models/cartmodel.dart';
import 'package:pizza/models/favourite.dart';
import 'package:pizza/models/pizza.dart';
import 'package:provider/provider.dart';

class PizzaInfo extends StatefulWidget {
  const PizzaInfo({super.key, required this.id});
  final String? id;

  @override
  State<PizzaInfo> createState() => _PizzaInfoState();
}

class _PizzaInfoState extends State<PizzaInfo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  bool isAdded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _sizeAnimation = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween(begin: 0, end: 5), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 5, end: 0), weight: 50),
    ]).animate(_controller);

    _controller.addStatusListener((status) {
      if (status.isCompleted) {
        setState(() {
          isAdded = true;
        });
      }
      if (status.isDismissed) {
        setState(() {
          isAdded = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final idToken = Provider.of<String?>(context);
    return Consumer<Pizza>(
      builder: (context, pizza, child) {
        final mypizza = pizza.pizzas
            .where((piza) => piza['id'] == int.parse(widget.id ?? ''))
            .toList();
        return Scaffold(
          backgroundColor: Color(0xffF8F8F8),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsetsGeometry.fromLTRB(20, 40, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            context.pop();
                          },
                          icon: Icon(Icons.arrow_back),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                        ),
                        Consumer<Favourite>(
                          builder: (context, fav, child) {
                            return IconButton(
                              onPressed: () {
                                fav.triggerFav(
                                  int.parse(widget.id ?? ''),
                                  idToken ?? '',
                                );
                              },
                              icon:
                                  fav.favs.contains(int.parse(widget.id ?? ''))
                                  ? Icon(Icons.favorite)
                                  : Icon(Icons.favorite_border),
                              iconSize: 30,
                            );
                          },
                        ),
                      ],
                    ),
                    Hero(
                      tag: mypizza[0]['id'],
                      child: Image.asset(
                        "${mypizza[0]['image_url']}",
                        width: 380,
                        height: 330,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      height: 30,
                      decoration: BoxDecoration(
                        color: Color(0xffEF1C26),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            constraints: const BoxConstraints(),
                            onPressed: () {},
                            icon: Icon(Icons.remove, color: Colors.white),
                            style: IconButton.styleFrom(
                              padding: EdgeInsets.all(0),
                            ),
                          ),
                          Text(
                            "2",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          IconButton(
                            constraints: const BoxConstraints(),
                            onPressed: () {},
                            icon: Icon(Icons.add, color: Colors.white),
                            style: IconButton.styleFrom(
                              padding: EdgeInsets.all(0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(30),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${mypizza[0]['name']}",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        "${mypizza[0]['description']}",
                        style: GoogleFonts.inter(
                          fontSize: 15.5,
                          color: Color(0xff868686),
                        ),
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/pepper.png",
                                width: 18,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Meduim",
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/fire.png",
                                width: 18,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 10),

                              Text(
                                "250 kcal",
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "- ${mypizza[0]['price']} \$ -",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Color(0xffEF1C26),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Consumer<CartProvider>(
                        builder: (context, cart, child) {
                          return AnimatedBuilder(
                            animation: _sizeAnimation,
                            builder: (context, child) {
                              return InkWell(
                                onTap: () {
                                  cart.addPizza(mypizza[0]);
                                  isAdded
                                      ? _controller.reverse()
                                      : _controller.forward();
                                },
                                child: Align(
                                  alignment: Alignment.center,

                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 20,
                                      horizontal: 35,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xffEF1C26),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.shopping_bag,
                                          color: Colors.white,
                                          size: 32 + _sizeAnimation.value,
                                        ),
                                        SizedBox(width: 17),
                                        Text(
                                          'Add to Bag',
                                          style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 22 + _sizeAnimation.value,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
