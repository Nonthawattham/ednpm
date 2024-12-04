import 'dart:io'; // Import dart:io for File
import 'package:ednpm/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart'; // For image picking

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _profileImage;

  // Function to pick the profile image
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = pickedFile.path; // Save the path of the selected image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Profile')),
        body: Center(child: Text('No user data available')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Profile Image (Icon version)
            Center(
              child: GestureDetector(
                onTap: _pickImage, // Allow the user to tap to change the profile image
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.grey[300],
                  child: _profileImage != null
                      ? ClipOval(
                          child: Image.file(
                            File(_profileImage!),
                            width: 160,
                            height: 160,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Icon(
                          Icons.person,
                          size: 80,
                          color: Colors.white, // White color for the person icon
                        ), // Default person icon when no image is selected
                ),
              ),
            ),
            SizedBox(height: 20),

            // Username
            Text(
              'Username: ${user.username}',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Email
            Text(
              'Email: ${user.email}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 30),

            // Optionally, you can add a button to edit profile, change password, etc.
            ElevatedButton(
              onPressed: () {
                // Add your logic for editing profile if needed
              },
              child: Text('Edit Profile'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(vertical: 15),
                textStyle: TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
