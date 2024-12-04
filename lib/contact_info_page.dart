import 'package:flutter/material.dart';

class ContactInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ข้อมูลติดต่อ'),
        backgroundColor: Colors.blueAccent, // ใช้สีฟ้าเข้มสำหรับ AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // ข้อมูลติดต่อ
            ListTile(
              leading: Icon(Icons.phone, color: Colors.blueAccent), // ไอคอนโทรศัพท์
              title: Text('เบอร์โทรศัพท์'),
              subtitle: Text('+66 123 456 789'),
              trailing: Icon(Icons.copy), // ไอคอน Copy ข้างๆ
              onTap: () {
                // สามารถเพิ่มฟังก์ชั่นเมื่อกดที่ไอคอนได้
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('คัดลอกเบอร์โทรศัพท์')),
                );
              },
            ),
            Divider(), // เส้นแบ่งระหว่างรายการ

            ListTile(
              leading: Icon(Icons.email, color: Colors.blueAccent), // ไอคอนอีเมล
              title: Text('อีเมล'),
              subtitle: Text('example@email.com'),
              trailing: Icon(Icons.copy),
              onTap: () {
                // ฟังก์ชั่นคัดลอกอีเมล
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('คัดลอกอีเมล')),
                );
              },
            ),
            Divider(),

            ListTile(
              leading: Icon(Icons.location_on, color: Colors.blueAccent), // ไอคอนที่อยู่
              title: Text('ที่อยู่'),
              subtitle: Text('123 ถนนหลัก, เมืองตัวอย่าง, ประเทศไทย'),
              trailing: Icon(Icons.copy),
              onTap: () {
                // ฟังก์ชั่นคัดลอกที่อยู่
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('คัดลอกที่อยู่')),
                );
              },
            ),
            Divider(),

            // เพิ่มข้อมูลติดต่ออื่นๆ ตามที่ต้องการ
            ListTile(
              leading: Icon(Icons.access_time, color: Colors.blueAccent), // ไอคอนเวลา
              title: Text('เวลาทำการ'),
              subtitle: Text('จันทร์ - ศุกร์: 08:00 - 17:00'),
            ),
          ],
        ),
      ),
    );
  }
}
