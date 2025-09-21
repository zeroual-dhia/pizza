import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza/models/favourite.dart';
import 'package:pizza/models/pizza.dart';
import 'package:pizza/widgets/pizzacard2.dart';
import 'package:provider/provider.dart';

class Favourites extends StatefulWidget {
  const Favourites({super.key});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  final List<String> tabs = ["All Pizzas", "Vegetarien", "Specials"];
  final TextEditingController searchController = TextEditingController();
  int selectedIndex = 0;

  List<dynamic> filter(pizzas, List favIds) {
    final query = searchController.text.trim();

    if (query.isEmpty && selectedIndex == 0) {
      return pizzas.where((pizza) => favIds.contains(pizza['id'])).toList();
    }

    final exp = RegExp("^$query", caseSensitive: false);

    return pizzas.where((pizza) {
      final matchesSearch = query.isEmpty || exp.hasMatch(pizza['name']);
      final matchesTab =
          selectedIndex == 0 || pizza['type'] == tabs[selectedIndex];
      final inFavs = favIds.contains(pizza['id']);
      return matchesSearch && matchesTab && inFavs;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.fromLTRB(20, 40, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Favourites",
                  style: GoogleFonts.pacifico(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    letterSpacing: 3,
                  ),
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
            SizedBox(height: 20),
            SearchBar(
              controller: searchController,
              hintText: "Search your Favourites pizza",
              hintStyle: MaterialStateProperty.all<TextStyle>(
                GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  color: Color(0xff868686),
                ),
              ),
              onChanged: (_) {
                setState(() {});
              },

              backgroundColor: MaterialStateProperty.all<Color>(
                Color(0xFFF8F8F8),
              ),
              elevation: MaterialStateProperty.all<double>(0),
              leading: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Icon(Icons.search, color: Color(0xff868686)),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                "your Favouritess",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(tabs.length, (index) {
                final isSelected = selectedIndex == index;
                return ChoiceChip(
                  selected: isSelected,
                  selectedColor: Color(0xffEF1C26),
                  disabledColor: Color(0xffF8F8F8),

                  shape: StadiumBorder(side: BorderSide.none),
                  side: BorderSide.none,
                  showCheckmark: false,

                  label: Text(
                    tabs[index],
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                  onSelected: (_) {
                    setState(() => selectedIndex = index);
                  },
                );
              }),
            ),
            SizedBox(height: 5),
            Expanded(
              child: Consumer2<Pizza, Favourite>(
                builder: (context, pizza, fav, child) {
                  final filtredPizzas = filter(pizza.pizzas, fav.favs);
                  return ListView.builder(
                    itemCount: filtredPizzas.length,
                    itemBuilder: (context, index) {
                      return Pizzacard2(pizza: filtredPizzas[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
