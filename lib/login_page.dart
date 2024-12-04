import 'package:ednpm/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'register_page.dart';
import 'forgot_password_page.dart';
import 'home_page.dart';
import 'models/user.dart'; // Correct import for User class

class LoginPage extends StatefulWidget {
  static List<User> registeredUsers = []; // Use the User class from models/user.dart

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false; // ตัวแปรสำหรับ Remember Me

  @override
  void initState() {
    super.initState();
    _loadUserData(); // โหลดข้อมูลผู้ใช้จาก SharedPreferences
  }

  // ฟังก์ชันเพื่อโหลดข้อมูลจาก SharedPreferences
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _rememberMe = prefs.getBool('rememberMe') ?? false;
      if (_rememberMe) {
        _usernameController.text = prefs.getString('username') ?? '';
        _passwordController.text = prefs.getString('password') ?? '';
      }
    });
  }

  // ฟังก์ชันสำหรับการเข้าสู่ระบบ
  void login() {
    final username = _usernameController.text;
    final password = _passwordController.text;

    final user = LoginPage.registeredUsers.firstWhere(
      (user) => user.username == username && user.password == password,
      orElse: () => User(username: '', password: '', email: ''),
    );

    if (user.username.isNotEmpty) {
      // Set the logged-in user data in UserProvider
      Provider.of<UserProvider>(context, listen: false).setUser(user);

      if (_rememberMe) {
        _saveUserData(); // Save user data for Remember Me functionality
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid Username or Password')),
      );
    }
  }


  // ฟังก์ชันสำหรับการบันทึกข้อมูลผู้ใช้
  Future<void> _saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('rememberMe', _rememberMe);
    prefs.setString('username', _usernameController.text);
    prefs.setString('password', _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo or Image at the top
              Center(
                child: Image.asset(
                  'images/logo.png', // Replace with your logo path
                  height: 300,
                  width: 300,
                ),
              ),
              SizedBox(height: 20),
              
              // Title
              Text(
                'Member Login',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 40),

              // Username TextField
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                ),
              ),
              SizedBox(height: 20),

              // Password TextField
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                ),
                obscureText: true,
              ),
              SizedBox(height: 30),

              // Remember Me and Forgot Password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value ?? false;
                          });
                        },
                      ),
                      Text('Remember me'),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to Forgot Password page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgotPasswordPage(),
                        ),
                      );
                    },
                    child: Text('Forgot password?', style: TextStyle(color: Colors.blueAccent)),
                  ),
                ],
              ),

              // Login Button
              ElevatedButton(
                onPressed: login,
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  textStyle: TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Register Button
              ElevatedButton(
                onPressed: () {
                  // Navigate to Register page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(),
                    ),
                  );
                },
                child: Text('Register'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  textStyle: TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
