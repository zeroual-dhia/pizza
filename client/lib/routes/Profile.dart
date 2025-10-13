import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza/constants.dart';
import 'package:pizza/models/navigation.dart';
import 'package:pizza/server/auth.dart';
import 'package:pizza/widgets/profileInput.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final _auth = Auth();

  bool check = true;
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic>? userData;
  bool isLoading = true;
  String? token;
  Future fetchUser(idToken) async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(
      Uri.parse('${AppConfig.baseUrl}/user'),
      headers: {
        'Authorization': 'Bearer $idToken',
        'Content-Type': ' application/json',
      },
    );

    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        final decoded = jsonDecode(response.body);
        setState(() {
          userData = decoded;
          nameController.text = decoded['name'] ?? '';
          emailController.text = decoded['email'] ?? '';
          phoneController.text = decoded['phone_number'] ?? '';
          locationController.text = decoded['location'] ?? '';
          isLoading = false;
        });
      } else {
        print("Response body is empty");
        setState(() => isLoading = false);
      }
    } else {
      print("Failed with status ${response.statusCode}");
      setState(() => isLoading = false);
    }
  }
  //It’s called when the widget is inserted into the tree and whenever
  //a provider it depends on changes (here → the token).This means: when
  //Firebase refreshes the token, didChangeDependencies fires
  //again, so you can refetch safely.

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    token = Provider.of<String?>(context);
    if (token != null) {
      fetchUser(token);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator(color: Color(0xffEF1C26)))
            : Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Profile",
                          style: GoogleFonts.pacifico(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            letterSpacing: 3,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                check = !check;
                              });
                              final response = await http.post(
                                Uri.parse('${AppConfig.baseUrl}/user'),
                                headers: {
                                  'Authorization': 'Bearer $token',
                                  'Content-Type': ' application/json',
                                },
                                body: jsonEncode({
                                  'name': nameController.text,
                                  'email': emailController.text,
                                  'phoneNumber': phoneController.text,
                                  'location': locationController.text,
                                }),
                              );
                              if (response.statusCode == 200) {
                                print("user data updated");
                              } else {
                                print(
                                  "failed to update user data ${response.statusCode} - ${response.body}",
                                );
                              }
                            }
                          },
                          icon: Icon(check ? Icons.edit : Icons.check),
                          style: IconButton.styleFrom(
                            backgroundColor: const Color(0xffF8F8F8),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 20,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipOval(
                                child: Image.asset(
                                  'assets/images/dhia.jpeg',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 30),

                              Profileinput(
                                icon: const Icon(Icons.email),
                                label: "your email : ",
                                readOnly: true,
                                controller: emailController,
                                selector: "email",
                              ),
                              const SizedBox(height: 25),

                              Profileinput(
                                icon: const Icon(Icons.account_circle),
                                label: "your name :",
                                readOnly: check,
                                controller: nameController,
                                selector: "name",
                              ),
                              const SizedBox(height: 25),

                              Profileinput(
                                icon: const Icon(Icons.phone),
                                label: "your phone number : ",
                                readOnly: check,
                                controller: phoneController,
                                selector: "phone",
                              ),
                              const SizedBox(height: 25),

                              Profileinput(
                                icon: const Icon(Icons.location_on),
                                label: "your location : ",
                                readOnly: check,
                                controller: locationController,
                                selector: "location",
                              ),
                              const SizedBox(height: 40),

                              TextButton.icon(
                                
                                onPressed: () async {
                                  context.read<NavigationProvider>().reset();
                                  await _auth.logout();
                                },
                                style: TextButton.styleFrom(
                                  
                                  backgroundColor: Color(0xffEF1C26),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 8,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.logout,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  "logout",
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
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
