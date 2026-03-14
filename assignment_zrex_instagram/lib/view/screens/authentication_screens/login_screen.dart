// import 'package:assignment_zrex_instagram/controller/auth_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_fonts/google_fonts.dart';


// class LoginScreen extends ConsumerStatefulWidget {
//   @override
//   ConsumerState<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends ConsumerState<LoginScreen> {
//   final GlobalKey<FormState> _formKey=GlobalKey<FormState>();

//   final AuthController _authController=AuthController();

//   late String email;

//   late String password;
//   bool isLoading = false;

//   userLogin()async{
//     setState(() {
//       isLoading=true;
//     });

//     await _authController.signInUsers(context: context, email: email, password: password,ref: ref).whenComplete(() {
//       _formKey.currentState!.reset();
//       setState(() {
//         isLoading=false;
//       });
      
//     });

//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white.withOpacity(0.95),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Login your account',
//                     style: GoogleFonts.getFont('Lato',
//                         color: const Color(0xFF0d120E),
//                         fontWeight: FontWeight.bold,
//                         letterSpacing: 0.2,
//                         fontSize: 23),
//                   ),
//                   Text(
//                     'To Explore the world exclusives',
//                     style: GoogleFonts.getFont('Lato',
//                         fontSize: 14, letterSpacing: 0.2),
//                   ),
//                   Image.asset(
//                     'assets/images/Illustration.png',
//                     width: 200,
//                     height: 200,
//                   ),
//                   Align(
//                     alignment: Alignment.topLeft,
//                     child: Text(
//                       'Email',
//                       style: GoogleFonts.getFont('Nunito Sans',
//                           fontWeight: FontWeight.w600, letterSpacing: 0.2),
//                     ),
//                   ),
//                   TextFormField(
//                     onChanged: (value) {
//                       email=value;
//                     },
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Enter your email';                        
//                       }else{
//                         return null;
//                       }
//                     },
//                     decoration: InputDecoration(
//                         fillColor: Colors.white,
//                         filled: true,
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(9)),
//                         focusedBorder: InputBorder.none,
//                         enabledBorder: InputBorder.none,
//                         labelText: 'Enter your email',
//                         labelStyle: GoogleFonts.getFont('Nunito Sans',
//                             fontSize: 14, letterSpacing: 0.1),
//                         prefixIcon: Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: Image.asset(
//                             'assets/icons/email.png',
//                             width: 20,
//                             height: 20,
//                           ),
//                         )),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Align(
//                     alignment: Alignment.topLeft,
//                     child: Text(
//                       'Password',
//                       style: GoogleFonts.getFont('Nunito Sans',
//                           fontWeight: FontWeight.w600, letterSpacing: 0.2),
//                     ),
//                   ),
//                   TextFormField(
//                     onChanged: (value) {
//                       password=value;
//                     },
//                     validator: (value) {
//                       if(value!.isEmpty){
//                         return 'Enter your password';
//                       }else{
//                         return null;
//                       }
//                     },
//                     decoration: InputDecoration(
//                         fillColor: Colors.white,
//                         filled: true,
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(9)),
//                         focusedBorder: InputBorder.none,
//                         enabledBorder: InputBorder.none,
//                         labelText: 'Enter your password',
//                         labelStyle: GoogleFonts.getFont('Nunito Sans',
//                             fontSize: 14, letterSpacing: 0.1),
//                         prefixIcon: Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: Image.asset(
//                             'assets/icons/password.png',
//                             width: 20,
//                             height: 20,
//                           ),
//                         ),
//                         suffixIcon: const Icon(Icons.visibility)),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   InkWell(
//                     onTap: () {
//                       if(_formKey.currentState!.validate()) {
//                         userLogin();
//                         print('pass');
                        
//                       }else{
//                         print('failed');
//                       }
//                     },
//                     child: Container(
//                         width: 319,
//                         height: 50,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(5),
//                           gradient: const LinearGradient(
//                             colors: [
//                               Color(0xFF102DE1),
//                               Color(0xCC0D6EFF),
//                             ],
//                           ),
//                         ),
//                         child: Stack(
//                           children: [
//                             Positioned(
//                               left: 278,
//                               top: 19,
//                               child: Opacity(
//                                 opacity: 0.5,
//                                 child: Container(
//                                   width: 60,
//                                   height: 60,
//                                   clipBehavior: Clip.antiAlias,
//                                   decoration: BoxDecoration(
//                                     border: Border.all(
//                                         width: 12, color: const Color(0xFF103DE5)),
//                                     borderRadius: BorderRadius.circular(30),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Positioned(
//                               left: 311,
//                               top: 36,
//                               child: Opacity(
//                                 opacity: 0.3,
//                                 child: Container(
//                                   width: 5,
//                                   height: 5,
//                                   clipBehavior: Clip.antiAlias,
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(3)),
//                                 ),
//                               ),
//                             ),
//                             Positioned(
//                               left: 281,
//                               top: -10,
//                               child: Opacity(
//                                 opacity: 0.3,
//                                 child: Container(
//                                   width: 20,
//                                   height: 20,
//                                   clipBehavior: Clip.antiAlias,
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(10)),
//                                 ),
//                               ),
//                             ),
//                             Center(
//                               child: isLoading ? const CircularProgressIndicator(color: Colors.white,):Text(
//                                 'Sign in',
//                                 style: GoogleFonts.getFont('Lato',
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 18),
//                               ),
//                             ),
//                           ],
//                         )),
//                   ),
//                       const SizedBox(height: 20,),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text('Need an account?',style: GoogleFonts.roboto(fontWeight: FontWeight.w500,letterSpacing: 1),),
//                           InkWell(onTap: (){
//                             Navigator.push(context, MaterialPageRoute(builder: (context){
//                               return RegisterScreen();
//                             }),);
//                           },child: Text('Sign Up',style: GoogleFonts.roboto(color: const Color(0xFF103DE5),fontWeight: FontWeight.bold,),)),
//                         ],
//                       ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:assignment_zrex_instagram/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();

  late String email;
  late String password;

  bool _isLoading = false;

  registeUser() async {
    setState(() {
      _isLoading = true;
    });
    await _authController
        .signInUsers(
            context: context,
            email: email,
            password: password, ref: ref)
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
                  _buildTextField(
                    label: 'Email',
                    onChanged: (value) => email = value,
                    validator: (value) =>
                        value!.isEmpty ? 'Enter your email' : null,

                        isDarkMode: isDarkMode,
                  ),
                  const SizedBox(height: 15),                  

                  // Password Field
                  _buildTextField(
                    label: 'Password',
                    isPassword: true,
                    onChanged: (value) => password = value,
                    validator: (value) =>
                        value!.isEmpty ? 'Enter your password' : null,
                        isDarkMode: isDarkMode,
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

                  // Login Redirection
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: GoogleFonts.roboto(fontWeight: FontWeight.w500),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
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
  // Helper method to keep code clean
  Widget _buildTextField({
    required String label,
    required Function(String) onChanged,
    required String? Function(String?) validator,
    required bool isDarkMode,
    bool isPassword = false,
    
  }) {
    return TextFormField(
      obscureText: isPassword,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        fillColor: isDarkMode ? Colors.grey[900] : Colors.white,
        filled: true,
        hintText: label,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.blue),
        ),
      ),
    );
  }
}
