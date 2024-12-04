import 'package:ednpm/cart_page2.dart';
import 'package:ednpm/item_detail/detail_page2.dart';
import 'package:flutter/material.dart';

class BagPage extends StatefulWidget {
  final String deliveryAddress; // Add deliveryAddress parameter

  const BagPage({required this.deliveryAddress}); // Accept it in the constructor

  @override
  _BagPageState createState() => _BagPageState();
}

class _BagPageState extends State<BagPage> {
  final List<Map<String, dynamic>> bagItems = [
    {
      'name': 'กระเป๋านักเรียน',
      'image': 'images/bag1.jpg',
      'price': 350,
    },
    {
      'name': 'กระเป๋าผ้า',
      'image': 'images/bag2.jpg',
      'price': 200,
    },
    {
      'name': 'กระเป๋าคาดเอว',
      'image': 'images/bag3.jpg',
      'price': 300,
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
        final item = bagItems.firstWhere((element) => element['name'] == itemName);
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
        title: Text('กระเป๋า - ที่อยู่จัดส่ง: ${widget.deliveryAddress}'), // Display delivery address
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage2(
                    cart2Items: cartItems,
                    deliveryAddress: widget.deliveryAddress, // Pass deliveryAddress to CartPage2
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: bagItems.length,
        itemBuilder: (context, index) {
          final item = bagItems[index];
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
