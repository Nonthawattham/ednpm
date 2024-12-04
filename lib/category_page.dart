import 'package:ednpm/burger_menu.dart';
import 'package:ednpm/equipment/bag_page.dart';
import 'package:ednpm/equipment/book_page.dart';
import 'package:ednpm/equipment/clothing_page.dart';
import 'package:ednpm/equipment/electronics_page.dart';
import 'package:ednpm/equipment/shoes_page.dart';
import 'package:ednpm/equipment/stationery_page.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  final String deliveryAddress;  // Add the deliveryAddress parameter

  const CategoryPage({required this.deliveryAddress});  // Accept it in the constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('บริจาคอุปกรณ์การเรียน - $deliveryAddress'),  // Show the deliveryAddress in the AppBar
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
      drawer: BurgerMenu(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ประเภท',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  CategoryButton(
                    icon: Icons.checkroom,
                    label: 'เสื้อผ้า',
                    onPressed: () {
                      // Pass the deliveryAddress to ClothingPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ClothingPage(
                            deliveryAddress: deliveryAddress, // Pass it here
                          ),
                        ),
                      );
                    },
                  ),
                  CategoryButton(
                    icon: Icons.sports_kabaddi,
                    label: 'รองเท้า',
                    onPressed: () {
                      // Pass the deliveryAddress to ShoesPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShoesPage(
                            deliveryAddress: deliveryAddress, // Pass it here
                          ),
                        ),
                      );
                    },
                  ),
                  CategoryButton(
                    icon: Icons.computer,
                    label: 'อุปกรณ์อิเล็กทรอนิกส์',
                    onPressed: () {
                      // Pass the deliveryAddress to ElectronicsPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ElectronicsPage(
                            deliveryAddress: deliveryAddress, // Pass it here
                          ),
                        ),
                      );
                    },
                  ),
                  CategoryButton(
                    icon: Icons.edit,
                    label: 'อุปกรณ์เครื่องเขียน',
                    onPressed: () {
                      // Pass the deliveryAddress to StationeryPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StationeryPage(
                            deliveryAddress: deliveryAddress, // Pass it here
                          ),
                        ),
                      );
                    },
                  ),
                  CategoryButton(
                    icon: Icons.book,
                    label: 'สมุด',
                    onPressed: () {
                      // Pass the deliveryAddress to BookPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookPage(
                            deliveryAddress: deliveryAddress, // Pass it here
                          ),
                        ),
                      );
                    },
                  ),
                  CategoryButton(
                    icon: Icons.backpack,
                    label: 'กระเป๋า',
                    onPressed: () {
                      // Pass the deliveryAddress to BagPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BagPage(
                            deliveryAddress: deliveryAddress, // Pass it here
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class CategoryButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const CategoryButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.lightBlueAccent,
          padding: EdgeInsets.symmetric(vertical: 16.0),
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            Icon(icon, color: Colors.black),
            SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
