import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  String name;
  String email;
  String bio;
  String address;
  String phoneNumber;
  String imagePath;

  User({
    required this.name,
    required this.email,
    required this.bio,
    required this.address,
    required this.phoneNumber,
    required this.imagePath,
  });
}

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('User Information'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildImagePicker(),
              const SizedBox(height: 20),
              _buildTextField("Name", nameController),
              const SizedBox(height: 20),
              _buildTextField("Email", emailController),
              const SizedBox(height: 20),
              _buildTextField("Bio", bioController),
              const SizedBox(height: 20),
              _buildTextField("Address", addressController),
              const SizedBox(height: 20),
              _buildTextField("Phone Number", phoneNumberController),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await _saveUserDetails();
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DisplayUserDetailsScreen(),
                      ));
                },
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            _selectImage();
          },
          child: CircleAvatar(
            radius: 50,
            backgroundImage:
                imagePath != null ? FileImage(File(imagePath!)) : null,
            child: imagePath == null
                ? const Icon(
                    Icons.camera_alt,
                    size: 40,
                  )
                : null,
          ),
        ),
        const SizedBox(height: 10),
        const Text("Tap to select an image"),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
    }
  }

  Future<void> _saveUserDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final user = User(
      name: nameController.text,
      email: emailController.text,
      bio: bioController.text,
      address: addressController.text,
      phoneNumber: phoneNumberController.text,
      imagePath: imagePath ?? '',
    );

    final userJson = userToJson(user);
    await prefs.setString('user', userJson);
  }

  String userToJson(User user) {
    return jsonEncode({
      "name": user.name,
      "email": user.email,
      "bio": user.bio,
      "address": user.address,
      "phoneNumber": user.phoneNumber,
      "imagePath": user.imagePath,
    });
  }
}

class DisplayUserDetailsScreen extends StatelessWidget {
  const DisplayUserDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('User Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<User?>(
        future: _getUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            final user = snapshot.data!;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: user.imagePath.isNotEmpty
                        ? FileImage(File(user.imagePath))
                        : null,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "Name: ${user.name}",
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 10),
                  Text("Email: ${user.email}",
                      style: const TextStyle(
                        fontSize: 22,
                      )),
                  const SizedBox(height: 10),
                  Text("Bio: ${user.bio}",
                      style: const TextStyle(
                        fontSize: 22,
                      )),
                  const SizedBox(height: 10),
                  Text("Address: ${user.address}",
                      style: const TextStyle(
                        fontSize: 22,
                      )),
                  const SizedBox(height: 10),
                  Text("Phone Number: ${user.phoneNumber}",
                      style: const TextStyle(
                        fontSize: 22,
                      )),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<User?> _getUserDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');

    if (userJson != null) {
      final Map<String, dynamic> userMap = jsonDecode(userJson);
      return User(
        name: userMap['name'],
        email: userMap['email'],
        bio: userMap['bio'],
        address: userMap['address'],
        phoneNumber: userMap['phoneNumber'],
        imagePath: userMap['imagePath'],
      );
    }

    return null;
  }
}

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Edit Profile'),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildImagePicker(),
            const SizedBox(height: 20),
            _buildTextField("Name", nameController),
            const SizedBox(height: 20),
            _buildTextField("Email", emailController),
            const SizedBox(height: 20),
            _buildTextField("Bio", bioController),
            const SizedBox(height: 20),
            _buildTextField("Address", addressController),
            const SizedBox(height: 20),
            _buildTextField("Phone Number", phoneNumberController),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _saveUserDetails();
                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            _selectImage();
          },
          child: CircleAvatar(
            radius: 50,
            backgroundImage:
                imagePath != null ? FileImage(File(imagePath!)) : null,
            child: imagePath == null
                ? const Icon(
                    Icons.camera_alt,
                    size: 40,
                  )
                : null,
          ),
        ),
        const SizedBox(height: 10),
        const Text("Tap to select an image"),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
    }
  }

  Future<void> _saveUserDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final user = User(
      name: nameController.text,
      email: emailController.text,
      bio: bioController.text,
      address: addressController.text,
      phoneNumber: phoneNumberController.text,
      imagePath: imagePath ?? '',
    );

    final userJson = userToJson(user);
    await prefs.setString('user', userJson);
  }

  String userToJson(User user) {
    return jsonEncode({
      "name": user.name,
      "email": user.email,
      "bio": user.bio,
      "address": user.address,
      "phoneNumber": user.phoneNumber,
      "imagePath": user.imagePath,
    });
  }
}
