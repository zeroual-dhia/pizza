import 'package:flutter/cupertino.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _pizzas = [];

  List<Map<String, dynamic>> get selectedItems => List.unmodifiable(_pizzas);

  int get totalPrice {
    int total = 0;
    for (var pizza in _pizzas) {
      final price = pizza['price'];
      final quantity = pizza['quantity'] as int;

      if (price is num) {
        total += price.toInt() * quantity;
      } else if (price is String) {
        total += (double.tryParse(price) ?? 0).toInt() * quantity;
      }
    }
    return total;
  }

  void addPizza(pizza) {
    final index = _pizzas.indexWhere((c) => c['id'] == pizza['id']);

    if (index != -1) {
      _pizzas[index]['quantity'] += 1;
    } else {
      pizza['quantity'] = 1;
      _pizzas.add(pizza);
    }

    notifyListeners();
  }

  void minusItem(pizza) {
    final index = _pizzas.indexWhere((c) => c['id'] == pizza['id']);

    if (index != -1) {
      _pizzas[index]['quantity'] -= 1;

      if (_pizzas[index]['quantity'] <= 0) {
        _pizzas.removeAt(index);
      }

      notifyListeners();
    }
  }

  void removePizza(pizza) {
    final index = _pizzas.indexWhere((c) => c['id'] == pizza['id']);
    _pizzas.removeAt(index);
    notifyListeners();
  }

  void clearCart() {
    _pizzas.clear();
    notifyListeners();
  }
}
/*
 
    }*/ 