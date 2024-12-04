import 'package:ednpm/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // นำเข้า provider package
import 'login_page.dart';
import 'home_page.dart';
import 'providers/user_provider.dart'; // นำเข้า UserProvider
import 'providers/order_number_provider.dart'; // นำเข้า OrderNumberProvider

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()), // เพิ่ม UserProvider
        ChangeNotifierProvider(create: (context) => OrderNumberProvider()), // เพิ่ม OrderNumberProvider
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      // กำหนด Route
      initialRoute: '/login', // หน้าที่เริ่มต้นคือ LoginPage
      routes: {
        '/login': (context) => LoginPage(),  // เส้นทางไปหน้าล็อกอิน
        '/home': (context) => HomePage(),    // เส้นทางไปหน้า HomePage
        '/profile': (context) => ProfilePage(), // เส้นทางไปหน้า ProfilePage
      },
    );
  }
}
