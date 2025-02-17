import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart'; // Import du package
import 'package:uber_clone/auth/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(
      begin: -0.05,
      end: 0.05,
    ).animate(CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blueAccent, Colors.purpleAccent],
          ),
        ),
        height:
            MediaQuery.of(
              context,
            ).size.height, // Prend toute la hauteur de l'écran
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 40),
                AnimatedBuilder(
                  animation: _animation!,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, 20 * _animation!.value),
                      child: child,
                    );
                  },
                  child: Image.asset('assets/images/logo.png', height: 120),
                ),
                const SizedBox(height: 20),
                const Text(
                      'Login to your Account',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 500.ms)
                    .slideY(
                      begin: -0.5,
                      end: 0,
                    ), // Animation avec flutter_animate
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    children: [
                      _buildTextField(
                            controller: emailTextEditingController,
                            labelText: 'Email',
                            icon: Icons.email,
                          )
                          .animate()
                          .fadeIn(duration: 600.ms)
                          .slideX(begin: -0.5, end: 0),
                      const SizedBox(height: 12),
                      _buildTextField(
                            controller: passwordTextEditingController,
                            labelText: 'Password',
                            icon: Icons.lock,
                            obscureText: true,
                          )
                          .animate()
                          .fadeIn(duration: 700.ms)
                          .slideX(begin: -0.5, end: 0),
                      const SizedBox(height: 34),
                      ElevatedButton(
                            onPressed: () {
                              // Ajouter la logique de connexion ici
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.purple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 100,
                                vertical: 12,
                              ),
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                          .animate()
                          .fadeIn(duration: 800.ms)
                          .slideY(begin: 0.5, end: 0),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {
                    // Utilisation de PageRouteBuilder pour une transition personnalisée
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder:
                            (context, animation, secondaryAnimation) =>
                                const SignupScreen(),
                        transitionsBuilder: (
                          context,
                          animation,
                          secondaryAnimation,
                          child,
                        ) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.easeInOut;
                          var tween = Tween(
                            begin: begin,
                            end: end,
                          ).chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);
                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: const Text(
                    'Don\'t have an Account? Sign Up Here.',
                    style: TextStyle(color: Colors.white),
                  ),
                ).animate().fadeIn(duration: 900.ms).slideY(begin: 0.5, end: 0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white),
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Icon(icon, color: Colors.white),
        filled: true,
        // ignore: deprecated_member_use
        fillColor: Colors.white.withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}
