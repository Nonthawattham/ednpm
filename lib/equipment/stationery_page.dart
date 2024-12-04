import 'package:ednpm/cart_page2.dart';
import 'package:ednpm/item_detail/detail_page2.dart';
import 'package:flutter/material.dart';

class StationeryPage extends StatefulWidget {
  final String deliveryAddress; // เพิ่มพารามิเตอร์ deliveryAddress

  const StationeryPage({required this.deliveryAddress}); // Constructor สำหรับรับ deliveryAddress

  @override
  _StationeryPageState createState() => _StationeryPageState();
}

class _StationeryPageState extends State<StationeryPage> {
  final List<Map<String, dynamic>> stationeryItems = [
    {"name": "ดินสอ", "image": "images/p1.jpg", "price": 15},
    {"name": "ปากกา", "image": "images/p2.jpg", "price": 20},
    {"name": "ยางลบ", "image": "images/p3.jpg", "price": 10},
    {"name": "ปากกาเน้นข้อความ", "image": "images/p4.jpg", "price": 25},
    {"name": "ปากกาเมจิก", "image": "images/p5.jpg", "price": 30},
    {"name": "กาว", "image": "images/p6.jpg", "price": 20},
    {"name": "สก็อตเทป", "image": "images/p7.jpg", "price": 25},
    {"name": "ไม้บรรทัด", "image": "images/p8.jpg", "price": 15},
    {"name": "ปากกาลบคําผิด", "image": "images/p9.jpg", "price": 25},
  ];

  List<Map<String, dynamic>> cartItems = [];

  void addToCart(String itemName) {
    setState(() {
      final existingItem = cartItems.firstWhere(
        (item) => item['name'] == itemName,
        orElse: () => {},
      );

      if (existingItem.isEmpty) {
        final item = stationeryItems.firstWhere((element) => element['name'] == itemName);
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
        title: Text('เครื่องเขียน - ที่อยู่: ${widget.deliveryAddress}'), // แสดง deliveryAddress
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage2(
                    cart2Items: cartItems,
                    deliveryAddress: widget.deliveryAddress, // ส่ง deliveryAddress
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: stationeryItems.length,
        itemBuilder: (context, index) {
          final item = stationeryItems[index];
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
