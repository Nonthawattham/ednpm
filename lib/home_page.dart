import 'package:flutter/material.dart';
import 'burger_menu.dart'; // Import BurgerMenu
import 'category_page.dart'; // Import CategoryPage

class HomePage extends StatelessWidget {
  final List<String> deliveryPoints = [
    'โรงเรียนรวมราษฎร์สามัคคี',
    'โรงเรียนบ้านตลาดลำใหม่',
    'โรงเรียนบ้านโพนขาว',
    'โรงเรียนบ้านป่าซาง',
    'โรงเรียนวัดทุ่งหลวง',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('จุดส่งพัสดุ/อุปกรณ์การเรียน', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent, // สีแถบด้านบน
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: BurgerMenu(), // ใช้เมนูเบอร์เกอร์ที่แยกไฟล์ไว้
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              'จุดส่งพัสดุ/อุปกรณ์การเรียน',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 20),

            // List of Delivery Points
            Expanded(
              child: ListView.builder(
                itemCount: deliveryPoints.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // แสดงข้อความแจ้งเตือนก่อนเปลี่ยนหน้า
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('กำลังเข้าสู่หน้าเลือกประเภทสำหรับ ${deliveryPoints[index]}'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        // เปลี่ยนหน้าไปยัง CategoryPage พร้อมส่ง deliveryAddress
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryPage(
                              deliveryAddress: deliveryPoints[index],
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 18.0), backgroundColor: Colors.blueAccent, // เปลี่ยนสีพื้นหลังเป็นสีฟ้า
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // ขอบมนของปุ่ม
                        ),
                        elevation: 5, // เพิ่มเงาให้กับปุ่ม
                      ),
                      child: Text(
                        deliveryPoints[index],
                        style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
