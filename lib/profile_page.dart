import 'package:flutter/material.dart';
import 'login.dart'; // Ensure correct import path

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.white,
      //   title: const Text('Profile', style: TextStyle(color: Colors.black)),
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back, color: Colors.black),
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      // ),
      body: SingleChildScrollView(
        // Wrap in SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Bashyitsi Ngoga Jubril',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  'ALU@example.com',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Account Settings',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const ListTile(
                leading: Icon(Icons.person),
                title: Text('Edit Profile'),
              ),
              const ListTile(
                leading: Icon(Icons.lock),
                title: Text('Change Password'),
              ),
              const ListTile(
                leading: Icon(Icons.notifications),
                title: Text('Notifications'),
              ),
              const ListTile(
                leading: Icon(Icons.help),
                title: Text('Help & Support'),
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const LoginPage()), // Ensure correct reference
                    (Route<dynamic> route) => false, // Clear the stack
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
