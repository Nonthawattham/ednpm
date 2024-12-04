import 'package:flutter/material.dart';

class ItemDetailPage extends StatelessWidget {
  final String name;
  final String image;
  final double price;
  final List<String> sizes;

  const ItemDetailPage({
    required this.name,
    required this.image,
    required this.price,
    required this.sizes,
  });

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
              'ราคา: ฿${price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Available Sizes:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              children: sizes.map((size) {
                return Chip(
                  label: Text(size),
                  backgroundColor: Colors.blueAccent,
                  labelStyle: TextStyle(color: Colors.white),
                );
              }).toList(),
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
