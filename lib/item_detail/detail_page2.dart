import 'package:flutter/material.dart';

class ItemDetail2Page extends StatelessWidget {
  final String name;
  final String image;
  final int price;

  const ItemDetail2Page({
    Key? key,
    required this.name,
    required this.image,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(image, height: 350, fit: BoxFit.cover),
            SizedBox(height: 20),
            Text(
              name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'ราคา: ฿$price',
              style: TextStyle(fontSize: 20, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('ย้อนกลับ'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12), backgroundColor: Colors.blueAccent,
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
