import 'package:flutter/material.dart';
import 'payment_page.dart';  // Import PaymentPage
import 'category_page.dart'; // Import CategoryPage

class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final String deliveryAddress;  // Add the deliveryAddress parameter

  const CartPage({required this.cartItems, required this.deliveryAddress});  // Accept it in the constructor

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;

    // คำนวณราคารวม
    widget.cartItems.forEach((item) {
      totalPrice += item['price'] * item['quantity'];
    });

    void removeItem(String itemName, String size) {
      setState(() {
        widget.cartItems.removeWhere(
          (item) => item['name'] == itemName && item['size'] == size,
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('ตะกร้าสินค้า'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: widget.cartItems.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Text('ตะกร้าสินค้าของคุณว่างเปล่า')),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // When cart is empty, navigate back to category page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryPage(
                            deliveryAddress: widget.deliveryAddress,
                          ),
                        ),
                      );
                    },
                    child: Text('ไปเลือกสินค้าต่อ'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: Colors.blue,
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView(
                      children: widget.cartItems.map((item) {
                        final itemName = item['name'];
                        final quantity = item['quantity'];
                        final itemPrice = item['price'];
                        final selectedSize = item['size']; // Get the selected size

                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            title: Text(itemName),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('ขนาดที่เลือก: $selectedSize'), // Display the selected size
                                Text('฿${itemPrice} x $quantity'),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                removeItem(itemName, selectedSize);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('$itemName (ขนาด: $selectedSize) ถูกลบออกจากตะกร้า'))
                                );
                              },
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'ราคารวม: ฿${totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // When confirming the order, pass the deliveryAddress to PaymentPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentPage(
                            totalPrice: totalPrice,
                            deliveryAddress: widget.deliveryAddress,  // Pass the deliveryAddress here
                          ),
                        ),
                      );
                    },
                    child: Text('ยืนยันการสั่งซื้อ'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: Colors.green,
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
