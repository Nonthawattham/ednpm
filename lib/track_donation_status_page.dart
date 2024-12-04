import 'package:ednpm/providers/order_number_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrackDonationStatusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orderNumbers = Provider.of<OrderNumberProvider>(context).orderNumbers;

    return Scaffold(
      appBar: AppBar(
        title: Text('สถานะพัสดุ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(
              Icons.local_shipping,
              size: 80,
              color: Colors.blue,
            ),
            SizedBox(height: 16),
            Text(
              'หมายเลขพัสดุ',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            SizedBox(height: 8),
            orderNumbers.isEmpty
                ? Text(
                    'ยังไม่มีหมายเลขพัสดุ',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  )
                : Column(
                    children: orderNumbers.map((orderNumber) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            orderNumber,
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'สถานะ: กำลังจัดส่ง',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
                          ),
                          Divider(height: 30, thickness: 1, color: Colors.grey[300]),
                        ],
                      );
                    }).toList(),
                  ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.home),
              label: Text('กลับหน้าหลัก'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
