import 'package:flutter/material.dart';
import 'payment_success_page.dart';  // นำเข้าไฟล์หน้าชำระเงินเสร็จสิ้น

class PaymentPage extends StatelessWidget {
  final double totalPrice;
  final String deliveryAddress;  // Accept the delivery address

  const PaymentPage({required this.totalPrice, required this.deliveryAddress});

  @override
  Widget build(BuildContext context) {
    // สร้างหมายเลขพัสดุสุ่ม (ในกรณีนี้จะเป็นหมายเลขที่ใช้ในการติดตามสถานะ)
    String orderNumber = 'ORD-${DateTime.now().millisecondsSinceEpoch}';

    return Scaffold(
      appBar: AppBar(
        title: Text('หน้าชำระเงิน'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'รายละเอียดการสั่งซื้อ',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'ราคารวม: ฿${totalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, color: Colors.green),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'ที่อยู่จัดส่ง: $deliveryAddress',  // Display the delivery address
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // เมื่อกดปุ่มชำระเงิน
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('การชำระเงินเสร็จสิ้นแล้ว!')),
                );
                // ไปที่หน้าชำระเงินเสร็จสิ้น
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentSuccessPage(
                      totalPrice: totalPrice,
                      orderNumber: orderNumber,
                      deliveryAddress: deliveryAddress,
                    ),
                  ),
                );
              },
              child: Text('ชำระเงิน'),
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
