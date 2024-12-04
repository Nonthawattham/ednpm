import 'package:flutter/material.dart';
import 'payment_page.dart';

class CartPage2 extends StatefulWidget {
  final List<Map<String, dynamic>> cart2Items;
  final String deliveryAddress; // เพิ่มตัวแปร deliveryAddress

  const CartPage2({
    required this.cart2Items,
    required this.deliveryAddress, // รับ deliveryAddress ผ่าน constructor
  });

  @override
  _CartPage2State createState() => _CartPage2State();
}

class _CartPage2State extends State<CartPage2> {
  void removeItem(String itemName) {
    setState(() {
      widget.cart2Items.removeWhere((item) => item['name'] == itemName);
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;

    // คำนวณราคารวม
    widget.cart2Items.forEach((item) {
      totalPrice += item['price'] * item['quantity'];
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('ตะกร้าสินค้า'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: widget.cart2Items.isEmpty
            ? Center(child: Text('ตะกร้าสินค้าของคุณว่างเปล่า'))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView(
                      children: widget.cart2Items.map((item) {
                        final itemName = item['name'];
                        final quantity = item['quantity'];
                        final itemPrice = item['price'];

                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            title: Text(itemName),
                            subtitle: Text('฿${itemPrice} x $quantity'),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                removeItem(itemName);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('$itemName ถูกลบออกจากตะกร้า')),
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
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // ส่ง deliveryAddress ไปยัง PaymentPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentPage(
                            totalPrice: totalPrice,
                            deliveryAddress: widget.deliveryAddress, // ส่งไปที่ PaymentPage
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
