import 'package:ednpm/cart_page.dart';
import 'package:ednpm/item_detail/detail_page1.dart';
import 'package:flutter/material.dart';

class ClothingPage extends StatefulWidget {
  final String deliveryAddress;  // Add the deliveryAddress parameter

  // Accept it in the constructor
  const ClothingPage({required this.deliveryAddress});

  @override
  _ClothingPageState createState() => _ClothingPageState();
}

class _ClothingPageState extends State<ClothingPage> {
  final List<Map<String, dynamic>> clothingItems = [
    {
      'name': 'เสื้อนักเรียนผู้ชาย',
      'image': 'images/s1.jpg',
      'price': 180,
      'sizes': ['S', 'M', 'L', 'XL'], // Sizes for the item
      'selectedSize': '', // Initially no size selected
    },
    {
      'name': 'เสื้อนักเรียนผู้หญิง',
      'image': 'images/s2.jpg',
      'price': 180,
      'sizes': ['S', 'M', 'L', 'XL'],
      'selectedSize': '', // Initially no size selected
    },
    {
      'name': 'กางเกงนักเรียนผู้ชาย',
      'image': 'images/s3.jpg',
      'price': 250,
      'sizes': ['S', 'M', 'L', 'XL'],
      'selectedSize': '', // Initially no size selected
    },
    {
      'name': 'กระโปรงนักเรียนผู้หญิง',
      'image': 'images/s4.jpg',
      'price': 220,
      'sizes': ['S', 'M', 'L', 'XL'],
      'selectedSize': '', // Initially no size selected
    },
    {
      'name': 'กางเกงวอร์ม',
      'image': 'images/s5.jpg',
      'price': 250,
      'sizes': ['S', 'M', 'L', 'XL'],
      'selectedSize': '', // Initially no size selected
    },
    {
      'name': 'ชุดลูกเสือ',
      'image': 'images/s6.jpg',
      'price': 350,
      'sizes': ['S', 'M', 'L', 'XL'],
      'selectedSize': '', // Initially no size selected
    },
    {
      'name': 'ชุดเนตรนารี',
      'image': 'images/s7.jpg',
      'price': 330,
      'sizes': ['S', 'M', 'L', 'XL'],
      'selectedSize': '', // Initially no size selected
    },
  ];

  List<Map<String, dynamic>> cartItems = [];

  // Add to cart with selected size
  void addToCart(String itemName, String size) {
    setState(() {
      final existingItem = cartItems.firstWhere(
        (item) => item['name'] == itemName && item['size'] == size,
        orElse: () => {},
      );

      if (existingItem.isEmpty) {
        final item = clothingItems.firstWhere((element) => element['name'] == itemName);
        cartItems.add({
          'name': item['name'],
          'size': size,
          'quantity': 1,
          'price': item['price'],
        });
      } else {
        existingItem['quantity']++;
      }
    });
  }

  // Remove from cart with selected size
  void removeFromCart(String itemName, String size) {
    setState(() {
      final existingItem = cartItems.firstWhere(
        (item) => item['name'] == itemName && item['size'] == size,
        orElse: () => {},
      );

      if (!existingItem.isEmpty && existingItem['quantity'] > 1) {
        existingItem['quantity']--;
      } else {
        cartItems.removeWhere((item) => item['name'] == itemName && item['size'] == size);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เสื้อผ้า - ที่อยู่จัดส่ง: ${widget.deliveryAddress}'),  // Display the delivery address
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(
                    cartItems: cartItems,
                    deliveryAddress: widget.deliveryAddress,  // Pass deliveryAddress to CartPage
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView( // เพิ่ม SingleChildScrollView
        child: Column(
          children: [
            // ปรับโครงสร้าง UI ภายใน Column ให้เหมาะสม
            ListView.builder(
              itemCount: clothingItems.length,
              shrinkWrap: true,  // ทำให้ ListView ไม่ใช้พื้นที่มากเกินไป
              physics: NeverScrollableScrollPhysics(),  // ปิดการเลื่อนซ้ำซ้อนใน ListView
              itemBuilder: (context, index) {
                final item = clothingItems[index];
                final itemName = item['name'];
                final itemImage = item['image'];
                final itemPrice = item['price'];
                final itemSizes = item['sizes'];
                final selectedSize = item['selectedSize'];

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: ListTile(
                    leading: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ItemDetailPage(
                              name: itemName,
                              image: itemImage,
                              price: itemPrice.toDouble(),
                              sizes: itemSizes,
                            ),
                          ),
                        );
                      },
                      child: Image.asset(itemImage, width: 50, height: 50, fit: BoxFit.cover),
                    ),
                    title: Text(itemName),
                    subtitle: Column(
                      children: [
                        Wrap(
                          spacing: 8.0,
                          children: itemSizes.map<Widget>((String size) {
                            return ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  item['selectedSize'] = size;
                                });
                              },
                              child: Text(size),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: selectedSize == size ? Colors.blue : Colors.grey,
                              ),
                            );
                          }).toList(),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                removeFromCart(itemName, selectedSize);
                              },
                            ),
                            Text(cartItems
                                .firstWhere(
                                    (item) => item['name'] == itemName && item['size'] == selectedSize, 
                                    orElse: () => {})
                                .isEmpty
                            ? '0'
                            : cartItems.firstWhere(
                                    (item) => item['name'] == itemName && item['size'] == selectedSize)['quantity']
                                .toString()),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                addToCart(itemName, selectedSize);
                              },
                            ),
                          ],
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
                              SnackBar(content: Text('$itemName ($selectedSize) added to cart')),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
