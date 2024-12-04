import 'package:ednpm/cart_page2.dart';
import 'package:ednpm/item_detail/detail_page2.dart';
import 'package:flutter/material.dart';

class ElectronicsPage extends StatefulWidget {
  final String deliveryAddress; // Add the deliveryAddress parameter

  const ElectronicsPage({required this.deliveryAddress}); // Accept it in the constructor

  @override
  _ElectronicsPageState createState() => _ElectronicsPageState();
}

class _ElectronicsPageState extends State<ElectronicsPage> {
  final List<Map<String, dynamic>> electronicsItems = [
    {
      'name': 'คอมพิวเตอร์',
      'image': 'images/e1.jpg',
      'price': 25000,
    },
    {
      'name': 'แท็บเล็ต',
      'image': 'images/e2.jpg',
      'price': 15000,
    },
  ];

  List<Map<String, dynamic>> cartItems = [];

  void addToCart(String itemName) {
    setState(() {
      final existingItem = cartItems.firstWhere(
        (item) => item['name'] == itemName,
        orElse: () => {},
      );

      if (existingItem.isEmpty) {
        final item = electronicsItems.firstWhere((element) => element['name'] == itemName);
        cartItems.add({
          'name': item['name'],
          'quantity': 1,
          'price': item['price'],
        });
      } else {
        existingItem['quantity']++;
      }
    });
  }

  void removeFromCart(String itemName) {
    setState(() {
      final existingItem = cartItems.firstWhere(
        (item) => item['name'] == itemName,
        orElse: () => {},
      );

      if (!existingItem.isEmpty && existingItem['quantity'] > 1) {
        existingItem['quantity']--;
      } else {
        cartItems.removeWhere((item) => item['name'] == itemName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('อุปกรณ์อิเล็กทรอนิกส์ - ที่อยู่จัดส่ง: ${widget.deliveryAddress}'), // Display deliveryAddress
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage2(
                    cart2Items: cartItems,
                    deliveryAddress: widget.deliveryAddress, // Pass deliveryAddress
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: electronicsItems.length,
        itemBuilder: (context, index) {
          final item = electronicsItems[index];
          final itemName = item['name'];
          final itemImage = item['image'];
          final itemPrice = item['price'];

          return Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: ListTile(
              leading: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ItemDetail2Page(
                        name: itemName,
                        image: itemImage,
                        price: itemPrice,
                      ),
                    ),
                  );
                },
                child: Image.asset(itemImage, width: 50, height: 50, fit: BoxFit.cover),
              ),
              title: Text(itemName),
              subtitle: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      removeFromCart(itemName);
                    },
                  ),
                  Text(cartItems
                          .firstWhere(
                              (item) => item['name'] == itemName, orElse: () => {})
                          .isEmpty
                      ? '0'
                      : cartItems.firstWhere(
                              (item) => item['name'] == itemName)['quantity']
                          .toString()),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      addToCart(itemName);
                    },
                  ),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('฿${itemPrice}'),
                  IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('$itemName added to cart')),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
