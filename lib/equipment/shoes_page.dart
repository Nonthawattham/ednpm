import 'package:ednpm/cart_page.dart';
import 'package:ednpm/item_detail/detail_page1.dart';
import 'package:flutter/material.dart';

class ShoesPage extends StatefulWidget {
  final String deliveryAddress;

  const ShoesPage({required this.deliveryAddress});

  @override
  _ShoesPageState createState() => _ShoesPageState();
}

class _ShoesPageState extends State<ShoesPage> {
  final List<Map<String, dynamic>> shoesItems = [
    {
      'name': 'รองเท้าผ้าใบนักเรียนผู้ชาย',
      'image': 'images/so1.jpg',
      'price': 450,
      'sizes': ['37', '38', '39', '40', '41', '42', '43', '44', '45'],
      'selectedSize': '', // Initially no size selected
    },
    {
      'name': 'รองเท้าผ้าใบนักเรียนผู้หญิง',
      'image': 'images/so2.jpg',
      'price': 450,
      'sizes': ['37', '38', '39', '40', '41', '42', '43', '44', '45'],
      'selectedSize': '', // Initially no size selected
    },
    {
      'name': 'รองเท้านักเรียนผู้หญิง',
      'image': 'images/so3.jpg',
      'price': 500,
      'sizes': ['37', '38', '39', '40', '41', '42', '43', '44', '45'],
      'selectedSize': '', // Initially no size selected
    },
    {
      'name': 'รองเท้าลูกเสือ',
      'image': 'images/so4.jpg',
      'price': 600,
      'sizes': ['37', '38', '39', '40', '41', '42', '43', '44', '45'],
      'selectedSize': '', // Initially no size selected
    },
  ];

  List<Map<String, dynamic>> cartItems = [];

  void addToCart(String itemName, String size) {
    setState(() {
      final existingItem = cartItems.firstWhere(
        (item) => item['name'] == itemName && item['size'] == size,
        orElse: () => {},
      );

      if (existingItem.isEmpty) {
        final item = shoesItems.firstWhere((element) => element['name'] == itemName);
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
        title: Text('รองเท้า - ที่อยู่จัดส่ง: ${widget.deliveryAddress}'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(
                    cartItems: cartItems,
                    deliveryAddress: widget.deliveryAddress,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              itemCount: shoesItems.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final item = shoesItems[index];
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
                        DropdownButton<String>(
                          hint: Text('เลือกขนาด'),
                          value: selectedSize.isEmpty ? null : selectedSize,
                          items: itemSizes.map<DropdownMenuItem<String>>((String size) {
                            return DropdownMenuItem<String>(
                              value: size,
                              child: Text(size),
                            );
                          }).toList(),
                          onChanged: (String? newSize) {
                            setState(() {
                              item['selectedSize'] = newSize ?? '';
                            });
                          },
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
                                : cartItems
                                    .firstWhere((item) => item['name'] == itemName && item['size'] == selectedSize)['quantity']
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
