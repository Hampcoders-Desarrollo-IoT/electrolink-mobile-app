import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/social_button.dart';
import 'package:mobile_app_electrolink/features/home/presentation/screens/home_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  void toggleView() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FF),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E2746),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(Icons.bolt, color: Color(0xFFFFD54F), size: 50),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'ElectroLink',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1E2746)),
                    ),
                    const Text(
                      'Tu energía bajo control',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 30),

                    CustomTextField(
                      label: 'Correo Electrónico',
                      hint: 'ejemplo@electrolink.com',
                      icon: Icons.email_outlined,
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      label: 'Contraseña',
                      hint: '********',
                      icon: Icons.lock_outline,
                      isPassword: true,
                    ),

                    if (!isLogin) ...[
                      const SizedBox(height: 15),
                      CustomTextField(
                        label: 'Repetir Contraseña',
                        hint: '********',
                        icon: Icons.lock_outline,
                        isPassword: true,
                      ),
                    ],

                    if (isLogin)
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text('¿Olvidaste tu contraseña?', style: TextStyle(fontSize: 12, color: Colors.black54)),
                        ),
                      ),

                    const SizedBox(height: 20),

                    // Botón Principal con Navegación al Home incorporada
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E2746),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          // Navegamos al HomeScreen al presionar el botón
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const HomeScreen()),
                          );
                        },
                        child: Text(isLogin ? 'Iniciar Sesión' : 'Registrarte'),
                      ),
                    ),

                    const SizedBox(height: 12),

                    if (isLogin)
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: const Color(0xFFD1E4FF),
                            side: BorderSide.none,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: toggleView,
                          child: const Text('Registrarse', style: TextStyle(color: Color(0xFF1E2746))),
                        ),
                      ),
                  ],
                ),
              ),

              if (isLogin) ...[
                const SizedBox(height: 30),
                const Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text('O CONTINUAR CON', style: TextStyle(color: Colors.grey, fontSize: 10)),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(child: SocialButton(label: 'Google', iconText: 'G')),
                    const SizedBox(width: 15),
                    Expanded(child: SocialButton(label: 'Apple', iconText: 'A')),
                  ],
                ),
              ],

              if (!isLogin)
                TextButton(
                  onPressed: toggleView,
                  child: const Text('¿Ya tienes cuenta? Inicia Sesión', style: TextStyle(color: Colors.black54)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}