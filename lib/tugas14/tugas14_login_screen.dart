import 'package:flutter/material.dart';
import 'package:ppkd_b6/day_19/database/preference_handler.dart';
import 'package:ppkd_b6/day_20/database/db_helper.dart';
import 'package:ppkd_b6/day_20/models/user_model_sql.dart';
import 'package:ppkd_b6/tugas14.dart';
import 'package:ppkd_b6/tugas14/tugas14_forgot_password_screen.dart';
import 'package:ppkd_b6/tugas14/tugas14_register_screen.dart';

class Tugas14LoginScreen extends StatefulWidget {
  const Tugas14LoginScreen({super.key});

  @override
  State<Tugas14LoginScreen> createState() => _Tugas14LoginScreenState();
}

class _Tugas14LoginScreenState extends State<Tugas14LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
    
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final emailOrUsername = _usernameController.text.trim();
      final password = _passwordController.text;

      // 1. Check fallback credentials
      if (emailOrUsername == 'admin' && password == 'admin') {
        await PreferenceHandler.setLogin(true);
        setState(() {
          _isLoading = false;
        });
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Tugas14Screen()),
          );
        }
        return;
      }

      // 2. Check SQLite DB
      try {
        final queryUser = UserModelSql(
          email: emailOrUsername,
          password: password,
        );
        final loggedInUser = await DBHelper().loginUser(queryUser);

        setState(() {
          _isLoading = false;
        });

        if (loggedInUser != null) {
          await PreferenceHandler.setLogin(true);
          if (mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const Tugas14Screen()),
            );
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Invalid email or password.'),
                backgroundColor: Colors.redAccent,
              ),
            );
          }
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Database error: $e'),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const themeBg = Color(0xFF0F111A);
    const cardBg = Color(0xFF1E2230);
    const accentGold = Color(0xFFE5A93C);
    const textWhite = Color(0xFFF5F6FA);
    const textGrey = Color(0xFF8A8F9E);

    return Scaffold(
      backgroundColor: themeBg,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 16.0,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo GoT
                  Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      'assets/images/Game-of-Thrones-logo.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.shield,
                          size: 80,
                          color: accentGold,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Title
                  const Text(
                    'WESTEROS ARCHIVES',
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: accentGold,
                      letterSpacing: 3.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Login to access the chronicles',
                    style: TextStyle(
                      fontSize: 14,
                      color: textGrey,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),

                  // Username / Email Input
                  TextFormField(
                    controller: _usernameController,
                    style: const TextStyle(color: textWhite),
                    decoration: InputDecoration(
                      hintText: 'Email or Username',
                      hintStyle: const TextStyle(color: textGrey),
                      prefixIcon: const Icon(Icons.person, color: accentGold),
                      filled: true,
                      fillColor: cardBg,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: accentGold.withValues(alpha: 0.5),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: accentGold,
                          width: 1.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: accentGold.withValues(alpha: 0.3),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter email or username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Password Input
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    style: const TextStyle(color: textWhite),
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: const TextStyle(color: textGrey),
                      prefixIcon: const Icon(Icons.lock, color: accentGold),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: accentGold,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      filled: true,
                      fillColor: cardBg,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: accentGold.withValues(alpha: 0.5),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: accentGold,
                          width: 1.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: accentGold.withValues(alpha: 0.3),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                  ),

                  // Forgot Password Link
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                const Tugas14ForgotPasswordScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: accentGold,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accentGold,
                        foregroundColor: themeBg,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: themeBg)
                          : const Text(
                              'LOGIN',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Sign Up Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Belum memiliki aliansi? ",
                        style: TextStyle(color: textGrey, fontSize: 13),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const Tugas14RegisterScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Daftar Akun",
                          style: TextStyle(
                            color: accentGold,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Mock Hint
                  Text(
                    'Or use "admin" / "admin" to log in',
                    style: TextStyle(
                      color: textGrey.withValues(alpha: 0.6),
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
