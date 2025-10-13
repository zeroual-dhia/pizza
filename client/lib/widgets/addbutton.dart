import 'package:flutter/material.dart';
import 'package:pizza/models/cartmodel.dart';

class Addbutton extends StatefulWidget {
  const Addbutton({
    super.key,
    required this.cart,
    required this.pizza,
    this.isboxconst = false,
  });
  final CartProvider cart;
  final Map<String, dynamic> pizza;
  final bool isboxconst;

  @override
  State<Addbutton> createState() => _AddbuttonState();
}

class _AddbuttonState extends State<Addbutton>
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
      TweenSequenceItem(tween: Tween(begin: 25, end: 35), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 35, end: 25), weight: 50),
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _sizeAnimation,
      builder: (context, child) {
        return IconButton(
          constraints: widget.isboxconst ? BoxConstraints() : null,
          onPressed: () {
            isAdded ? _controller.reverse() : _controller.forward();
            widget.cart.addPizza(widget.pizza);
          },

          icon: const Icon(Icons.add, color: Colors.white),
          style: IconButton.styleFrom(
            padding: widget.isboxconst ? EdgeInsets.all(2) : null,
            backgroundColor: Colors.black,
            iconSize: _sizeAnimation.value,
          ),
        );
      },
    );
  }
}
