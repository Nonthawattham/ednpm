import 'package:ednpm/providers/order_number_provider.dart';
import 'package:ednpm/track_donation_status_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentSuccessPage extends StatelessWidget {
  final double totalPrice;
  final String orderNumber;
  final String deliveryAddress;

  const PaymentSuccessPage({
    required this.totalPrice,
    required this.orderNumber,
    required this.deliveryAddress,
  });

  @override
  Widget build(BuildContext context) {
    // Add the order number to the provider
    Provider.of<OrderNumberProvider>(context, listen: false).addOrderNumber(orderNumber);

    return Scaffold(
      appBar: AppBar(
        title: Text('การชำระเงินเสร็จสิ้น'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_outline,
                size: 120,
                color: Colors.green,
              ),
              SizedBox(height: 20),
              Text(
                'การชำระเงินของคุณเสร็จสิ้นแล้ว!',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15),
              Text(
                'หมายเลขพัสดุ: $orderNumber',
                style: TextStyle(fontSize: 20, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'ที่อยู่จัดส่ง: $deliveryAddress',
                style: TextStyle(fontSize: 18, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TrackDonationStatusPage(),
                    ),
                  );
                },
                child: Text(
                  'ติดตามสถานะการจัดส่ง',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14), backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: Text(
                  'กลับไปยังหน้าหลัก',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14), backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
