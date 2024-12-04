import 'package:flutter/material.dart';

class LogoutDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('ออกจากระบบ'),
        content: Text('คุณต้องการออกจากระบบหรือไม่?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // ปิด Dialog
            },
            child: Text('ยกเลิก'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // ปิด Dialog
              Navigator.pushReplacementNamed(context, '/login'); // ย้อนกลับไปหน้าล็อกอิน
            },
            child: Text('ออกจากระบบ'),
          ),
        ],
      ),
    );
  }
}
