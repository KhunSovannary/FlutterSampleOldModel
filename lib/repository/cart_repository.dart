import 'package:flutter/foundation.dart';
import 'package:flutter_chabhuoy/models/product_model.dart';

class CartItem {
  final int id;
  final String name;
  final String image;
  final int quantity;
  final double price;
  final double total;
  final List<Option> options;

  CartItem({
    @required this.id,
    @required this.name,
    @required this.quantity,
    @required this.price,
    @required this.image,
    @required this.total,
    @required this.options,
  });

  Map<String, dynamic> toJson() => {
    "product_id": id,
    "name": name,
    "unit_price": price,
    "quantity": quantity,
    "discount" : 0,
    "options" : List<dynamic>.from(options.map((x) => x.toJson())),
    "variants" : [],
    "discounts" : []
  };
}

class CartRepository with ChangeNotifier {
  Map<String, CartItem> _items = {};

  double deliveryFee = 0;

  List<CartItem> get items {
    return _items.values.toList();
  }

  int get itemCount {
    return _items.length;
  }

  List<CartItem> get  getItems {
    return _items.values.toList();
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return (total - deliveryFee);
  }

  void addItem(ProductModel product, String image, int quantity, List<Option> productOption) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id.toString(),
            (existingValue) => CartItem(
            id: existingValue.id,
            name: existingValue.name,
            price: existingValue.price,
            quantity: quantity,
            image: image,
            total: existingValue.price * existingValue.quantity,
            options: productOption
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id.toString(),
            () => CartItem(
          id: product.id,
          price: double.parse(product.unitPrice),
          name: product.name,
          quantity: quantity,
          image: image,
          total: double.parse(product.unitPrice) * quantity,
          options: productOption
          ),
      );
    }
    notifyListeners();
  }

  void updateQuantity(productId, quantity) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
            (existingValue) => CartItem(
            id: existingValue.id,
            name: existingValue.name,
            price: existingValue.price,
            quantity: quantity >= 1 ? existingValue.quantity + 1 : (existingValue.quantity - 1 <= 0 ? 1 : existingValue.quantity - 1),
            image: existingValue.image,
            total: existingValue.price,
            options: existingValue.options
        ),
      );
    }
    notifyListeners();
  }

  void setDeliveryFee(double fee) {
    deliveryFee = fee;
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }
  void clear() {
    _items = {};
    notifyListeners();
  }

}