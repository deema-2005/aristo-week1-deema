enum DrinkSize { 
  small, medium, large }

abstract class Drink {
  final String name;
  final double basePrice;
  final DrinkSize size;

  Drink({
    required this.name,
    required this.basePrice,
    required this.size,
  });

  double get finalPrice {
    switch (size) {
      case DrinkSize.small:
        return basePrice * 1.0;
      case DrinkSize.medium:
        return basePrice * 1.25;
      case DrinkSize.large:
        return basePrice * 1.5;
    }
  }

  String description();

  @override
  String toString() {
    return '${description()} - ${finalPrice.toStringAsFixed(2)} EGP';
  }
}

class Coffee extends Drink {
  final int numberOfExtraShots;

  Coffee({
    required super.name,
    required super.basePrice,
    required super.size,
    required this.numberOfExtraShots,
  });

  @override
  double get finalPrice {
    return super.finalPrice + (numberOfExtraShots * 5.0);
  }

  @override
  String description() {
    String sizeStr = size.toString().split('.').last;
    return '$name ($sizeStr, $numberOfExtraShots extra shots)';
  }
}

class Tea extends Drink {
  final bool isHerbal;

  Tea({
    required super.name,
    required super.basePrice,
    required super.size,
    required this.isHerbal,
  });

  @override
  String description() {
    String sizeStr = size.toString().split('.').last;
    String typeStr = isHerbal ? 'Herbal' : 'Regular';
    return '$name ($sizeStr, $typeStr)';
  }
}

class Juice extends Drink {
  final String fruitName;

  Juice({
    required super.name,
    required super.basePrice,
    required super.size,
    required this.fruitName,
  });

  @override
  String description() {
    String sizeStr = size.toString().split('.').last;
    return '$name ($sizeStr, $fruitName Fruit)';
  }
}

// 6. كلاس الطلب (Order) لإدارة المشروبات وحساب الفاتورة
class Order {
  final String customerName;
  final List<Drink> _drinks = [];

  Order({required this.customerName});

  void addDrink(Drink drink) {
    _drinks.add(drink);
  }

]  void removeDrink(Drink drink) {
    _drinks.remove(drink);
  }

  int get itemsCount => _drinks.length;

  double get totalPrice {
    double total = 0;
    for (var drink in _drinks) {
      total += drink.finalPrice;
    }
    
    if (itemsCount > 3) {
      total = total * 0.9; 
    }
    return total;
  }

String receipt() {
  String output = '';

  output += '=== Areisto Coffee ===\n';
  output += 'Customer: $customerName\n';

  for (var drink in _drinks) {
    output += '${drink.toString()}\n';
  }

 
  output += 'Items: $itemsCount\n';

  if (itemsCount > 3) {
    output += 'Discount Applied: 10% Off!\n';
  }

  output += 'Total: ${totalPrice.toStringAsFixed(2)} EGP\n';
  
  return output;
}

}

void main() {
  final order = Order(customerName: 'Sara');

  final latte = Coffee(name: 'Latte', basePrice: 20.0, size: DrinkSize.large, numberOfExtraShots: 2);
  final greenTea = Tea(name: 'Green Tea', basePrice: 15.0, size: DrinkSize.small, isHerbal: true);
  final orangeJuice = Juice(name: 'Orange Juice', basePrice: 20.0, size: DrinkSize.medium, fruitName: 'Orange');

  order.addDrink(latte);
  order.addDrink(greenTea);
  order.addDrink(orangeJuice);

  order.removeDrink(greenTea);

  print(order.receipt());
}

