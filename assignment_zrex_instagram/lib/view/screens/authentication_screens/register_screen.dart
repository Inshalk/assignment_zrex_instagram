import 'package:assignment_zrex_instagram/controller/auth_controller.dart';
import 'package:assignment_zrex_instagram/view/screens/authentication_screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();

  late String email;
  late String fullName;
  late String userName;
  late String password;

  bool _isLoading = false;

  registeUser() async {
    setState(() {
      _isLoading = true;
    });
    await _authController
        .signUpUsers(
            context: context,
            email: email,
            fullName: fullName,
            username: userName,
            password: password)
        .whenComplete(() {
      if (mounted) {
        _formKey.currentState!.reset();
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white.withOpacity(0.95),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Instagram Logo via Image.network
                  Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Instagram_logo.svg/1200px-Instagram_logo.svg.png',
                    height: 60,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Sign up to see photos and videos \nfrom your friends.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.getFont('Lato',
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  const SizedBox(height: 30),

                  // Email Field
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                    onChanged: (value) => email = value,
                    validator: (value) => (value == null || value.isEmpty) ? 'Enter your email' : null,
                    decoration: inputDecoration('Email', isDarkMode),
                  ),
                  const SizedBox(height: 15),

                  // fullname field
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                    onChanged: (value) => fullName = value,
                    validator: (value) => (value == null || value.isEmpty) ? 'Enter your full name' : null,
                    decoration: inputDecoration('Full Name', isDarkMode),
                  ),
                  const SizedBox(height: 15),

                  // Username Field
                  TextFormField(
                    style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                    onChanged: (value) => userName = value,
                    validator: (value) => (value == null || value.isEmpty) ? 'Enter your username' : null,
                    decoration: inputDecoration('Username', isDarkMode),
                  ),
                  const SizedBox(height: 15),

                  // Password Field
                  TextFormField(
                    obscureText: true,
                    style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                    onChanged: (value) => password = value,
                    validator: (value) => (value == null || value.isEmpty) ? 'Enter your password' : null,
                    decoration: inputDecoration('Password', isDarkMode),
                  ),
                  const SizedBox(height: 25),

                  // Sign Up Button
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        registeUser();
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF102DE1),
                            Color(0xCC0D6EFF),
                          ],
                        ),
                      ),
                      child: Center(
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                    color: Colors.white, strokeWidth: 2),
                              )
                            : Text(
                                'Sign Up',
                                style: GoogleFonts.getFont('Lato',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: GoogleFonts.roboto(fontWeight: FontWeight.w500),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return LoginScreen();
                          }));
                        },
                        child: Text(
                          'Sign In',
                          style: GoogleFonts.roboto(
                            color: const Color(0xFF103DE5),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String hint, bool isDarkMode) {
      return InputDecoration(
        fillColor: isDarkMode ? Colors.grey[900] : Colors.white,
        filled: true,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      );
    }
}