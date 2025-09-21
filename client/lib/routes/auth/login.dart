import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza/routes/loading.dart';
import 'package:pizza/server/auth.dart';
import 'package:pizza/widgets/textinput.dart';
import 'package:flutter_svg/svg.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  final _auth = Auth();
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(30),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    const SizedBox(height: 70),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Login",
                          style: GoogleFonts.montserrat(
                            fontSize: 30,
                            color: const Color(0xFFEF1C26),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 45),
                        Textinput(
                          hint_text: "abcd12@gmail.com",
                          label: "Enter your email",
                          selector: "email",
                          controller: _emailController,
                        ),
                        const SizedBox(height: 15),
                        Textinput(
                          label: "Enter your password",
                          password: true,
                          selector: "password",
                          controller: _passwordController,
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {},
                              child: Text(
                                "forgot password?",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  letterSpacing: 0.5,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        InkWell(
                          borderRadius: BorderRadius.circular(18),
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });

                              dynamic user = await _auth.login(
                                _emailController.text,
                                _passwordController.text,
                              );

                              if (!mounted) return;

                              if (user == null) {
                                // 👇 Show error message
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Cannot login. Please check your credentials.",
                                    ),
                                    backgroundColor: Colors.redAccent,
                                    behavior: SnackBarBehavior.floating,
                                    margin: EdgeInsets.all(20),
                                  ),
                                );
                                setState(() {
                                  loading = false;
                                });
                              } else {
                                
                                context.pop();
                              }
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEF1C26),
                              borderRadius: BorderRadius.circular(17),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 14,
                            ),
                            child: Text(
                              textAlign: TextAlign.center,
                              "Login",
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 20,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Dont have an acount ? ",
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                letterSpacing: 0.5,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                context.go('/register');
                              },
                              child: Text(
                                "sign up",
                                style: GoogleFonts.montserrat(
                                  color: const Color(0xFFEF1C26),
                                  letterSpacing: 0.5,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "or",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            letterSpacing: 0.5,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 15),
                        InkWell(
                          borderRadius: BorderRadius.circular(18),
                          onTap: () {},
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xFFEF1C26).withValues(alpha: 0.5),
                                style: BorderStyle.solid,
                                width: 1.5,
                              ),
                              color: const Color(0xffF2F2F2),
                              borderRadius: BorderRadius.circular(17),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 13,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/icon/google.svg',
                                  width: 28,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  textAlign: TextAlign.center,
                                  "Continue with Google",
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 15,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        InkWell(
                          borderRadius: BorderRadius.circular(18),
                          onTap: () {},
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xFFEF1C26).withValues(alpha: 0.5),
                                style: BorderStyle.solid,
                                width: 1.5,
                              ),
                              color: const Color(0xffF2F2F2),
                              borderRadius: BorderRadius.circular(17),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.apple,
                                  color: Color(0xFFEF1C26),
                                  size: 34,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  textAlign: TextAlign.center,
                                  "Continue with Apple",
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 15,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
