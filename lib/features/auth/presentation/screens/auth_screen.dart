import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/social_button.dart';
import 'package:mobile_app_electrolink/core/enums/user_role.dart';
import 'package:mobile_app_electrolink/core/widgets/homeowner_shell.dart';
import 'package:mobile_app_electrolink/features/technical/presentation/screens/technical_dashboard_screen.dart';
import 'package:mobile_app_electrolink/features/company/presentation/screens/company_shell.dart';
import 'package:mobile_app_electrolink/core/auth/auth_bloc.dart';
import 'package:mobile_app_electrolink/features/profile_completion/presentation/screens/complete_profile_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  UserRole _selectedRole = UserRole.company;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void toggleView() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  void _submit() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    if (email.isEmpty || password.isEmpty) return;

    if (isLogin) {
      context.read<AuthBloc>().add(LoginRequested(email, password));
    } else {
      final confirm = _confirmPasswordController.text;
      if (password != confirm) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Las contraseñas no coinciden')),
        );
        return;
      }
      context.read<AuthBloc>().add(RegisterRequested(
        email: email,
        password: password,
        passwordConfirmation: confirm,
        role: _roleApiValue(),
      ));
    }
  }

  String _roleApiValue() {
    switch (_selectedRole) {
      case UserRole.technician:
        return 'technician';
      case UserRole.company:
        return 'company';
      case UserRole.homeowner:
        return 'homeowner';
    }
  }

  void _onAuthStateChange(BuildContext context, AuthState state) {
    if (state is AuthAuthenticated) {
      if (state.isNewUser) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const CompleteProfileScreen()),
        );
        return;
      }
      final Widget destination;
      switch (_selectedRole) {
        case UserRole.technician:
          destination = const TechnicalDashboardScreen();
        case UserRole.company:
          destination = const CompanyShell();
        case UserRole.homeowner:
          destination = const HomeownerShell();
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => destination),
      );
    } else if (state is AuthError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: _onAuthStateChange,
      builder: (context, state) {
        final isLoading = state is AuthLoading;

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
                          color: Colors.black.withValues(alpha: 0.05),
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

                        if (!isLogin) ...[
                          _buildRoleSelector(),
                          const SizedBox(height: 20),
                        ],

                        CustomTextField(
                          label: 'Correo Electrónico',
                          hint: 'ejemplo@electrolink.com',
                          icon: Icons.email_outlined,
                          controller: _emailController,
                        ),
                        const SizedBox(height: 15),
                        CustomTextField(
                          label: 'Contraseña',
                          hint: '********',
                          icon: Icons.lock_outline,
                          isPassword: true,
                          controller: _passwordController,
                        ),

                        if (!isLogin) ...[
                          const SizedBox(height: 15),
                          CustomTextField(
                            label: 'Repetir Contraseña',
                            hint: '********',
                            icon: Icons.lock_outline,
                            isPassword: true,
                            controller: _confirmPasswordController,
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

                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1E2746),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: isLoading ? null : _submit,
                            child: isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                  )
                                : Text(isLogin ? 'Iniciar Sesión' : 'Registrarte'),
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
      },
    );
  }

  Widget _buildRoleSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Tipo de usuario', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Row(
          children: UserRole.values.map((role) {
            final isSelected = _selectedRole == role;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: role != UserRole.values.last ? 8 : 0,
                ),
                child: GestureDetector(
                  onTap: () => setState(() => _selectedRole = role),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF1E2746) : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected ? const Color(0xFF1E2746) : Colors.grey.shade300,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          role.icon,
                          color: isSelected ? Colors.white : const Color(0xFF1E2746),
                          size: 24,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          role.label,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : const Color(0xFF1E2746),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}