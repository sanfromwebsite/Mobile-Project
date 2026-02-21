import 'package:flutter/material.dart';
import 'package:ui/features/auth/presentation/pages/login_page.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../home/presentation/pages/home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isPasswordObscured = true;
  bool _isConfirmObscured = true;
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [

            /// ================= header =================
            Container(
              width: double.infinity,
              height: 270,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Stack(
                children: [

                  Positioned(
                    top: 0,
                    left: 40,
                    child: Container(
                      width: 110,
                      height: 140,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(70),
                          bottomRight: Radius.circular(70),
                        ),
                      ),
                    ),
                  ),

                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        const SizedBox(height: 20),

                        const Padding(
                          padding: EdgeInsets.only(left: 100, top: 20),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1B5E20),
                              shadows: [
                                Shadow(
                                  blurRadius: 6,
                                  color: Colors.black26,
                                  offset: Offset(2, 3),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        Image.asset(
                          'assets/images/logo.png',
                          width: 320,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// ================= FORM AREA =================
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 28,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  _buildLabel("First Name"),
                  _buildInputField("Enter first name"),

                  const SizedBox(height: 20),

                  _buildLabel("Last Name"),
                  _buildInputField("Enter last name"),

                  const SizedBox(height: 20),

                  _buildLabel("Email Address"),
                  _buildInputField("email@example.com"),

                  const SizedBox(height: 20),

                  _buildLabel("Password"),
                  _buildPasswordField(),

                  const SizedBox(height: 20),

                  _buildLabel("Confirm Password"),
                  _buildConfirmPasswordField(),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        activeColor: AppColors.primary,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value!;
                          });
                        },
                      ),
                      const Text(
                        "Keep me signed in",
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  /// SIGN UP BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ================= LABEL =================
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Colors.black87,
        ),
      ),
    );
  }

  /// ================= INPUT FIELD =================
  Widget _buildInputField(String hint) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400]),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
      ),
    );
  }

  /// ================= PASSWORD FIELD =================
  Widget _buildPasswordField() {
    return TextField(
      obscureText: _isPasswordObscured,
      decoration: InputDecoration(
        hintText: 'Enter your password...',
        hintStyle: TextStyle(color: Colors.grey[400]),
        filled: true,
        fillColor: Colors.grey[50],
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordObscured
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: Colors.grey[600],
          ),
          onPressed: () {
            setState(() {
              _isPasswordObscured = !_isPasswordObscured;
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
      ),
    );
  }

  /// ================= CONFIRM PASSWORD =================
  Widget _buildConfirmPasswordField() {
    return TextField(
      obscureText: _isConfirmObscured,
      decoration: InputDecoration(
        hintText: 'Confirm your password...',
        hintStyle: TextStyle(color: Colors.grey[400]),
        filled: true,
        fillColor: Colors.grey[50],
        suffixIcon: IconButton(
          icon: Icon(
            _isConfirmObscured
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: Colors.grey[600],
          ),
          onPressed: () {
            setState(() {
              _isConfirmObscured = !_isConfirmObscured;
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
      ),
    );
  }
}