import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  // Variabel Controller untuk input
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  // Variabel untuk Animasi Background
  late AnimationController _backgroundAnimationController;
  late Animation<Color?> _colorAnimation;

  // Variabel untuk Animasi Tombol
  late AnimationController _buttonAnimationController;
  late Animation<double> _buttonScaleAnimation;

  @override
  void initState() {
    super.initState();

    // Inisialisasi controller background
    _backgroundAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4), 
    )..repeat(reverse: true); 

    // Buat ColorTween untuk background
    _colorAnimation = ColorTween(
      begin: const Color.fromARGB(255, 241, 44, 169), // Biru sedang
      end: const Color.fromARGB(255, 169, 210, 230), // Biru muda
    ).animate(_backgroundAnimationController);

    // Inisialisasi controller tombol
    _buttonAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );

    // Animasi skala untuk tombol
    _buttonScaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _buttonAnimationController,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    // Memastikan semua controller di-dispose
    _backgroundAnimationController.dispose();
    _buttonAnimationController.dispose();
    _emailController.dispose(); 
    _passwordController.dispose(); 
    super.dispose();
  }

  void _login() async {
    // Efek tekan pada tombol
    _buttonAnimationController.forward();
    await Future.delayed(const Duration(milliseconds: 150));
    _buttonAnimationController.reverse();

    print('Email: ${_emailController.text}');
    print('Password: ${_passwordController.text}');

    // Simulasi penundaan dan navigasi
    await Future.delayed(const Duration(milliseconds: 500));
    // Ganti '/home' dengan rute tujuan Anda
    Navigator.pushReplacementNamed(context, '/home'); 
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return Scaffold(
          // Background Scaffold mengikuti animasi warna
          backgroundColor: _colorAnimation.value,
          body: Stack(
            children: [
              // 1. ANIMASI LOTTIE DI KANAN ATAS
              Positioned(
                top: -50,
                right: 50,
                child: Lottie.asset(
                  'assets/animations/vet_doctor_animation.json', 
                  width: 300, 
                  height: 300,
                  fit: BoxFit.cover,
                  repeat: true,
                ),
              ),
              
              // 2. ANIMASI LOTTIE DI KIRI ATAS (Tambahan Baru)
              Positioned(
                top: -50, // Geser sedikit ke atas
                left: -50, // Geser sedikit ke kiri
                child: Lottie.asset(
                  'assets/animations/vet_defens_animation.json', // Bisa diganti file lain
                  width: 350, 
                  height: 300,
                  fit: BoxFit.cover,
                  repeat: true,
                ),
              ),
              
              // 3. KONTEN LOGIN DI TENGAH
              SafeArea(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      // Animasi masuk (Fade dan Slide Up)
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.easeOutCubic,
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(0, 50 * (1 - value)),
                              child: child,
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            // Gradien untuk kotak login
                            gradient: LinearGradient(
                              colors: [
                                Colors.white,
                                Colors.blue.shade50!,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                
                                // Animasi Lottie untuk Logo
                                Lottie.asset(
                                  'assets/animations/vet_pet_animation.json',
                                  width: 80, 
                                  height: 80,
                                  repeat: true,
                                ),
                                
                                const SizedBox(height: 16),
                                // Teks diperbaiki kontras warnanya
                                const Text(
                                  'Selamat Datang!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Login ke akun klinik hewan Anda',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 40),

                                // FIELD EMAIL
                                TextField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  style: const TextStyle(color: Colors.black87), // Warna teks input
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    labelStyle: const TextStyle(color: Colors.grey),
                                    prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                                    filled: true,
                                    fillColor: Colors.white, 
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),

                                // FIELD PASSWORD
                                TextField(
                                  controller: _passwordController,
                                  obscureText: _obscurePassword,
                                  style: const TextStyle(color: Colors.black87), // Warna teks input
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    labelStyle: const TextStyle(color: Colors.grey),
                                    prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscurePassword
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _obscurePassword = !_obscurePassword;
                                        });
                                      },
                                    ),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                                    filled: true,
                                    fillColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                                
                                const SizedBox(height: 16),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      // Logika untuk lupa password
                                    },
                                    child: Text(
                                      'Lupa Password?',
                                      style: TextStyle(color: Theme.of(context).primaryColor),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Tombol Login dengan animasi Scale
                                ScaleTransition(
                                  scale: _buttonScaleAnimation,
                                  child: ElevatedButton(
                                    onPressed: _login,
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      backgroundColor: Theme.of(context).primaryColor,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      elevation: 5,
                                    ),
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                
                                // Tautan Daftar
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Belum punya akun?"),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/register');
                                      },
                                      child: Text(
                                        'Daftar di sini',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
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
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}