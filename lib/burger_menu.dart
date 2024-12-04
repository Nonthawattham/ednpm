import 'package:ednpm/ProfilePage.dart';
import 'package:ednpm/home_page.dart';
import 'package:ednpm/logout_dialog.dart';
import 'package:ednpm/track_donation_status_page.dart';
import 'package:flutter/material.dart';
import 'package:ednpm/contact_info_page.dart';

import 'package:ednpm/donation_centers_page.dart'; // Import หน้า "ศูนย์รับบริจาค"

class BurgerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Center(
              child: Text(
                'เมนู',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('หน้า Home'),
            onTap: () {
              Navigator.pop(context); // ปิด Drawer
              // นำไปหน้า HomePage
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              // เชื่อมต่อไปหน้า Profile โดยดึงข้อมูลผู้ใช้จาก UserProvider
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.track_changes),
            title: Text('ติดตามสถานะบริจาค'),
            onTap: () {
              Navigator.pop(context);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TrackDonationStatusPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.local_hospital),
            title: Text('ศูนย์รับบริจาค'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DonationCentersPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_page),
            title: Text('ข้อมูลติดต่อ'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactInfoPage(),
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('ล็อกเอาต์'),
            onTap: () {
              // เรียกใช้ LogoutDialog ที่เราสร้าง
              LogoutDialog.show(context);
            },
          ),
        ],
      ),
    );
  }
}
